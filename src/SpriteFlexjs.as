package 
{
	import flash.__native.BaseRenderer;
	import flash.__native.IRenderer;
	/**
	 * ...
	 * @author lizhi
	 */
	public class SpriteFlexjs 
	{
		public static var stageWidth:Number = 800;
		public static var stageHeight:Number = 600;
		public static var autoSize:Boolean = false;
		public static var startTime:Number = 0;
		public static var drawCounter:int;
		public static var batDrawCounter:int;
		public static var debug:Boolean = false;
		public static var wmode:String = "direct";//direct,gpu
		public static var renderer:IRenderer = new BaseRenderer;
		public static var dirtyGraphics:Boolean = true;
		public static var requestAnimationFrame:Function =
			window["requestAnimationFrame"]       ||
			window["webkitRequestAnimationFrame"] ||
			window["mozRequestAnimationFrame"]    ||
			window["oRequestAnimationFrame"] ||
			window["msRequestAnimationFrame"] ||
			function(callback):void {
				setTimeout(callback, 1000 / 60);
			};

		public function SpriteFlexjs() 
		{
			
		}
		
	}

}