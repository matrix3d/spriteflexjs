package flash.utils
{
	import flash.events.EventDispatcher;
	
	public dynamic class Proxy extends EventDispatcher
	{
		
		private var valueMap:Object = {};
		
		public function getProperty(propName:*):*
		{
			return valueMap[propName];
		}
		
		public function setProperty(propName:*, value:*):void
		{
			valueMap[propName] = value;
		}
		
		public function hasProperty(propName:*):Boolean
		{
			return valueMap.hasOwnProperty(propName);
		}
		
		public function deleteProperty(propName:*):void
		{
			delete valueMap[propName];
		}
		
		public function elementNames():Array
		{
			var names:Array = [];
			for (var p:String in valueMap)
				names.push(p);
			return names;
		}
	}

}
