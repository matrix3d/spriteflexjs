package flash.__native 
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class MemArray 
	{
		public var array:Array = [];
		public var length:int = 0;
		public function MemArray() 
		{
			
		}
		
		public function push(v:Object):void{
			array[length++] = v;
		}
	}

}