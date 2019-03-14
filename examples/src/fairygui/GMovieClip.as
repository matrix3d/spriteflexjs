package fairygui
{
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	
	import fairygui.display.UIMovieClip;
	import fairygui.utils.ToolSet;
	
	public class GMovieClip extends GObject implements IAnimationGear, IColorGear
	{	
		private var _movieClip:UIMovieClip;
		private var _color:uint;
		
		public function GMovieClip()
		{
			_sizeImplType = 1;
			_color = 0xFFFFFF;
		}
		
		override protected function createDisplayObject():void
		{
			_movieClip = new UIMovieClip(this);
			_movieClip.mouseEnabled = false;
			_movieClip.mouseChildren = false;
			setDisplayObject(_movieClip);
		}
		
		final public function get playing():Boolean
		{
			return _movieClip.playing;
		}
		
		final public function set playing(value:Boolean):void
		{
			if(_movieClip.playing!=value)
			{
				_movieClip.playing = value;
				updateGear(5);
			}
		}
		
		final public function get frame():int
		{
			return _movieClip.currentFrame;
		}
		
		public function set frame(value:int):void
		{
			if(_movieClip.currentFrame!=value)
			{
				_movieClip.currentFrame = value;
				updateGear(5);
			}
		}
		
		//从start帧开始，播放到end帧（-1表示结尾），重复times次（0表示无限循环），循环结束后，停止在endAt帧（-1表示参数end）
		public function setPlaySettings(start:int = 0, end:int = -1, 
										times:int = 0, endAt:int = -1, 
										endCallback:Function = null):void
		{
			_movieClip.setPlaySettings(start, end, times, endAt, endCallback);	
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
			var ct:ColorTransform = _movieClip.transform.colorTransform;
			ct.redMultiplier = ((_color>>16)&0xFF)/255;
			ct.greenMultiplier =  ((_color>>8)&0xFF)/255;
			ct.blueMultiplier = (_color&0xFF)/255;
			_movieClip.transform.colorTransform = ct;
		}
		
		public override function dispose():void
		{
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
				__movieClipLoaded(packageItem);
			else
				packageItem.owner.addItemCallback(packageItem, __movieClipLoaded);
		}
		
		private function __movieClipLoaded(pi:PackageItem):void
		{
			_movieClip.interval = packageItem.interval;
			_movieClip.swing = packageItem.swing;
			_movieClip.repeatDelay = packageItem.repeatDelay;
			_movieClip.frames = packageItem.frames;
			_movieClip.boundsRect = new Rectangle(0, 0, sourceWidth, sourceHeight);
		}

		override public function setup_beforeAdd(xml:XML):void
		{
			super.setup_beforeAdd(xml);
			
			var str:String;
			str = xml.@frame;
			if(str)
				_movieClip.currentFrame = parseInt(str);
			str = xml.@playing;
			_movieClip.playing = str!= "false";
			str = xml.@color;
			if(str)
				this.color = ToolSet.convertFromHtmlColor(str);
		}
	}
}