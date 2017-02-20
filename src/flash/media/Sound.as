package flash.media
{
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	[Event(name = "progress", type = "flash.events.ProgressEvent")][Event(name = "open", type = "flash.events.Event")][Event(name = "ioError", type = "flash.events.IOErrorEvent")][Event(name = "id3", type = "flash.events.Event")][Event(name = "complete", type = "flash.events.Event")][Event(name = "sampleData", type = "flash.events.SampleDataEvent")]
	
	public class Sound extends EventDispatcher
	{
		public static var sounds:Array = [];
		private var xhr:XMLHttpRequest;
		private var buffer:AudioBuffer;
		private static var _ctx:AudioContext;
		public var playing:Boolean = false;
		private var loops:int;
		private var sndTransform:SoundTransform;
		private var startTime:Number;
		private var stream:URLRequest;
		private var context:SoundLoaderContext;
		public var source:AudioBufferSourceNode;
		public function Sound(stream:URLRequest = null, context:SoundLoaderContext = null)
		{
			super();
			this.context = context;
			this.stream = stream;
			if(ctx){
				sounds.push(this);
				//this.load(stream, context);
			}
		}
		
		public function load(stream:URLRequest, context:SoundLoaderContext = null):void
		{
			if(ctx){
				var _context:SoundLoaderContext = this._buildLoaderContext(context);
				this._load(stream, _context.checkPolicyFile, _context.bufferTime);
			}
		}
		
		public function loadCompressedDataFromByteArray(bytes:ByteArray, bytesLength:uint):void
		{
		
		}
		
		public function loadPCMFromByteArray(bytes:ByteArray, samples:uint, format:String="float", stereo:Boolean=true, sampleRate:Number=44100):void
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
		
		private function _load(url:URLRequest, checkPolicyFile:Boolean, bufferTime:Number):void
		{
			xhr = new XMLHttpRequest;
			xhr.open("GET", url.url);
			xhr.responseType = "arraybuffer";
			xhr.addEventListener("load", xhr_load,true);
			xhr.send();
		}
		
		private function xhr_load(e:Object):void 
		{
			ctx.decodeAudioData(xhr.response as ArrayBuffer, decodeAudioDataSuccess);
		}
		
		private function decodeAudioDataSuccess(buffer:AudioBuffer):void 
		{
			this.buffer = buffer;
			if (playing) {
				play(startTime,loops,sndTransform);
			}
		}
		
		public function get url():String
		{
			return null;
		}
		
		public function get isURLInaccessible():Boolean
		{
			return false;
		}
		
		public function play(startTime:Number=0, loops:int=0, sndTransform:SoundTransform=null):SoundChannel
		{
			if (ctx){
				if (xhr==null){
					load(stream, context);
				}
				this.startTime = startTime;
				this.sndTransform = sndTransform;
				this.loops = loops;
				playing = true;
				if(buffer){
					source = ctx.createBufferSource();
					source.loop = loops>0;
					source.buffer = buffer;
					source.connect(ctx.destination);
					source.start(startTime);
				}
			}
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
		
		static public function get ctx():AudioContext 
		{
			if (_ctx==null) {
				if (typeof(AudioContext)!="undefined") {
					_ctx = new AudioContext;
				}else if(typeof(webkitAudioContext)!="undefined"){
					_ctx =new webkitAudioContext;
				}else {
					//throw ("can not find AudioContext");
				}
			}
			return _ctx;
		}
		
		public function close():void
		{
		
		}
		
		public function extract(target:ByteArray, length:Number, startPosition:Number=-1):Number
		{
			return 0;
		}
	}
}
