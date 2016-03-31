package net 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author lizhi
	 */
	public class BatLoader extends EventDispatcher
	{
		public var assets:Object = {};
		private var urls:Array = [];
		private var p:int = 0;
		public var loading:Array;
		public function BatLoader() 
		{
			
		}
		
		public function addImage(url:String):void{
			urls.push(["image",url]);
		}
		
		public function addJSON(url:String):void{
			urls.push(["json",url]);
		}
		
		public function load():void{
			next();
		}
		
		private function next():void{
			if(p<urls.length){
				loading = urls[p++]
				var req:URLRequest = new URLRequest(loading[1]);
				if (loading[0]=="image") {
					var imageloader:Loader = new Loader;
					imageloader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageloader_complete);
					imageloader.load(req);
				}else if (loading[0]=="json") {
					var jsonloader:URLLoader = new URLLoader;
					jsonloader.addEventListener(Event.COMPLETE, jsonloader_complete);
					jsonloader.load(req);
				}
				dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, p - 1, urls.length));
			}else{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function jsonloader_complete(e:Event):void 
		{
			assets[loading[1]] = JSON.parse((e.currentTarget as URLLoader).data as String);
			next();
		}
		
		private function imageloader_complete(e:Event):void 
		{
			assets[loading[1]] = ((e.currentTarget as LoaderInfo).content as Bitmap).bitmapData;
			next();
		}
	}

}