package net 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author lizhi
	 */
	public class IO 
	{
		public static var assets:Object = {};
		private static var waits:Array = [];
		private static var loadings:Array = [];
		private static var comps:Array = [];
		private static var errors:Array = [];
		public function IO() 
		{
			
		}
		
		public static function next():void{
			if (waits.length&&loadings.length < 4){
				var loader:Object = waits.shift();
				loadings.push(loader);
				loader.load(loader.request);
			}
		}
		
		public static function getImageLoader(url:String):LoaderEx{
			var loader:LoaderEx = assets[url] as LoaderEx;
			if (loader==null){
				loader = assets[url] = new LoaderEx;
				loader.addEventListener(Event.COMPLETE, loader_complete);
				loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioError);
				loader.request = new URLRequest(url);
				waits.push(loader);
				next();
				//loader.load(new URLRequest(url));
			}
			return loader;
		}
		
		static private function loader_ioError(e:IOErrorEvent):void 
		{
			var loader:Object = e.currentTarget;
			var i:int = loadings.indexOf(loader);
			if (i!=-1){
				loadings.splice(i, 1);
			}
			errors.push(loader);
			next();
		}
		
		static private function loader_complete(e:Event):void 
		{
			var loader:Object = e.currentTarget;
			var i:int = loadings.indexOf(loader);
			if (i!=-1){
				loadings.splice(i, 1);
			}
			comps.push(loader);
			next();
		}
		
		public static function getBinLoader(url:String):UrlLoaderEx{
			var loader:UrlLoaderEx = assets[url] as UrlLoaderEx;
			if (loader==null){
				loader = assets[url] = new UrlLoaderEx;
				loader.addEventListener(Event.COMPLETE, loader_complete);
				loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioError);
				//loader.load(new URLRequest(url));
				loader.request = new URLRequest(url);
				waits.push(loader);
				next();
			}
			return loader;
		}
	}

}