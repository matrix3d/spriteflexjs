package flash.display
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display3D.Context3D;
	
	public class Stage3D extends EventDispatcher
	{
		private var _context3D:Context3D;
		
		public function Stage3D()
		{
			super();
		}
		
		public function get context3D():Context3D  { return _context3D }
		
		public function requestContext3D(param1:String = "auto", param2:String = "baseline"):void
		{
			_context3D = new Context3D;
			dispatchEvent(new Event(Event.CONTEXT3D_CREATE));
		}
		
		public function requestContext3DMatchingProfiles(param1:Vector.<String>):void
		{
			requestContext3D();
		}
		
		public function get x():Number  { return 0 }
		
		public function set x(param1:Number):void
		{
		}
		
		public function get y():Number  { return 0 }
		
		public function set y(param1:Number):void
		{
		}
		
		public function get visible():Boolean  { return false }
		
		public function set visible(param1:Boolean):void
		{
		}
	}
}
