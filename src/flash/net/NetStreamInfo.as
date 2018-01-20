package flash.net
{
	/**
	 * The NetStreamInfo class specifies the various Quality of Service (QOS) statistics and other information related to a NetStream object
	 * and the underlying streaming buffer for audio, video, and data. A NetStreamInfo object is returned in response
	 * to the <codeph class="+ topic/ph pr-d/codeph ">NetStream.info</codeph> call, which takes a snapshot of the current QOS state
	 * and provides the QOS statistics through the NetStreamInfo properties.
	 * @langversion	3.0
	 * @playerversion	Flash 10
	 * @playerversion	AIR 1.5
	 * @playerversion	Lite 4
	 */
	public final class NetStreamInfo extends Object
	{
		/**
		 * Provides the NetStream audio buffer size in bytes.
		 * It specifies the buffer size for audio data in streaming media, both live and recorded.
		 * This property is like Netstream.bytesLoaded,
		 * which is used in progressive downloads.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get audioBufferByteLength () : Number { return null; }

		/**
		 * Provides NetStream audio buffer size in seconds. This property extends the NetStream.bufferLength property
		 * and provides the buffer length in time specifically for audio data.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get audioBufferLength () : Number { return null; }

		/**
		 * Specifies the total number of audio bytes that have arrived in the queue, regardless of how many have been played or flushed.
		 * You can use this value to calculate the incoming audio data rate, using the metric of your choice, by creating a timer and calculating the difference in values
		 * in successive timer calls. Alternatively, use audioBytesPerSecond.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get audioByteCount () : Number { return null; }

		/**
		 * Specifies the rate at which the NetStream audio buffer is filled in bytes per second. The value is calculated as a smooth
		 * average for the audio data received in the last second.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get audioBytesPerSecond () : Number { return null; }

		/**
		 * Specifies the audio loss for the NetStream session. This value returns a valid value only for RTMFP streams and would return 0 for RTMP streams.
		 * Loss rate is defined as the ratio of lost messages to total messages.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	Lite 4
		 */
		public function get audioLossRate () : Number { return null; }

		/**
		 * Specifies the total number of bytes that have arrived into the queue, regardless of how many have been played or flushed.
		 * You can use this value to calculate the incoming data rate, using the metric of your choice, by creating a timer and calculating the difference in values
		 * in successive timer calls. Alternatively, use currentBytesPerSecond.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get byteCount () : Number { return null; }

		/**
		 * Specifies the rate at which the NetStream buffer is filled in bytes per second. The value is calculated as a smooth
		 * average for the total data received in the last second.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get currentBytesPerSecond () : Number { return null; }

		/**
		 * Provides the NetStream data buffer size in bytes.
		 * It specifies the buffer size for data messages in streaming media, both live and recorded.
		 * This property is like Netstream.bytesLoaded,
		 * which is used in progressive downloads.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get dataBufferByteLength () : Number { return null; }

		/**
		 * Provides NetStream data buffer size in seconds. This property extends the NetStream.bufferLength property
		 * and provides the buffer length in time specifically for data messages.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get dataBufferLength () : Number { return null; }

		/**
		 * Specifies the total number of bytes of data messages that have arrived in the queue, regardless of how many have been played or flushed.
		 * You can use this value to calculate the incoming data-messages rate, using the metric of your choice,
		 * by creating a timer and calculating the difference in values in successive timer calls.
		 * Alternatively, use dataBytesPerSecond.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get dataByteCount () : Number { return null; }

		/**
		 * Specifies the rate at which the NetStream data buffer is filled in bytes per second. The value is calculated as a smooth
		 * average for the data messages received in the last second.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get dataBytesPerSecond () : Number { return null; }

		/**
		 * Returns the number of video frames dropped in the current NetStream playback session.
		 * In recorded streaming or progressive download, if the video is a high-quality or high-resolution, high-bitrate video,
		 * the decoder can lag behind in decoding the required number of frames per second if it does not have adequate
		 * system CPU resources. In live streaming, the buffer drops video frames if the latency is too high. This property specifies
		 * the number of frames that were dropped and not presented normally.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get droppedFrames () : Number { return null; }

		/**
		 * Whether the media being played is recorded or live. This property is relevant for RTMP streaming only.  For 
		 * progressive download and HTTP Dynamic Streaming the property is always false.
		 * 
		 *   Note: This property is always false in Flash Player in the browser on Android and Blackberry Tablet OS or
		 * in AIR on iOS.
		 * @langversion	3.0
		 * @playerversion	Flash 10.3
		 * @playerversion	AIR 2.7
		 */
		public function get isLive () : Boolean { return false; }

		/**
		 * Specifies the maximum rate at which the NetStream buffer is filled in bytes per second. This value provides information about the capacity of the
		 * client network based on the last messages received by the NetStream object. Depending on the size of the buffer specified in
		 * NetStream.bufferTime and the bandwidth available on the client, Flash Media Server fills the buffer in bursts.
		 * This property provides the maximum rate at which the client buffer is filled.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get maxBytesPerSecond () : Number { return null; }

		/**
		 * The most recent metadata object associated with the media being played.
		 * 
		 *   Note: This property is always null in Flash Player in the browser on Android and Blackberry Tablet OS or
		 * in AIR on iOS.
		 * @langversion	3.0
		 * @playerversion	Flash 10.3
		 * @playerversion	AIR 2.7
		 */
		public function get metaData () : Object { return null; }

		/**
		 * Returns the stream playback rate in bytes per second. The playback buffer can contain content of various playlists.
		 * This property provides the playback rate that closely matches the bit rate of the currently playing stream.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get playbackBytesPerSecond () : Number { return null; }

		/**
		 * The resource name used when NetStream.play() was called. This property contains the full URL for progressive
		 * download, the resource name for RTMP streaming and null for HTTP streaming.
		 * 
		 *   Note: This property is always null in Flash Player in the browser on Android and Blackberry Tablet OS or
		 * in AIR on iOS.
		 * @langversion	3.0
		 * @playerversion	Flash 10.3
		 * @playerversion	AIR 2.7
		 */
		public function get resourceName () : String { return null; }

		/**
		 * The smoothed round trip time (SRTT) for the NetStream session, in milliseconds.
		 * This property contains a valid value only for RTMFP streams. For RTMP streams, the value is 0.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get SRTT () : Number { return null; }

		/**
		 * The URI used when NetConnection.connect() was called. This is null for progressive download 
		 * or HTTP streaming.
		 * 
		 *   Note: This property is always null in Flash Player in the browser on Android and Blackberry Tablet OS or
		 * in AIR on iOS.
		 * @langversion	3.0
		 * @playerversion	Flash 10.3
		 * @playerversion	AIR 2.7
		 */
		public function get uri () : String { return null; }

		/**
		 * Provides the NetStream video buffer size in bytes.
		 * It specifies the buffer size for video data in streaming media, both live and recorded.
		 * This property is like Netstream.bytesLoaded,
		 * which is used in progressive downloads.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get videoBufferByteLength () : Number { return null; }

		/**
		 * Provides NetStream video buffer size in seconds. This property extends the NetStream.bufferLength property
		 * and provides the buffer length in time specifically for video data.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get videoBufferLength () : Number { return null; }

		/**
		 * Specifies the total number of video bytes that have arrived in the queue, regardless of how many have been played or flushed.
		 * You can use this value to calculate the incoming video data rate, using the metric of your choice,
		 * by creating a timer and calculating the difference in values in successive timer calls.
		 * Alternatively, use videoBytesPerSecond,
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get videoByteCount () : Number { return null; }

		/**
		 * Specifies the rate at which the NetStream video buffer is filled in bytes per second. The value is calculated as a smooth
		 * average for the video data received in the last second.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function get videoBytesPerSecond () : Number { return null; }

		/**
		 * Provides the NetStream video loss rate (ratio of lost messages to total messages).
		 * 
		 *   When the message size is smaller than the maximum transmission unit (MTU), this value corresponds to
		 * the network packet loss rate.This property returns a valid value only for RTMFP streams. For RTMP streams, it returns a value of zero.
		 * For more information, see the
		 * Flash Media Server documentation.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get videoLossRate () : Number { return null; }

		/**
		 * The most recent XMP data object associated with the media being played.
		 * 
		 *   Note: This property is always null in Flash Player in the browser on Android and Blackberry Tablet OS or
		 * in AIR on iOS.
		 * @langversion	3.0
		 * @playerversion	Flash 10.3
		 * @playerversion	AIR 2.7
		 */
		public function get xmpData () : Object { return null; }

		public function NetStreamInfo (curBPS:Number, byteCount:Number, maxBPS:Number, audioBPS:Number, audioByteCount:Number, videoBPS:Number, videoByteCount:Number, dataBPS:Number, dataByteCount:Number, playbackBPS:Number, droppedFrames:Number, audioBufferByteLength:Number, videoBufferByteLength:Number, dataBufferByteLength:Number, audioBufferLength:Number, videoBufferLength:Number, dataBufferLength:Number, srtt:Number, audioLossRate:Number, videoLossRate:Number, metaData:Object = null, xmpData:Object = null, uri:String = null, resourceName:String = null, isLive:Boolean = true)
		{
			
		}

		/**
		 * Returns a text value listing the properties of the NetStreamInfo object.
		 * @return	A string containing the values of the properties of the NetStreamInfo object
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function toString () : String { return ""; }
	}
}