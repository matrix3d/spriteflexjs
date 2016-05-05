package
{
	import flash.__native.WebGLRenderer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
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
			SpriteFlexjs.wmode = "gpu batch";
			SpriteFlexjs.renderer = new WebGLRenderer;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addChild(new Stats);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var bmd:BitmapData=new BitmapData(10, 10,false,0xffffff*Math.random())
			for (var i:int = 0; i < 5000;i++ ){
				//var b:Bitmap = new Bitmap(bmd);
				
				var b:Shape = new Shape;
				b.graphics.beginBitmapFill(bmd);
				b.graphics.drawRect(0, 0, bmd.width, bmd.height);
				
				addChild(b);
				b.x = 400 * Math.random();
				b.y = 400 * Math.random();
			}
		}
	}
}