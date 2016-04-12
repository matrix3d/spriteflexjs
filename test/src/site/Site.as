package site 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	import pathfind.AStar;
	import pathfind.Node;
	import rpg.MMP;
	import rpg.Player;
	import rpg.Sheet;
	import spriteflexjs.Stats;
	/**
	 * ...
	 * @author lizhi
	 */
	public class Site extends Sprite
	{
		
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
		private var xlen:int;
		private var ylen:int;
		private var mapdata:Array;
		private var lastTime:Number = 0;
		private var isMouseDown:Boolean = false;
		private var isMouseUp:Boolean = false;
		private var loader:Loader;
		private var mmploader:URLLoader;
		private var mmpobj:Object;
		private var mmp:MMP;
		
		public function Site() 
		{
			mmploader = new URLLoader(new URLRequest("../../assets/site/__out/s10100/s10100.json"));
			mmploader.addEventListener(Event.COMPLETE, mmploader_complete);
			
		}
		
		private function mmploader_complete(e:Event):void 
		{
			astar = new AStar;
			mmpobj = JSON.parse(mmploader.data + "");
			tw = mmpobj["w"];
			th = mmpobj["h"];
			xlen = mmpobj["xlen"];
			ylen = mmpobj["ylen"];
			mapdata = mmpobj["r"];
			for (var x:int = 0; x < xlen; x++){
				for (var y:int = 0; y < ylen; y++){
					var v:int = mapdata[x * ylen + y];
					if(v!=1)
					astar.add(new Node(x, y));
				}
			}
			init();
		}
		
		private function loader_complete(e:Event):void 
		{
			mapLayer.addChildAt(loader.content,0);
		}
		
		private function addPlayer(sheets:Array):Player{
			var player:Player = new Player();
			for each(var sheet:String in sheets){
				player.addSheet(new Sheet("../../assets/site/__out/" + sheet + "/"));
			}
			players.push(player);
			player.speed = 3.5 / 60;
			player.animSpeed = 0.25;
			player.name2animSpeed = {};
			player.name2animSpeed["idle"] = 0.1;
			playerLayer.addChild(player);	
			player.play("idle", int(Math.random() * 8));
			return player;
		}
		
		private function init():void 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			mmp = new MMP("../../assets/site/__out/s10100/", 256, int(mmpobj["mw"] / 256), int(mmpobj["mh"] / 256));
			mapLayer.addChild(mmp);
			
			var names:Array = ["diaoxiang", "huangquanjiaozhu", "molongjiaozhu","nanzhanlv3","niumowang","nvfalv4","wumajiaozhu","wuqinanzhanlv1","wuqinvfalv3"];
			//myPlayer = addPlayer(["nanzhanlv3","wuqinanzhanlv1"]);
			myPlayer = addPlayer(["nvfalv4", "wuqinvfalv3"]);
			myPlayer.x = 2000;
			myPlayer.y = 1600;
			
			var player:Player = addPlayer(["diaoxiang"]);
			player.x = 1650;
			player.y = 1130;
			
			player = addPlayer(["diaoxiang"]);
			player.x = 2255;
			player.y = 1550;
			
			player = addPlayer(["huangquanjiaozhu"]);
			player.x = 1855;
			player.y = 1550;
			
			//loader = new Loader;
			//loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
			//loader.load(new URLRequest("../../assets/site/new_map.jpg"));
			lastTime = getTimer();
			addChild(worldLayer);
			addChild(new Stats);
			worldLayer.addChild(mapLayer);
			worldLayer.addChild(debugLayer);
			worldLayer.addChild(playerLayer);
			
			
			camera.x = myPlayer.x;
			camera.y = myPlayer.y;
			
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
			//myPlayer.moveTo([[myPlayer.x,myPlayer.y],[worldLayer.mouseX,worldLayer.mouseY]]);
			var sx:int = int(myPlayer.x / tw);
			var sy:int = int(myPlayer.y / th);
			var ex:int = int(worldLayer.mouseX / tw);
			var ey:int = int(worldLayer.mouseY / th);
			if (astar.findPath(sx, sy, ex, ey)) {
				//astar.floyd();
				var path:Array = [];
				debugLayer.graphics.clear();
				debugLayer.graphics.lineStyle(0);
				var flag:Boolean = false;
				for each(var node:Node in astar.path) {
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
				var sx:int = int(player.x / tw);
				var sy:int = int(player.y / th);
				var v:int = mapdata[sx*ylen + sy];
				if (v==0){
					player.alpha =1;
				}else if (v==2){
					player.alpha = .7;
				}
			}
			playerLayer.removeChildren();
			CONFIG::as_only {
				players.sortOn("y", Array.NUMERIC);
			}
			for each(player in players){
				playerLayer.addChild(player);
			}
			var elas:Number = .1;
			camera.x += (myPlayer.x - camera.x) * elas;
			camera.y += (myPlayer.y - camera.y) * elas;
			if (camera.x<stage.stageWidth/2){
				camera.x = stage.stageWidth / 2;
			}
			
			if (camera.y<stage.stageHeight/2){
				camera.y = stage.stageHeight / 2;
			}
			var w:int = mmpobj["mw"];
			var h:int = mmpobj["mh"];
			if (camera.x>w-stage.stageWidth/2){
				camera.x = w - stage.stageWidth / 2;
			}
			if (camera.y>h-stage.stageHeight/2){
				camera.y = h - stage.stageHeight / 2;
			}
			worldLayer.x = -int(camera.x) + int(stage.stageWidth / 2);
			worldLayer.y = -int(camera.y) + int(stage.stageHeight / 2);
			mmp.update( -worldLayer.x, -worldLayer.y, stage.stageWidth, stage.stageHeight);
			lastTime = now;
		}
	}

}