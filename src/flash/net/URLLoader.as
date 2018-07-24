package flash.net
{
	import flash.events.*;
	import flash.utils.*;
	
	public class URLLoader extends EventDispatcher
	{
		private var _data:*;		
		private var _dataFormat:String = "text";
		private var _bytesLoaded:uint = 0;
		private var _bytesTotal:uint = 0;
		private var stream:URLStream;
		
		public function URLLoader(request:URLRequest = null)
		{
			super();
			stream = new URLStream();
			stream.addEventListener(Event.OPEN, this.redirectEvent);
			stream.addEventListener(IOErrorEvent.IO_ERROR, stream_ioError);
			stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.redirectEvent);
			stream.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.redirectEvent);
			stream.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
			stream.addEventListener(Event.COMPLETE, this.onComplete);
			if (request != null)
			{
				load(request);
			}
		}
		
		private function stream_ioError(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
		}
		
		/*override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			if (type == HTTPStatusEvent.HTTP_RESPONSE_STATUS)
			{
				this.stream.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.redirectEvent);
			}
		}*/
		
		public function load(request:URLRequest):void
		{
			stream.load(request);
		}
		
		public function close():void
		{
			stream.close();
		}
		
		private function redirectEvent(event:Event):void
		{
			dispatchEvent(event);
		}
		
		private function onComplete(event:Event):void
		{
			var buff:ArrayBuffer = stream.xhr.response as ArrayBuffer;
			var bytes:ByteArray = new ByteArray();
			bytes.length = buff.byteLength;
			bytes.dataView = new DataView(buff);
			switch (_dataFormat)
			{
			case URLLoaderDataFormat.TEXT: 
				_data = bytes.toString();
				break;
			case "variables": 
				if (bytes.length > 0)
				{
					_data = new URLVariables(bytes.toString());
					break;
				}
			default: 
				_data = bytes;
			}
			dispatchEvent(event);
		}
		
		private function onProgress(event:ProgressEvent):void
		{
			_bytesLoaded = event.bytesLoaded;
			_bytesTotal = event.bytesTotal;
			dispatchEvent(event);
		}
		
		public function get data():* { return _data; }
		public function set data(value:*):void { _data = value; }
		
		public function get dataFormat():String { return _dataFormat; }
		public function set dataFormat(value:String):void { _dataFormat = value; }
		
		public function get bytesLoaded():uint { return _bytesLoaded; }
		public function set bytesLoaded(value:uint):void { _bytesLoaded = value; }
		
		public function get bytesTotal():uint { return _bytesTotal; }
		public function set bytesTotal(value:uint):void { _bytesTotal = value; }
	}
}
