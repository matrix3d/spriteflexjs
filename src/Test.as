package 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author lizhi
	 */
	public class Test 
	{
		
		public function Test() 
		{
			
		}
		
		public function start():void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
			loader.load(new URLRequest("http://www.baidu.com/img/bd_logo1.png"));
		}
		
		private function loader_complete(e:Event):void 
		{
			var target:LoaderInfo = e.currentTarget as LoaderInfo;
			alert((target.content as Bitmap).bitmapData.width);
		}
		
	}

}