package net 
{
	import flash.display.Loader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author lizhi
	 */
	public class IO 
	{
		public static var assets:Object = {};
		public function IO() 
		{
			
		}
		
		public static function getImageLoader(url:String):LoaderEx{
			var loader:LoaderEx = assets[url] as LoaderEx;
			if (loader==null){
				loader = assets[url] = new LoaderEx;
				loader.load(new URLRequest(url));
			}
			return loader;
		}
		
		public static function getBinLoader(url:String):UrlLoaderEx{
			var loader:UrlLoaderEx = assets[url] as UrlLoaderEx;
			if (loader==null){
				loader = assets[url] = new UrlLoaderEx;
				loader.load(new URLRequest(url));
			}
			return loader;
		}
	}

}