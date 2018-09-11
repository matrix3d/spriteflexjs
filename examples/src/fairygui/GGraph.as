package fairygui
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	
	import fairygui.display.UISprite;
	import fairygui.utils.ToolSet;
	
	public class GGraph extends GObject implements IColorGear
	{
		private var _graphics:Graphics;
		
		private var _type:int;
		private var _lineSize:int;
		private var _lineColor:int;
		private var _lineAlpha:Number;
		private var _fillColor:int;
		private var _fillAlpha:Number;
		private var _fillBitmapData:BitmapData;
		private var _corner:Array;

		public function GGraph()
		{
			_lineSize = 1;
			_lineAlpha = 1;
			_fillAlpha = 1;
			_fillColor = 0xFFFFFF;
		}
		
		public function get graphics():Graphics
		{
			if(_graphics)
				return _graphics;
			
			delayCreateDisplayObject();
			_graphics = Sprite(displayObject).graphics;
			return _graphics;
		}
		
		public function get color():uint
		{
			return _fillColor;
		}
		
		public function set color(value:uint):void 
		{
			if(_fillColor != value)
			{
				_fillColor = value;
				updateGear(4);
				if(_type!=0)
					drawCommon();
			}
		}
		
		public function drawRect(lineSize:int, lineColor:int, lineAlpha:Number,
								 fillColor:int, fillAlpha:Number, corner:Array=null):void
		{
			_type = 1;
			_lineSize = lineSize;
			_lineColor = lineColor;
			_lineAlpha = lineAlpha;
			_fillColor = fillColor;
			_fillAlpha = fillAlpha;
			_fillBitmapData = null;
			_corner = corner;
			drawCommon();
		}
		
		public function drawRectWithBitmap(lineSize:int, lineColor:int, lineAlpha:Number, bitmapData:BitmapData):void
		{
			_type = 1;
			_lineSize = lineSize;
			_lineColor = lineColor;
			_lineAlpha = lineAlpha;
			_fillBitmapData = bitmapData;
			drawCommon();
		}

		public function drawEllipse(lineSize:int, lineColor:int, lineAlpha:Number,
									fillColor:int, fillAlpha:Number):void
		{
			_type = 2;
			_lineSize = lineSize;
			_lineColor = lineColor;
			_lineAlpha = lineAlpha;
			_fillColor = fillColor;
			_fillAlpha = fillAlpha;
			_corner = null;
			drawCommon();
		}
		
		public function clearGraphics():void
		{
			if(_graphics)
			{
				_type = 0;
				_graphics.clear();
			}
		}
		
		private function drawCommon():void
		{			
			this.graphics;//force create
			
			_graphics.clear();
			
			var w:int = Math.ceil(this.width);
			var h:int = Math.ceil(this.height);
			if(w==0 || h==0)
				return;
			
			if(_lineSize==0)
				_graphics.lineStyle(0,0,0,true,LineScaleMode.NONE);
			else
				_graphics.lineStyle(_lineSize, _lineColor, _lineAlpha, true, LineScaleMode.NONE);
			
			//flash 画线的方法有点特殊，这里的处理保证了当lineSize是1时，图形的大小是正确的。
			//如果lineSize大于1，则无法保证，线条会在元件区域外显示
			if(_lineSize==1) 
			{
				if(w>0)
					w-=_lineSize;
				if(h>0)
					h-=_lineSize;
			}
			if(_fillBitmapData!=null)
				_graphics.beginBitmapFill(_fillBitmapData);
			else
				_graphics.beginFill(_fillColor, _fillAlpha);
			if(_type==1)
			{	
				if(_corner)
				{
					if(_corner.length==1)
						_graphics.drawRoundRect(0,0,w,h,int(_corner[0]), int(_corner[0]));
					else
						_graphics.drawRoundRectComplex(0,0,w,h,
							int(_corner[0]),int(_corner[1]),int(_corner[2]),int(_corner[3]));
				}
				else
					_graphics.drawRect(0,0,w,h);
			}
			else
				_graphics.drawEllipse(0,0,w,h);
			_graphics.endFill();
		}
		
		public function replaceMe(target:GObject):void
		{
			if(!_parent)
				throw new Error("parent not set");
			
			target.name = this.name;
			target.alpha = this.alpha;
			target.rotation = this.rotation;
			target.visible = this.visible;
			target.touchable = this.touchable;
			target.grayed = this.grayed;
			target.setXY(this.x, this.y);
			target.setSize(this.width, this.height);
			
			var index:int = _parent.getChildIndex(this);
			_parent.addChildAt(target, index);
			target.relations.copyFrom(this.relations);
			
			_parent.removeChild(this, true);			
		}
		
		public function addBeforeMe(target:GObject):void
		{
			if (_parent == null)
				throw new Error("parent not set");
			
			var index:int = _parent.getChildIndex(this);
			_parent.addChildAt(target, index);
		}
		
		public function addAfterMe(target:GObject):void
		{
			if (_parent == null)
				throw new Error("parent not set");
			
			var index:int = _parent.getChildIndex(this);
			index++;
			_parent.addChildAt(target, index);
		}
		
		public function setNativeObject(obj:DisplayObject):void
		{
			delayCreateDisplayObject();
			Sprite(displayObject).addChild(obj);
		}
		
		private function delayCreateDisplayObject():void
		{
			if(!displayObject)
			{
				setDisplayObject(new UISprite(this));
				if(_parent)
					_parent.childStateChanged(this);
				handlePositionChanged();
				displayObject.alpha = this.alpha;
				displayObject.rotation = this.normalizeRotation;
				displayObject.visible = this.visible;
				Sprite(displayObject).mouseEnabled = this.touchable;
				Sprite(displayObject).mouseChildren = this.touchable;
			}
			else
			{
				Sprite(displayObject).graphics.clear();
				Sprite(displayObject).removeChildren();
				_graphics = null;
			}
		}
		
		override protected function handleSizeChanged():void
		{
			if(_graphics)
			{
				if(_type!=0)
					drawCommon();
			}
		}

		override public function setup_beforeAdd(xml:XML):void
		{
			var str:String;
			var type:String = xml.@type;
			if(type && type!="empty")
			{
				setDisplayObject(new UISprite(this));
			}
			
			super.setup_beforeAdd(xml);
			
			if(displayObject!=null)
			{
				_graphics = Sprite(this.displayObject).graphics;
				
				str = xml.@lineSize;
				if(str)
					_lineSize = parseInt(str);
				
				str = xml.@lineColor;
				if(str)
				{
					var c:uint = ToolSet.convertFromHtmlColor(str,true);
					_lineColor = c & 0xFFFFFF;
					_lineAlpha = ((c>>24)&0xFF)/0xFF;
				}
				
				str = xml.@fillColor;
				if(str)
				{
					c = ToolSet.convertFromHtmlColor(str,true);
					_fillColor = c & 0xFFFFFF;
					_fillAlpha = ((c>>24)&0xFF)/0xFF;
				}
				
				str = xml.@corner;
				if(str)
					_corner = str.split(",");

				if(type=="rect")
					_type = 1;
				else
					_type = 2;
				
				drawCommon();
			}
		}
	}
}