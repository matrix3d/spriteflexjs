package fairygui.display
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class Frame
	{
		public var rect:Rectangle;
		public var addDelay:int;
		public var image:BitmapData;
		
		public function Frame()
		{
			rect = new Rectangle();
		}
	}
}