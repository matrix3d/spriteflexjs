package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import pathfind.AStar;
	import pathfind.BinaryHeap;
	import pathfind.Node;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestAStar extends Sprite
	{
		private var start:Point = new Point(0, 0);
		private var astar:AStar;
		private var cw:int = 10;
		private var ch:int = 10;
		private var ecolor:uint=0;
		public function TestAStar() 
		{
			var d:Number = .5;
			//CONFIG::js_only{
			//SpriteFlexjs.wmode = "gpu batch";
			//SpriteFlexjs.renderer = new WebGLRenderer;
			//d = .2;
			//}
			astar = new AStar;
			var bmd:BitmapData = new BitmapData(80, 60, false, 0);
			bmd.perlinNoise(10, 10, 3, Math.random() * 0xffffff, true, true, 7, true);
			addChild(new Bitmap(bmd));
			for (var i:int = 0; i < bmd.width;i++ ){
				for (var j:int = 0; j < bmd.height; j++ ){
					if ((bmd.getPixel(i,j)&0xff)/0xff>d){
					//if(Math.random()>.1){
						astar.add(new Node(i, j));
					}
				}
			}
			astar.add(new Node(0, 0));
			
			stage.addEventListener(MouseEvent.CLICK, stage_click);
			draw();
		}
		
		private function stage_click(e:MouseEvent):void 
		{
			var end:Point = new Point(int(mouseX / cw), int(mouseY / ch));
			
			if (astar.findPath(start.x, start.y, end.x, end.y)){
				ecolor = 0xff00;
			}else{
				ecolor = 0xff0000;
			}
			draw();
			graphics.endFill();
			graphics.lineStyle(0, 0xff);
			graphics.drawCircle((start.x+.5) * cw, (start.y+.5) * ch, cw/2);
			graphics.lineStyle(0, 0xff00ff);
			graphics.drawCircle((end.x+.5) * cw, (end.y+.5) * ch, cw/2);
			start = end;
		}
		
		private function draw():void{
			graphics.clear();
			graphics.beginFill(0);
			graphics.drawRect(0, 0, 1000, 1000);
			
			graphics.beginFill(0xffffff);
			for each(var line:Object in astar.nodes){
				for each(var node:Node in line){
					graphics.drawRect(node.x * cw, node.y * ch, cw, ch);
				}
			}
			if (astar.path){
				graphics.beginFill(ecolor,.5);
				for each(node in astar.path){
					graphics.drawRect(node.x * cw, node.y * ch, cw, ch);
				}
			}
		}
		
	}

}