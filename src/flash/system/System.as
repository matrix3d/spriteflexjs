package flash.system
{
	[(methods = "auto", cls = "SystemClass", construct = "none")]
	
	public final class System extends Object
	{
		
		//private static var theIME:IME = null;
		
		public function System()
		{
			super();
		}
		
		//public static function get ime() : IME;
		
		public static function setClipboard(param1:String):void
		{
		
		}
		
		public static function get totalMemory():uint
		{
			return totalMemoryNumber as uint;
		}
		
		public static function get totalMemoryNumber():Number
		{
			return 0;
		}
		
		public static function get freeMemory():Number
		{
			return 0;
		}
		
		public static function get privateMemory():Number
		{
			return 0;
		}
		
		public static function get processCPUUsage():Number
		{
			return 0;
		}
		
		public static function get useCodePage():Boolean
		{
			return false;
		}
		
		public static function set useCodePage(param1:Boolean):void
		{
		
		}
		
		public static function get vmVersion():String
		{
			return null;
		}
		
		public static function pause():void
		{
		
		}
		
		public static function resume():void
		{
		
		}
		
		public static function exit(param1:uint):void
		{
		
		}
		
		public static function gc():void
		{
		
		}
		
		public static function pauseForGCIfCollectionImminent(param1:Number = 0.75):void
		{
		
		}
	
		//public static function disposeXML(param1:XML) : void;
	}
}
