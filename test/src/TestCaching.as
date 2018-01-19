package 
{
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.display.CapsStyle;
	
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class TestCaching extends Sprite
	{
		private var boxes:Array = [];
		
		public function TestCaching() 
		{
			SpriteFlexjs.autoSize = true;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var mat:Matrix = new Matrix();
			
			for (var i:int = 0; i < 500; i++) 
			{
				var	degrees:int = 0;
				var radians:Number = Math.PI / 180 * degrees;
				mat.createGradientBox(200, 200, radians, -100, -100);
				
				var spinBox:Sprite = new Sprite();
				spinBox.graphics.lineStyle(10);
				spinBox.graphics.lineGradientStyle(GradientType.LINEAR, [0xFF8000, 0xFFFF00], [1, 1], [0, 255], mat);
				spinBox.graphics.beginGradientFill(GradientType.LINEAR, [0x00000, 0xFF0000], [1, 1], [0, 255], mat);
				spinBox.graphics.drawRoundRect(-100, -100, 200, 200, 20, 20);
				spinBox.x = Math.random() * stage.stageWidth;
				spinBox.y = Math.random() * stage.stageHeight;
				//spinBox.scaleX = spinBox.scaleY = .40;
				
				
				var circ:Shape = new Shape();
				circ.graphics.lineStyle(5, 0xFFFFFF);
				circ.graphics.beginGradientFill(GradientType.RADIAL, [0xFFFFFF, 0x000000], [.90, .90], [0, 255], mat);
				circ.graphics.drawCircle(0, 0, 40);
				circ.x = circ.y = 50;
				spinBox.addChild(circ);
				
				spinBox.cacheAsBitmap = true;
				addChild(spinBox);
				
				boxes.push(spinBox);
			}
			
			var circle:Shape = new Shape();
			circle.graphics.lineStyle(10, 0xFFFFFF);
			circle.graphics.beginGradientFill(GradientType.RADIAL, [0xFF0000, 0x000000], [.90, .90], [0, 255], mat);
			circle.graphics.drawCircle(0, 0, 200);
			circle.x = circle.y = 220;
			circle.cacheAsBitmap = true;
			addChild(circle);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			var i:int = 0;
			for each (var box:Shape in boxes) 
			{
				i++;
				(i % 2 == 0) ? box.rotation++ : box.rotation--;
			}
		}
		
	}

}