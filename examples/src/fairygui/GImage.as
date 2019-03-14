package fairygui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	import fairygui.display.UIImage;
	import fairygui.utils.ToolSet;

	public class GImage extends GObject implements IColorGear
	{
		private var _bmdSource:BitmapData;
		private var _content:Bitmap;
		private var _color:uint;
		private var _flip:int;
			
		public function GImage()
		{
			_color = 0xFFFFFF;
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void 
		{
			if(_color != value)
			{
				_color = value;
				updateGear(4);
				applyColor();
			}
		}
		
		private function applyColor():void
		{
			var ct:ColorTransform = _content.transform.colorTransform;
			ct.redMultiplier = ((_color>>16)&0xFF)/255;
			ct.greenMultiplier =  ((_color>>8)&0xFF)/255;
			ct.blueMultiplier = (_color&0xFF)/255;
			_content.transform.colorTransform = ct;
		}
		
		public function get flip():int
		{
			return _flip;
		}
		
		public function set flip(value:int):void
		{
			if(_flip!=value)
			{
				_flip = value;
				updateBitmap();
			}
		}
		
		public function get texture():BitmapData
		{
			return _bmdSource;
		}
		
		public function set texture(value:BitmapData):void
		{
			_bmdSource = value;
			handleSizeChanged();
		}
		
		override protected function createDisplayObject():void
		{ 
			_content = new UIImage(this);
			setDisplayObject(_content);
		}
		
		override public function dispose():void
		{
			if(!packageItem.loaded)
				packageItem.owner.removeItemCallback(packageItem, __imageLoaded);
			
			if(_content.bitmapData!=null && _content.bitmapData!=_bmdSource)
			{
				_content.bitmapData.dispose();
				_content.bitmapData = null;
			}
			
			super.dispose();
		}
		
		override public function constructFromResource():void
		{
			_sourceWidth = packageItem.width;
			_sourceHeight = packageItem.height;
			_initWidth = _sourceWidth;
			_initHeight = _sourceHeight;
			
			setSize(_sourceWidth, _sourceHeight);
			
			if(packageItem.loaded)
				__imageLoaded(packageItem);
			else
				packageItem.owner.addItemCallback(packageItem, __imageLoaded);
		}

		private function __imageLoaded(pi:PackageItem):void
		{
			if(_bmdSource!=null)
				return;
			
			_bmdSource = pi.image;
			_content.bitmapData = _bmdSource;
			_content.smoothing = packageItem.smoothing;
			updateBitmap();
		}
		
		override protected function handleSizeChanged():void
		{
			if(packageItem.scale9Grid==null && !packageItem.scaleByTile || _bmdSource!=packageItem.image)
				_sizeImplType = 1;
			else
				_sizeImplType = 0;
			handleScaleChanged();
			updateBitmap();
		}
		
		private function updateBitmap():void
		{
			if(_bmdSource==null)
				return;
			
			var newBmd:BitmapData = _bmdSource;
			var w:int = this.width;
			var h:int = this.height;
			
			if(w<=0 || h<=0)
				newBmd = null;
			else if(_bmdSource==packageItem.image
				&& (_bmdSource.width!=w || _bmdSource.height!=h))
			{
				if(packageItem.scale9Grid!=null)
					newBmd = ToolSet.scaleBitmapWith9Grid(_bmdSource, 
						packageItem.scale9Grid, w, h, packageItem.smoothing, packageItem.tileGridIndice);
				else if(packageItem.scaleByTile)
					newBmd = ToolSet.tileBitmap(_bmdSource, _bmdSource.rect, w, h);
			}
			
			if(newBmd!=null &&　_flip!=FlipType.None)
			{
				var mat:Matrix = new Matrix();
				var a:int=1,b:int=1;
				if(_flip==FlipType.Both)
				{
					mat.scale(-1,-1);
					mat.translate(newBmd.width, newBmd.height);
				}
				else if(_flip==FlipType.Horizontal)
				{
					mat.scale(-1, 1);
					mat.translate(newBmd.width, 0);
				}
				else
				{
					mat.scale(1,-1);
					mat.translate(0, newBmd.height);
				}
				
				var bmdAfterFlip:BitmapData = new BitmapData(newBmd.width,newBmd.height,newBmd.transparent,0);
				bmdAfterFlip.draw(newBmd, mat);
				
				if(newBmd!=_bmdSource)
					newBmd.dispose();
				
				newBmd = bmdAfterFlip;
			}
			
			var oldBmd:BitmapData = _content.bitmapData;
			if(oldBmd!=newBmd)
			{
				if(oldBmd && oldBmd!=_bmdSource)
					oldBmd.dispose();
				_content.bitmapData = newBmd;
			}
		}
		
		override public function setup_beforeAdd(xml:XML):void
		{
			super.setup_beforeAdd(xml);
			
			var str:String;
			str = xml.@color;
			if(str)
				this.color = ToolSet.convertFromHtmlColor(str);
			
			str = xml.@flip;
			if(str)
				this.flip = FlipType.parse(str);			
		}
	}
}