package 
{
	CONFIG::js_only{
	import flash.__native.WebGLRenderer;
	}
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import spriteflexjs.Stats;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestTMX extends Sprite
	{
		private var tmxloader:URLLoader;
		private var mapLayer:Sprite = new Sprite;
		private var pngs:Array = [];
		private var tmxobj:Object;
		private var tw:Number;
		private var th:Number;
		public function TestTMX() 
		{
			CONFIG::js_only{
			SpriteFlexjs.wmode = "gpu batch";
			SpriteFlexjs.renderer = new WebGLRenderer;
			}
			tmxloader = new URLLoader(new URLRequest("../../assets/tmx/sewers.json"));
			tmxloader.addEventListener(Event.COMPLETE, tmxloader_complete);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		private function tmxloader_complete(e:Event):void 
		{
			tmxobj = JSON.parse(tmxloader.data + "");
			loadNextTile();
		}
		
		private function loadNextTile():void 
		{
			if (pngs.length<tmxobj["tilesets"].length) {
				var loader:Loader = new Loader;
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
				var tset:Object = tmxobj["tilesets"][pngs.length];
				var url:String = tset["image"];
				url = url.slice(url.lastIndexOf("\/")+1);
				loader.load(new URLRequest("../../assets/tmx/"+url));
			}else {
				init();
			}
		}
		
		private function loader_complete(e:Event):void 
		{
			pngs.push(((e.currentTarget as LoaderInfo).content as Bitmap).bitmapData);
			loadNextTile();
		}
		
		private function init():void 
		{
			addChild(mapLayer);
			addChild(new Stats);
			
			var tsetpngs:Array = [];
			for (var i:int = 0; i < tmxobj["tilesets"].length;i++ ) {
				var tset:Object = tmxobj["tilesets"][i];
				tw = tset["tilewidth"];
				th = tset["tileheight"];
				var png:BitmapData = pngs[i] as BitmapData;
				for (var j:int = 0; j < tset["tilecount"];j++ ) {
					var ttw:int = tset["tilewidth"];
					var tth:int = tset["tileheight"];
					var numCols:int = tset["imagewidth"]/ttw;
					var tx:int = int(j % numCols);
					var ty:int = int(j / numCols);
					//var dst:BitmapData = new BitmapData(tw, th, png.transparent, 0);
					//dst.copyPixels(png, new Rectangle(tx * tw, ty * th, tw, th), new Point);
					var dst:Array = [png, new Rectangle(tx * tw, ty * th, tw, th)];
					tsetpngs[j + tset["firstgid"]] = dst;
				}
			}
			tw = tmxobj["tilewidth"];
			th = tmxobj["tileheight"];
			
			for each(var layer:Object in tmxobj["layers"]) {
				for (i = 0; i < layer["data"].length; i++ ) {
					var id:int = layer["data"][i];
					if(id>0){
						var x:int = int(i % layer["width"]);
						var y:int = int(i / layer["width"]);
						dst = tsetpngs[id];
						png = dst[0];
						var rect:Rectangle = dst[1];
						mapLayer.graphics.beginBitmapFill(png,new Matrix(1,0,0,1,-rect.x+x*tw,-rect.y+y*th));
						mapLayer.graphics.drawRect(x * tw, y * th, tw, th);
						//var image:Bitmap = new Bitmap(tsetpngs[id]);
						//image.x = x * tw;
						//image.y = y * th;
						//mapLayer.addChild(image);
						//if (id == 28) {
							//astar.add(new Node(x, y));
						//}
					}
				}
			}
		}
	}
}