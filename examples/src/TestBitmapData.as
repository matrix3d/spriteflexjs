package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestBitmapData extends Sprite
	{
		
		private var b:BitmapData;
		
		public function TestBitmapData()
		{
			b = new BitmapData(200, 100, false);
			addChild(new Bitmap(b));
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void
		{
			var t:Number = getTimer() / 400;
			var scale:Number = 4;
			var wave:Number = Math.PI * 6 / b.height;
			b.lock();
			for (var x:int = 0; x < b.width; x++)
			{
				for (var y:int = 0; y < b.height; y++)
				{
					var offsetY:Number = (Math.sin(x * wave / 20 + t)) * 30 + (Math.sin(x * wave / 5 + t * 2)) * 5;
					var offsetX:Number = (2 + Math.sin((y + offsetY) * wave + t) + Math.sin((y + offsetY) * wave * .7 + t * 2.4)) / 4;
					b.setPixel(x, y, 0xff * (offsetX));
				}
			}
			b.unlock();
		}
	
	}

}