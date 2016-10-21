package 
{
	import flash.__native.WebGLRenderer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		private var tf:TextField;
		public function TestGraphics() 
		{
			CONFIG::js_only{
				//SpriteFlexjs.wmode = "gpu batch";
				//SpriteFlexjs.renderer = new WebGLRenderer;
			}
			
			var s:Sprite = new Sprite;
			addChild(s);
			
			//s.graphics.lineStyle(0, 0xff00);
			s.graphics.lineStyle(5);
			s.graphics.beginFill(0xff0000);
			s.graphics.moveTo(200, 0);
			s.graphics.curveTo(300, 0, 300, 100);
			addChild(s);
			
			s2 = new Sprite;
			addChild(s2);
			s2.graphics.beginFill(0xff00ff);
			s2.graphics.lineStyle(0, 0xffff);
			s2.graphics.drawCircle(0, 0, 50);
			//s2.graphics.drawRoundRect( 70, -50, 100, 100, 10, 10);
			s2.graphics.drawRoundRectComplex( 70, -50, 100, 100, 10, 20,30,40);
			s2.graphics.drawEllipse( 300, 0, 200, 100);
			s2.rotation = 30;
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			s2.x = 150;
			s2.y = 150;
			
			tf = new TextField;
			tf.text = "textfield";
			addChild(tf);
			tf.y = 200;
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
			loader.load(new URLRequest("../../assets/wood.jpg"));
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
		}
		
		private function stage_mouseMove(e:MouseEvent):void 
		{
			tf.text = e.localX + "," + e.localY;
			for (var i:int = 0; i < numChildren;i++ ) {
				var c:DisplayObject = getChildAt(i);
				if (c.hitTestPoint(e.localX,e.localY)) {
					tf.appendText("hittest,")
				}
			}
		}
		
		private function loader_complete(e:Event):void 
		{
			var target:LoaderInfo = e.currentTarget as LoaderInfo;
			var bmp:Bitmap = target.content as Bitmap;
			var bmd:BitmapData = bmp.bitmapData;
			
			var s3:Sprite = new Sprite;
			//s3.blendMode = BlendMode.ADD;
			s3.graphics.beginBitmapFill(bmd,matr,true);
			s3.graphics.drawRect(20, 20, 100, 100);
			addChild(s3);
			//s3.graphics.beginFill(0xff0000);
			s3.graphics.drawRect(50, 50, 100, 100);
			
			s3.graphics.moveTo(100, 0);
			s3.graphics.curveTo(200, 0, 200, 100);
			addChild(bmp);
			bmp.y = 300;
		}
		
		private function enterFrame(e:Event):void 
		{
			matr.rotate(1/180*Math.PI);
		}
		
		public function start():void {
			
		}
		
	}

}