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
	 * The NetStream class opens a one-way streaming channel over a NetConnection.
	 * 
	 *   <p class="- topic/p "> Use the NetStream class to do the following:</p><ul class="- topic/ul "><li class="- topic/li ">Call <codeph class="+ topic/ph pr-d/codeph ">NetStream.play()</codeph> to play a media file from a local disk, a web server, or Flash Media Server.</li><li class="- topic/li ">Call <codeph class="+ topic/ph pr-d/codeph ">NetStream.publish()</codeph> to publish a video, audio, and data stream to Flash Media Server.</li><li class="- topic/li ">Call <codeph class="+ topic/ph pr-d/codeph ">NetStream.send()</codeph> to send data messages to all subscribed clients.</li><li class="- topic/li ">Call <codeph class="+ topic/ph pr-d/codeph ">NetStream.send()</codeph> to add metadata to a live stream.</li><li class="- topic/li ">Call <codeph class="+ topic/ph pr-d/codeph ">NetStream.appendBytes()</codeph> to pass ByteArray data into the NetStream.</li></ul><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Note:</b>You cannot play and publish a stream over the same NetStream object.</p><p class="- topic/p ">Adobe AIR and Flash Player 9.0.115.0 and later versions
	 * support files derived from the standard MPEG-4 container format. These files include F4V, MP4, M4A, MOV, MP4V, 3GP, and 3G2
	 * if they contain H.264 video, HEAAC v2 encoded audio, or both. H.264 delivers higher quality video at lower bit rates
	 * when compared to the same encoding profile in Sorenson or On2. AAC is a standard audio format defined in the MPEG-4 video standard.
	 * HE-AAC v2 is an extension of AAC that uses Spectral Band Replication (SBR)
	 * and Parametric Stereo (PS) techniques to increase coding efficiency at low bit rates.</p><p class="- topic/p ">For information about supported codecs and file formats, see the following:</p><ul class="- topic/ul "><li class="- topic/li "><xref href="http://www.adobe.com/go/learn_fms_fileformats_en" scope="external" class="- topic/xref ">Flash Media Server documentation</xref></li><li class="- topic/li "><xref href="http://www.adobe.com/go/hardware_scaling_en" scope="external" class="- topic/xref ">Exploring Flash Player support for high-definition H.264 video and AAC audio</xref></li><li class="- topic/li "><xref href="http://www.adobe.com/go/video_file_format" scope="external" class="- topic/xref ">FLV/F4V open specification documents</xref></li></ul><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Receiving data from a Flash Media Server stream, progressive F4V file, or progressive FLV file</b></p><p class="- topic/p ">Flash Media Server, F4V files, and FLV files can send event objects containing data at specific
	 * data points during streaming or playback. You can handle data from a stream or FLV file during playback in two ways:</p><ul class="- topic/ul "><li class="- topic/li ">
	 * Associate a client property with an event handler to receive the data object.
	 * Use the <codeph class="+ topic/ph pr-d/codeph ">NetStream.client</codeph> property to assign an object to call specific
	 * data handling functions. The object assigned to the <codeph class="+ topic/ph pr-d/codeph ">NetStream.client</codeph> property
	 * can listen for the following data points: <codeph class="+ topic/ph pr-d/codeph ">onCuePoint()</codeph>,
	 * <codeph class="+ topic/ph pr-d/codeph ">onImageData()</codeph>, <codeph class="+ topic/ph pr-d/codeph ">onMetaData()</codeph>, <codeph class="+ topic/ph pr-d/codeph ">onPlayStatus()</codeph>, <codeph class="+ topic/ph pr-d/codeph ">onSeekPoint()</codeph>,
	 * <codeph class="+ topic/ph pr-d/codeph ">onTextData()</codeph>, and <codeph class="+ topic/ph pr-d/codeph ">onXMPData()</codeph>. Write procedures within those functions
	 * to handle the data object returned from the stream during playback.
	 * See the <codeph class="+ topic/ph pr-d/codeph ">NetStream.client</codeph> property for more information.
	 * </li><li class="- topic/li ">
	 * Associate a client property with a subclass of the NetStream class, then write
	 * an event handler to receive the data object. NetStream is
	 * a sealed class, which means that properties or methods cannot be added to a NetStream object
	 * at runtime. However, you can create a subclass of NetStream and define your event handler
	 * in the subclass. You can also make the subclass dynamic and add the event handler to an
	 * instance of the subclass.
	 * </li></ul><p class="- topic/p ">Wait to receive a <codeph class="+ topic/ph pr-d/codeph ">NetGroup.Neighbor.Connect</codeph> event before you use the object replication, direct routing, or posting APIs.</p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Note:</b> To send data through an audio file, like an mp3 file, use the Sound class
	 * to associate the audio file with a Sound object. Then, use the <codeph class="+ topic/ph pr-d/codeph ">Sound.id3</codeph> property
	 * to read metadata from the sound file.</p>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example uses a Video object with the NetConnection and 
	 * NetStream classes to load and play an FLV file. 
	 * <p class="- topic/p ">In this example, the code that creates the Video and NetStream objects and calls the
	 * <codeph class="+ topic/ph pr-d/codeph ">Video.attachNetStream()</codeph> and <codeph class="+ topic/ph pr-d/codeph ">NetStream.play()</codeph> methods is placed 
	 * in a handler function. The handler is called only if the
	 * attempt to connect to the NetConnection object is successful; that is, 
	 * when the <codeph class="+ topic/ph pr-d/codeph ">netStatus</codeph> event returns an <codeph class="+ topic/ph pr-d/codeph ">info</codeph> object with a <codeph class="+ topic/ph pr-d/codeph ">code</codeph>
	 * property that indicates success. 
	 * It is recommended that you wait for a successful connection before you call
	 * <codeph class="+ topic/ph pr-d/codeph ">NetStream.play()</codeph>. </p><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * package {
	 * import flash.display.Sprite;
	 * import flash.events.NetStatusEvent;
	 * import flash.events.SecurityErrorEvent;
	 * import flash.media.Video;
	 * import flash.net.NetConnection;
	 * import flash.net.NetStream;
	 * import flash.events.Event;
	 * 
	 *   public class NetConnectionExample extends Sprite {
	 * private var videoURL:String = "http://www.helpexamples.com/flash/video/cuepoints.flv";
	 * private var connection:NetConnection;
	 * private var stream:NetStream;
	 * private var video:Video = new Video();
	 * 
	 *   public function NetConnectionExample() {
	 * connection = new NetConnection();
	 * connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
	 * connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
	 * connection.connect(null);
	 * }
	 * 
	 *   private function netStatusHandler(event:NetStatusEvent):void {
	 * switch (event.info.code) {
	 * case "NetConnection.Connect.Success":
	 * connectStream();
	 * break;
	 * case "NetStream.Play.StreamNotFound":
	 * trace("Stream not found: " + videoURL);
	 * break;
	 * }
	 * }
	 * 
	 *   private function securityErrorHandler(event:SecurityErrorEvent):void {
	 * trace("securityErrorHandler: " + event);
	 * }
	 * 
	 *   private function connectStream():void {
	 * var stream:NetStream = new NetStream(connection);
	 * stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
	 * stream.client = new CustomClient();
	 * video.attachNetStream(stream);
	 * stream.play(videoURL);
	 * addChild(video);
	 * }
	 * }
	 * }
	 * 
	 *   class CustomClient {
	 * public function onMetaData(info:Object):void {
	 * trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
	 * }
	 * public function onCuePoint(info:Object):void {
	 * trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
	 * }
	 * }
	 * </codeblock>
	 * 
	 *   EXAMPLE:
	 * 
	 *   You can get metadata using a function, instead of creating a custom class. The following suggestion, 
	 * provided by <xref href="http://www.sandlight.com" scope="external" class="- topic/xref ">Bill Sanders</xref>, shows how to edit the NetConnectionExample code above to call metadata within a function. In this case, the object
	 * <codeph class="+ topic/ph pr-d/codeph ">mdata</codeph> is used to set up the width and height of a video instance <codeph class="+ topic/ph pr-d/codeph ">video</codeph>:
	 * <codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * //Place the following in the connectStream() function
	 * //in the NetConnectionExample code
	 * var metaSniffer:Object=new Object();  
	 * stream.client=metaSniffer; //stream is the NetStream instance  
	 * metaSniffer.onMetaData=getMeta;
	 * 
	 *   // Add the following function within the NetConnectionExample class  
	 * private function getMeta (mdata:Object):void  
	 * {  
	 * video.width=mdata.width/2;  
	 * video.height=mdata.height/2;  
	 * }  
	 * </codeblock>
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 * @playerversion	Lite 4
	 */
	public class NetStream extends EventDispatcher
	{
		/**
		 * A static object used as a parameter to
		 * the constructor for a NetStream instance. It is the default value of the second parameter
		 * in the NetStream constructor; it is
		 * not used by the application for progressive media playback. When used, this parameter causes the constructor to
		 * make a connection to a Flash Media Server instance.
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
		 * For RTMFP connections, specifies whether audio is sent with full reliability.  When TRUE, all audio transmitted over this NetStream is fully reliable.
		 * When FALSE, the audio transmitted is not fully reliable, but instead is retransmitted for a limited time and then dropped.
		 * You can use the FALSE value to reduce latency at the expense of audio quality.
		 * 
		 *   If you try to set this property to FALSE on a network protocol that does not support partial reliability,
		 * the attempt is ignored and the property is set to TRUE.
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
		 * The number of seconds of previously displayed data that currently cached for rewinding and playback.
		 * 
		 *   This property is available only when data is streaming from Flash Media Server 3.5.3 or higher;
		 * for more information on Flash Media Server, see the class description.To specify how much previously displayed data is cached, use the Netstream.backBufferTime property.  To prevent data from being cached, set the Netstream.inBufferSeek property to FALSE.
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
		 * Specifies how much previously displayed data Flash Player tries to cache for rewinding and playback, in seconds.
		 * The default value is 30 seconds for desktop applications and 3 seconds for mobile applications.
		 * 
		 *   This property is available only when data is streaming from Flash Media Server version 3.5.3 or later;
		 * for more information on Flash Media Server, see the class description.Using this property improves performance for rewind operations, as data that has already been displayed
		 * isn't retrieved from the server again. Instead, the stream begins replaying from the buffer.
		 * During playback, data continues streaming from the server until the buffer is full. If the rewind position is farther back than the data in the cache, the buffer is flushed;
		 * the data then starts streaming from the server at the requested position. To use this property set the Netstream.inBufferSeek property to TRUE.
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
		 * The number of seconds of data currently in the buffer. You can use this property with
		 * the bufferTime property to estimate how close the buffer is to being full — for example,
		 * to display feedback to a user who is waiting for data to be loaded into the buffer.
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
		 * Specifies how long to buffer messages before starting to display the stream.
		 * 
		 *   The default value is 0.1 (one-tenth of a second). To determine the number of seconds
		 * currently in the buffer, use the bufferLength property.To play a server-side playlist, set bufferTime to at least 1 second. If
		 * you experience playback issues, increase the length of bufferTime.
		 * Recorded content To avoid distortion when streaming pre-recorded (not live) content,
		 * do not set the value of Netstream.bufferTime to 0. By default, the application
		 * uses an input buffer for pre-recorded content that queues the media data and plays the media properly.
		 * For pre-recorded content, use the default setting or increase the buffer time.Live content When streaming live content, set the bufferTime property to 0.Starting with Flash Player 9.0.115.0, Flash Player no longer clears the buffer
		 * when NetStream.pause() is called. Before Flash Player 9.0.115.0, Flash Player
		 * waited for the buffer to fill up before resuming playback, which often caused a delay.For a single pause, the NetStream.bufferLength property has a limit of either 60 seconds
		 * or twice the value of NetStream.bufferTime, whichever value is higher. For example, if
		 * bufferTime is 20 seconds, Flash Player buffers until NetStream.bufferLength
		 * is the higher value of either 20~~2 (40), or 60. In this case it buffers until bufferLength is 60.
		 * If bufferTime is 40 seconds, Flash Player buffers until bufferLength is the higher value
		 * of 40~~2 (80), or 60. In this case it buffers until bufferLength is 80 seconds.The bufferLength property also has an absolute limit.
		 * If any call to pause() causes bufferLength
		 * to increase more than 600 seconds or the value of bufferTime ~~ 2, whichever is higher, Flash Player
		 * flushes the buffer and resets bufferLength to 0. For example, if
		 * bufferTime is 120 seconds, Flash Player flushes the buffer
		 * if bufferLength reaches 600 seconds; if bufferTime is 360 seconds,
		 * Flash Player flushes the buffer if bufferLength reaches 720 seconds.Tip: You can use NetStream.pause() in code to buffer data while viewers are watching
		 * a commercial, for example, and then unpause when the main video starts.For more information about the new pause behavior,
		 * see http://www.adobe.com/go/learn_fms_smartpause_en.Flash Media Server. The buffer behavior depends on whether the buffer time is
		 * set on a publishing stream or a subscribing stream.
		 * For a publishing stream, bufferTime specifies how long the outgoing buffer can
		 * grow before the application starts dropping frames.
		 * On a high-speed connection, buffer time is not a concern; data is sent
		 * almost as quickly as the application can buffer it. On a slow connection, however, there can
		 * be a significant difference between how fast the application buffers the data and how fast it
		 * is sent to the client.
		 * 
		 *   For a subscribing stream, bufferTime specifies how long to buffer incoming
		 * data before starting to display the stream.
		 * 
		 *   When a recorded stream is played, if bufferTime is 0, Flash sets it to a small
		 * value (approximately 10 milliseconds). If live streams are later played
		 * (for example, from a playlist), this buffer time persists. That is, bufferTime
		 * remains nonzero for the stream.
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
		 * Specifies a maximum buffer length for live streaming content, in seconds. The default value is 0.
		 * Buffer length can grow over time due to networking and device issues (such as clock drift between sender and receiver).
		 * Set this property to cap the buffer length for live applications such as meetings and surveillance.
		 * 
		 *   When bufferTimeMax > 0 and bufferLength >= bufferTimeMax, audio plays faster until
		 * bufferLength reaches bufferTime. If a live stream is video-only, video plays faster
		 * until bufferLength reaches bufferTime.Depending on how much playback is lagging (the difference between bufferLength and bufferTime),
		 * Flash Player controls the rate of catch-up between 1.5% and 6.25%.
		 * If the stream contains audio, faster playback is achieved by frequency domain downsampling which minimizes audible distortion.Set the bufferTimeMax property to enable live buffered stream catch-up in the following cases:Streaming live media from Flash Media Server.Streaming live media in Data Generation Mode (NetStream.appendBytes()).
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
		 * The number of bytes of data that have been loaded into the application. You can use this property
		 * with the bytesTotal property to estimate how close the buffer is to being full — for example,
		 * to display feedback to a user who is waiting for data to be loaded into the buffer.
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
		 * Specifies whether the application tries to download a cross-domain policy file from the
		 * loaded video file's server before beginning to load the video file. Use this property for progressive video download,
		 * and to load files that are outside the calling SWF file's own domain.
		 * This property is ignored when you are using RTMP.
		 * 
		 *   Set this property to true to call BitmapData.draw() on a video file loaded from a
		 * domain outside that of the calling SWF. The BitmapData.draw() method provides pixel-level access to the video.
		 * If you call BitmapData.draw() without setting the checkPolicyFile property
		 * to true at loading time, you can get a SecurityError exception
		 * because the required policy file was not downloaded.Do not set this property to true unless you want pixel-level access to the video you are loading.
		 * Checking for a policy file consumes network bandwidth and can delay the start of your download.When you call the NetStream.play() method with checkPolicyFile set to true,
		 * Flash Player or the AIR runtime
		 * must either successfully download a relevant cross-domain policy file or determine
		 * that no such policy file exists before it begins downloading. To verify the existence of a policy file,
		 * Flash Player or the AIR runtime
		 * performs the following actions, in this order:The application considers policy files that have already been downloaded.The application tries to download any pending policy files specified in calls to the
		 * Security.loadPolicyFile() method.The application tries to download a policy file from the default
		 * location that corresponds to the URL you passed to NetStream.play(), which is
		 * /crossdomain.xml on the same server as that URL.In all cases, Flash Player or Adobe AIR
		 * requires that an appropriate policy file exist on the video's server,
		 * that it provide access to the object at the URL you passed to play() based on the
		 * policy file's location, and that it allow the domain of the calling code's file to access the video,
		 * through one or more <allow-access-from> tags.If you set checkPolicyFile to true, the application waits until the policy file
		 * is verified before downloading the video. Wait to perform any pixel-level
		 * operations on the video data, such as calling BitmapData.draw(), until
		 * you receive onMetaData or NetStatus events from your
		 * NetStream object.If you set checkPolicyFile to true but no relevant policy file is found,
		 * you won't receive an error until you perform an operation that requires a policy file, and then
		 * the application throws a SecurityError exception.Be careful with checkPolicyFile if you are downloading a file from a URL that
		 * uses server-side HTTP redirects. The application tries to retrieve policy files
		 * that correspond to the initial URL that you specify in NetStream.play(). If the
		 * final file comes from a different URL because of HTTP redirects, the initially
		 * downloaded policy files might not be applicable to the file's final URL, which is the URL
		 * that matters in security decisions.For more information on policy files, see "Website controls (policy files)" in
		 * the ActionScript 3.0 Developer's Guide and the Flash Player Developer Center Topic:
		 * Security.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @internal	: please review at same time: checkPolicyFile property in LoaderContext
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
		 * Specifies the object on which callback methods are invoked to handle streaming or F4V/FLV
		 * file data. The default object is this, the
		 * NetStream object being created. If you set the client property to another
		 * object, callback methods are invoked on that other object. The NetStream.client
		 * object can call the following functions and receive an associated data object:
		 * onCuePoint(),
		 * onImageData(),
		 * onMetaData(), onPlayStatus(), onSeekPoint(),
		 * onTextData(), and onXMPData().
		 * To associate the client property with an event handler:Create an object and assign it to the client property of the
		 * NetStream object:
		 * 
		 *   <codeblock>
		 * 
		 *   var customClient:Object = new Object();
		 * my_netstream.client = customClient;
		 * 
		 *   </codeblock>
		 * Assign a handler function for the desired data event as a property of the client
		 * object:
		 * 
		 *   <codeblock>
		 * 
		 *   customClient.onImageData = onImageDataHandler;
		 * 
		 *   </codeblock>
		 * Write the handler function to receive the data event object, such as:
		 * 
		 *   <codeblock>
		 * 
		 *   public function onImageDataHandler(imageData:Object):void {
		 * trace("imageData length: " + imageData.data.length);
		 * }
		 * 
		 *   </codeblock>
		 * When data is passed through the stream or during playback, the data event object (in
		 * this case the imageData object) is populated with the data. See the onImageData
		 * description, which includes a full example of an object assigned to the client property.To associate the client property with a subclass:Create a subclass with a handler function to receive the data event object:
		 * 
		 *   <codeblock>
		 * 
		 *   class CustomClient {
		 * public function onMetaData(info:Object):void {
		 * trace("metadata: duration=" + info.duration + " framerate=" + info.framerate);
		 * }
		 * 
		 *   </codeblock>
		 * Assign an instance of the subclass to the client property  of the
		 * NetStream object:
		 * 
		 *   <codeblock>
		 * 
		 *   my_netstream.client = new CustomClient();
		 * 
		 *   </codeblock>
		 * When data is passed through the stream or during playback, the data event object (in
		 * this case the info object) is populated with the data. See the class example at
		 * the end of the NetStream class, which shows the assignment of a subclass instance
		 * to the client property.
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
		 * The number of frames per second being displayed. If you are exporting video files to be played back on a number
		 * of systems, you can check this value during testing to help you determine how much compression to apply when
		 * exporting the file.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get currentFPS():Number
		{
			return _currentFPS;
		}

		/**
		 * For RTMFP connections, specifies whether NetStream.send() calls are sent with full reliability.
		 * When TRUE, NetStream.send() calls
		 * that are transmitted over this NetStream are fully reliable.
		 * When FALSE, NetStream.send() calls are not transmitted with full reliability,
		 * but instead are retransmitted for a limited time and then dropped.
		 * You can set this value to FALSE to reduce latency at the expense of data quality.
		 * 
		 *   If you try to set this property to FALSE on a network protocol that does not support partial reliability,
		 * the attempt is ignored and the property is set to TRUE.
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
		 * Specifies whether displayed data is cached for smart seeking (TRUE), or not (FALSE).
		 * The default value is FALSE.
		 * 
		 *   Flash Media Server 3.5.3 and Flash Player 10.1 work together to support smart seeking.
		 * Smart seeking uses back and forward buffers to seek without requesting data from the server.
		 * Standard seeking flushes buffered data and asks the server to send new data based on the seek time.Call NetStream.step() to step forward and backward a specified number of frames. Call
		 * NetStream.seek() to seek forward and backward a specified number of seconds.Smart seeking reduces server load and improves seeking performance. Set inBufferSeek=true and
		 * call step() and seek() to create:Client-side DVR functionality. Seek within the client-side buffer instead of going to the server for delivery of new video.Trick modes. Create players that step through frames, fast-forward, fast-rewind, and advance in slow-motion.When inBufferSeek=true and a call to NetStream.seek() is successful,
		 * the NetStatusEvent info.description property contains the string "client-inBufferSeek".When a call to NetStream.step() is successful, the NetStatusEvent info.code property
		 * contains the string "NetStream.Step.Notify".
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 * @internal	The following links work only if qualified with NetStream. We don't know why.
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
		 * Returns a NetStreamInfo object whose properties contain statistics about the quality of service.
		 * The object is a snapshot of the current state.
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
		 * The number of seconds of data in the subscribing stream's
		 * buffer in live (unbuffered) mode. This property specifies the current
		 * network transmission delay (lag time).
		 * 
		 *   This property is intended primarily for use with a server such as Flash Media Server;
		 * for more information, see the class description.You can get the value of this property to roughly gauge the transmission
		 * quality of the stream and communicate it to the user.
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
		 * Specifies how long to buffer messages during pause mode, in seconds. This property can be used to limit how much buffering is done
		 * during pause mode. As soon as the value of NetStream.bufferLength reaches
		 * this limit, it stops buffering.
		 * 
		 *   If this value is not set, it defaults the limit to 60 seconds or twice the value of  NetStream.bufferTime on each pause,
		 * whichever is higher.
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
		 * For RTMFP connections, specifies whether peer-to-peer multicast fragment availability messages are
		 * sent to all peers or to just one peer.
		 * A value of TRUE specifies that the messages are sent to all peers once
		 * per specified interval. A value of FALSE specifies that the
		 * messages are sent to just one peer per specified interval. The interval
		 * is determined by the multicastAvailabilityUpdatePeriod property.
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
		 * For RTMFP connections, specifies the interval in seconds between messages sent to peers informing them that
		 * the local node has new peer-to-peer multicast media fragments available.
		 * Larger values can increase batching efficiency and reduce control overhead,
		 * but they can lower quality on the receiving end by reducing the amount of time available to retrieve
		 * fragments before they are out-of-window. Lower values can reduce latency and
		 * improve quality, but they increase control overhead.
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
		 * For RTMFP connections, specifies the time in seconds between when the local node learns that a peer-to-peer
		 * multicast media fragment is available and when it tries to fetch it from a peer. This value gives an opportunity for the
		 * fragment to be proactively pushed to the local node before a fetch from a
		 * peer is attempted. It also allows for more than one peer to announce availability
		 * of the fragment, so the fetch load can be spread among multiple peers.
		 * 
		 *   Larger values can improve load balancing and fairness in the peer-to-peer mesh,
		 * but reduce the available multicastWindowDuration and increase latency. Smaller values can
		 * reduce latency when fetching is required, but might increase duplicate data reception
		 * and reduce peer-to-peer mesh load balance.
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
		 * The object encoding (AMF version) for this NetStream object. The NetStream object
		 * inherits its objectEncoding value from the associated NetConnection object.
		 * It's important to understand this property if your ActionScript 3.0 SWF file needs to
		 * communicate with servers released prior to Flash Player 9.
		 * For more information, see the objectEncoding property description
		 * in the NetConnection class.
		 * 
		 *   The value of this property depends on whether the stream is local or
		 * remote. Local streams, where null was passed to the
		 * NetConnection.connect() method, return the value of
		 * NetConnection.defaultObjectEncoding. Remote streams, where you
		 * are connecting to a server, return the object encoding of the connection to the server.If you try to read this property when not connected, or if you try to change this property,
		 * the application throws an exception.
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
		 * The position of the playhead, in seconds.
		 * Flash Media Server For a subscribing stream, the number of seconds
		 * the stream has been playing. For a publishing stream, the number of
		 * seconds the stream has been publishing.
		 * This number is accurate to the thousandths decimal place; multiply
		 * by 1000 to get the number of milliseconds the stream has been playing.
		 * 
		 *   For a subscribing stream, if the server stops sending data but the stream remains open,
		 * the value of the time property stops advancing. When the server begins sending data again,
		 * the value continues to advance from the point at which it stopped (when the server stopped sending data).
		 * 
		 *   The value of time continues to advance when the stream
		 * switches from one playlist element to another. This property is set to 0 when
		 * NetStream.play() is called with reset set to 1 or
		 * true, or when NetStream.close() is called.
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
		 * For RTMFP connections, specifies whether video is sent with full reliability.  When TRUE, all video transmitted over this NetStream is fully reliable.
		 * When FALSE, the video transmitted is not fully reliable, but instead is retransmitted for a limited time and then dropped.
		 * You can use the FALSE value to reduce latency at the expense of video quality.
		 * 
		 *   If you try to set this property to FALSE on a network protocol that does not support partial reliability,
		 * the attempt is ignored and the property is set to TRUE.
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
		 * Passes a ByteArray into a NetStream for playout. Call this method on a NetStream in "Data Generation Mode". To put a NetStream into
		 * Data Generation Mode, call NetStream.play(null) on a NetStream created on a NetConnection connected to null.
		 * Calling appendBytes() on a NetStream that isn't in Data Generation Mode is an error and raises an exception.
		 * 
		 *   The byte parser understands an FLV file with a header.
		 * After the header is parsed, appendBytes() expects all future calls to be continuations
		 * of the same real or virtual file. Another header is not expected unless
		 * appendBytesAction(NetStreamAppendBytesAction.RESET_BEGIN) is called.
		 * 
		 *   A NetStream object has two buffers: the FIFO from appendBytes() to the NetStream,
		 * and the playout buffer. The FIFO is the partial-FLV-tag reassembly buffer and contains no more than one incomplete FLV tag.
		 * Calls to NetStream.seek() flush both buffers.
		 * After a call to seek(), call appendBytesAction() to reset the timescale to begin at the timestamp of the next appended message.
		 * 
		 *   Each call to appendBytes() adds bytes into the FIFO until an FLV tag is complete.
		 * When an FLV tag is complete, it moves to the playout buffer.  A call to appendBytes() can write multiple FLV tags.
		 * The first bytes complete an existing FLV tag (which moves to the playout buffer). Complete FLV tags move to the playout buffer.
		 * Remaining bytes that don’t form a complete FLV tag go into the FIFO. Bytes in the FIFO are either completed by a call to appendBytes()
		 * or flushed by a call to appendBytesAction() with the RESET_SEEK or RESET_BEGIN argument.
		 * Note: The byte parser may not be able to completely decode a call to appendBytes() until a
		 * subsequent call to appendBytes() is made.
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
					//trace("VideoBytes.play() Setup Buffer");
					setupBuffer();
				}
				else
				{
					//trace("VideoBytes.play() AppendBytes");
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
				//trace("VideoBytes.play() Open MediaSource");
				_playbackTarget.src = URL.createObjectURL(_mediaSource);
			}
		}

		/**
		 * Indicates a timescale discontinuity, flushes the FIFO, and tells the byte parser to expect a file header or the beginning of an FLV tag.
		 * 
		 *   Calls to NetStream.seek() flush the NetStream buffers.  The byte parser remains in flushing mode until you
		 * call appendBytesAction() and pass the RESET_BEGIN or RESET_SEEK argument.
		 * Capture the "NetStream.Seek.Notify" event to call appendBytesAction() after a seek.
		 * A new file header can support playlists and seeking without calling NetStream.seek().
		 * 
		 *   You can also call this method to reset the byte counter for the onSeekPoint()) callback.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function appendBytesAction (netStreamAppendBytesAction:String):void
		{
			trace("Netstream.appendBytesAction method not implemented.");
		}

		/**
		 * Attaches a stream to a new NetConnection object. Call this method to attach a NetStream to a new NetConnection object
		 * after a connection has dropped and been reconnected. Flash Player and AIR resume streaming from the playback point when
		 * the connection was lost.You can also use this method to implement load balancing.
		 * 
		 *   This method requires Flash Media Server version 3.5.3 or later.To use this method to implement stream reconnection, see the
		 * Flash Media Server 3.5.3 documentation. To use this method to implement load balancing, do the following:  Attach a connected stream to a NetConnection object on another server. After the stream is successfully attached to the new connection, call NetConnection.close()
		 * on the prior connection to prevent data leaks.Call NetStream.play2() and set the value of NetStreamPlayOptions.transition to RESUME.
		 * Set the rest of the NetStreamPlayOptions properties to the same values you used when you originally called
		 * NetStream.play() or NetStream.play2() to start the stream.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 * @internal	uncomment the following line after offset is added to the file
		 */
		public function attach (connection:NetConnection):void
		{
			_netConnection = connection;
		}

		/**
		 * Attaches an audio stream to a NetStream object from a Microphone
		 * object passed as the source. This method is available
		 * only to the publisher of the specified stream.
		 * 
		 *   Use this method with Flash Media Server to send live audio to the server.
		 * Call this method before or after you call the publish() method.
		 * Set the Microphone.rate property to match
		 * the rate of the sound capture device. Call setSilenceLevel() to set the silence level threshold.
		 * To control the sound properties (volume and panning) of
		 * the audio stream, use the Microphone.soundTransform property.
		 * var nc:NetConnection = new NetConnection();
		 * nc.connect("rtmp://server.domain.com/app");
		 * var ns:NetStream = new NetStream(nc);
		 * 
		 *   var live_mic:Microphone = Microphone.get();
		 * live_mic.rate = 8;
		 * live_mic.setSilenceLevel(20,200);
		 * 
		 *   var soundTrans:SoundTransform = new SoundTransform();
		 * soundTrans.volume = 6;
		 * live_mic.soundTransform = soundTrans;
		 * 
		 *   ns.attachAudio(live_mic);
		 * ns.publish("mic_stream","live")
		 * To hear the audio, call the NetStream.play() method and call DisplayObjectContainer.addChild()
		 * to route the audio to an object on the display list.
		 * @param	microphone	The source of the audio stream to be transmitted.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function attachAudio (microphone:Microphone):void
		{
			
		}

		/**
		 * Starts capturing video from a camera, or stops capturing if
		 * theCamera is set to null.
		 * This method is available only to the publisher of the specified stream.
		 * 
		 *   This method is intended for use with Flash Media Server;
		 * for more information, see the class description. After attaching the video source, you must call NetStream.publish()
		 * to begin transmitting. Subscribers who want to display the video
		 * must call the NetStream.play() and Video.attachCamera() methods
		 * to display the video on the stage.You can use snapshotMilliseconds to send a single snapshot
		 * (by providing a value of 0) or a series of snapshots — in effect,
		 * time-lapse footage — by providing a positive number that adds a trailer
		 * of the specified number of milliseconds to the video feed. The trailer
		 * extends the display time of the video message. By repeatedly
		 * calling attachCamera() with a positive value for snapshotMilliseconds,
		 * the sequence of alternating snapshots and trailers creates time-lapse footage.
		 * For example, you could capture one frame per day and append it to a video file.
		 * When a subscriber plays the file, each frame remains onscreen for the specified
		 * number of milliseconds and then the next frame is displayed.The purpose of the snapshotMilliseconds parameter is different
		 * from the fps parameter you can set with Camera.setMode(). When you specify
		 * snapshotMilliseconds, you control how much time elapses between recorded frames. When
		 * you specify fps using Camera.setMode(), you are
		 * controlling how much time elapses during recording and playback.For example, suppose you want to take a snapshot every 5 minutes for a total
		 * of 100 snapshots. You can do this in two ways:You can issue a NetStream.attachCamera(myCamera, 500) command
		 * 100 times, once every 5 minutes. This takes 500 minutes to record, but the resulting file
		 * will play back in 50 seconds (100 frames with 500 milliseconds between frames).You can issue a Camera.setMode() command with an fps value
		 * of 1/300 (one per 300 seconds, or one every 5 minutes), and then issue a
		 * NetStream.attachCamera(source) command, letting the camera capture continuously
		 * for 500 minutes. The resulting file will play back in 500 minutes — the same length of time
		 * that it took to record — with each frame being displayed for 5 minutes.Both techniques capture the same 500 frames, and both approaches are useful;
		 * the approach to use depends primarily on your playback requirements. For example,
		 * in the second case, you could be recording audio the entire time. Also, both files
		 * would be approximately the same size.
		 * @param	theCamera	The source of the video transmission. Valid values are a Camera object
		 *   (which starts capturing video) and null. If you pass null,
		 *   the application stops capturing video, and any additional parameters you send are ignored.
		 * @param	snapshotMilliseconds	Specifies whether the video stream is continuous,
		 *   a single frame, or a series of single frames used to create time-lapse photography.
		 *   
		 *     If you omit this parameter, the application captures all video until you pass
		 *   a value of null to attachCamera.If you pass 0, the application captures only a single video frame. Use this value
		 *   to transmit "snapshots" within a preexisting stream. Flash Player
		 *   or  AIR interprets invalid, negative, or nonnumeric arguments as 0.If you pass a positive number, the application captures a single video frame and then appends a pause
		 *   of the specified length as a trailer on the snapshot. Use this value to create time-lapse
		 *   photography effects.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function attachCamera (theCamera:Camera, snapshotMilliseconds:int =-1):void
		{
			if (snapshotMilliseconds != -1) trace("WARNING Netstream.attachCamera() snapshotMilliseconds not implemented."); 
			
			if (theCamera.cameraStream)
			{
				_playbackTarget.src = URL.createObjectURL( theCamera.cameraStream ) || theCamera.cameraStream;
				theCamera.videoElement = _playbackTarget as HTMLVideoElement;
			}
			else
			{
				theCamera.addEventListener(ActivityEvent.ACTIVITY, function(e:ActivityEvent):void {
					if (e.activating)
					{
						_playbackTarget.src = URL.createObjectURL( theCamera.cameraStream ) || theCamera.cameraStream;
						theCamera.videoElement = _playbackTarget as HTMLVideoElement;
					}
				});
			}
		}

		/**
		 * Stops playing all data on the stream, sets the time property to 0,
		 * and makes the stream available for another use. This method also deletes the local copy
		 * of a video file that was downloaded through HTTP. Although the application deletes the
		 * local copy of the file that it creates, a copy might persist in the
		 * cache directory. If you must completely prevent caching or local storage of the video file,
		 * use Flash Media Server.
		 * 
		 *   When using Flash Media Server, this method is invoked implicitly when you call
		 * NetStream.play() from a publishing stream or
		 * NetStream.publish() from a subscribing stream.
		 * Please note that:
		 * 
		 *   If close() is called from a publishing stream, the stream
		 * stops publishing and the publisher can now use the stream for another purpose.
		 * Subscribers no longer receive anything that was being published on the stream,
		 * because the stream has stopped publishing.
		 * 
		 *   If close() is called from a subscribing stream, the stream
		 * stops playing for the subscriber, and the subscriber can use the stream for
		 * another purpose.  Other subscribers are not affected.
		 * 
		 *   You can stop a subscribing stream from playing, without closing the stream
		 * or changing the stream type by using flash.net.NetStream.play(false).
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function close():void
		{
			
		}

		public function dispose():void
		{
			
		}

		/**
		 * Creates a stream that you can use to play media files and send data over a NetConnection object.
		 * @param	connection	A NetConnection object.
		 * @param	peerID	This optional parameter is available in Flash Player 10 and later, for use with RTMFP connections.
		 *   (If the value of the NetConnection.protocol property
		 *   is not "rtmfp", this parameter is ignored.) Use one of the following values:
		 *   
		 *     To connect to Flash Media Server, specify NetStream.CONNECT_TO_FMS. To publish directly to peers, specify NetStream.DIRECT_CONNECTIONS.To play directly from a specific peer, specify that peer's identity (see NetConnection.nearID
		 *   and NetStream.farID).(Flash Player 10.1 or AIR 2 or later) To publish or play a stream in a peer-to-peer multicast group,
		 *   specify a groupspec string (see the GroupSpecifier class).In most cases, a groupspec has the potential to use the network uplink on the local system. In this case,
		 *   the user is asked for permission to use the computer's network resources. If the user allows this
		 *   use, a NetStream.Connect.Success NetStatusEvent is sent to the NetConnection's event
		 *   listener. If the user denies permission, a NetStream.Connect.Rejected event is sent.
		 *   When specifying a groupspec, until a NetStream.Connect.Success event is received, it is an error to use any method
		 *   of the NetStream object, and an exception is raised.If you include this parameter in your constructor statement but pass a value of null,
		 *   the value is set to "connectToFMS".
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
		 * Invoked when a peer-publishing stream matches a peer-subscribing stream. Before the subscriber is
		 * connected to the publisher, call this method to allow the ActionScript code fine access control for
		 * peer-to-peer publishing. The following code shows an example of how to create a callback function for this method:
		 * 
		 *   <codeblock>
		 * 
		 *   var c:Object = new Object;
		 * c.onPeerConnect = function(subscriber:NetStream):Boolean {
		 * if (accept)
		 * return true;
		 * else
		 * return false;
		 * };
		 * m_netStream.client = c;
		 * 
		 *   </codeblock>
		 * If a peer-publisher does not implement this method, all peers are allowed to play any published content.
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
		 * Pauses playback of a video stream. Calling this method does nothing if the video
		 * is already paused. To resume play after pausing a video, call resume().
		 * To toggle between pause and play (first pausing the video, then resuming), call
		 * togglePause().
		 * 
		 *   Starting with Flash Player 9.0.115.0, Flash Player no longer clears the buffer when NetStream.pause() is called. 
		 * This behavior is called "smart pause". Before Flash Player 9.0.115.0, Flash Player waited for the buffer to fill up before resuming 
		 * playback, which often caused a delay. Note: For backwards compatibility, the "NetStream.Buffer.Flush" event (see the NetStatusEvent.info
		 * property) still fires, although the server does not flush the buffer.For a single pause, the NetStream.bufferLength property has a limit of either 60 seconds
		 * or twice the value of NetStream.bufferTime, whichever value is higher. For example, if
		 * bufferTime is 20 seconds, Flash Player buffers until NetStream.bufferLength
		 * is the higher value of either 20~~2 (40), or 60, so in this case it buffers until bufferLength is 60.
		 * If bufferTime is 40 seconds, Flash Player buffers until bufferLength is the higher value
		 * of 40~~2 (80), or 60, so in this case it buffers until bufferLength is 80 seconds.The bufferLength property also has an absolute limit.
		 * If any call to pause() causes bufferLength
		 * to increase more than 600 seconds or the value of bufferTime ~~ 2, whichever is higher, Flash Player
		 * flushes the buffer and resets bufferLength to 0. For example, if
		 * bufferTime is 120 seconds, Flash Player flushes the buffer
		 * if bufferLength reaches 600 seconds; if bufferTime is 360 seconds,
		 * Flash Player flushes the buffer if bufferLength reaches 720 seconds.Tip: You can use NetStream.pause() in code to buffer data while viewers are watching
		 * a commercial, for example, and then unpause when the main video starts.
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
		 * Plays a media file from a local directory or a web server; plays a media file or a live stream from Flash Media Server.
		 * Dispatches a NetStatusEvent object to report status and error messages.
		 * 
		 *   For information about supported codecs and file formats, see the following:Flash Media Server documentationExploring Flash Player support for high-definition H.264 video and AAC audioFLV/F4V open specification documentsWorkflow for playing a file or live streamCreate a NetConnection object and call NetConnection.connect().
		 * To play a file from a local directory or web server, pass null.To play a recorded file or live stream from Flash Media Server, pass the URI of a Flash Media Server application.Call NetConnection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler) to listen for NetStatusEvent events.On "NetConnection.Connect.Success", create a NetStream object and pass the NetConnection object to the constructor.Create a Video object and call Video.attachNetStream() and pass the NetStream object.Call NetStream.play().
		 * To play a live stream,
		 * pass the stream name passed to the NetStream.publish() method.To play a recorded file, pass the file name.Call addChild() and pass the Video object to display the video.Note:To see sample code, scroll to the example at the bottom of this page.Enable Data Generation Mode
		 * Call play(null) to enable "Data Generation Mode". In this mode, call the appendBytes() method to deliver
		 * data to the NetStream. Use Data Generation Mode to stream content over HTTP from the Adobe HTTP Dynamic Streaming Origin Module on an Apache HTTP Server.
		 * HTTP Dynamic Streaming lets clients seek quickly to any point in a file. The Open Source Media Framework (OSMF)
		 * supports HTTP Dynamic Streaming for vod and live streams. For examples of how to use NetStream Data Generation Mode, download the
		 * OSMF source.
		 * For more information about HTTP Dynamic Streaming, see
		 * HTTP Dynamic Streaming.
		 * 
		 *   When you use this method without Flash Media Server, there are security considerations. A file in the local-trusted or
		 * local-with-networking sandbox can load and play a video file from the remote sandbox, but cannot access
		 * the remote file's data without explicit permission in the form of a URL policy file.
		 * Also, you can prevent a SWF file running in Flash Player from using this method
		 * by setting the allowNetworking parameter of the the object and embed
		 * tags in the HTML page that contains the SWF content. For more information related to security, see the Flash Player Developer Center Topic:
		 * Security.
		 * @param	arguments	Play a local file
		 *   The location of a media file. Argument can be a String, a URLRequest.url
		 *   property, or a variable referencing either. In Flash Player and in AIR content outside the application
		 *   security sandbox, you can play local video files that are stored in the same directory as the SWF file or in a
		 *   subdirectory; however, you can't navigate to a higher-level directory.
		 *   
		 *     With AIR content in the application security sandbox, the path you specify for the media file is relative to the SWF 
		 *   file's directory. However, you cannot navigate above the SWF file's directory. Do not specify a full path since 
		 *   AIR treats it as a relative path.      
		 *   Play a file from Flash Media ServerNameRequiredDescriptionname:ObjectRequired  The name of a recorded file,
		 *   an identifier for live data published by NetStream.publish(),
		 *   or false.
		 *   If false, the stream stops playing and any additional parameters
		 *   are ignored. For more information on the filename syntax, see the file format table following this table.start:NumberOptional The start time, in seconds. Allowed values are -2, -1, 0,
		 *   or a positive number. The default value is -2, which looks
		 *   for a live stream, then a recorded stream, and if it finds
		 *   neither, opens a live stream. If -1, plays only a live stream.
		 *   If 0 or a positive number, plays a recorded stream, beginning
		 *   start seconds in.
		 *   len:Number Optional if start is specified.  The duration of the playback, in seconds.
		 *   Allowed values are -1, 0, or a positive number.
		 *   The default value is -1,
		 *   which plays a live or recorded stream until it ends.
		 *   If 0, plays a single frame that is
		 *   start
		 *   seconds from the beginning of a recorded stream.
		 *   If a positive number, plays a live or recorded stream for
		 *   len seconds.
		 *   reset:Object Optional if len is specified.  Whether to clear a playlist.
		 *   The default value is 1 or true, which clears any previous
		 *   play calls and plays name immediately.
		 *   If 0 or false, adds the stream to a playlist.
		 *   If 2, maintains the playlist and returns all stream
		 *   messages at once, rather than at intervals.
		 *   If 3, clears the playlist and returns all stream messages
		 *   at once.  
		 *   You can play back the file formats described in the following table. The syntax differs depending on the file format.
		 *   File formatSyntaxExampleFLVSpecify the stream name (in the "samples" directory) as a string without a filename extension.ns.play("samples/myflvstream");mp3 or ID3Specify the stream name (in the "samples" directory) as a string with the prefix mp3: or id3: without a filename extension.ns.play("mp3:samples/mymp3stream");ns.play("id3:samples/myid3data");MPEG-4-based files (such as F4V and MP4)Specify the stream name (in the "samples" directory) as a string with the prefix mp4:
		 *   The prefix indicates to the server that the file contains H.264-encoded video and AAC-encoded audio within
		 *   the MPEG-4 Part 14 container format. If the file on the server has a file extension, specify it. ns.play("mp4:samples/myvideo.f4v");ns.play("mp4:samples/myvideo.mp4");ns.play("mp4:samples/myvideo");ns.play("mp4:samples/myvideo.mov");RAWSpecify the stream name (in the "samples" directory) as a string with the prefix raw:ns.play("raw:samples/myvideo");Enable Data Generation Mode
		 *   To enable "Data Generation Mode", pass the value null to a NetStream created on a NetConnection connected to null.
		 *   In this mode, call appendBytes() to deliver data to the NetStream.
		 *   (Passing null also resets the byte counter for the onSeekPoint() callback.)
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @internal	"at"see flash.media.Video#attachVideo()  This method no longer exists.  Replace with new method.
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
					_playbackTarget.play();
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
		 * 
		 *   This method is an enhanced version of NetStream.play(). Like the play() method, the play2() method begins
		 * playback of a media file or queues up media files to create a playlist. When used with Flash Media Server, it can also
		 * request that the server switch to a different media file. The transition occurs seamlessly in the client application. The following features
		 * use play2() stream switching:Dynamic streamingDynamic streaming (supported in Flash Media Server 3.5 and later) lets you serve a stream encoded at multiple bit rates. As a viewer's network conditions change,
		 * they receive the bitrate that provides the best viewing experience. Use the NetStreamInfo class to monitor network conditions and
		 * switch streams based on the data. You can also switch streams for clients with different capabilities.
		 * For more information, see "Dynamic streaming" in the
		 * "Adobe Flash Media Server Developer Guide".Adobe built a custom ActionScript class called DynamicStream that extends the NetStream class. You can use the DynamicStream class
		 * to implement dynamic streaming in an application instead of writing your own code to detect network conditions. Even if you choose to write your own
		 * dynamic streaming code, use the DynamicStream class as a reference implementation. Download the class and the class documentation at the
		 * Flash Media Server tools and downloads page.Stream reconnectingStream reconnecting (supported in Flash Media Server 3.5.3 and later) lets users to experience media uninterrupted even when they lose their connection.
		 * The media uses the buffer to play while your ActionScript logic reconnects to Flash Media Server. After reconnection, call NetStream.attach()
		 * to use the same NetStream object with the new NetConnection. Use the NetStream.attach(), NetStreamPlayTransitions.RESUME,
		 * and NetStreamPlayTrasitions.APPEND_AND_WAIT APIs to reconnect a stream. For more information,
		 * see the Flash Media Server 3.5.3 documentation.
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
		 * Sends streaming audio, video, and data messages from a client to Flash Media Server,
		 * optionally recording the stream during transmission. This method dispatches a NetStatusEvent object with information about the stream.
		 * Before you call NetStream.publish(), capture the "NetConnection.Connect.Success" event
		 * to verify that the application has successfully connected to Flash Media Server.
		 * 
		 *   While publishing, you can record files in FLV or F4V format. If you record a file in F4V format,
		 * use a flattener tool to edit or play the file in another application.
		 * To download the tool, see
		 * www.adobe.com/go/fms_tools.Note:Do not use this method to play a stream. To play a stream, call the NetStream.play() method.Workflow for publishing a streamCreate a NetConnection object and call NetConnection.connect().Call NetConnection.addEventListener() to listen for NetStatusEvent events.On the "NetConnection.Connect.Success" event, create a NetStream object and pass the NetConnection object to the constructor.To capture audio and video, call the NetStream.attachAudio()method
		 * and the NetStream.attachCamera() method.To publish a stream, call the NetStream.publish() method.
		 * You can record the data as you publish it so that users can play it back later.Note: A NetStream can either publish a stream or play a stream, it cannot do both. To publish a stream and view the playback
		 * from the server, create two NetStream objects. You can send multiple NetStream objects over one NetConnection object.When Flash Media Server records a stream it creates a file.
		 * By default, the server creates a directory with the
		 * application instance name passed to NetConnection.connect() and stores the file in the directory.
		 * For example, the following code connects to the default instance of the "lectureseries" application and records a stream called "lecture".
		 * The file "lecture.flv" is recorded in the applications/lectureseries/streams/_definst_ directory:
		 * 
		 *   <codeblock>
		 * 
		 *   var nc:NetConnection = new NetConnection();
		 * nc.connect("rtmp://fms.example.com/lectureseries");
		 * nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
		 * 
		 *   function netStatusHandler(event:NetStatusEvent):void{
		 * if (event.info.code == "NetConnection.Connect.Success"){
		 * var ns:NetStream = new NetStream(nc);
		 * ns.publish("lecture", "record");
		 * }
		 * }
		 * 
		 *   </codeblock>
		 * The following example connects to the "monday" instance of the same application.
		 * The file "lecture.flv" is recorded in the directory /applications/lectureseries/streams/monday:
		 * <codeblock>
		 * 
		 *   var nc:NetConnection = new NetConnection();
		 * nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
		 * nc.connect("rtmp://fms.example.com/lectureseries/monday");
		 * 
		 *   function netStatusHandler(event:NetStatusEvent):void{
		 * if (event.info.code == "NetConnection.Connect.Success"){
		 * var ns:NetStream = new NetStream(nc);
		 * ns.publish("lecture", "record");
		 * }
		 * }
		 * 
		 *   </codeblock>
		 * @param	name	A string that identifies the stream. Clients that subscribe to this stream pass
		 *   this name when they call NetStream.play(). Don't follow the stream name with a "/". For example, don't use
		 *   the stream name "bolero/".
		 *   
		 *     You can record files in the formats described in the following table (you cannot use publish() for MP3 format files). 
		 *   The syntax differs depending on the file format.File formatSyntaxExampleFLVSpecify the stream name as a string without a filename extension.ns.publish("myflvstream");MPEG-4-based files (such as F4V or MP4)Specify the stream name as a string with the prefix mp4: with or without the filename extension.
		 *   Flash Player doesn't encode using H.264, but Flash Media Server can record any codec in the F4V container. Flash Media Live Encoder
		 *   can encode using H.264.
		 *   ns.publish("mp4:myvideo.f4v")ns.publish("mp4:myvideo");RAWSpecify the stream name as a string with the prefix raw:ns.publish("raw:myvideo");
		 * @param	type	A string that specifies how to publish the stream.
		 *   Valid values are "record", "append", "appendWithGap", and "live".
		 *   The default value is "live".
		 *   If you pass "record", the server publishes and records live data,
		 *   saving the recorded data to a new file with a name matching the value passed
		 *   to the name parameter. If the file exists, it is overwritten.If you pass "append", the server publishes and records live data,
		 *   appending the recorded data to a file with a name that matches the value passed
		 *   to the name parameter. If no file matching the name parameter is found, it is created. If you pass "appendWithGap", additional
		 *   information about time coordination is passed to help the server determine the correct transition point when dynamic streaming.If you omit this parameter or pass "live", the server publishes live data without
		 *   recording it. If a file with a name that matches the value passed
		 *   to the name parameter exists, it is deleted.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function publish (name:String = null, type:String = null):void
		{
			trace("Netstream.publish property not implemented.");
		}

		/**
		 * Specifies whether incoming audio plays on the stream.
		 * This method is available only to clients subscribed to the specified stream.
		 * It is not available to the publisher of the stream. Call this method before or after you call the NetStream.play() method.
		 * For example, attach this method to a button to allow users to mute and unmute the audio.
		 * Use this method only on unicast streams that are played back from Flash Media Server.  This method doesn't work on RTMFP multicast streams
		 * or when using the NetStream.appendBytes() method.
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
		 * Specifies whether incoming video plays on the stream. This method is available only to clients subscribed to the specified stream.
		 * It is not available to the publisher of the stream. Call this method before or after you call the NetStream.play() method. 
		 * For example, attach this method to a button to allow users to show and hide the video.
		 * Use this method only on unicast streams that are played back from Flash Media Server. This method doesn't work on RTMFP multicast streams
		 * or when using the NetStream.appendBytes() method.
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
		 * Specifies the frame rate for incoming video. This method is available only to clients subscribed to the specified stream. 
		 * It is not available to the publisher of the stream.
		 * Call this method before or after you call the NetStream.play() method. For example, call this method to allow users 
		 * to set the video frame rate. To determine the current frame rate, use NetStream.currentFPS. To stop receiving video, pass 0.
		 * When you pass a value to the FPS parameter to limit the frame rate of the video, Flash Media Server attempts to reduce the frame rate while preserving
		 * the integrity of the video. Between every two keyframes, the server sends the minimum number of frames needed to satisfy the desired rate. 
		 * Please note that I-frames (or intermediate frames) must be sent contiguously, otherwise the video is corrupted. Therefore, the desired number of frames 
		 * is sent immediately and contiguously following a keyframe. Since the frames are not evenly distributed, the motion appears smooth in segments punctuated by stalls.Use this method only on unicast streams that are played back from Flash Media Server. This method doesn't work on RTMFP multicast streams or when using the
		 * NetStream.appendBytes() method.
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
		 * Deletes all locally cached digital rights management (DRM) voucher data.
		 * 
		 *   The application must re-download any required vouchers from the media rights server for the user
		 * to be able to access protected content. Calling this function is equivalent to calling the
		 * resetDRMVouchers() function of the DRMManager object.
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
			_playbackTarget.pause();
			_paused = false;
		}

		/**
		 * Seeks the keyframe (also called an I-frame in the video industry) closest to
		 * the specified location. The keyframe is placed at an offset, in seconds, from
		 * the beginning of the stream.
		 * 
		 *   Video streams are usually encoded with two types of frames, keyframes (or I-frames)
		 * and P-frames. A keyframe contains an entire image, while a P-frame is an
		 * interim frame that provides additional video information between keyframes.
		 * A video stream typically has a keyframe every 10-50 frames.
		 * Flash Media Server has several types of seek behavior: enhanced seeking and smart seeking.Enhanced seeking Enhanced seeking is enabled by default. To disable enhanced seeking, on Flash Media Server set the EnhancedSeek
		 * element in the Application.xml configuration file to false.
		 * If enhanced seeking is enabled, the server generates
		 * a new keyframe at offset based on the previous keyframe and any
		 * intervening P-frames. However, generating keyframes creates a high processing load on the server
		 * and distortion might occur in the generated keyframe.
		 * If the video codec is On2, the keyframe before the seek point and any
		 * P-frames between the keyframe and the seek point are sent to the client.
		 * 
		 *   If enhanced seeking is disabled, the server starts streaming
		 * from the nearest keyframe. For example, suppose a video has keyframes at 0 seconds
		 * and 10 seconds. A seek to 4 seconds causes playback to start at 4 seconds
		 * using the keyframe at 0 seconds. The video stays frozen until it reaches the
		 * next keyframe at 10 seconds. To get a better seeking experience, you need to
		 * reduce the keyframe interval. In normal seek mode, you cannot start the video
		 * at a point between the keyframes.
		 * Smart seekingTo enable smart seeking, set NetStream.inBufferSeek to true.Smart seeking allows Flash Player to seek within an existing back buffer and forward buffer. When smart seeking is disabled,
		 * each time seek() is called Flash Player flushes the buffer and requests data from the server.
		 * For more information, see NetStream.inBufferSeek.Seeking in Data Generation ModeWhen you call seek() on a NetStream in Data Generation Mode, all bytes passed to
		 * appendBytes() are discarded (not placed in the buffer, accumulated in the partial message FIFO, or parsed for seek points)
		 * until you call appendBytesAction(NetStreamAppendBytesAction.RESET_BEGIN) or appendBytesAction(NetStreamAppendBytesAction.RESET_SEEK)
		 * to reset the parser. For information about Data Generation Mode, see NetStream.play().
		 * @param	offset	The approximate time value, in seconds, to move to in a video file.
		 *   With Flash Media Server, if <EnhancedSeek> is set to true in the Application.xml
		 *   configuration file (which it is by default), the server
		 *   generates a keyframe at offset.
		 *   
		 *     To return to the beginning of the stream, pass 0 for offset.To seek forward from the beginning of the stream, pass the number of seconds to advance.
		 *   For example, to position the playhead at 15 seconds from the beginning (or the keyframe
		 *   before 15 seconds), use myStream.seek(15).To seek relative to the current position, pass NetStream.time + n
		 *   or NetStream.time - n
		 *   to seek n seconds forward or backward, respectively, from the current position.
		 *   For example, to rewind 20 seconds from the current position, use
		 *   NetStream.seek(NetStream.time - 20).
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
		 * Sends a message on a published stream to all subscribing clients.
		 * This method is available only to the publisher of the specified stream.
		 * This method is available for use with Flash Media Server only.
		 * To process and respond to this message, create a handler on the
		 * NetStream object, for example, ns.HandlerName.
		 * 
		 *   Flash Player or  AIR does not serialize methods
		 * or their data, object prototype variables, or non-enumerable variables. For display objects,
		 * Flash Player or  AIR serializes the path but none of the data.
		 * 
		 *   You can call the send() method to add data keyframes to a live stream
		 * published to Flash Media Server. A data keyframe is a message a publisher adds
		 * to a live stream. Data keyframes are typically used to add metadata to a live stream
		 * before data is captured for the stream from camera and microphone.
		 * A publisher can add a data keyframe at any time while the live stream is being published.
		 * The data keyframe is saved in the server's memory as long
		 * as the publisher is connected to the server.
		 * 
		 *   Clients who are subscribed to the live stream before a data keyframe is
		 * added receive the keyframe as soon as it is added. Clients who subscribe
		 * to the live stream after the data keyframe is added receive the keyframe
		 * when they subscribe.
		 * 
		 *   To add a keyframe of metadata to a live stream sent to Flash Media Server, use
		 * @setDataFrame as the handler name,
		 *   followed by two additional arguments, for example:
		 *   
		 *     <codeblock>
		 *   
		 *     var ns:NetStream = new NetStream(nc);
		 *   ns.send("@setDataFrame", "onMetaData", metaData);
		 *   
		 *     </codeblock>
		 *   
		 *     The
		 * @setDataFrame argument
		 *   refers to a special handler built in to Flash Media Server.
		 *   The onMetaData argument is the
		 *   name of a callback function in your client application that
		 *   listens for the onMetaData event and retrieves the metadata.
		 *   The third item, metaData, is an instance
		 *   of Object or Array
		 *   with properties that define the metadata values.
		 *   Use
		 * @clearDataFrame to clear a keyframe
		 *   of metadata that has already been set in the stream:
		 *   
		 *     <codeblock>
		 *   
		 *     ns.send("@clearDataFrame", "onMetaData");
		 *   
		 *     </codeblock>
		 * @param	handlerName	The message to send; also the name of the ActionScript
		 *   handler to receive the message. The handler name can be only one level deep
		 *   (that is, it can't be of the form parent/child) and is relative to the stream object.
		 *   Do not use a reserved term for a handler name.
		 *   For example, using "close" as a handler name causes
		 *   the method to fail.
		 *   With Flash Media Server, use
		 * @setDataFrame to add a
		 *   keyframe of metadata to a live stream
		 *   or
		 * @clearDataFrame to remove a keyframe.
		 * @param	arguments	Optional arguments that can be of any type. They are
		 *   serialized and sent over the connection, and the receiving handler receives
		 *   them in the same order. If a parameter is a circular object (for example,
		 *   a linked list that is circular), the serializer handles the references correctly.
		 *   With Flash Media Server,
		 *   if
		 * @setDataFrame is the first argument,
		 *   use onMetaData as the second argument; for the third
		 *   argument, pass an instance of Object
		 *   or Array that has the metadata set as properties.
		 *   See the
		 *   Flash Media Server Developer Guide
		 *   for a list of suggested
		 *   property names.
		 *   With
		 * @clearDataFrame as the first argument,
		 *   use onMetaData as the second argument and no third argument.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function send (handlerName:String, ...rest):void
		{
			trace("Netstream.send method not implemented.");
		}

		/**
		 * Steps forward or back the specified number of frames, relative to the currently displayed frame.
		 * Specify a positive number to step forward and a negative number to step in reverse.
		 * Call this method to create accurate fast forward or rewind functionality.
		 * 
		 *   This method is available only when data is streaming from Flash Media Server 3.5.3 or higher
		 * and when NetStream.inBufferSeek is true. Also, the target frame must be in the buffer.
		 * For example, if the currently displayed frame is frame number 120 and you specify a value
		 * of 1000, the method fails if frame number 1120 is not in the buffer.This method is intended to be used with the pause() or togglePause() methods. If you
		 * step 10 frames forward or backward during playback without pausing, you may not notice the steps or they'll look like a glitch.
		 * Also, when you call pause() or togglePause the audio is suppressed.If the call to NetStream.step() is successful, a NetStatusEvent is sent with "NetStream.Step.Notify"
		 * as the value of the info object's code property.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function step (frames:int):void
		{
			trace("Netstream.step method not implemented.");
		}

		/**
		 * Pauses or resumes playback of a stream.
		 * The first time you call this method, it pauses play; the next time, it resumes play.
		 * You could use this method to let users pause or resume playback by pressing
		 * a single button.
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
		 * loops the playback continuously.
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
			//trace("NetStream.handleUpdateEnd() readyState: " + _mediaSource.readyState + ", duration: " + _mediaSource.duration);
			if (_mimeCodec == VideoCodec.VP8) _mediaSource.endOfStream(); // throws error on IE using MP4
			if (_isNewBytes)
			{
				//trace("NetStream.handleUpdateEnd() Seek to New Bytes!");
				_playbackTarget.removeEventListener('timeupdate', handleTime, false);
				var currentDuration:Number = _duration;
				_duration = _mediaSource.duration;
				_isNewBytes = false;
				_playbackTarget.currentTime = _duration - .25;
			}
			else
			{
				_duration = _mediaSource.duration;
				if (_playbackTarget.paused) _playbackTarget.play();
			}
			
			if (_bytesQueue.length > 0)
			{
				_sourceBuffer.appendBuffer(_bytesQueue[0]);
				_bytesQueue.shift();
			}
			
			_looped = false;
			_playbackTarget.play();
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
				_sourceBuffer.timestampOffset = _duration;
				_sourceBuffer.appendBuffer(_bytes.slice(0));
				//trace("NetStream.handleTime() APPEND LOOP!");
			}
		}
	}
}