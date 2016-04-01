package rpg
{
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

	public class Player extends Sprite {
		private var path:Array = [];
		private var pathPtr:int;
		private var moving:Boolean = false;
		private var movingTime:Number = 0;
		private var attacking:Boolean = false;
		private var attackTime:Number = 0;
		private var attackTarget:Player;
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
		private var playerRect:Rectangle = new Rectangle( -20, -80, 40, 80);
		public function Player(baseurl:String) 
		{
			this.baseurl = baseurl;
			graphics.beginFill(0xff0000);
			graphics.drawCircle(0, 0, 5);
			addChild(image);
			play("idle",0)
		}
		
		public function attack(target:Player):void{
			attackTarget = target;
			attackTime = 0;
			attacking = true;
			moving = false;
			dirDirty = true;
		}
		
		public function moveTo(path:Array):void {
			this.path = path;
			path[0][0] = x;
			path[0][1] = y;
			pathPtr = 0;
			moving = true;
			movingTime = 0;
			dirDirty = true;
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
			loadOverBMD = true;
		}
		
		private function animObjLoader_complete(e:Event):void 
		{
			loadOverJSON = true;
		}
		
		public function playerHittest(x:Number, y:Number):Boolean{
			return playerRect.containsPoint(new Point(x-this.x,y-this.y));
		}
		
		private function getDir(dx:Number, dy:Number):int{
			var dir:int = Math.round(Math.atan2(dy, dx) / (Math.PI / 4));
			dir += 18;
			dir = dir % 8;
			return dir;
		}
		
		public function update(delta:Number):void {
			if (attacking){
				if (dirDirty){
					animDir = getDir(attackTarget.x - x, attackTarget.y - y);
					dirDirty = false;
				}
				if (animName!="attack_A"){
					play("attack_A", animDir, 0);
				}
			}else if (moving) {
				if (animName!="run"){
					play("run", animDir,0);
				}
				var p0:Array = path[pathPtr];
				var p1:Array = path[pathPtr+1];
				var dx:Number = p1[0]-p0[0];
				var dy:Number = p1[1]-p0[1];
				var len:Number = Math.sqrt(dx * dx + dy * dy);
				var deltaSpeed:Number = (movingTime+delta) * speed / (1000 / 60);
				if (dirDirty) {
					animDir = getDir(dx, dy);
					play(animName, animDir);
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
						play("idle", animDir);
					}else {
						play("run", animDir);
					}
				}else {
					x =p0[0]+ int(deltaSpeed * dx / len);
					y =p0[1]+ int(deltaSpeed * dy / len);
				}
				movingTime+= delta;
			}else{
				if (animName!="idle"){
					play("idle", animDir,0);
				}
			}
			if (playing && loadOverBMD && loadOverJSON) {
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
					if (attacking){
						attacking = false;
					}
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
}