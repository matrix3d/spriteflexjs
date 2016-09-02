package pathfind 
{
	import flash.geom.Point;

	/**
	 * ...
	 * @author lizhi
	 */
	public class Node {
		public var x:int;
		public var y:int;
		public var f:Number;
		public var g:Number;
		public var parent:Node;
		public var version:int = 1;

		public function Node(x:int, y:int){
			this.x = x;
			this.y = y;
		}
	}

}