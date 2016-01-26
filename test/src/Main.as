package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author lizhi
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var b:Bitmap = new Bitmap(new BitmapData(100, 100));
			addChild(b);
			b.scaleX = 2;
			b.rotation = 45;
			trace(b.transform.pixelBounds);
			trace(typeof Sprite);
		}
		
	}
	
}