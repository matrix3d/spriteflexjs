package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import pathfind.AStar;
	import pathfind.Node;
	import rpg.Player;
	import rpg.Sheet;
	import spriteflexjs.Stats;
	import parser.tmx.TMX;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestTMX extends Sprite
	{
		private var tmxloader:URLLoader;
		private var pngs:Array = [];
		private var tmxobj:Object;
		private var camera:Point = new Point;
		private var worldLayer:Sprite = new Sprite;
		private var mapLayer:Sprite = new Sprite;
		private var playerLayer:Sprite = new Sprite;
		private var debugLayer:Sprite = new Sprite;
		private var myPlayer:Player;
		private var players:Array = [];
		private var astar:AStar;
		private var tw:Number;
		private var th:Number;
		private var lastTime:Number = 0;
		private var isMouseDown:Boolean = false;
		private var isMouseUp:Boolean = false;
		public function TestTMX() 
		{
			tmxloader = new URLLoader(new URLRequest("../../assets/tmx/sewers.json"));
			tmxloader.addEventListener(Event.COMPLETE, tmxloader_complete);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var names:Array = ["u1", "u2", "nanzhanLv1"];
			for (var i:int = 0; i < 10;i++ ){
				var player:Player = new Player();
				player.addSheet(new Sheet("../../assets/mir/role/"+names[int(names.length*Math.random())]+"/"));
				players.push(player);
				playerLayer.addChild(player);
				player.x =800+ int(400 * (Math.random()-.5));
				player.y = 500 +int(400 * (Math.random() - .5));	
				player.play("idle", int(Math.random() * 8));
			}
			myPlayer = player;
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
			lastTime = getTimer();
			addChild(worldLayer);
			addChild(new Stats);
			worldLayer.addChild(mapLayer);
			worldLayer.addChild(debugLayer);
			worldLayer.addChild(playerLayer);
			
			var tsetpngs:Array = [];
			for (var i:int = 0; i < tmxobj["tilesets"].length;i++ ) {
				var tset:Object = tmxobj["tilesets"][i];
				tw = tset["tilewidth"];
				th = tset["tileheight"];
				var png:BitmapData = pngs[i] as BitmapData;
				for (var j:int = 0; j < tset["tilecount"];j++ ) {
					var tx:int = int(j % numCols);
					var ty:int = int(j / numCols);
					var ttw:int = tset["tilewidth"];
					var tth:int = tset["tileheight"];
					var numCols:int = tset["imagewidth"]/ttw;
					var dst:BitmapData = new BitmapData(tw, th, png.transparent, 0);
					dst.copyPixels(png, new Rectangle(tx * tw, ty * th, tw, th), new Point);
					tsetpngs[j + tset["firstgid"]] = dst;
				}
			}
			tw = tmxobj["tilewidth"];
			th = tmxobj["tileheight"];
			
			camera.x = myPlayer.x;
			camera.y = myPlayer.y;
			astar = new AStar;
			for each(var layer:Object in tmxobj["layers"]) {
				for (i = 0; i < layer["data"].length; i++ ) {
					var id:int = layer["data"][i];
					if(id>0){
						var x:int = int(i % layer["width"]);
						var y:int = int(i / layer["width"]);
						var image:Bitmap = new Bitmap(tsetpngs[id]);
						image.x = x * tw;
						image.y = y * th;
						mapLayer.addChild(image);
						if (id == 28) {
							astar.add(new Node(x, y));
						}
					}
				}
			}
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUp);
		}
		
		private function stage_mouseUp(e:MouseEvent):void 
		{
			isMouseDown = false;
			isMouseUp = true;
		}
		
		private function stage_mouseDown(e:MouseEvent):void 
		{
			isMouseDown = true;
		}
		
		private function startMove():void 
		{
			var sx:int = int(myPlayer.x / tw);
			var sy:int = int(myPlayer.y / th);
			var ex:int = int(worldLayer.mouseX / tw);
			var ey:int = int(worldLayer.mouseY / th);
			if (astar.findPath(sx, sy, ex, ey)) {
				astar.floyd();
				var path:Array = [];
				debugLayer.graphics.clear();
				debugLayer.graphics.lineStyle(0);
				var flag:Boolean = false;
				for each(var node:Node in astar.floydPath) {
					var x:Number = (node.x + .5) * tw;
					var y:Number = (node.y + .5) * th;
					path.push([node.x, node.y]);
					if (flag) {
						debugLayer.graphics.lineTo(x, y);
					}else {
						debugLayer.graphics.moveTo(x, y);
					}
					flag = true;
					debugLayer.graphics.drawCircle(x, y, 5);
					debugLayer.graphics.moveTo(x, y);
				}
				if(path.length>1){
					myPlayer.moveTo(path,[tw,th]);
				}
			}
		}
		
		private function enterFrame(e:Event):void 
		{
			if (isMouseDown){
				startMove();
			}
			if (isMouseUp){
				//click
				for each(var player:Player in players) {
					if (player.playerHittest(worldLayer.mouseX, worldLayer.mouseY)){
						if (player!=myPlayer){
							myPlayer.attack(player);
						}
					}
				}
				isMouseUp = false;
			}
			var now:Number = getTimer();
			for each(player in players) {
				player.update(now - lastTime);
			}
			playerLayer.removeChildren();
			CONFIG::as_only {
				players.sortOn("y", Array.NUMERIC);
			}
			for each(player in players){
				playerLayer.addChild(player);
			}
			var elas:Number = .1;
			camera.x += (myPlayer.x-camera.x)*elas;
			camera.y += (myPlayer.y-camera.y)*elas;
			worldLayer.x = -int(camera.x) + int(stage.stageWidth / 2);
			worldLayer.y = -int(camera.y) + int(stage.stageHeight / 2);
			lastTime = now;
		}
	}
}