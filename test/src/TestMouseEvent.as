package 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestMouseEvent extends Sprite
	{
		private var tf:TextField;
		public function TestMouseEvent() 
		{
			for (var i:int = 0; i < 100;i++ ) {
				var s:Sprite = new Sprite;
				s.graphics.beginFill(0xffffff * Math.random());
				var w:Number = 50 + 50 * Math.random();
				var h:Number = 50 + 50 * Math.random();
				s.graphics.drawRect(-w/2, -h/2, w, h);
				s.rotation = Math.random() * 360;
				s.x = 400 * Math.random();
				s.y = 400 * Math.random();
				s.addEventListener(MouseEvent.MOUSE_OUT, s_mouseOut);
				s.addEventListener(MouseEvent.MOUSE_OVER, s_mouseOver);
				addChild(s);
				s.addEventListener(MouseEvent.CLICK, s_mouseevent);
				s.addEventListener(MouseEvent.CONTEXT_MENU, s_mouseevent);
				s.addEventListener(MouseEvent.DOUBLE_CLICK, s_mouseevent);
				s.addEventListener(MouseEvent.MOUSE_DOWN, s_mouseevent);
				s.addEventListener(MouseEvent.MOUSE_MOVE, s_mouseevent);
				s.addEventListener(MouseEvent.MOUSE_UP, s_mouseevent);
			}
			tf = new TextField;
			tf.y = 200;
			addChild(tf);
		}
		
		private function s_mouseevent(e:MouseEvent):void 
		{
			tf.text = e.type;
		}
		
		private function s_mouseOut(e:MouseEvent):void 
		{
			var t:DisplayObject = e.currentTarget as DisplayObject;
			t.alpha = 1;
			t.scaleX = t.scaleY = 1;
		}
		
		private function s_mouseOver(e:MouseEvent):void 
		{
			var t:DisplayObject = e.currentTarget as DisplayObject;
			t.alpha = .5;
			t.scaleX = t.scaleY = 1.2;
		}
		
	}

}