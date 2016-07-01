package 
{
	CONFIG::js_only{
	import flash.__native.WebGLRenderer;
	}
	import bunnymark.Background;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestBunnymark extends Sprite
	{
		private var _width:Number = 480;
		private var _height:Number = 640;
		public function TestBunnymark() 
		{
			CONFIG::js_only{
				SpriteFlexjs.wmode = "gpu batch";
				SpriteFlexjs.renderer = new WebGLRenderer;
			}
			
			var bg:Background = new Background;
			bg.cols = 8;
			bg.rows = 12;
			bg.x =-50;
			bg.y =-50;
			bg.texture = new BitmapData(256, 256, true, 0xffff0000);
			bg.texture.perlinNoise(50, 50, 3, 1, true, true);
			bg.setSize(_width, _height);
			addChild(bg);
		}
		
	}

}