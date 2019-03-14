package 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestMouseEvent extends Sprite
	{
		private var tf:TextField;
		private var moving:Sprite;
		public function TestMouseEvent() 
		{
			for (var i:int = 0; i < 100;i++ ) {
				var s:Sprite = new Sprite;
				s.graphics.beginFill(0xffffff * Math.random());
				var w:Number = 50 + 50 * Math.random();
				var h:Number = 50 + 50 * Math.random();
				s.graphics.drawRect( -w / 2, -h / 2, w, h);
				s.rotation = Math.random() * 360;
				s.x = 400 * Math.random();
				s.y = 400 * Math.random();
				s.addEventListener(MouseEvent.MOUSE_OUT, s_mouseOut);
				s.addEventListener(MouseEvent.MOUSE_OVER, s_mouseOver);
				s.addEventListener(MouseEvent.MOUSE_DOWN, s_mouseDown);
				addChild(s);
				s.addEventListener(MouseEvent.CLICK, s_mouseevent);
				//s.addEventListener(MouseEvent.CONTEXT_MENU, s_mouseevent);
				s.addEventListener(MouseEvent.DOUBLE_CLICK, s_mouseevent);
				s.addEventListener(MouseEvent.MOUSE_DOWN, s_mouseevent);
				s.addEventListener(MouseEvent.MOUSE_MOVE, s_mouseevent);
				s.addEventListener(MouseEvent.MOUSE_OUT, s_mouseevent);
				s.addEventListener(MouseEvent.MOUSE_OVER, s_mouseevent);
				s.addEventListener(MouseEvent.MOUSE_UP, s_mouseevent);
			}
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUp);
			tf = new TextField;
			tf.y = 200;
			tf.mouseEnabled = false;
			addChild(tf);
		}
		
		private function stage_mouseUp(e:MouseEvent):void 
		{
			moving = null;
		}
		
		private function stage_mouseMove(e:MouseEvent):void 
		{
			if (moving) {
				moving.x = mouseX;
				moving.y = mouseY;
			}
		}
		
		private function s_mouseDown(e:MouseEvent):void 
		{
			moving = e.currentTarget as Sprite;
			(moving.parent as DisplayObjectContainer).setChildIndex(moving, (moving.parent as DisplayObjectContainer).numChildren - 1);
		}
		
		private function s_mouseevent(e:MouseEvent):void 
		{
			tf.text = e.type;
			trace(e.type,e.localX,e.localY);
		}
		
		private function s_mouseOut(e:MouseEvent):void 
		{
			var t:DisplayObject = e.currentTarget as DisplayObject;
			t.scaleX = t.scaleY = 1;
			t.alpha = 1;
		}
		
		private function s_mouseOver(e:MouseEvent):void 
		{
			var t:DisplayObject = e.currentTarget as DisplayObject;
			t.scaleX = t.scaleY = 1.2;
			t.alpha = .8;
		}
		
	}

}