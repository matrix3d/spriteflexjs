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
		public static var startTime:Number = 0;
		public static var drawCounter:int;
		public static var batDrawCounter:int;
		public static var debug:Boolean = false;
		public static var wmode:String = "direct";//direct,gpu
		public static var renderer:IRenderer = new BaseRenderer;
		public function SpriteFlexjs() 
		{
			
		}
		
	}

}