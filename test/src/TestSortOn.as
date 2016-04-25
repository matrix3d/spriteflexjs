package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestSortOn extends Sprite
	{
		private var sortNames:Array;
		private var sortNamesOne:Array = [];
		private var muler:Number;
		private var zeroStr:String = String.fromCharCode(0);
		public function TestSortOn() 
		{
			var arr:Array = [
				{a:1,b:2},
				{a:2},
				{a:3},
				{a:1,b:4},
				{a:13}
			];
			sortOn(arr, ["a","b"],Array.NUMERIC|Array.DESCENDING);
			trace(JSON.stringify(arr, null, 4));
			arr.sortOn(["a","b"],Array.NUMERIC|Array.DESCENDING);
			trace(JSON.stringify(arr, null, 4));
		}
		
		private function sortOn(arr:Array,names:Object,opt:int=0):void{
			if (names is Array){
				sortNames = names as Array;
			}else{
				sortNamesOne[0] = names;
				sortNames = sortNamesOne;
			}
			muler = (Array.DESCENDING & opt) > 0?-1: 1;
			if(opt&Array.NUMERIC){
				arr.sort(compareNumber);
			}else if (opt&Array.CASEINSENSITIVE){
				arr.sort(compareStringCaseinsensitive);
			}else{
				arr.sort(compareString);
			}
		}
		private function compareStringCaseinsensitive(a:Object, b:Object):int{
			for each(var n:String in sortNames){
				var v:int = (a[n]||zeroStr).toString().toLowerCase().localeCompare((b[n]||zeroStr).toString().toLowerCase());
				if (v != 0){
					return v*muler;
				}
			}
			return 0;
		}
		private function compareString(a:Object, b:Object):int{
			for each(var n:String in sortNames){
				var v:int = (a[n]||zeroStr).toString().localeCompare((b[n]||zeroStr).toString());
				if (v != 0){
					return v*muler;
				}
			}
			return 0;
		}
		
		private function compareNumber(a:Object, b:Object):int{
			for each(var n:String in sortNames){
				var v:int = a[n] - b[n];
				if (v!=0){
					return v*muler;
				}
			}
			return 0;
		}
		
	}

}