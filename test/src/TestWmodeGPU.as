package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import spriteflexjs.Stats;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestWmodeGPU extends Sprite
	{
		
		public function TestWmodeGPU() 
		{
			SpriteFlexjs.wmode = "gpu";
			var bmd:BitmapData = new BitmapData(100, 100, true, 0xffff0000);
			for (var i:int = 0; i < 1000;i++ ) {
				var image:Bitmap = new Bitmap(bmd);
				addChild(image);
				image.x = stage.stageWidth * Math.random();
				image.y = stage.stageHeight * Math.random();
			}
			addChild(new Stats);
		}
		
	}

}