package 
{
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
		public function TestAStar() 
		{
			astar = new AStar;
			var bmd:BitmapData = new BitmapData(100, 100, true, 0);
			bmd.perlinNoise(10, 10, 2, Math.random() * 0xffffff, true, true, 7, true);
			for (var i:int = 0; i < bmd.width;i++ ){
				for (var j:int = 0; j < bmd.height; j++ ){
					if ((bmd.getPixel(i,j)&0xff)/0xff>.5){
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
				
			}
			start = end;
			draw();
			graphics.beginFill(0xff00);
			graphics.drawRect(end.x * cw, end.y * ch, cw, ch);
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
				graphics.beginFill(0xff0000);
				for each(node in astar.path){
					graphics.drawRect(node.x * cw, node.y * ch, cw, ch);
				}
			}
		}
		
	}

}