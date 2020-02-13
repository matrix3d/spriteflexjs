package flash.net
{
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.media.Microphone;
	import flash.media.Camera;
	import flash.net.NetStream;
	import flash.net.Responder;
	import flash.net.NetStreamPlayOptions;
	import flash.net.NetStreamInfo;
	import flash.net.NetStreamMulticastInfo;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;
	import flash.media.VideoStreamSettings;
	import flash.media.VideoCodec;
	import flash.events.ActivityEvent;
	
	/**
	 * Dispatched when playing video content and certain type of messages are processed.
	 * @eventType	flash.events.NetDataEvent
	 */
	[Event(name="mediaTypeData", type="flash.events.NetDataEvent")] 

	/**
	 * Called synchronously from appendBytes() when the append bytes parser encounters a point that it believes is a seekable
	 * point (for example, a video key frame).
	 */
	[Event(name="onSeekPoint", type="")] 

	/**
	 * Dispatched when the digital rights management (DRM) encrypted content
	 * begins playing (when the user is authenticated and authorized to play the content).
	 * @eventType	flash.events.DRMStatusEvent.DRM_STATUS
	 */
	[Event(name="drmStatus", type="flash.events.DRMStatusEvent")] 

	/**
	 * Dispatched when a NetStream object, trying to play a digital rights management (DRM) encrypted
	 * file, encounters a DRM-related error.
	 * @eventType	flash.events.DRMErrorEvent.DRM_ERROR
	 */
	[Event(name="drmError", type="flash.events.DRMErrorEvent")] 

	/**
	 * Dispatched when a NetStream object tries to play a digital rights management (DRM) encrypted
	 * content that requires a user credential for authentication before playing.
	 * @eventType	flash.events.DRMAuthenticateEvent.DRM_AUTHENTICATE
	 */
	[Event(name="drmAuthenticate", type="flash.events.DRMAuthenticateEvent")] 

	/// Establishes a listener to respond when AIR extracts DRM content metadata embedded in a media file.
	[Event(name="onDRMContentData", type="")] 

	/// Establishes a listener to respond when a NetStream object has completely played a stream.
	[Event(name="onPlayStatus", type="")] 

	/// Establishes a listener to respond when an embedded cue point is reached while playing a video file.
	[Event(name="onCuePoint", type="")] 

	/// Establishes a listener to respond when Flash Player receives text data embedded in a media file that is playing.
	[Event(name="onTextData", type="")] 

	/**
	 * Establishes a listener to respond when Flash Player receives image data as a byte array embedded in a media file that is
	 * playing.
	 */
	[Event(name="onImageData", type="")] 

	/// Establishes a listener to respond when Flash Player receives descriptive information embedded in the video being played.
	[Event(name="onMetaData", type="")] 

	/**
	 * Establishes a listener to respond when Flash Player receives information specific to Adobe
	 * Extensible Metadata Platform (XMP) embedded in the video being played.
	 */
	[Event(name="onXMPData", type="")] 

	/**
	 * Dispatched when a NetStream object is reporting its status or error condition.
	 * @eventType	flash.events.NetStatusEvent.NET_STATUS
	 */
	[Event(name="netStatus", type="flash.events.NetStatusEvent")] 

	/**
	 * Dispatched when an input or output error occurs that causes a network operation to fail.
	 * @eventType	flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event(name="ioError", type="flash.events.IOErrorEvent")] 

	/**
	 * Dispatched when an exception is thrown asynchronously &#x2014; that is,
	 * from native asynchronous code.
	 * @eventType	flash.events.AsyncErrorEvent.ASYNC_ERROR
	 */
	[Event(name="asyncError", type="flash.events.AsyncErrorEvent")] 

	/**
	 * Dispatched when the application attempts to play content encrypted with digital rights management (DRM),
	 * by invoking the NetStream.play() method.
	 * @eventType	flash.events.StatusEvent.STATUS
	 */
	[Event(name="status", type="flash.events.StatusEvent")] 

	/**
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 * @playerversion	Lite 4
	 */
	public class NetStream extends EventDispatcher
	{
		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public static const CONNECT_TO_FMS:String = "connectToFMS";

		/**
		 * Creates a peer-to-peer publisher connection. Pass this string for the second (optional) parameter to
		 * the constructor for a NetStream instance. With this string, an application can create
		 * a NetStream connection for the purposes of publishing audio and video to clients.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public static const DIRECT_CONNECTIONS:String = "directConnections";
		
		private var _netConnection:NetConnection;
		private var _url:String;
		private var _bytes:ArrayBuffer;
		private var _sourceBuffer:SourceBuffer;
		private var _mimeCodec:String;
		private var _mediaSource:MediaSource;
		private var _duration:Number = 0;
		private var _currentFPS:int = 0;
		private var _inBufferSeek:Boolean = false;
		private var _time:Number = 0;
		private var _videoCodec:uint;
		private var _loop:Boolean = false;
		private var _looped:Boolean = false;
		private var _playing:Boolean = false;
		private var _paused:Boolean = true;
		private var _seeking:Boolean = false;
		private var _playbackTarget:Object;
		private var _clientObject:Object;
		private var _bytesQueue:Array = [];
		private var _isNewBytes:Boolean = false;
		private var _camera:Camera;

		public function get audioCodec():uint
		{
			trace("Netstream.audioCodec property not implemented.");
			return null;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get audioReliable():Boolean
		{
			trace("Netstream.audioReliable property not implemented.");
			return null;
		}
		
		public function set audioReliable(reliable:Boolean):void
		{
			trace("Netstream.audioReliable property not implemented.");
		}

		/**
		 * For RTMFP connections, specifies whether peer-to-peer subscribers on this NetStream are allowed to capture the audio stream.
		 * When FALSE, subscriber attempts to capture the audio stream show permission errors.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get audioSampleAccess():Boolean
		{
			trace("Netstream.audioSampleAccess property not implemented.");
			return null;
		}
		public function set audioSampleAccess(reliable:Boolean):void
		{
			trace("Netstream.audioSampleAccess property not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get backBufferLength():Number
		{
			trace("Netstream.backBufferLength property not implemented.");
			return null;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get backBufferTime():Number
		{
			trace("Netstream.backBufferTimer property not implemented.");
			return null;
		}
		public function set backBufferTime (backBufferTime:Number):void
		{
			trace("Netstream.backBufferTime property not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get bufferLength():Number
		{
			if (_bytes)
			{
				return _bytes.byteLength;
			}
			
			return 0;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get bufferTime():Number
		{
			trace("Netstream.bufferTimer property not implemented.");
			return null;
		}
		public function set bufferTime (bufferTime:Number):void
		{
			trace("Netstream.bufferTime property not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get bufferTimeMax():Number
		{
			trace("Netstream.bufferTimeMax property not implemented.");
			return null;
		}
		public function set bufferTimeMax (bufferTimeMax:Number):void
		{
			trace("Netstream.bufferTimeMax property not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get bytesLoaded():uint
		{
			if (_bytes)
			{
				return _bytes.byteLength;
			}
			
			return 0;
		}

		/**
		 * The total size in bytes of the file being loaded into the application.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get bytesTotal():uint
		{
			if (_bytes)
			{
				return _bytes.byteLength;
			}
			
			return 0;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get checkPolicyFile():Boolean
		{
			trace("Netstream.checkPolicyFile property not implemented.");
			return null;
		}
		public function set checkPolicyFile (state:Boolean):void
		{
			trace("Netstream.checkPolicyFile property not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	TypeError The client property must be set to a non-null object.
		 */
		public function get client():Object
		{
			return _clientObject;
		}
		public function set client (object:Object):void
		{
			_clientObject = object;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get currentFPS():Number
		{
			return _currentFPS;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get dataReliable():Boolean
		{
			trace("Netstream.dataReliable property not implemented.");
			return null
		}
		public function set dataReliable (reliable:Boolean):void
		{
			trace("Netstream.dataReliable property not implemented.");
		}

		public function get decodedFrames():uint
		{
			trace("Netstream.decodedFrames property not implemented.");
			return null;
		}

		/**
		 * For RTMFP connections, the identifier of the far end that is connected to this NetStream instance.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get farID():String
		{
			trace("Netstream.farID property not implemented.");
			return null;
		}

		/**
		 * For RTMFP and RTMPE connections, a value chosen substantially by the other end of this stream, unique to this connection.
		 * This value appears to the other end of the stream as its nearNonce value.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get farNonce():String
		{
			trace("Netstream.farNonce property not implemented.");
			return null;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get inBufferSeek():Boolean
		{
			return _inBufferSeek;
		}
		public function set inBufferSeek (value:Boolean):void
		{
			_inBufferSeek = value;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get info():flash.net.NetStreamInfo
		{
			trace("Netstream.info property not implemented.");
			return null;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @category	Property
		 */
		public function get liveDelay():Number
		{
			trace("Netstream.liveDelay property not implemented.");
			return null;
		}

		/**
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get maxPauseBufferTime():Number
		{
			trace("Netstream.maxPauseBufferTime property not implemented.");
			return null;
		}
		public function set maxPauseBufferTime (pauseBufferTime:Number):void
		{
			trace("Netstream.maxPauseBufferTimer property not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get multicastAvailabilitySendToAll():Boolean
		{
			trace("Netstream.multicastAvailabilitySendToAll property not implemented.");
			return null;
		}
		public function set multicastAvailabilitySendToAll (value:Boolean):void
		{
			trace("Netstream.multicastAvailabilitySendToAll property not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get multicastAvailabilityUpdatePeriod():Number
		{
			trace("Netstream.multicastAvailabilityUpdatePeriod property not implemented.");
			return null;
		}
		public function set multicastAvailabilityUpdatePeriod (seconds:Number):void
		{
			trace("Netstream.multicastAvailabilityUpdatePeriod property not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get multicastFetchPeriod():Number
		{
			trace("Netstream.multicastFetchPeriod property not implemented.");
			return null;
		}
		public function set multicastFetchPeriod (seconds:Number):void
		{
			trace("Netstream.multicastAvailabilityUpdatePeriod property not implemented.");
		}

		/**
		 * For RTMFP connections, returns a NetStreamMulticastInfo object whose properties contain statistics about the quality of service.
		 * The object is a snapshot of the current state.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get multicastInfo():flash.net.NetStreamMulticastInfo
		{
			trace("Netstream.multicastInfo property not implemented.");
			return null;
		}

		/**
		 * For RTMFP connections, specifies the maximum number of peers to which to proactively push
		 * multicast media.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get multicastPushNeighborLimit():Number
		{
			trace("Netstream.multicastPushNeighborLimit property not implemented.");
			return null;
		}
		public function set multicastPushNeighborLimit (neighbors:Number):void
		{
			trace("Netstream.multicastPushNeighborLimit property not implemented.");
		}

		/**
		 * For RTMFP connections, specifies the duration in seconds that peer-to-peer multicast data remains
		 * available to send to peers that request it beyond a specified duration. The duration is specified
		 * by the multicastWindowDuration property.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get multicastRelayMarginDuration():Number
		{
			trace("Netstream.multicastRelayMarginDuration property not implemented.");
			return null;
		}
		public function set multicastRelayMarginDuration (seconds:Number):void
		{
			trace("Netstream.multicastRelayMarginDuration property not implemented.");
		}

		/**
		 * For RTMFP connections, specifies the duration in seconds of the peer-to-peer multicast reassembly
		 * window. Shorter values reduce latency but may reduce quality by not
		 * allowing enough time to obtain all of the fragments. Conversely, larger values may increase
		 * quality by providing more time to obtain all of the fragments, with a corresponding
		 * increase in latency.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get multicastWindowDuration():Number
		{
			trace("Netstream.multicastWindowDuration property not implemented.");
			return null;
		}
		public function set multicastWindowDuration (seconds:Number):void
		{
			trace("Netstream.multicastWindowDuration property not implemented.");
		}

		/**
		 * For RTMFP and RTMPE connections, a value chosen substantially by this end of the stream, unique to this connection.
		 * This value appears to the other end of the stream as its farNonce value.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get nearNonce():String
		{
			trace("Netstream.nearNonce property not implemented.");
			return null;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get objectEncoding():uint
		{
			trace("Netstream.objectEncoding property not implemented.");
			return null;
		}

		/**
		 * An object that holds all of the subscribing NetStream instances that are listening to this publishing NetStream instance.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get peerStreams():Array
		{
			trace("Netstream.peerStreams property not implemented.");
			return null;
		}

		/**
		 * Controls sound in this NetStream object. For more information, see the SoundTransform class.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get soundTransform():flash.media.SoundTransform
		{
			trace("Netstream.soundTransform property not implemented.");
			return null;
		}
		public function set soundTransform (sndTransform:SoundTransform):void
		{
			trace("Netstream.soundTransform property not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get time():Number
		{
			return _time;
		}

		public function get useHardwareDecoder():Boolean
		{
			trace("Netstream.useHardwareDecoder property not implemented.");
			return null;
		}
		public function set useHardwareDecoder (v:Boolean):void
		{
			trace("Netstream.useHardwareDecoder property not implemented.");
		}

		public function get useJitterBuffer():Boolean
		{
			trace("Netstream.useJitterBuffer property not implemented.");
			return null;
		}
		public function set useJitterBuffer (value:Boolean):void
		{
			trace("Netstream.useJitterBuffer property not implemented.");
		}

		public function get videoCodec():uint
		{
			return _videoCodec;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get videoReliable():Boolean
		{
			trace("Netstream.videoReliable property not implemented.");
			return null;
		}
		public function set videoReliable (reliable:Boolean):void
		{
			trace("Netstream.videoReliable property not implemented.");
		}

		/**
		 * For RTMFP connections, specifies whether peer-to-peer subscribers on this NetStream are allowed to capture the video stream.
		 * When FALSE, subscriber attempts to capture the video stream show permission errors.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get videoSampleAccess():Boolean
		{
			trace("Netstream.videoSampleAccess property not implemented.");
			return null;
		}
		public function set videoSampleAccess (reliable:Boolean):void
		{
			trace("Netstream.videoSampleAccess property not implemented.");
		}

		public function get videoStreamSettings():VideoStreamSettings
		{
			trace("Netstream.videoStreamSettings property not implemented.");
			return null;
		}
		public function set videoStreamSettings (settings:VideoStreamSettings):void
		{
			trace("Netstream.videoStreamSettings property not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function appendBytes (bytes:ByteArray):void
		{
			if (bytes.length == 0) throw Error("NetStream.play() No Bytes Available. bytes.length is 0.");
			
			_playbackTarget.loop = false;
			_bytes = bytes.dataView.buffer;
			
			if (_mediaSource.readyState == "open" || _mediaSource.readyState == "ended")
			{
				_isNewBytes = true;
				
				if (!_sourceBuffer || _mediaSource.sourceBuffers.length == 0) 
				{
					//trace("NetStream.play() Setup Buffer");
					setupBuffer();
				}
				else
				{
					//trace("NestStream.appendBytes() AppendBytes");
					if (_sourceBuffer.updating)
					{
						_bytesQueue.push(_bytes);
					}
					else
					{
						_sourceBuffer.appendBuffer(_bytes);
					}
				}
			}
			else
			{
				//trace("NestStream.appendBytes Open MediaSource");
				HTMLMediaElement(_playbackTarget).src = URL.createObjectURL(_mediaSource);
				
			}
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function appendBytesAction (netStreamAppendBytesAction:String):void
		{
			trace("Netstream.appendBytesAction method not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function attach (connection:NetConnection):void
		{
			_netConnection = connection;
		}

		/**
		 * @param	microphone	The source of the audio stream to be transmitted.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function attachAudio (microphone:Microphone):void
		{
			
		}

		/**
		 * @param	theCamera	The source of the video transmission. Valid values are a Camera object
		 *   (which starts capturing video) and null. If you pass null,
		 *   the application stops capturing video, and any additional parameters you send are ignored.
		 * @param	snapshotMilliseconds	Specifies whether the video stream is continuous,
		 *   a single frame, or a series of single frames used to create time-lapse photography.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function attachCamera (theCamera:Camera, snapshotMilliseconds:int =-1):void
		{
			if (snapshotMilliseconds != -1) trace("WARNING Netstream.attachCamera() snapshotMilliseconds not implemented."); 
			
			if (theCamera.cameraStream)
			{
				_playbackTarget.srcObject = theCamera.cameraStream;
				theCamera.videoElement = _playbackTarget as HTMLVideoElement;
			}
			else
			{
				theCamera.addEventListener(ActivityEvent.ACTIVITY, function(e:ActivityEvent):void {
					if (e.activating)
					{
						_playbackTarget.srcObject = theCamera.cameraStream;
						theCamera.videoElement = _playbackTarget as HTMLVideoElement;
					}
				});
			}
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function close():void
		{
			// TODO implement close() method
		}

		public function dispose():void
		{
			// TODO implement dispose() method
		}

		/**
		 * Creates a stream that you can use to play media files and send data over a NetConnection object.
		 * @param	connection	A NetConnection object.
		 * @param	peerID	This optional parameter is available in Flash Player 10 and later, for use with RTMFP connections.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	ArgumentError The NetConnection instance is not connected.
		 */
		public function NetStream (connection:NetConnection, peerID:String = "connectToFMS")
		{
			_netConnection = connection;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function onPeerConnect (subscriber:NetStream):Boolean
		{
			trace("WARNING Netstream.onPeerConnect property not implemented.");
			return null;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function pause():void
		{
			_playbackTarget.pause();
			_paused = true;
		}

		/**
		 * @param	arguments	Play a local file
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	SecurityError Local untrusted SWF files cannot communicate with
		 *   the Internet. You can work around this restriction by reclassifying this SWF file
		 *   as local-with-networking or trusted.
		 * @throws	ArgumentError At least one parameter must be specified.
		 * @throws	Error The NetStream Object is invalid.  This may be due to a failed NetConnection.
		 */
		public function play (...rest):void
		{
			if (rest && rest[0] != null)
			{
				_url = rest[0];
				if (_playbackTarget)
				{
					_playbackTarget.src = _url;
					try
					{
						HTMLMediaElement(_playbackTarget).play();
					}
					catch (e:Error)
					{
						trace("Playback Error: " + e.message);
					}
					
					_playbackTarget.loop = _loop;
				}
			}
			else if (rest && rest[0] == null)
			{
				if (_mimeCodec == "undefined")
				{
					throw Error("NetStream.play mimeCodec must be set before playback.");
				}
				else if (MediaSource.isTypeSupported(_mimeCodec))
				{
					_mediaSource = new MediaSource();
					_mediaSource.addEventListener('sourceopen', handleSourceOpened, false);
					_mediaSource.addEventListener('error', handleMediaSourceError, false);
				}
				else
				{
					alert('Unsupported MIME type or codec: ' + _mimeCodec);
				}
			}
		}

		/**
		 * Switches seamlessly between files with multiple bit rates and allows a NetStream to resume when a connection is dropped and reconnected.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function play2 (param:NetStreamPlayOptions):void
		{
			trace("Netstream.play2 property not implemented.");
		}

		/**
		 * @param	name	A string that identifies the stream. Clients that subscribe to this stream pass
		 *   this name when they call NetStream.play(). Don't follow the stream name with a "/". For example, don't use
		 *   the stream name "bolero/".
		 * @param	type	A string that specifies how to publish the stream.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function publish (name:String = null, type:String = null):void
		{
			trace("Netstream.publish property not implemented.");
		}

		/**
		 * @param	flag	Specifies whether incoming audio plays on the stream (true) or not (false). The default value is true. 
		 *   If the specified stream contains only audio data, NetStream.time stops incrementing when you pass false.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function receiveAudio (flag:Boolean):void
		{
			trace("Netstream.receiveAudio property not implemented.");
		}

		/**
		 * @param	flag	Specifies whether incoming video plays on this stream (true) or not (false). The default value is true.
		 *   If the specified stream contains only video data, NetStream.time stops incrementing when you pass false.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function receiveVideo (flag:Boolean):void
		{
			trace("Netstream.receiveVideo property not implemented.");
		}

		/**
		 * @param	FPS	Specifies the frame rate per second at which the incoming video plays.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function receiveVideoFPS (FPS:Number):void
		{
			trace("Netstream.receiveVideoFPS property not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 * @throws	IOError The voucher data cannot be deleted.
		 */
		public static function resetDRMVouchers():void
		{
			trace("Netstream.resetDRMVouchers property not implemented.");
		}

		/**
		 * Resumes playback of a video stream that is paused. If the video is already playing, calling this method
		 * does nothing.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function resume():void
		{
			_playbackTarget.play();
			_paused = false;
		}

		/**
		 * @param	offset	The approximate time value, in seconds, to move to in a video file.
		 * @param	fastSeek	if true, seeking is faster, but less accurate.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function seek (offset:Number):void
		{
			_playbackTarget.currentTime = offset;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function send (handlerName:String, ...rest):void
		{
			trace("Netstream.send method not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function step (frames:int):void
		{
			trace("Netstream.step method not implemented.");
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function togglePause():void
		{
			_paused = !_paused;
			if (_playbackTarget)
			{
				(_paused) ? _playbackTarget.play() : _playbackTarget.pause();
			}
		}
		
		/**
		 * Path to local file for playback.
		 */
		public function get url():String
		{
			return _url;
		}
		
		/**
		 * Object such as Video to set source for playback.
		 */
		public function set playbackTarget(value:Object):void 
		{
			_playbackTarget = value;
			_playbackTarget.onabort = netStatusEvents;
			_playbackTarget.oncanplay = netStatusEvents;
			_playbackTarget.oncanplaythrough = netStatusEvents;
			_playbackTarget.ondurationchange = netStatusEvents;
			_playbackTarget.onemptied = netStatusEvents;
			_playbackTarget.onended = netStatusEvents;
			_playbackTarget.onerror = netStatusEvents;
			_playbackTarget.onloadeddata = netStatusEvents;
			_playbackTarget.onloadedmetadata = netStatusEvents;
			_playbackTarget.onloadstart = netStatusEvents;
			_playbackTarget.onpause = netStatusEvents;
			_playbackTarget.onplay = netStatusEvents;
			_playbackTarget.onplaying = netStatusEvents;
			_playbackTarget.onprogress = netStatusEvents;
			_playbackTarget.onratechange = netStatusEvents;
			_playbackTarget.onseeked = netStatusEvents;
			_playbackTarget.onseeking = netStatusEvents;
			_playbackTarget.onstalled = netStatusEvents;
			_playbackTarget.onsuspend = netStatusEvents;
			_playbackTarget.ontimeupdate = netStatusEvents;
			_playbackTarget.addEventListener('timeupdate', handleTime, false);
			_playbackTarget.onvolumechange = netStatusEvents;
			_playbackTarget.onwaiting = netStatusEvents;
		}
		
		/**
		 * The codec used in the supplied file.  VideoCodec.H264AVC (.mp4) and VideoCodec.VP8 (.webm) accepted only.
		 */
		public function get mimeCodec():String 
		{
			return _mimeCodec;
		}
		
		public function set mimeCodec(value:String):void 
		{
			_mimeCodec = value;
		}
		
		/**
		 * loops the playback continuously.  not supported in flash player or AIR.
		 */
		public function get loop():Boolean 
		{
			return _loop;
		}
		
		public function set loop(value:Boolean):void 
		{
			_loop = value;
			if (_playbackTarget && _url) _playbackTarget.loop = value;
		}
		
		private function netStatusEvents(e:Event):void 
		{
			switch (e.type) 
			{
				case 'abort':
					Object(e).code = "NetStream.Abort";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'canplay':
					Object(e).code = "NetStream.CanPlay";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'canplaythrough':
					Object(e).code = "NetStream.CanPlayThrough";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'durationchange':
					Object(e).code = "NetStream.DurationChange";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'emptied':
					Object(e).code = "NetStream.Emptied";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'ended':
					Object(e).code = "NetStream.ended";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'error':
					Object(e).code = "NetStream.Play.Stop";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'loadeddata':
					Object(e).code = "NetStream.LoadedData";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'loadedmetadata':
					Object(e).code = "NetStream.LoadedMetaData";
					if (_clientObject)
					{
						if (_playbackTarget is HTMLVideoElement)
						{
							if (_clientObject.onMetaData) _clientObject.onMetaData({duration:_playbackTarget.duration, width:_playbackTarget.videoWidth, height:_playbackTarget.videoHeight});
						}
						else if (_playbackTarget is HTMLAudioElement)
						{
							if (_clientObject.onMetaData) _clientObject.onMetaData({duration:_playbackTarget.duration, samplerate:_playbackTarget.playbackRate});
						}
					}
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'loadstart':
					Object(e).code = "NetStream.LoadStart";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'pause':
					Object(e).code = "NetStream.Play.Stop";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					Object(e).code = "NetStream.Pause.Notify";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'play':
					Object(e).code = "NetStream.Play.Start";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'playing':
					Object(e).code = "NetStream.Playing";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'progress':
					Object(e).code = "NetStream.Progress";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'ratechange':
					Object(e).code = "NetStream.RateChange";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'seeked':
					Object(e).code = "NetStream.Seek.Notify";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'seeking':
					Object(e).code = "NetStream.Seeking";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'stalled':
					Object(e).code = "NetStream.Stalled";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'suspend':
					Object(e).code = "NetStream.Suspend";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'timeupdate':
					Object(e).code = "NetStream.TimeUpdate";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'volumechange':
					Object(e).code = "NetStream.VolumeChange";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
				case 'waiting':
					Object(e).code = "NetStream.Waiting";
					dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, e));
					break;
			}
		}
		
		private function setupBuffer():void 
		{
			_sourceBuffer = _mediaSource.addSourceBuffer(_mimeCodec);
			_sourceBuffer.addEventListener('updateend', handleUpdateEnd, false);
			_sourceBuffer.addEventListener("error", netStatusEvents, false);
			_sourceBuffer.addEventListener("abort", netStatusEvents, false);
			_sourceBuffer.appendBuffer(_bytes);
		}
		
		private function handleMediaSourceError(e:Event):void 
		{
			trace("Error: NetStream.handleMediaSourceError()", e);
		}
		
		private function handleSourceOpened(e:Event):void 
		{
			//trace("Source Opened? " + _mediaSource.readyState);
			if (!_sourceBuffer) setupBuffer();
		}
		
		private function handleUpdateEnd(e:Event):void 
		{
			trace("NetStream.handleUpdateEnd() readyState: " + _mediaSource.readyState + ", duration: " + _mediaSource.duration);
			if (_mimeCodec == VideoCodec.VP8) _mediaSource.endOfStream(); // throws error on IE using MP4
			if (_isNewBytes)
			{
				//trace("NetStream.handleUpdateEnd() Seek to New Bytes!");
				_playbackTarget.removeEventListener('timeupdate', handleTime, false);
				var currentDuration:Number = _duration;
				_duration = _mediaSource.duration;
				_isNewBytes = false;
				_playbackTarget.currentTime = _duration - .0005;
			}
			else
			{
				_duration = _mediaSource.duration;
				if (_playbackTarget.paused)
				{
					try
					{
						HTMLMediaElement(_playbackTarget).play();
					}
					catch (e:Error)
					{
						trace("NetStream.handleUpdateEnd() Playback Error: " + e.message);
					}
				}
			}
			
			if (_bytesQueue.length > 0)
			{
				_sourceBuffer.appendBuffer(_bytesQueue[0]);
				_bytesQueue.shift();
			}
			
			_looped = false;
			
			try
			{
				HTMLMediaElement(_playbackTarget).play();
			}
			catch (e:Error)
			{
				trace("NetStream.handleUpdateEnd() Playback Error: " + e.message);
			}
		}
		
		
		private function handleSeeked(e:Event):void 
		{
			//trace("NetStream.handleSeeked()");
			_playbackTarget.addEventListener('timeupdate', handleTime, false);
		}
		
		private function handleTime(e:Event):void 
		{
			//trace("NetStream.handleTime() time: " + _playbackTarget.currentTime);
			if (_bytes && _playbackTarget.currentTime != 0 && _playbackTarget.currentTime >= _duration - 1 && !_looped)
			{
				_looped = true;
				_sourceBuffer.timestampOffset = _duration - .0005;
				_sourceBuffer.appendBuffer(_bytes.slice(0));
				//trace("NetStream.handleTime() APPEND LOOP!");
			}
		}
	}
}