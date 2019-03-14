package fairygui.event
{
	import flash.events.Event;
	
	public class StateChangeEvent extends Event 
	{
		public static const CHANGED:String = "stateChanged";

		public function StateChangeEvent(type:String) 
		{
			super(type, false, false);
		}
	}
	
}