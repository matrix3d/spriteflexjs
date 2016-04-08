package net 
{
	import flash.system.LoaderContext;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author lizhi
	 */
	public class LoaderEx extends Loader
	{
		public var request:URLRequest;
		public var userData:Object = {};
		public function LoaderEx() 
		{
			contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
		}
		
		private function complete(e:Event):void 
		{
			dispatchEvent(e);
		}
		
		override public function load(request:URLRequest, context:LoaderContext = null):void 
		{
			this.request = request;
			super.load(request, context);
		}
		
	}

}