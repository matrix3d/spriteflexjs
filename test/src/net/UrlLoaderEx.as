package net 
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author lizhi
	 */
	public class UrlLoaderEx extends URLLoader
	{
		public var request:URLRequest;
		public var userData:Object = {};
		public function UrlLoaderEx() 
		{
			
		}
		
		override public function load(request:URLRequest):void 
		{
			this.request = request;
			super.load(request);
		}
	}

}