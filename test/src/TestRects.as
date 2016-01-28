package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import spriteflexjs.Stats;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestRects extends Sprite
	{
		private var objs:Array;
		
		public function TestRects() 
		{
			objs =[];
			for(var i:int=0;i<10000;i++){
				var obj:MySprite = new MySprite;
				obj.vx = 20 * (Math.random() - .5);
				obj.vy = 20 * (Math.random() - .5);
				obj.x = 400 * Math.random();
				obj.y = 400 * Math.random();
				addChild(obj);
				obj.graphics.beginFill(0xffffff * Math.random());
				var size2:Number=20+20*Math.random()
				obj.graphics.drawRect(0, 0, size2, size2);
				objs.push(obj);
			}
			addEventListener(Event.ENTER_FRAME, enterFrame);
			addChild(new Stats);0
		}
		
		private function enterFrame(e:Event):void 
		{
			for (var i:int=0;i<this.objs.length;i++){
				var obj:MySprite=this.objs[i];
				obj.x+=obj.vx;
				obj.y+=obj.vy;
				if((obj.x>400)||(obj.x<0)){
					obj.vx*=-1;
				}
				if((obj.y>400)||(obj.y<0)){
					obj.vy*=-1;
				}
			}
		}
	}
}
import flash.display.Shape;
import flash.display.Sprite;

class MySprite extends Shape{
	public var vx:Number;
	public var vy:Number;
}