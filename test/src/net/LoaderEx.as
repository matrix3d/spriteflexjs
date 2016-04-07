package net 
{
	import flash.display.Loader;
	import flash.events.Event;
	/**
	 * ...
	 * @author lizhi
	 */
	public class LoaderEx extends Loader
	{
		public var userData:Object = {};
		public function LoaderEx() 
		{
			contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
		}
		
		private function complete(e:Event):void 
		{
			dispatchEvent(e);
		}
		
	}

}