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
		
		public static function setClipboard(text:String):void
		{
                    var textArea:Object = document.createElement("textarea");
                    textArea.style.position = 'fixed';
                    textArea.style.top = 0;
                    textArea.style.left = 0;
                    textArea.style.width = '2em';
                    textArea.style.height = '2em';
                    textArea.style.padding = 0;
                    textArea.style.border = 'none';
                    textArea.style.outline = 'none';
                    textArea.style.boxShadow = 'none';
                    textArea.style.background = 'transparent';
                    textArea.value = text;
                    document.body.appendChild(textArea as HTMLElement);
                    textArea.select();
                    try {
                        var successful:Boolean = document.execCommand('copy');
                        var msg:String = successful ? 'successful' : 'unsuccessful';
                        console.log('Copying text command was ' + msg);
                    } catch (err) {
                        console.log('Oops, unable to copy');
                    }
                    document.body.removeChild(textArea as HTMLElement);		
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
