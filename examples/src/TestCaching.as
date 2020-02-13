package 
{
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
	public class TestCaching extends Sprite
	{
		private var boxes:Array = [];
		private var circle:Sprite;
		private var circText:TextField;
		
		public function TestCaching() 
		{
			SpriteFlexjs.autoSize = true;
			//SpriteFlexjs.debug = true;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var mat:Matrix = new Matrix();
			
			for (var i:int = 0; i < 500; i++) 
			{
				var	degrees:int = 0;
				var radians:Number = Math.PI / 180 * degrees;
				mat.createGradientBox(300, 300, radians, -100, -100);
				
				var spinBox:Sprite = new Sprite();
				spinBox.graphics.lineStyle(10);
				spinBox.graphics.lineGradientStyle(GradientType.LINEAR, [0xFF8000, 0xFFFF00], [1, 1], [0, 255], mat);
				spinBox.graphics.beginGradientFill(GradientType.LINEAR, [0x00000, 0xFF0000], [1, 1], [0, 255], mat);
				spinBox.graphics.drawRoundRect( -100, -100, 200, 200, 20, 20);
				spinBox.filters = [new DropShadowFilter(25, 45, 0, .55)];
				spinBox.x = Math.random() * stage.stageWidth;
				spinBox.y = Math.random() * stage.stageHeight;
				//spinBox.scaleX = spinBox.scaleY = .40;
				
				mat.createGradientBox(40*2,40*2,0,-40,-40);
				var circ:Shape = new Shape();
				circ.graphics.lineStyle(5, 0xFFFFFF);
				circ.graphics.beginGradientFill(GradientType.RADIAL, [0xFFFFFF, 0x000000], [.90, .90], [0, 255], mat);
				circ.graphics.drawCircle(0, 0, 40);
				circ.filters = [new DropShadowFilter(8, 45, 0, .75)];
				circ.x = circ.y = 50;
				//circ.cacheAsBitmap = true;
				spinBox.addChild(circ);
				
				spinBox.cacheAsBitmap = true;
				spinBox.buttonMode = true;
				addChild(spinBox);
				
				boxes.push(spinBox);
			}
			
			mat.createGradientBox(200*2,200*2,0,-200,-200);
			circle = new Sprite();
			circle.graphics.lineStyle(10, 0xFFFFFF);
			circle.graphics.beginGradientFill(GradientType.RADIAL, [0xFF0000, 0x000000], [.75, .75], [0, 255], mat);
			circle.graphics.drawCircle(0, 0, 200);
			circle.filters = [new GlowFilter(0xEC7600, 1, 20, 20, 5)];
			//circle.filters = [new DropShadowFilter(15, 45, 0, .75)];
			circle.x = circle.y = 240;
			
			circText = new TextField();
			circText.defaultTextFormat = new TextFormat("Arial", 60, 0xFFFFFF);
			circText.text = "Hello World";
			circText.width = circText.textWidth;
			circText.height = circText.textHeight;
			//circText.background = true; 
			//circText.border = true;
			//circText.filters = [new DropShadowFilter(15, 45, 0, 1)];
			circText.filters = [new GlowFilter(0x000000, 1, 5, 5, 4), new DropShadowFilter(10, 45, 0, .25)];
			circText.x = -circText.textWidth / 2;
			circText.y = -circText.textHeight / 2;
			//circText.cacheAsBitmap = true;
			circle.addChild(circText);
			
			//circle.cacheAsBitmap = true;
			addChild(circle);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			var i:int = 0;
			for each (var box:Sprite in boxes) 
			{
				i++;
				(i % 2 == 0) ? box.rotation++ : box.rotation--;
			}
			
			//circle.rotation++;
		}
		
	}

}