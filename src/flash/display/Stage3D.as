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
			var canvas:HTMLCanvasElement = document.createElement("canvas") as HTMLCanvasElement;
			_context3D.canvas = canvas;
			canvas.style.position = "absolute";
			canvas.style.left = 0;
			canvas.style.top = 0;
			canvas.style.zIndex = 0;
			document.body.appendChild(canvas);
			_context3D.gl = (canvas.getContext("webgl",{alpha:false,antialias:false}) || canvas.getContext("experimental-webgl",{alpha:false,antialias:false})) as WebGLRenderingContext;
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
