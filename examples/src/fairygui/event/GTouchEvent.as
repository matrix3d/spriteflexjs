package fairygui.event
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;

	public class GTouchEvent extends Event
	{
		private var _stopPropagation:Boolean;
		
		private var _realTarget:DisplayObject;
		private var _clickCount:int;
		private var _stageX:Number;
		private var _stageY:Number;
		private var _shiftKey:Boolean;
		private var _ctrlKey:Boolean;
		private var _touchPointID:int;
		
		public static const BEGIN:String = "beginGTouch";
		public static const DRAG:String = "dragGTouch";
		public static const END:String = "endGTouch";
		public static const CLICK:String = "clickGTouch";
		
		public function GTouchEvent(type:String):void
		{
			super(type, false, false);
		}
		
		public function copyFrom(evt:Event, clickCount:int=1):void
		{
			if(evt is MouseEvent)
			{
				_stageX = MouseEvent(evt).stageX;
				_stageY = MouseEvent(evt).stageY;
				_shiftKey = MouseEvent(evt).shiftKey;
				_ctrlKey = MouseEvent(evt).ctrlKey;
			}
			else
			{
				_stageX = TouchEvent(evt).stageX;
				_stageY = TouchEvent(evt).stageY;
				_shiftKey = TouchEvent(evt).shiftKey;
				_ctrlKey = TouchEvent(evt).ctrlKey;
				_touchPointID = TouchEvent(evt).touchPointID;
			}
			_realTarget = evt.target as DisplayObject;
			_clickCount = clickCount;
			_stopPropagation = false;
		}
		
		final public function get realTarget():DisplayObject
		{
			return _realTarget;
		}
		final public function get clickCount():int
		{
			return _clickCount;
		}
		final public function get stageX():Number
		{
			return _stageX;
		}
		final public function get stageY():Number
		{
			return _stageY;
		}
		final public function get shiftKey():Boolean
		{
			return _shiftKey;
		}
		final public function get ctrlKey():Boolean
		{
			return _ctrlKey;
		}
		final public function get touchPointID():int
		{
			return _touchPointID;
		}
		override public function stopPropagation():void
		{
			_stopPropagation = true;
		}
		
		final public function get isPropagationStop():Boolean
		{
			return _stopPropagation;
		}
		
		override public function clone():Event {
			var ret:GTouchEvent = new GTouchEvent(type);
			ret._realTarget = _realTarget;
			ret._clickCount = _clickCount;
			ret._stageX = _stageX;
			ret._stageY = _stageY;
			ret._shiftKey = _shiftKey;
			ret._ctrlKey = _ctrlKey;
			ret._touchPointID = _touchPointID;
			return ret;			
		}
	}
}