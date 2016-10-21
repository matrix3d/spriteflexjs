package bunnymark{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.text.TextField;

	/**
	 * @author Joshua Granick
	 * @author Philippe Elsass
	 */
	public class TileTest extends Sprite 
	{
		private var tf:TextField;	
		private var numBunnies:int;
		private var incBunnies:int;
		private var smooth:Boolean;
		private var gravity:Number;
		private var bunnies:Array;
		private var maxX:int;
		private var minX:int=0;
		private var maxY:int;
		private var minY:int=0;
		private var bunnyAsset:BitmapData;
		private var tilesheet:Sprite;
		private var drawList:Array;
		private var loader:Loader;
		public function TileTest() 
		{
			super ();

			gravity = 0.5;
			incBunnies = 100;
			smooth = true;
			numBunnies = 0;

			bunnyAsset = new BitmapData(26, 37);// = Assets.getBitmapData("assets/wabbit_alpha.png");
			
			loader = new Loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
			loader.load(new URLRequest("../../assets/bunnyMark/wabbit_alpha.png"));
			bunnyAsset.perlinNoise(10, 10, 2, 1, true, true);
			
			bunnies = new Array();
			drawList = new Array();
			tilesheet = new Sprite//new Tilesheet(bunnyAsset);
			tilesheet.mouseChildren = tilesheet.mouseEnabled = false;
			addChild(tilesheet);
			//tilesheet.addTileRect(
			//	new Rectangle (0, 0, bunnyAsset.width, bunnyAsset.height));
			
			
			createCounter();
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			stage_resize(null);
			counter_click(null);
		}
		
		private function loader_complete(e:Event):void 
		{
			bunnyAsset = (loader.content as Bitmap).bitmapData;
			var bunny:Bunny;
			for (var i:int = 0; i < numBunnies;i++ )
			{
				bunny = bunnies[i];
				(bunny.display as Bitmap).bitmapData = bunnyAsset;
			}
		}

		private function createCounter():void
		{
			var btn:Sprite = new Sprite;
			btn.graphics.beginFill(0xff0000);
			btn.graphics.drawRect(0, 0, 100, 30);
			tf = new TextField();
			//btn.x = maxX - tf.width - 10;
			//btn.y = 10;
			addChild(btn);
			btn.addChild(tf);

			btn.addEventListener(MouseEvent.CLICK, counter_click);
		}

		public function counter_click(e:Event):void
		{
			var i:int = 100000;
			numBunnies += i;
			trace("numBunies",numBunnies);
			while(i-->0){
				var bunny:Bunny = new Bunny();
				bunny.display = new Bitmap(bunnyAsset);
				
				tilesheet.addChild(bunny.display);
				//bunny .position = new Point();
				bunny.speedX = Math.random() * 5;
				bunny.speedY = (Math.random() * 5) - 2.5;
				bunny.display.scaleX =
				bunny.display.scaleY =
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
			tf.text = "c:" + numBunnies;
			//tf.x = maxX - tf.width - 10;
		}
		
		private function enterFrame(e:Event) :void
		{
			var bunny:Bunny;
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