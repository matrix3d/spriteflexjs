package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestGraphicsPerformance extends Sprite
	{
		private var vs:Array = [];
		public function TestGraphicsPerformance() 
		{
			addEventListener(Event.ENTER_FRAME, enterFrame);
			for (var i:int = 0; i < 1000;i++ ) {
				add();
			}
		}
		
		private function add():void {
			var s:Sprite = new Sprite;
			s.graphics.beginFill(0xffffff * Math.random());
			s.graphics.lineStyle(0, 0xffffff * Math.random());
			s.graphics.drawRect( -25, -25, 50, 50);
			s.x = 400 * Math.random();
			s.y = 400 * Math.random();
			s.rotation = 360 * Math.random();
			addChild(s);
			vs.push({s:s,v:[36*(Math.random()-.5),20*(Math.random()-.5),20*(Math.random()-.5)]});
		}
		
		private function enterFrame(e:Event):void 
		{
			for each(var b:Object in vs) {
				var s:Sprite = b.s as Sprite;
				var v:Array = b.v as Array;
				s.rotation += v[0];
				v[2] += 1;
				if (v[2] > 10) {
					v[2] = 10;
				}
				s.x += v[1];
				s.y += v[2];
				if (s.x<0) {
					s.x = 0;
					v[1] *= -1;
				}
				if (s.x > 400) {
					s.x = 400;
					v[1] *= -1;
				}
				if (s.y<0) {
					s.y = 0;
					v[2] *= -1;
				}
				if (s.y > 400) {
					s.y = 0;
					//v[2] *= -1;
				}
			}
		}
		
	}

}