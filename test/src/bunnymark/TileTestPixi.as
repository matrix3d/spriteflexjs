package bunnymark{
	import PIXI.Sprite;
	import PIXI.Texture;

	/**
	 * @author Joshua Granick
	 * @author Philippe Elsass
	 */
	public class TileTestPixi extends Sprite
	{
		private var numBunnies:int;
		private var incBunnies:int;
		private var smooth:Boolean;
		private var gravity:Number;
		private var bunnies:Array;
		private var maxX:int;
		private var minX:int=0;
		private var maxY:int;
		private var minY:int=0;
		private var bunnyAsset:Texture;
		private var tilesheet:Sprite;
		private var drawList:Array;
		public function TileTestPixi() 
		{
			super ();

			gravity = 0.5;
			incBunnies = 100;
			smooth = true;
			numBunnies = 0;

			bunnyAsset = Texture.fromImage("http://192.168.1.250/flexjs/assets/bunnyMark/wabbit_alpha.png"); //new BitmapData(26, 37);// = Assets.getBitmapData("assets/wabbit_alpha.png");
			
			
			
			bunnies = new Array();
			drawList = new Array();
			tilesheet = new Sprite//new Tilesheet(bunnyAsset);
			//tilesheet.mouseChildren = tilesheet.mouseEnabled = false;
			addChild(tilesheet);
			//tilesheet.addTileRect(
			//	new Rectangle (0, 0, bunnyAsset.width, bunnyAsset.height));
			
			
			
			stage_resize(null);
			counter_click(null);
		}

		public function counter_click(e:Event):void
		{
			var i:int = 100000;
			numBunnies += i;
			trace("numBunies",numBunnies);
			while(i-->0){
				var bunny:BunnyPixi = new BunnyPixi();
				bunny.display = new Sprite(bunnyAsset);
				
				tilesheet.addChild(bunny.display);
				//bunny .position = new Point();
				bunny.speedX = Math.random() * 5;
				bunny.speedY = (Math.random() * 5) - 2.5;
				bunny.display.scale.x =
				bunny.display.scale.y =
				 0.3 + Math.random();
				bunny.display.rotation = 120*(15 - Math.random() * 30);
				bunnies.push (bunny);
			}

			stage_resize(null);
		}
		
		private function stage_resize(e:Event) :void
		{
			maxX = 480;
			maxY = 640;
			//tf.text = "c:" + numBunnies;
			//tf.x = maxX - tf.width - 10;
		}
		
		public function enterFrame() :void
		{
			var bunny:BunnyPixi;
			for (var i:int = 0; i < numBunnies;i++ )
			{
				bunny = bunnies[i];
				bunny.display.x += bunny.speedX;
				bunny.display.y += bunny.speedY;
				bunny.speedY += gravity;
				//bunny.display.alpha = 0.3 + 0.7 * bunny.display.y / maxY;
				
				if (bunny.display.x > maxX)
				{
					bunny.speedX *= -1;
					bunny.display.x = maxX;
				}
				else if (bunny.display.x < minX)
				{
					bunny.speedX *= -1;
					bunny.display.x = minX;
				}
				if (bunny.display.y > maxY)
				{
					bunny.speedY *= -0.8;
					bunny.display.y = maxY;
					if (Math.random() > 0.5) bunny.speedY -= 3 + Math.random() * 4;
				} 
				else if (bunny.display.y < minY)
				{
					bunny.speedY = 0;
					bunny.display.y = minY;
				}
				
			}
		}
		
		
	}
}