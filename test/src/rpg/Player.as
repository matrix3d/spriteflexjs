package rpg
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.IO;
	import net.LoaderEx;
	import net.UrlLoaderEx;

	public class Player extends Sprite {
		private var pathScale:Array;
		private var path:Array = [];
		private var pathPtr:int;
		private var moving:Boolean = false;
		private var movingTime:Number = 0;
		private var attacking:Boolean = false;
		private var attackTime:Number = 0;
		private var attackTarget:Player;
		private var animName:String;
		private var animDir:int
		private var animFrame:Number = 0;
		private var playing:Boolean = false;
		private var dirDirty:Boolean = true;
		public var speed:Number =  2/60;
		public var animSpeed:Number = 0.15;
		public var name2animSpeed:Object = {};
		private var playerRect:Rectangle = new Rectangle( -20, -80, 40, 80);
		private var sheets:Array = [];
		public function Player() 
		{
			graphics.beginFill(0xff0000);
			graphics.drawCircle(0, 0, 5);
			play("idle",0)
		}
		
		public function addSheet(sheet:Sheet):void{
			sheets.push(sheet);
			addChild(sheet.image);
			if (playing){
				sheet.play(animName);
			}
		}
		
		public function attack(target:Player):void{
			attackTarget = target;
			attackTime = 0;
			attacking = true;
			moving = false;
			dirDirty = true;
		}
		
		public function moveTo(path:Array, pathScale:Array):void {
			this.pathScale = pathScale;
			this.path = path;
			path[0][0] = (x/pathScale[0])-.5;
			path[0][1] = (y/pathScale[1])-.5;
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
			for each(var sheet:Sheet in sheets){
				sheet.play(name);
			}
		}
		
		public function playerHittest(x:Number, y:Number):Boolean{
			return playerRect.containsPoint(new Point(x-this.x,y-this.y));
		}
		
		private function getDir(dx:Number, dy:Number):int{
			var b:int = Math.round(Math.atan2(dy, dx) / (Math.PI / 4));
			var c:int = (b + 18);
			if (b ==-2 && c == 17){// ios 9 ,bug
				trace(b+" "+c);
			}
			var dir:int=(c%8);
			return dir;
		}
		
		public function update(delta:Number):void {
			if (attacking){
				if (dirDirty){
					animDir = getDir(attackTarget.x - x, attackTarget.y - y);
					dirDirty = false;
				}
				if (animName!="attack"){
					play("attack", animDir, 0);
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
					x = (p1[0]+.5)*pathScale[0];
					y = (p1[1]+.5)*pathScale[1];
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
					x =(p0[0]+ (deltaSpeed * dx / len)+.5)*pathScale[0];
					y =(p0[1]+ (deltaSpeed * dy / len)+.5)*pathScale[1];
				}
				movingTime+= delta;
			}else{
				if (animName!="idle"){
					play("idle", animDir,0);
				}
			}
			if (playing) {
				animFrame+=(name2animSpeed[animName]||animSpeed) * delta / (1000 / 60);
				for each(var sheet:Sheet in sheets){
					sheet.update(animFrame, animDir);
					if (sheet.appLoop){
						if(attacking){
							attacking = false;
						}
						animFrame = 0;
					}
				}
				
			}
		}
	}
}