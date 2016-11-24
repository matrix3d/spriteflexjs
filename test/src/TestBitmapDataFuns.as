package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestBitmapDataFuns extends Sprite
	{
		private var bmd:BitmapData;
		public function TestBitmapDataFuns() 
		{
			bmd = new BitmapData(400, 400, true);
			addChild(new Bitmap(bmd));
			bmd.perlinNoise(100, 100, 10, 1, true, true, 7, false);
		}
		
		public function perlinNoise(baseX:Number, baseY:Number, numOctaves:uint, red:Boolean = true,green:Boolean=true,blue:Boolean=true, grayScale:Boolean = false):void{
			var op:int = 0;
			if (red){
				op =op|BitmapDataChannel.RED;
			}if (green){
				op =op|BitmapDataChannel.GREEN;
			}if (blue){
				op =op|BitmapDataChannel.BLUE;
			}
			bmd.perlinNoise(baseX, baseY, numOctaves, 1, true, true, op, grayScale);
		}
	}

}