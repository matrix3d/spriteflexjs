package 
{
	CONFIG::js_only{
	import flash.__native.WebGLRenderer;
	import spriteflexjs.Stats;
	}
	import bunnymark.Background;
	import bunnymark.TileTest;
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
				SpriteFlexjs.stageWidth = _width;
				SpriteFlexjs.stageHeight = _height;
			}
			
			var bg:Background = new Background;
			bg.cols = 8;
			bg.rows = 12;
			bg.x =-50;
			bg.y =-50;
			bg.setSize(_width, _height);
			addChild(bg);
			
			addChild(new TileTest());
			
			var sts:Stats = new Stats;
			addChild(sts);
			sts.y = 200;
		}
		
	}

}