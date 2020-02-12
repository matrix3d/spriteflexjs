package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class TestDraw extends Sprite
	{
		private var  _sprite:Sprite;
		
		public function TestDraw()
		{
			SpriteFlexjs.autoSize = true;
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_sprite=new Sprite();
			addChild(_sprite);
			_sprite.graphics.beginFill(0x556677);
			_sprite.graphics.drawRect(0,0,500,500);
			_sprite.graphics.endFill();
			
			_sprite.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			_sprite.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			_sprite.graphics.lineStyle(3,0x551100,1);
			_sprite.graphics.moveTo(mouseX,mouseY);
			_sprite.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			_sprite.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			_sprite.graphics.lineTo(mouseX, mouseY);
		} 
	}
}