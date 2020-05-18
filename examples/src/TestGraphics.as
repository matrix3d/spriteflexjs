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
	import flash.display.StageScaleMode;
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
				SpriteFlexjs.wmode = "gpu batch";
				SpriteFlexjs.renderer = new WebGLRenderer;
			}
			
			SpriteFlexjs.autoSize = true;
			
			stage.canvas.style.backgroundColor = "#000000";
			
			this.name = "TestGraphics";
			
			var triangle:Sprite = new Sprite();
			triangle.graphics.lineStyle(3);
			triangle.graphics.beginFill(0xFFFFFF);
			triangle.graphics.lineTo(50, 100);
			triangle.graphics.lineTo(-50, 100);
			triangle.graphics.lineTo(0, 0);
			triangle.name = "triangle";
			triangle.x = 400;
			triangle.y = 10;
			addChild(triangle);
			
			var box:Sprite = new Sprite();
			box.graphics.lineStyle(3);
			box.graphics.beginFill(0x0080FF);
			box.graphics.drawRoundRect(0, 0, 100, 100, 9, 9);
			box.name = "box";
			box.x = 475;
			box.y = 10;
			addChild(box);
			
			var circle:Sprite = new Sprite();
			circle.graphics.lineStyle(3);
			circle.graphics.beginFill(0xFF8000)
			circle.graphics.drawCircle(0, 0, 50);
			circle.name = "circle";
			circle.x = 650;
			circle.y = 60;
			addChild(circle);
			
			var elipse:Sprite = new Sprite;
			elipse.graphics.lineStyle(3, 0xFFFFFF);
			elipse.graphics.beginFill(0xFF00FF);
			elipse.graphics.drawEllipse(0, 0, 150, 75);
			elipse.name = "elipse";
			elipse.rotation = 30;
			elipse.x = 350;
			elipse.y = 125;
			addChild(elipse);
			
			var rectComplex:Sprite = new Sprite();
			rectComplex.graphics.lineStyle(3);
			rectComplex.graphics.beginFill(0xC0C0C0);
			rectComplex.graphics.drawRoundRectComplex(0, 0, 100, 100, 10, 20, 30, 40);
			rectComplex.name = "rectComplex";
			rectComplex.x = 475;
			rectComplex.y = 150;
			addChild(rectComplex);
			
			var halfMoon:Sprite = new Sprite();
			halfMoon.graphics.lineStyle(5);
			halfMoon.graphics.beginFill(0xff0000);
			halfMoon.graphics.moveTo(200, 0);
			halfMoon.graphics.curveTo(300, 0, 300, 100);
			halfMoon.name = "halfMoon";
			halfMoon.x = 415;
			halfMoon.y = 150;
			addChild(halfMoon);
			
			tf = new TextField();
			tf.width = 150;
			tf.text = "textfield";
			tf.y = 200;
			addChild(tf);
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
			loader.load(new URLRequest("../../assets/wood.jpg"));
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function stage_mouseMove(e:MouseEvent):void 
		{
			tf.text = e.localX + "," + e.localY;
			for (var i:int = 0; i < numChildren;i++ ) {
				var c:DisplayObject = getChildAt(i);
				if (c.hitTestPoint(e.localX,e.localY)) {
					tf.appendText(" hittest " + c.name);
				}
			}
		}
		
		private function loader_complete(e:Event):void 
		{
			var target:LoaderInfo = e.currentTarget as LoaderInfo;
			var bmp:Bitmap = target.content as Bitmap;
			var bmd:BitmapData = bmp.bitmapData;
			
			// use bitmap as fill
			var s3:Sprite = new Sprite;
			//s3.blendMode = BlendMode.ADD;
			s3.graphics.beginBitmapFill(bmd,matr,true);
			s3.graphics.drawRect(20, 20, 100, 100);
			s3.graphics.drawRect(50, 50, 100, 100);			
			s3.graphics.moveTo(100, 0);
			s3.graphics.curveTo(200, 0, 200, 100);
			addChild(s3);
			
			// bitmap itself
			bmp.y = 300;
			addChild(bmp);
			
			// fill background
			this.graphics.beginFill(0x00FF00);
			this.graphics.drawRect(0, 0, 800, 600);
		}
		
		private function enterFrame(e:Event):void 
		{
			matr.rotate(1 / 180 * Math.PI);
		}
		
		public function start():void { }
		
	}

}