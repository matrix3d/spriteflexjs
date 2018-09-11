package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestSortOn extends Sprite
	{
		static private var sortNames:Array;
		static private var sortNamesOne:Array = [];
		static private var muler:Number;
		static private var zeroStr:String = String.fromCharCode(0);
		public function TestSortOn() 
		{
			var arr:Array = [
				{a:1.2,b:2},
				{a:1.1},
				{a:1.5},
				{a:1.2,b:4},
				{a:1.4}
			];
			sortOn(arr, ["a","b"],Array.NUMERIC|Array.DESCENDING);
			trace(JSON.stringify(arr));
			arr.sortOn(["a","b"],Array.NUMERIC|Array.DESCENDING);
			trace(JSON.stringify(arr));
			sortOn(arr, ["a", "b"], [Array.NUMERIC, Array.DESCENDING]);
			//arr.sortOn(["a", "b"], [Array.NUMERIC, Array.DESCENDING]);
			//arr.sortOn(["a","b"],Array.NUMERIC|Array.DESCENDING);
			trace(JSON.stringify(arr));
			arr.sortOn(["a","b"],[Array.NUMERIC,Array.DESCENDING]);
			trace(JSON.stringify(arr));
		}
		private static function sortOn(arr:Array,names:Object,opt:Object=0):void{
			if (names is Array){
				sortNames = names as Array;
			}else{
				sortNamesOne[0] = names;
				sortNames = sortNamesOne;
			}
			if (opt is Array){
				var opt2:int = 0;
				for each(var o:int in opt){
					opt2 = opt2 | o;
				}
			}else{
				opt2 = opt as int;
			}
			muler = (Array.DESCENDING & opt2) > 0?-1: 1;
			if(opt2&Array.NUMERIC){
				arr.sort(compareNumber);
			}else if (opt2&Array.CASEINSENSITIVE){
				arr.sort(compareStringCaseinsensitive);
			}else{
				arr.sort(compareString);
			}
		}
		private static function compareStringCaseinsensitive(a:Object, b:Object):int{
			for each(var n:String in sortNames){
				var v:int = (a[n]||zeroStr).toString().toLowerCase().localeCompare((b[n]||zeroStr).toString().toLowerCase());
				if (v != 0){
					return v*muler;
				}
			}
			return 0;
		}
		private static function compareString(a:Object, b:Object):int{
			for each(var n:String in sortNames){
				var v:int = (a[n]||zeroStr).toString().localeCompare((b[n]||zeroStr).toString());
				if (v != 0){
					return v*muler;
				}
			}
			return 0;
		}
		
		private static function compareNumber(a:Object, b:Object):int{
			for each(var n:String in sortNames){
				if (a[n]>b[n]){
					return muler;
				}else if (a[n]<b[n]){
					return -muler;
				}
			}
			return 0;
		}
		
	}

}