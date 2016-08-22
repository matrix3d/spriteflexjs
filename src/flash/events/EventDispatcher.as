package flash.events
{
	import flash.net.*;
	
	[Event(name = "deactivate", type = "flash.events.Event")]
	[Event(name = "activate", type = "flash.events.Event")]
	public class EventDispatcher implements IEventDispatcher
	{
		private var listeners:Object = {};
		
		public function EventDispatcher(target:IEventDispatcher = null)
		{
			super();
			this.ctor(target);
		}
		
		private static function trimHeaderValue(headerValue:String):String
		{
			var currChar:String = null;
			var indexOfFirstValueChar:uint = 0;
			var headerValueLen:uint = headerValue.length;
			var done:Boolean = false;
			while (indexOfFirstValueChar < headerValueLen && !done)
			{
				currChar = headerValue.charAt(indexOfFirstValueChar);
				done = currChar != " " && currChar != "\t";
				if (!done)
				{
					indexOfFirstValueChar++;
				}
			}
			var indexOfLastValueChar:uint = headerValueLen;
			done = false;
			while (indexOfLastValueChar > indexOfFirstValueChar && !done)
			{
				currChar = headerValue.charAt(indexOfLastValueChar - 1);
				done = currChar != " " && currChar != "\t";
				if (!done)
				{
					indexOfLastValueChar--;
				}
			}
			return headerValue.substring(indexOfFirstValueChar, indexOfLastValueChar);
		}
		
		private function ctor(param1:IEventDispatcher):void
		{
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			var funcs:Array = listeners[type] = listeners[type] || [];
			var i:Object = funcs.indexOf(listener);
			if (i != -1)
			{
				funcs.splice(i, 1);
			}
			funcs.push(listener);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			var funcs:Array = listeners[type];
			if (funcs)
			{
				var i:Object = funcs.indexOf(listener);
				if (i != -1)
				{
					funcs.splice(i, 1);
				}
				if (funcs.length === 0)
				{
					listeners[type] = null;
					delete listeners[type];
				}
			}
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			if (event.target)
			{
				return this.dispatchEventFunction(event.clone());
			}
			return this.dispatchEventFunction(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return listeners[type] != null;
		}
		
		public function willTrigger(param1:String):Boolean  { return false }
		
		private function dispatchEventFunction(event:Event):Boolean
		{
			event.target = this;
			event.currentTarget = this;
			var funcs:Array = listeners[event.type];
			if (funcs)
			{
				var len:int = funcs.length
				for (var i:int = 0; i < len;i++ ){
					var func:Function = funcs[i];
					func(event);
				}
			}
			return false;
		}
	
	}
}
