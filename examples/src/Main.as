package
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLVariables;
	import flash.text.Font;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	import spriteflexjs.Stats;
	public class Main extends Sprite{
		private var arr:Array = [0];
		private var arr2:Float32Array = new Float32Array(1);
		public function Main() 
		{
			var v:URLVariables = new URLVariables("sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=0ahUKEwiWgMXk2KLPAhVHxoMKHXEmCtIQFgghMAA&url=http%3A%2F%2Fwww.w3school.com.cn%2Fjsref%2Fjsref_unescape.asp&usg=AFQjCNGo_udYljpJ-_SA4piSBsBgcSCYvw");
			trace(v);
			addEventListener(Event.ENTER_FRAME, enterFrame);
			addChild(new Stats);
			
			setInterval(null);
			new Timer(1000);setInterval()
		}
		
		private function enterFrame(e:Event):void 
		{
			for (var i:int = 0; i < 100000000;i++ ){
				var a:Number = arr2[0] as Number;
			}
		}
	}
}