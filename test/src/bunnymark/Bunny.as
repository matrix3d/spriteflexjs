package bunnymark{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * ...
	 * @author Joshua Granick
	 */
	public class Bunny 
	{
		public var speedX:Number;
		public var speedY:Number;
		public var x:Number=0;
		public var y:Number=0;
		public var display:DisplayObject;
		
		public function Bunny()
		{
			speedX = 0;
			speedY = 0;
		}
		
	}
}