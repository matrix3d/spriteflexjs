package fairygui
{
	public class GObjectPool
	{
		private var _pool:Object;
		private var _count:int;
		private var _initCallback:Function;
		
		public function GObjectPool()
		{
			_pool = {};
		}
		
		public function get initCallback():Function
		{
			return _initCallback;
		}
		
		public function set initCallback(value:Function):void
		{
			_initCallback = value;
		}
		
		public function clear():void
		{
			for each(var arr:Vector.<GObject> in _pool)
			{
				var cnt:int = arr.length;
				for(var i:int=0;i<cnt;i++)
					arr[i].dispose();
			}
			_pool = {};
			_count = 0;
		}
		
		public function get count():int
		{
			return _count;
		}
		
		public function getObject(url:String):GObject
		{			
			url = UIPackage.normalizeURL(url);
			
			var arr:Vector.<GObject> = _pool[url];
			if(arr!=null && arr.length)
			{
				_count--;
				return arr.shift();
			}

			var child:GObject = UIPackage.createObjectFromURL(url);
			if(child)
			{
				if(_initCallback!=null)
					_initCallback(child);
			}
			
			return child;
		}
		
		public function returnObject(obj:GObject):void
		{
			var url:String = obj.resourceURL;
			if(!url)
				return;
			
			var arr:Vector.<GObject> = _pool[url];
			if(arr==null)
			{
				arr = new Vector.<GObject>;
				_pool[url] = arr;
			}
			
			_count++;
			arr.push(obj);
		}
	}
}