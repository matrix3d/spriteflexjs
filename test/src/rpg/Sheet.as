package rpg 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.IO;
	import net.LoaderEx;
	import net.UrlLoaderEx;
	/**
	 * ...
	 * @author lizhi
	 */
	public class Sheet 
	{
		private var baseurl:String;
		
		private var animObjLoader:UrlLoaderEx;
		private var animBmdLoader:LoaderEx;
		private var loadOverJSON:Boolean = false;
		private var loadOverBMD:Boolean = false;
		public var image:Bitmap = new Bitmap;
		public var appLoop:Boolean = false;
		public function Sheet(baseurl:String) 
		{
			this.baseurl = baseurl;
		}
		
		public function play(name:String):void{
			if (animObjLoader){
				animObjLoader.removeEventListener(Event.COMPLETE, animObjLoader_complete);
			}
			if (animBmdLoader){
				animBmdLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, animBmdLoader_complete);
			}
			animObjLoader = IO.getBinLoader(baseurl + name+".json");
			animBmdLoader = IO.getImageLoader(baseurl + name+".png");
			if (animObjLoader.data){
				loadOverJSON = true;
			}else{
				loadOverJSON = false;
				animObjLoader.addEventListener(Event.COMPLETE, animObjLoader_complete);
			}
			if (animBmdLoader.content){
				loadOverBMD = true;
			}else{
				loadOverBMD = false;
				animBmdLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, animBmdLoader_complete);
			}
		}
		private function animBmdLoader_complete(e:Event):void 
		{
			loadOverBMD = true;
		}
		
		private function animObjLoader_complete(e:Event):void 
		{
			loadOverJSON = true;
		}
		
		public function update(animFrame:Number, animDir:int):void{
			appLoop = false;
			if(loadOverBMD&&loadOverJSON){
				if (animObjLoader.userData["bmd"]==null){
					animBmdLoader.userData["bmd"] = (animBmdLoader.content as Bitmap).bitmapData;
				}
				if(animObjLoader.userData["obj"]==null){
					animObjLoader.userData["obj"] = JSON.parse(animObjLoader.data as String);
				}
				var obj:Object = animObjLoader.userData["obj"]["ts"];
				var info:Object = animObjLoader.userData["obj"]["info"];
				var bmd:BitmapData = animBmdLoader.userData["bmd"] as BitmapData;
				var objs:Array = animObjLoader.userData[animDir];
				if (objs==null) {
					objs = animObjLoader.userData[animDir] = [];
					for (var i:int = 0; i < obj.length / 8; i++ ) {
						var j:int = animDir * int(obj.length / 8)+i;
						var sobj:Object = obj[j];
						sobj.i = j;
						objs.push(sobj);
					}
				}
				var bmds:Array = animBmdLoader.userData["pngs"];
				if (bmds==null) {
					bmds = animBmdLoader.userData["pngs"] = [];
				}
				var numFrame:int = objs.length;
				if (animFrame>=numFrame) {
					animFrame = 0;
					appLoop = true;
				}
				var id:int = int(animFrame);
				var data:Object = objs[id];
				var sbmd:BitmapData = bmds[data.i];
				if (sbmd==null) {
					sbmd = new BitmapData(data["w"], data["h"], bmd.transparent, 0);
					sbmd.copyPixels(bmd, new Rectangle(data["x"], data["y"],data["w"],data["h"]), new Point);
					bmds[data.i] = sbmd;
				}
				image.bitmapData = sbmd;
				image.x = data["fx"] - info["w"] / 2;
				image.y = data["fy"] - info["h"] / 2;
			}else{
				numFrame =-1;
			}
		}
	}

}