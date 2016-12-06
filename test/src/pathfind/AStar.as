package pathfind
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author lizhi
	 */
	public class AStar
	{
		private var open:BinaryHeap;
		public var path:Array;
		public var floydPath:Array;
		private var nowVersion:int = 1;
		public var nodes:Object = {};
		
		public function AStar()
		{
		
		}
		
		public function add(node:Node):void
		{
			if (nodes[node.y] == null)
			{
				nodes[node.y] = {};
			}
			nodes[node.y][node.x] = node;
		}
		
		public function remove(x:int, y:int):void
		{
			if (nodes[y] && nodes[y][x])
			{
				nodes[y][x] = null;
				delete nodes[y][x];
			}
		}
		
		private function justMin(x:Object, y:Object):Boolean
		{
			return x.f < y.f;
		}
		
		public function findPath(startX:int, startY:int, endX:int, endY:int,maxStep:int=0):Boolean
		{
			nowVersion++;
			var step:int = 0;
			open = new BinaryHeap(justMin);
			if (nodes[startY] && nodes[startY][startX])
			{
				var startNode:Node = nodes[startY][startX];
				startNode.g = 0;
			}
			else
			{
				return false;
			}
			var node:Node = startNode;
			node.version = nowVersion;
			var isFind:Boolean = true;
			var best:Node = node;
			var bestH:int = Math.sqrt((node.x-endX)*(node.x-endX)+(node.y-endY)*(node.y-endY))//Math.abs(node.x - endX) + Math.abs(node.y - endY);
			while (node.x!=endX||node.y!=endY)
			{
				for (var y:int = -1; y < 2; y++)
				{
					var line:Object = nodes[node.y + y];
					if (line)
					{
						for (var x:int = -1; x < 2; x++)
						{
							if (y != 0 || x != 0)
							{
								var test:Node = line[node.x + x];
								if (test && nodes[node.y][test.x] && line[node.x])
								{
									if (x == 0 || y == 0)
									{
										var cost:Number = 1;
									}
									else
									{
										cost = Math.SQRT2;
									}
									step++;
									var g:Number = node.g + cost;
									var h:Number = Math.sqrt((test.x-endX)*(test.x-endX)+(test.y-endY)*(test.y-endY))//Math.abs(test.x - endX) + Math.abs(test.y - endY);
									var f:Number = g + h;
									if (test.version == nowVersion)
									{
										if (test.f > f)
										{
											test.f = f;
											test.g = g;
											test.parent = node;
											if (bestH > h)
											{
												best = test;
												bestH = h;
											}
										}
									}
									else
									{
										test.f = f;
										test.g = g;
										test.parent = node;
										open.ins(test);
										test.version = nowVersion;
										if (bestH > h)
										{
											best = test;
											bestH = h;
										}
									}
								}
							}
						}
					}
				}
				if (open.a.length == 1||(maxStep!=0&&step>maxStep))
				{
					isFind = false;
					break;
				}
				node = open.pop() as Node;
			}
			if (node.x!=endX||node.y!=endY)
			{
				node = best;
			}
			if (node)
			{
				path = [];
				path.push(node);
				while (node != startNode)
				{
					node = node.parent;
					path.unshift(node);
				}
			}
			return isFind;
		}
		
		/*public function manhattan(node:Node,endNode:Node):Number {
		   return Math.abs(node.x - endNode.x) + Math.abs(node.y - endNode.y);
		   }
		
		   public function euclidian(node:Node,endNode:Node):Number {
		   var dx:Number = node.x - endNode.x;
		   var dy:Number = node.y - endNode.y;
		   return Math.sqrt(dx * dx + dy * dy);
		   }
		
		   public function diagonal(node:Node,endNode:Node):Number {
		   var dx:Number = Math.abs(node.x - endNode.x);
		   var dy:Number = Math.abs(node.y - endNode.y);
		   var diag:Number = Math.min(dx, dy);
		   var straight:Number = dx + dy;
		   return Math.SQRT2 * diag + straight - 2 * diag;
		   }*/
		
		public function floyd():void
		{
			if (path == null)
				return;
			floydPath = path.concat();
			var len:int = floydPath.length;
			if (len > 2)
			{
				var vector:Node = new Node(0, 0);
				var tempVector:Node = new Node(0, 0);
				floydVector(vector, floydPath[len - 1], floydPath[len - 2]);
				for (var i:int = floydPath.length - 3; i >= 0; i--)
				{
					floydVector(tempVector, floydPath[i + 1], floydPath[i]);
					if (vector.x == tempVector.x && vector.y == tempVector.y)
					{
						floydPath.splice(i + 1, 1);
					}
					else
					{
						vector.x = tempVector.x;
						vector.y = tempVector.y;
					}
				}
			}
			len = floydPath.length;
			for (i = len - 1; i >= 0; i--)
			{
				for (var j:int = 0; j <= i - 2; j++)
				{
					if (floydCrossAble(floydPath[i], floydPath[j]))
					{
						for (var k:int = i - 1; k > j; k--)
						{
							floydPath.splice(k, 1);
						}
						i = j;
						len = floydPath.length;
						break;
					}
				}
			}
		}
		
		private function floydCrossAble(n1:Node, n2:Node):Boolean
		{
			var ps:Array = bresenhamNodes(new Point(n1.x, n1.y), new Point(n2.x, n2.y));
			for (var i:int = ps.length - 2; i > 0; i--)
			{
				//if (ps[i].x>=0&&ps[i].y>=0&&ps[i].x<_grid.numCols&&ps[i].y<_grid.numRows&&!_grid.getNode(ps[i].x,ps[i].y).walkable) {
				var x:int = ps[i].x;
				var y:int = ps[i].y;
				if (nodes[y] == null || nodes[y][x] == null)
				{
					return false;
				}
			}
			return true;
		}
		
		private function bresenhamNodes(p1:Point, p2:Point):Array
		{
			var steep:Boolean = Math.abs(p2.y - p1.y) > Math.abs(p2.x - p1.x);
			if (steep)
			{
				var temp:int = p1.x;
				p1.x = p1.y;
				p1.y = temp;
				temp = p2.x;
				p2.x = p2.y;
				p2.y = temp;
			}
			var stepX:int = p2.x > p1.x ? 1 : (p2.x < p1.x ? -1 : 0);
			var deltay:Number = (p2.y - p1.y) / Math.abs(p2.x - p1.x);
			var ret:Array = [];
			var nowX:Number = p1.x + stepX;
			var nowY:Number = p1.y + deltay;
			if (steep)
			{
				ret.push(new Point(p1.y, p1.x));
			}
			else
			{
				ret.push(new Point(p1.x, p1.y));
			}
			if (Math.abs(p1.x - p2.x) == Math.abs(p1.y - p2.y))
			{
				if (p1.x < p2.x && p1.y < p2.y)
				{
					ret.push(new Point(p1.x, p1.y + 1), new Point(p2.x, p2.y - 1));
				}
				else if (p1.x > p2.x && p1.y > p2.y)
				{
					ret.push(new Point(p1.x, p1.y - 1), new Point(p2.x, p2.y + 1));
				}
				else if (p1.x < p2.x && p1.y > p2.y)
				{
					ret.push(new Point(p1.x, p1.y - 1), new Point(p2.x, p2.y + 1));
				}
				else if (p1.x > p2.x && p1.y < p2.y)
				{
					ret.push(new Point(p1.x, p1.y + 1), new Point(p2.x, p2.y - 1));
				}
			}
			while (nowX != p2.x)
			{
				var fy:int = Math.floor(nowY)
				var cy:int = Math.ceil(nowY);
				if (steep)
				{
					ret.push(new Point(fy, nowX));
				}
				else
				{
					ret.push(new Point(nowX, fy));
				}
				if (fy != cy)
				{
					if (steep)
					{
						ret.push(new Point(cy, nowX));
					}
					else
					{
						ret.push(new Point(nowX, cy));
					}
				}
				else if (deltay != 0)
				{
					if (steep)
					{
						ret.push(new Point(cy + 1, nowX));
						ret.push(new Point(cy - 1, nowX));
					}
					else
					{
						ret.push(new Point(nowX, cy + 1));
						ret.push(new Point(nowX, cy - 1));
					}
				}
				nowX += stepX;
				nowY += deltay;
			}
			if (steep)
			{
				ret.push(new Point(p2.y, p2.x));
			}
			else
			{
				ret.push(new Point(p2.x, p2.y));
			}
			return ret;
		}
		
		private function floydVector(target:Node, n1:Node, n2:Node):void
		{
			target.x = n1.x - n2.x;
			target.y = n1.y - n2.y;
		}
	}

}