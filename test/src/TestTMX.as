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
		public function TestTMX() 
		{
			tmxloader = new URLLoader(new URLRequest("../../assets/tmx/sewers.json"));
			tmxloader.addEventListener(Event.COMPLETE, tmxloader_complete);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var names:Array = ["u1", "u2", "nanzhanLv1"];
			for (var i:int = 0; i < 10;i++ ){
				var player:Player = new Player("../../assets/mir/role/"+names[int(names.length*Math.random())]+"/");
				players.push(player);
				playerLayer.addChild(player);
				player.x =800+ 400 * (Math.random()-.5);
				player.y = 500 +400 * (Math.random() - .5);	
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
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
		}
		
		private function stage_mouseDown(e:MouseEvent):void 
		{
			startMove();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
		}
		
		private function stage_mouseMove(e:MouseEvent):void 
		{
			startMove();
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
					path.push([x, y]);
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
					myPlayer.moveTo(path);
				}
			}
		}
		
		private function enterFrame(e:Event):void 
		{
			var now:Number = getTimer();
			for each(var player:Player in players) {
				player.update(now - lastTime);
			}
			playerLayer.removeChildren();
			players.sortOn("y", Array.NUMERIC);
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
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import net.IO;
import net.LoaderEx;
import net.UrlLoaderEx;

class Player extends Sprite {
	private var path:Array = [];
	private var pathPtr:int;
	private var moving:Boolean = false;
	private var movingTime:Number = 0;
	private var animName:String;
	private var animDir:int
	private var animObjLoader:UrlLoaderEx;
	private var animBmdLoader:LoaderEx;
	private var loadOverJSON:Boolean = false;
	private var loadOverBMD:Boolean = false;
	private var animFrame:Number = 0;
	private var playing:Boolean = false;
	private var dirDirty:Boolean = true;
	private var speed:Number =  2;
	private var image:Bitmap = new Bitmap;
	private var baseurl:String;
	public function Player(baseurl:String) 
	{
		this.baseurl = baseurl;
		graphics.beginFill(0xff0000);
		graphics.drawCircle(0, 0, 5);
		addChild(image);
		play("idle",0)
	}
	
	public function moveTo(path:Array):void {
		this.path = path;
		path[0][0] = x;
		path[0][1] = y;
		pathPtr = 0;
		moving = true;
		movingTime = 0;
		dirDirty = true;
		play("run", animDir);
	}
	
	public function play(name:String,dir:int,frame:int=-1):void {
		animName = name;
		animDir = dir;
		if(frame>=0){
			animFrame = frame;
		}
		playing = true;
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
		animBmdLoader.userData["bmd"] = (animBmdLoader.content as Bitmap).bitmapData;
		loadOverBMD = true;
	}
	
	private function animObjLoader_complete(e:Event):void 
	{
		animObjLoader.userData["obj"] = JSON.parse(animObjLoader.data as String);
		loadOverJSON = true;
	}
	
	public function update(delta:Number):void {
		if (moving) {
			var p0:Array = path[pathPtr];
			var p1:Array = path[pathPtr+1];
			var dx:Number = p1[0]-p0[0];
			var dy:Number = p1[1]-p0[1];
			var len:Number = Math.sqrt(dx * dx + dy * dy);
			var deltaSpeed:Number = (movingTime+delta) * speed / (1000 / 60);
			if (dirDirty) {
				var dir:int = Math.round(Math.atan2(dy, dx) / (Math.PI / 4));
				//rotation = dir * 180 / 4;
				dir += 18;
				dir = dir % 8;
				play(animName, dir);
				dirDirty = false;
			}
			if (len<=deltaSpeed) {
				x = p1[0];
				y = p1[1];
				pathPtr++;
				movingTime = 0;
				dirDirty = true;
				if (pathPtr>=(path.length-1)) {
					moving = false;
					play("idle", animDir)
				}else {
					play("run", animDir);
				}
			}else {
				x =p0[0]+ int(deltaSpeed * dx / len);
				y =p0[1]+ int(deltaSpeed * dy / len);
			}
			movingTime+= delta;
		}
		if (playing&&loadOverBMD&&loadOverJSON) {
			var obj:Object = animObjLoader.userData["obj"]["ts"];
			var info:Object = animObjLoader.userData["obj"]["info"];
			var bmd:BitmapData = animBmdLoader.userData["bmd"] as BitmapData;
			var objs:Array = animObjLoader.userData[animDir];
			if (objs==null) {
				objs = animObjLoader.userData[animDir] = [];
				for (var i:int = 0; i < obj.length / 8; i++ ) {
					var j:int = animDir * obj.length / 8+i;
					var sobj:Object = obj[j];
					sobj.i = j;
					objs.push(sobj);
				}
			}
			
			var bmds:Array = animBmdLoader.userData["pngs"];
			if (bmds==null) {
				bmds = animBmdLoader.userData["pngs"] = [];
			}
			animFrame+= 0.15 * delta / (1000 / 60);
			if (animFrame>=objs.length) {
				animFrame = 0;
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
			image.x = data["fx"]-info["w"]/2;
			image.y = data["fy"]-info["h"]/2;
		}
	}
}