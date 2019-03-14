package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.display.CapsStyle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class TestCaching2 extends Sprite
	{
		private var box:Shape;
		private var boxes:Array = [];
		private var spinBox:Sprite;
		private var testBM:Bitmap;
		private var gf:GlowFilter;
		
		public function TestCaching2() 
		{
			SpriteFlexjs.autoSize = true;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			
			/*var circText:TextField = new TextField();
			circText.defaultTextFormat = new TextFormat("Arial", 30, 0x000000);
			circText.text = "Hello World";
			circText.width = circText.textWidth;
			circText.height = circText.textHeight;
			//circText.background = true; 
			//circText.border = true;
			circText.x = 400;
			circText.y = 400;
			circText.filters = [new DropShadowFilter(15, 45, 0x000000, .75)];
			//circText.cacheAsBitmap = true;
			addChild(circText);*/
			
			/*var circle:Shape = new Shape();
			circle.graphics.beginFill(0x0000FF);
			circle.graphics.drawCircle(100, 100, 100);
			circle.x = circle.y = 200;
			circle.filters = [new GlowFilter(0xFF0000, 1, 60, 60, 2, 1, false, false)];
			addChild(circle);*/
			
			box = new Shape();
			box.graphics.beginFill(0x0000FF);
			box.graphics.drawRect(0, 0, 200, 200);
			box.x = 200;
			box.y = 300;
			gf = new GlowFilter(0xFF0000, 1, 20, 20, 4, 3, false, false);
			box.filters = [gf];
			//box.cacheAsBitmap = true;
			addChild(box);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function start():void { }
		
		private function onEnterFrame(e:Event):void 
		{
			//box.rotation++;
			
			if (this.contains(testBM) == false && gf.origImage)
			{
				var testCanvas:HTMLCanvasElement = document.createElement("canvas") as HTMLCanvasElement;
				testCanvas.width = gf.origImage.width;
				testCanvas.height = gf.origImage.height;
				var testCtx:CanvasRenderingContext2D = testCanvas.getContext("2d") as CanvasRenderingContext2D;
				//testCtx.fillStyle = 'gainsboro';  // light grey
				//testCtx.fillRect(0, 0, testCanvas.width, testCanvas.height);
				testCtx.putImageData(gf.origImage, 0, 0);
				
				trace("testImage: " + gf.origImage.width);
				
				var bmd:BitmapData = new BitmapData(gf.origImage.width, gf.origImage.height);
				bmd.image = testCanvas;
				testBM = new Bitmap(bmd);
				testBM.x = testBM.y = 350;
				addChild(testBM);
				
				
				var copyCanvas:HTMLCanvasElement = document.createElement("canvas") as HTMLCanvasElement;
				copyCanvas.width = gf.copyData.width;
				copyCanvas.height = gf.copyData.height;
				var copyCtx:CanvasRenderingContext2D = copyCanvas.getContext("2d") as CanvasRenderingContext2D;
				copyCtx.putImageData(gf.copyData, -20, -20);
				//copyCtx.fillStyle = 'gainsboro';  // light grey
				//copyCtx.fillRect(0, 0, testCanvas.width, testCanvas.height);
				
				trace("copyImage: " + gf.copyData.width);
				
				var bmd2:BitmapData = new BitmapData(gf.copyData.width, gf.copyData.height);
				bmd2.image = copyCanvas;
				var copyBM:Bitmap = new Bitmap(bmd2);
				copyBM.x = 350;
				copyBM.y = 600;
				addChild(copyBM);
				trace("added testBM!");
				
				
				var bmd3:BitmapData = new BitmapData(gf.copyCanvas.width, gf.copyCanvas.height);
				bmd3.image = gf.copyCanvas;
				var copyCan:Bitmap = new Bitmap(bmd3);
				copyCan.x = 100;
				copyCan.y = 600;
				addChild(copyCan);
			}
		}
		
	}

}