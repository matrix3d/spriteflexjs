package fairygui.utils 
{
	public class SimpleDispatcher 
	{
		private var _elements:Array;
		private var _dispatching:int;
		
		public function SimpleDispatcher():void {
			_elements = [];
		}
		
		public function addListener(type:int, e:Function):void {
			var arr:Array = _elements[type];
			if(!arr) {
				arr = [];
				_elements[type] = arr;
				arr.push(e);
			}
			else if(arr.indexOf(e)==-1) {
				arr.push(e);
			}
		}
		
		public function removeListener(type:int, e:Function):void {
			var arr:Array = _elements[type];
			if(arr) {
				var i:int = arr.indexOf(e);
				if(i!=-1)
					arr[i] = null;
			}
		}
		
		public function hasListener(type:int):Boolean {
			var arr:Array = _elements[type];
			if(arr && arr.length>0)
				return true;
			else
				return false;
		}
		
		public function dispatch(source:Object, type:int):void {
			var arr:Array = _elements[type];
			if(!arr || arr.length==0)
				return;
			
			var hasDeleted:Boolean;
			var i:int = 0;
			_dispatching++;
			while(i<arr.length) {
				var e:Function = arr[i];
				if(e!=null)
				{
					if(e.length==1)
						e(source);
					else
						e();
				}
				else
					hasDeleted = true;
				i++;
			}
			_dispatching--;
			
			if(hasDeleted && _dispatching==0)
			{
				i = 0;
				while(i<arr.length) {
					e = arr[i];
					if(e==null)
						arr.splice(i, 1);
					else
						i++;
				}
			}
		}
		
		public function clear():void {
			_elements.length = 0;
		}
	}
}