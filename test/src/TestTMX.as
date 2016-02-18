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
	import pathfind.AStar;
	import pathfind.Node;
	import spriteflexjs.Stats;
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
		private var myPlayer:Player = new Player;
		private var players:Array = [];
		private var astar:AStar;
		private var tw:Number;
		private var th:Number;
		private var roleasseturls:Array = ["idle.json","idle.png","walk.json","walk.png"];
		public static var roleassets:Object = { };
		private var roleasseturl:String;
		public function TestTMX() 
		{
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
			if (pngs.length<tmxobj.tilesets.length) {
				var loader:Loader = new Loader;
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
				var tset:Object = tmxobj.tilesets[pngs.length];
				var url:String = tset.image;
				url = url.slice(url.lastIndexOf("\/")+1);
				loader.load(new URLRequest("../../assets/tmx/"+url));
			}else {
				loadNextRole();
			}
		}
		
		private function loadNextRole():void 
		{
			if (roleasseturls.length==0) {
				init();
			}else {
				roleasseturl = roleasseturls.shift() as String;
				if (roleasseturl.indexOf(".json")!=-1) {
					var jsonloader:URLLoader = new URLLoader;
					jsonloader.addEventListener(Event.COMPLETE, jsonloader_complete);
					jsonloader.load(new URLRequest("../../assets/mir/role/1/"+roleasseturl));
				}else {
					var pngloader:Loader = new Loader;
					pngloader.contentLoaderInfo.addEventListener(Event.COMPLETE, pngloader_complete);
					pngloader.load(new URLRequest("../../assets/mir/role/1/"+roleasseturl));
				}
			}
		}
		
		private function pngloader_complete(e:Event):void 
		{
			roleassets[roleasseturl] = ((e.currentTarget as LoaderInfo).content as Bitmap).bitmapData;
			loadNextRole();
		}
		
		private function jsonloader_complete(e:Event):void 
		{
			roleassets[roleasseturl] = JSON.parse(((e.currentTarget as URLLoader).data + ""));
			loadNextRole();
		}
		
		private function loader_complete(e:Event):void 
		{
			pngs.push(((e.currentTarget as LoaderInfo).content as Bitmap).bitmapData);
			loadNextTile();
		}
		
		private function init():void 
		{
			addChild(worldLayer);
			addChild(new Stats);
			worldLayer.addChild(mapLayer);
			worldLayer.addChild(playerLayer);
			playerLayer.addChild(myPlayer);
			
			var tsetpngs:Array = [];
			for (var i:int = 0; i < tmxobj.tilesets.length;i++ ) {
				var tset:Object = tmxobj.tilesets[i];
				tw = tset.tilewidth;
				th = tset.tileheight;
				var png:BitmapData = pngs[i] as BitmapData;
				for (var j:int = 0; j < tset.tilecount;j++ ) {
					var tx:int = int(j % numCols);
					var ty:int = int(j / numCols);
					var ttw:int = tset.tilewidth;
					var tth:int = tset.tileheight;
					var numCols:int = tset.imagewidth/ttw;
					var dst:BitmapData = new BitmapData(tw, th, png.transparent, 0);
					dst.copyPixels(png, new Rectangle(tx * tw, ty * th, tw, th), new Point);
					tsetpngs[j + tset.firstgid] = dst;
				}
			}
			tw = tmxobj.tilewidth;
			th = tmxobj.tileheight;
			
			myPlayer.x = int(120/tw)*tw;
			myPlayer.y = int(480/th)*th;
			players.push(myPlayer);
			camera.x = myPlayer.x;
			camera.y = myPlayer.y;
			astar = new AStar;
			for each(var layer:Object in tmxobj.layers) {
				for (i = 0; i < layer.data.length; i++ ) {
					var id:int = layer.data[i];
					if(id>0){
						var x:int = int(i % layer.width);
						var y:int = int(i / layer.width);
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
			stage.addEventListener(MouseEvent.CLICK, stage_click);
		}
		
		private function stage_click(e:MouseEvent):void 
		{
			var sx:int = int(myPlayer.x / tw);
			var sy:int = int(myPlayer.y / th);
			var ex:int = int(worldLayer.mouseX / tw);
			var ey:int = int(worldLayer.mouseY / th);
			if (astar.findPath(sx, sy, ex, ey)) {
				astar.floyd();
				var path:Array = [];
				for each(var node:Node in astar.floydPath) {
					path.push([(node.x + .5) * tw, (node.y + .5) * th]);
				}
				path.shift();
				if(path.length)
				myPlayer.moveTo(path);
			}
			
		}
		
		private function enterFrame(e:Event):void 
		{
			for each(var player:Player in players) {
				player.update();
			}
			var elas:Number = .1;
			camera.x += (myPlayer.x-camera.x)*elas;
			camera.y += (myPlayer.y-camera.y)*elas;
			worldLayer.x = -int(camera.x) + int(stage.stageWidth / 2);
			worldLayer.y = -int(camera.y) + int(stage.stageHeight / 2);
		}
	}
}
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;

class Player extends Sprite {
	private var path:Array = [];
	private var pathPtr:int;
	private var moving:Boolean = false;
	private var animName:String;
	private var animDir:int
	private var animFrame:Number = 0;
	private var playing:Boolean = false;
	private var dirDirty:Boolean = true;
	private var speed:Number = 2;
	private var image:Bitmap = new Bitmap;
	public function Player() 
	{
		/*graphics.beginFill(0xff0000);
		graphics.moveTo(20, 0);
		graphics.lineTo( -20, 10);
		graphics.lineTo( -20, -10);
		graphics.lineTo( 20, 0);*/
		addChild(image);
		play("idle",0)
	}
	
	public function moveTo(path:Array):void {
		this.path = path;
		pathPtr = 0;
		moving = true;
		dirDirty = true;
		play("walk", animDir);
	}
	
	public function play(name:String,dir:int):void {
		animName = name;
		animDir = dir;
		animFrame = 0;
		playing = true;
	}
	
	public function update():void {
		if (moving) {
			var p:Array = path[pathPtr];
			var dx:Number = p[0]-x;
			var dy:Number = p[1]-y;
			var len:Number = Math.sqrt(dx*dx+dy*dy);
			if (dirDirty) {
				var dir:int = Math.round(Math.atan2(dy, dx) / (Math.PI / 4));
				//rotation = dir * 180 / 4;
				dir += 18;
				dir = dir % 8;
				play(animName, dir);
				dirDirty = false;
			}
			if (len<=speed) {
				x = p[0];
				y = p[1];
				pathPtr++;
				dirDirty = true;
				if (pathPtr>=path.length) {
					moving = false;
					play("idle", animDir)
				}else {
					play("walk", animDir);
				}
			}else {
				x += int(speed * dx / len);
				y += int(speed * dy / len);
			}
		}
		if (playing) {
			var obj:Array = TestTMX.roleassets[animName+".json"];
			var bmd:BitmapData = TestTMX.roleassets[animName+".png"];
			if (obj && bmd) {
				var objs:Array = TestTMX.roleassets[animName+".json" + animDir];
				if (objs==null) {
					objs = TestTMX.roleassets[animName+".json" + animDir] = [];
					for (var i:int = 0; i < obj.length;i++ ) {
						var sobj:Object = obj[i];
						sobj.i = i;
						if (sobj.name.indexOf(animDir+"")==0) {
							objs.push(sobj);
						}
					}
				}
				
				var bmds:Array= TestTMX.roleassets[animName+".pngs"];
				if (bmds==null) {
					TestTMX.roleassets[animName+".pngs"] = bmds = [];
				}
				animFrame+= .1;
				if (animFrame>=objs.length) {
					animFrame = 0;
				}
				var id:int = int(animFrame);
				var data:Object = objs[id];
				var sbmd:BitmapData = bmds[data.i];
				if (sbmd==null) {
					sbmd = new BitmapData(data.w, data.h, bmd.transparent, 0);
					sbmd.copyPixels(bmd, new Rectangle(data.x, data.y,data.w,data.h), new Point);
					bmds[data.i] = sbmd;
				}
				image.bitmapData = sbmd;
				image.x = data.fx-192/2;
				image.y = data.fy-192/2;
			}
		}
	}
}