package flash.net
{
	import flash.events.EventDispatcher;

	/**
	 * The NetStreamPlayOptions class specifies the various options that can be passed 
	 * to the <codeph class="+ topic/ph pr-d/codeph ">NetStream.play2()</codeph> method. You pass a NetStreamPlayOptions object
	 * to <codeph class="+ topic/ph pr-d/codeph ">play2()</codeph>, and the properties of the class specify the various options.
	 * The primary use case for this class is to implement transitions between streams dynamically,
	 * either to switch to streams of different bit rates and sizes or to swap to different content
	 * in a playlist.
	 * @langversion	3.0
	 * @playerversion	Flash 10
	 * @playerversion	AIR 1.5
	 * @playerversion	Lite 4
	 */
	public dynamic class NetStreamPlayOptions extends EventDispatcher
	{
		/**
		 * The duration of playback, in seconds, for the stream specified in streamName. 
		 * The default value is -1, which means that Flash Player plays a live stream until it is no longer available or plays a recorded stream until it ends.
		 * If you pass 0 for len, Flash Player plays the single frame that is start seconds from the beginning of a recorded stream
		 * (assuming that start is equal to or greater than 0).
		 * If you pass a positive number for len, Flash Player plays a live stream for len seconds after it becomes available, 
		 * or plays a recorded stream for len seconds. (If a stream ends before len seconds, playback ends when the stream ends.)If you pass a negative number other than -1 for len, Flash Player interprets the value as if it were -1.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public var len : Number;

		/**
		 * The time in seconds in the stream playback at which the switch to a new stream should be made. 
		 * The offset parameter is used when a NetStream.play2() call is made with the 
		 * NetStreamPlayTransitions.SWITCH transition mode. Flash Media Server looks for the nearest switch point 
		 * after the specified offset time and starts streaming the new stream from that point onwards.
		 * 
		 *   Fast switchWhen this property is specified, Flash Media Server pre-empts the current stream and starts streaming the new stream 
		 * from the specified index position immediately, without waiting to 
		 * find a keyframe. Any data after the offset already buffered from a previous stream is flushed. 
		 * This technique can switch to a new stream more quickly than standard switching, because the buffered data from an older stream
		 * doesn't have to play out.The default value of offset is -1, which is fast switch mode. In this mode, switching occurs at the first available keyframe after netstream.time + 3, 
		 * which is about 3 seconds later than the playback point.The offset value must be higher than the current playback time (Netstream.time)
		 * If the value is less, a NetStream.Play.Failed status event is sent.For more information, see "Fast switching between streams"
		 * in the Adobe Flash Media Server Developer's Guide.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 * @playerversion	Lite 4
		 */
		public var offset : Number;

		/**
		 * The name of the old stream or the stream to transition from.   
		 * When NetStream.play2() is used to simply play a stream (not perform a transition), the value of this property
		 * should be either null or undefined. Otherwise, specify the stream to transition from.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public var oldStreamName : String;

		/**
		 * The start time, in seconds, for streamName. Valid values are -2, -1, and 0.
		 * 
		 *   The default value for start is -2, which means that Flash Player first tries to play the live stream specified in streamName. 
		 * If a live stream of that name is not found, Flash Player plays the recorded stream specified in streamName. 
		 * If neither a live nor a recorded stream is found, Flash Player opens a live stream named streamName, even though no one is 
		 * publishing on it. When someone does begin publishing on that stream, Flash Player begins playing it.If you pass -1 for start, Flash Player plays only the live stream specified in streamName. If no live stream is found,
		 * Flash Player waits for it indefinitely if len is set to -1; if len is set to a different value, 
		 * Flash Player waits for len seconds before it begins playing the next item in the playlist. If you pass 0 or a positive number for start, Flash Player plays only a recorded stream named streamName, 
		 * beginning start seconds from the beginning of the stream. If no recorded stream is found, Flash Player begins playing the next item
		 * in the playlist immediately.If you pass a negative number other than -1 or -2 for start, Flash Player interprets the value as if it were -2.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public var start : Number 

		/**
		 * The name of the new stream to transition to or to play. When oldStreamName is null or undefined, calling
		 * NetStream.play2() simply starts playback of streamName. If oldStreamName is specified, calling NetStream.play2()
		 * transitions oldStreamName to streamName using the transition mode specified in the transition property.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public var streamName : String;

		/**
		 * The mode in which streamName is played or transitioned to. Possible values are constants from the NetStreamPlayTransitions class.
		 * Depending on whether Netstream.play2() is called to play or transition a stream, the transition mode results in different behaviors. 
		 * For more information on the transition modes, see the NetStreamPlayTransitions class.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public var transition : String;

		/**
		 * Creates a NetStreamPlayOptions object to specify the options that are passed to the NetStream.play2() method.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public function NetStreamPlayOptions () {}
	}
}