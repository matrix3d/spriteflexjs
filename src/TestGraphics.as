package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestGraphics extends Sprite
	{
		private var s2:Sprite;
		
		public function TestGraphics() 
		{
			var s:Sprite = new Sprite;
			addChild(s);
			
			s.graphics.lineStyle(0, 0xff00);
			s.graphics.beginFill(0xff0000);
			s.graphics.moveTo(0, 0);
			s.graphics.lineTo(1000, 1000);
			s.graphics.drawRect(100, 100, 100, 100);
			
			s2 = new Sprite;
			addChild(s2);
			s2.graphics.beginFill(0xff00ff);
			s2.graphics.lineStyle(0, 0xffff);
			s2.graphics.drawRoundRect( -50, -50, 100, 100, 10, 10);
			addEventListener(Event.ENTER_FRAME, enterFrame);
			s2.x = 150;
			s2.y = 150;
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
			loader.load(new URLRequest("../../wood.jpg"));
		}
		
		private function loader_complete(e:Event):void 
		{
			var target:LoaderInfo = e.currentTarget as LoaderInfo;
			var bmp:Bitmap = target.content as Bitmap;
			var bmd:BitmapData = bmp.bitmapData;
			
			var s3:Sprite = new Sprite;
			s3.graphics.beginBitmapFill(bmd);
			s3.graphics.drawRect(0, 0, 100, 100);
			addChild(s3);
		}
		
		private function enterFrame(e:Event):void 
		{
			s2.rotation++;
		}
		
		public function start():void {
			
		}
		
	}

}