package parser.tmx 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TMX extends Sprite
	{
		private var jsonloader:URLLoader;
		private var tmxobj:Object;
		private var pngs:Array = [];
		public function TMX() 
		{
			
		}
		
		public function loadJSON(url:String):void {
			jsonloader = new URLLoader(new URLRequest(url));
			jsonloader.addEventListener(Event.COMPLETE, jsonloader_complete);
		}
		
		private function jsonloader_complete(e:Event):void 
		{
			tmxobj = JSON.parse(jsonloader.data + "");
			loadNextTile();
		}
		
		private function loadNextTile():void 
		{
			if (pngs.length<tmxobj.tilesets.length) {
				var loader:Loader = new Loader;
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
				var tset:Object = tmxobj.tilesets[pngs.length];
				var url:String = tset.image;
				url = url.slice(url.lastIndexOf("\/")+1);
				loader.load(new URLRequest("../../assets/tmx/"+url));
			}else {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function loader_complete(e:Event):void 
		{
			pngs.push(((e.currentTarget as LoaderInfo).content as Bitmap).bitmapData);
			loadNextTile();
		}
	}

}