package fairygui
{
	public class Margin
	{
		public var left:int;
		public var right:int;
		public var top:int;
		public var bottom:int;
		
		public function Margin()
		{
		}
		
		public function parse(str:String):void
		{
			var arr:Array = str.split(",");
			if(arr.length==1)
			{
				var k:int = int(arr[0]);
				top = k;
				bottom = k;
				left = k;
				right = k;
			}
			else
			{
				top = int(arr[0]);
				bottom = int(arr[1]);
				left = int(arr[2]);
				right = int(arr[3]);
			}
		}
		
		public function copy(source:Margin):void
		{
			top = source.top;
			bottom = source.bottom;
			left = source.left;
			right = source.right;
		}
	}
}