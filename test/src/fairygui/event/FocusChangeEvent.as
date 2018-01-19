package fairygui.event
{
	import flash.events.Event;
	
	import fairygui.GObject;
	
	public class FocusChangeEvent extends Event 
	{
		public static const CHANGED:String = "focusChanged";
		
		private var _oldFocusedObject:GObject;
		private var _newFocusedObject:GObject;
		
		public function FocusChangeEvent(type:String, oldObject:GObject, newObject:GObject) 
		{
			super(type, false, false);
			_oldFocusedObject = oldObject;
			_newFocusedObject = newObject;
		}
		
		final public function get oldFocusedObject():GObject
		{
			return _oldFocusedObject;
		}
		
		final public function get newFocusedObject():GObject
		{
			return _newFocusedObject;
		}
		
		override public function clone():Event {
			return new FocusChangeEvent(type, _oldFocusedObject, _newFocusedObject);
		}
	}
}

