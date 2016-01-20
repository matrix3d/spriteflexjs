package flash.media
{
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	[(instance = "SoundObject", methods = "auto", cls = "SoundClass", gc = "exact")][Event(name = "progress", type = "flash.events.ProgressEvent")][Event(name = "open", type = "flash.events.Event")][Event(name = "ioError", type = "flash.events.IOErrorEvent")][Event(name = "id3", type = "flash.events.Event")][Event(name = "complete", type = "flash.events.Event")][Event(name = "sampleData", type = "flash.events.SampleDataEvent")]
	
	public class Sound extends EventDispatcher
	{
		
		public function Sound(stream:URLRequest = null, context:SoundLoaderContext = null)
		{
			super();
			this.load(stream, context);
		}
		
		public function load(stream:URLRequest, context:SoundLoaderContext = null):void
		{
			var _context:SoundLoaderContext = this._buildLoaderContext(context);
			this._load(stream, _context.checkPolicyFile, _context.bufferTime);
		}
		
		public function loadCompressedDataFromByteArray(param1:ByteArray, param2:uint):void
		{
		
		}
		
		public function loadPCMFromByteArray(param1:ByteArray, param2:uint, param3:String = "float", param4:Boolean = true, param5:Number = 44100.0):void
		{
		
		}
		
		private function _buildLoaderContext(context:SoundLoaderContext):SoundLoaderContext
		{
			if (context == null)
			{
				context = new SoundLoaderContext();
			}
			return context;
		}
		
		private function _load(param1:URLRequest, param2:Boolean, param3:Number):void
		{
		
		}
		
		public function get url():String
		{
			return null;
		}
		
		public function get isURLInaccessible():Boolean
		{
			return false;
		}
		
		public function play(param1:Number = 0, param2:int = 0, param3:SoundTransform = null):SoundChannel
		{
			return null;
		}
		
		public function get length():Number
		{
			return 0;
		}
		
		public function get isBuffering():Boolean
		{
			return false;
		}
		
		public function get bytesLoaded():uint
		{
			return 0;
		}
		
		public function get bytesTotal():int
		{
			return 0;
		}
		
		public function get id3():ID3Info
		{
			return null;
		}
		
		public function close():void
		{
		
		}
		
		public function extract(param1:ByteArray, param2:Number, param3:Number = -1):Number
		{
			return 0;
		}
	}
}
