package rpg 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import net.IO;
	import net.LoaderEx;
	/**
	 * ...
	 * @author lizhi
	 */
	public class MMP extends Sprite
	{
		private var baseurl:String;
		private var maps:Object = {};
		private var size:int;
		private var numRows:int;
		private var numCols:int;
		public function MMP(baseurl:String,size:int,numRows:int,numCols:int) 
		{
			this.numCols = numCols;
			this.numRows = numRows;
			this.size = size;
			this.baseurl = baseurl;
			
		}
		
		public function update(sx:Number, sy:int, sw:int, sh:int):void{
			for each(var map:DisplayObject in maps){
				map.visible = false;
			}
			//trace(sx, sy, sw, sh);
			//graphics.clear();
			//graphics.lineStyle(0, 0xff0000);
			//graphics.drawRect(sx + 10, sy + 10, sw - 20, sh - 20);
			var sxid:int = int(sx / size);
			var syid:int = int(sy / size);
			var exid:int = Math.ceil((sx+sw)/size);
			var eyid:int = Math.ceil((sy + sh) / size);
			//graphics.lineStyle(0, 0xff);
			for (var x:int = sxid; x < exid;x++ ){
				for (var y:int = syid; y < eyid; y++ ){
					var url:String = y + "_" + x;
					map = maps[url];
					if (map==null){
						map = new Bitmap;
						map.x = x * size;
						map.y = y * size;
						addChild(map);
						maps[url] = map;
						var loader:LoaderEx = IO.getImageLoader(baseurl + "s10100_" + url + ".jpg");
						loader.userData.map = map;
						loader.addEventListener(Event.COMPLETE, loader_complete);
					}
					map.visible = true;
					//graphics.drawRect(x * size+5, y * size+5, size-10, size -10);
				}
			}
		}
		
		private function loader_complete(e:Event):void 
		{
			var loader:LoaderEx = e.currentTarget as LoaderEx;
			loader.userData.map.bitmapData = (loader.content as Bitmap).bitmapData;
		}
	}

}