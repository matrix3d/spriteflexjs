package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import spriteflexjs.Stats;
	
	/**
	 * ...
	 * @author lizhi
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			SpriteFlexjs.wmode = "gpu";
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addChild(new Stats);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var bmd:BitmapData=new BitmapData(100, 100,false,0xffffff*Math.random())
			for (var i:int = 0; i < 1000;i++ ){
				var b:Bitmap = new Bitmap(bmd);
				addChild(b);
				b.x = 400 * Math.random();
				b.y = 400 * Math.random();
			}
		}
	}
}