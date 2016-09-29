package flash.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.*;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	public class URLStream extends EventDispatcher
	{
		public var xhr:XMLHttpRequest;
		
		public function URLStream()
		{
			super();
		}
		
		public function load(v:URLRequest):void
		{
			xhr = new XMLHttpRequest;
			xhr.open("get", v.url);
			xhr.responseType = "arraybuffer";
			xhr.addEventListener("readystatechange", xhr_onreadystatechange, false);
			xhr.addEventListener("error", xhr_error,false);
			xhr.addEventListener("progress", xhr_progress,false);
			xhr.send();
		}
		
		private function xhr_error(e:Event):void 
		{
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
		}
		
		private function xhr_progress(e:Object):void 
		{
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, e.loaded, e.total));
		}
		
		private function xhr_onreadystatechange(e:*):void
		{
			if (xhr.readyState === 4 && xhr.status === 200)
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}else if (xhr.readyState===4&&xhr.status===404){
				dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
			}
		}
		
		public function readBytes(b:ByteArray, offset:uint = 0, length:uint = 0):void  {
		}
		
		public function readBoolean():Boolean  { return false }
		
		public function readByte():int  { return 0 }
		
		public function readUnsignedByte():uint  { return 0 }
		
		public function readShort():int  { return 0 }
		
		public function readUnsignedShort():uint  { return 0 }
		
		public function readUnsignedInt():uint  { return 0 }
		
		public function readInt():int  { return 0 }
		
		public function readFloat():Number  { return 0 }
		
		public function readDouble():Number  { return 0 }
		
		public function readMultiByte(param1:uint, param2:String):String  { return null; }
		
		public function readUTF():String  { return null }
		
		public function readUTFBytes(param1:uint):String  { return null; }
		
		public function get connected():Boolean  { return false }
		
		public function get bytesAvailable():uint  { return 0; }
		
		public function close():void  {/**/ }
		
		public function readObject():*  { return null; }
		
		public function get objectEncoding():uint  { return 0; }
		
		public function set objectEncoding(param1:uint):void  {/**/ }
		
		public function get endian():String  { return null; }
		
		public function set endian(param1:String):void  {/**/ }
		
		public function get diskCacheEnabled():Boolean  { return false }
		
		public function get position():Number  { return 0; }
		
		public function set position(param1:Number):void  {/**/ }
		
		public function get length():Number  { return 0; }
		
		public function stop():void  {/**/ }
	}
}
