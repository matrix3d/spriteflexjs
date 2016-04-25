package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestSortOn extends Sprite
	{
		private var opt:int;
		private var sortNames:Array;
		public function TestSortOn() 
		{
			var arr:Array = [
				{a:1},
				{a:2},
				{a:3},
				{a:1},
				{a:13}
			];
			//arr.sortOn("a");
			sortOn(arr, "a", 0);
			trace(JSON.stringify(arr, null, 4));
		}
		
		private function sortOn(arr:Array,names:Object,opt:int):void{
			this.opt = opt;
			if (names is Array){
				sortNames = names as Array;
			}else{
				sortNames = [names];
			}
			arr.sort(compare);
		}
		
		private function compare(a:Object, b:Object):int{
			for each(var n:String in sortNames){
				if (a[n]>b[n]){
					return 1;
				}else {
					return -1;
				}
			}
			return 0;
		}
		
	}

}