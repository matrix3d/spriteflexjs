package flash.utils
{
	import flash.events.*;
	
	public class SetIntervalTimer extends Timer
	{
		
		private static var intervals:Array = [];
		
		public var id:uint;
		
		private var closure:Function;
		
		private var rest:Array;
		
		public function SetIntervalTimer(closure:Function, delay:Number, repeats:Boolean, rest:Array)
		{
			super(delay, repeats ? 0 : 1);
			this.closure = closure;
			this.rest = rest;
			addEventListener(TimerEvent.TIMER, this.onTimer);
			start();
			this.id = intervals.length + 1;
			intervals.push(this);
		}
		
		public static function clearInterval(id_to_clear:uint):void
		{
			id_to_clear--;
			if (intervals[id_to_clear] is SetIntervalTimer)
			{
				intervals[id_to_clear].stop();
				delete intervals[id_to_clear];
			}
		}
		
		private function onTimer(event:Event):void
		{
			this.closure.apply(null, this.rest);
			if (repeatCount === 1)
			{
				if (intervals[this.id - 1] == this)
				{
					delete intervals[this.id - 1];
				}
			}
		}
	}
}
