package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import spriteflexjs.Stats;
	import supertest.S1;
	import supertest.S4;
	/**
	 * ...
	 * @author lizhi
	 */
	public class SuperTest extends Sprite
	{
		private var ss:Array = [];
		private var bmd:BitmapData;
		public function SuperTest() 
		{
			addChild(new Stats);
			for (var i:int = 0; i < 100000;i++ ){
				ss.push(new S4);
			}
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void 
		{
			var len:int = ss.length;
			for (var i:int = 0; i < len;i++){
				var s:S4 = ss[i];
				if (s.test){
					
				}
			}
		}
		
	}

}