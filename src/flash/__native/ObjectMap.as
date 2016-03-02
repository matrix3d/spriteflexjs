package flash.__native 
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class ObjectMap 
	{
		public var keys:Array = [];
		public var values:Array = [];
		public function ObjectMap() 
		{
			
		}
		
		public function get(key:Object):Object {
			return values[keys.indexOf(key)];
		}
		
		public function set(key:Object, value:Object):void {
			var i:Number = keys.indexOf(key);
			if (i ==-1) {
				i = keys.length;
				keys.push(key);
			}
			values[i] = value;
		}
		
	}

}