package flash.display
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display3D.Context3D;
	
	public class Stage3D extends EventDispatcher
	{
		public var __stage:Stage;
		private var _context3D:Context3D;
		private static var ID:int = 0;
		private var id:int;
		public function Stage3D()
		{
			id = ID++;
			super();
		}
		
		public function get context3D():Context3D  { return _context3D }
		
		public function requestContext3D(param1:String = "auto", param2:String = "baseline"):void
		{
			_context3D = new Context3D;
			var canvas:HTMLCanvasElement = (document.getElementById("spriteflexjsstage3d" + id)) as HTMLCanvasElement;
			if(canvas==null){
				canvas = document.createElement("canvas") as HTMLCanvasElement;
				canvas.style.position = "absolute";
				canvas.style.left = "0px";
				canvas.style.top = "0px";
				canvas.style.zIndex =id-20;
				
				__stage.__rootHtmlElement.appendChild(canvas);
			}
			_context3D.canvas = canvas;
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
