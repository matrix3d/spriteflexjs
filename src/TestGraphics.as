package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.text.TextField;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestGraphics extends Sprite
	{
		private var s2:Sprite;
		private var matr:Matrix = new Matrix;
		public function TestGraphics() 
		{
			var s:Sprite = new Sprite;
			addChild(s);
			
			//s.graphics.lineStyle(0, 0xff00);
			s.graphics.beginFill(0xff0000);
			s.graphics.lineStyle(0, 0xff);
			s.graphics.drawRect(100, 100, 100, 100);
			
			s.graphics.beginFill(0xff);
			s.graphics.lineStyle(5, 0xff00ff);
			s.graphics.drawRect(200, 200, 100, 100);
			
			s2 = new Sprite;
			addChild(s2);
			s2.graphics.beginFill(0xff00ff);
			s2.graphics.lineStyle(0, 0xffff);
			s2.graphics.drawCircle(0, 0, 50);// .drawRoundRect( -50, -50, 100, 100, 10, 10);
			addEventListener(Event.ENTER_FRAME, enterFrame);
			s2.x = 150;
			s2.y = 150;
			
			var tf:TextField = new TextField;
			tf.text = "textfield";
			addChild(tf);
			tf.y = 200;
			
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
			s3.graphics.beginBitmapFill(bmd,matr);
			s3.graphics.drawRect(0, 0, 100, 100);
			addChild(s3);
			s3.graphics.beginFill(0xff0000);
			s3.graphics.drawRect(50, 50, 100, 100);
			
			addChild(bmp);
			bmp.y = 300;
		}
		
		private function enterFrame(e:Event):void 
		{
			matr.rotate(1/180*Math.PI);
			s2.rotation++;
		}
		
		public function start():void {
			
		}
		
	}

}