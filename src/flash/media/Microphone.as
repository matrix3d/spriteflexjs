package flash.media
{
	import flash.events.EventDispatcher;
	import flash.media.Microphone;
	import flash.media.SoundTransform;
	import flash.media.MicrophoneEnhancedOptions;

	/**
	 * Dispatched when a microphone reports its status.
	 * @eventType	flash.events.StatusEvent.STATUS
	 */
	[Event(name="status", type="flash.events.StatusEvent")] 

	/**
	 * Dispatched when the microphone has sound data in the buffer.
	 * @eventType	flash.events.SampleDataEvent.SAMPLE_DATA
	 */
	[Event(name="sampleData", type="flash.events.SampleDataEvent")] 

	/**
	 * Dispatched when a microphone starts or stops recording due to detected silence.
	 * @eventType	flash.events.ActivityEvent.ACTIVITY
	 */
	[Event(name="activity", type="flash.events.ActivityEvent")] 

	/**
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 */
	public final class Microphone extends EventDispatcher
	{
		private var _activityLevel:Number = 0;
		private var _codec:String = "";
		private var _enableVAD:Boolean = false;
		private var _encodeQuality:int = 6;
		private var _enhancedOptions:MicrophoneEnhancedOptions;
		private var _gain:Number = 50;
		private var _index:int = 0;
		private static var _isSupported:Boolean = false;
		private var _muted:Boolean = false;
		private var _name:String;
		private static var _names:Array = [];
		private var _rate:Number = 8;
		private var _silenceLevel:Number = 10;
		private var _silenceTimeout:int = 2000; // 2 seconds
		private var _soundTransform:SoundTransform;
		private var _setLoopBack:Boolean = false;
		
		/**
		 * The amount of sound the microphone is detecting. Values range from 
		 * 0 (no sound is detected) to 100 (very loud sound is detected). The value of this property can 
		 * help you determine a good value to pass to the Microphone.setSilenceLevel() method.
		 * 
		 *   If the microphone muted property is true, the value of this property is always -1.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get activityLevel () : Number
		{
			return _activityLevel;
		}

		/**
		 * The codec to use for compressing audio. Available codecs are Nellymoser (the default) and Speex. The enumeration class SoundCodec contains
		 * the various values that are valid for the codec property.
		 * 
		 *   If you use the Nellymoser codec, you can set the sample rate using Microphone.rate(). 
		 * If you use the Speex codec, the sample rate is set to 16 kHz.Speex includes voice activity detection (VAD) and automatically reduces bandwidth when no voice is detected. 
		 * When using the Speex codec, Adobe recommends that you set the silence level to 0. To set the silence level, use the
		 * Microphone.setSilenceLevel() method.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get codec () : String
		{
			return _codec;
		}
		public function set codec (codec:String) : void
		{
			_codec = codec;
		}

		/**
		 * Enable Speex voice activity detection.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get enableVAD () : Boolean
		{
			trace("WARNING Microphone.enableVAD property not implemented.");
			return false;
		}
		public function set enableVAD (enable:Boolean) : void
		{
			trace("WARNING Microphone.enableVAD property not implemented.");
		}

		/**
		 * The encoded speech quality when using the Speex codec. Possible values are from 0 to 10. The default value is 6. 
		 * Higher numbers represent higher quality but require more bandwidth, as shown in the following table. The bit rate values that are listed 
		 * represent net bit rates and do not include packetization overhead.
		 * Quality valueRequired bit rate (kilobits per second)0 3.9515.7527.7539.80412.8516.8620.6723.8827.8934.21042.2
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get encodeQuality () : int
		{
			trace("WARNING Microphone.encodeQuality property not implemented.");
			return null;
		}
		public function set encodeQuality (quality:int) : void
		{
			trace("WARNING Microphone.encodeQuality property not implemented.");
		}

		/**
		 * Controls enhanced microphone options. For more information, see	
		 * MicrophoneEnhancedOptions class. This property is ignored for non-enhanced Microphone instances.
		 * @langversion	3.0
		 * @playerversion	Flash 10.3
		 * @playerversion	AIR 2.7
		 */
		public function get enhancedOptions () : flash.media.MicrophoneEnhancedOptions
		{
			return _enhancedOptions;
		}
		public function set enhancedOptions (options:MicrophoneEnhancedOptions) : void
		{
			_enhancedOptions = options;
		}

		/**
		 * Number of Speex speech frames transmitted in a packet (message). 
		 * Each frame is 20 ms long. The default value is two frames per packet.
		 * 
		 *   The more Speex frames in a message, the lower the bandwidth required but the longer the delay in sending the
		 * message. Fewer Speex frames increases bandwidth required but reduces delay.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get framesPerPacket () : int
		{
			trace("WARNING Microphone.framesPerPacket property not implemented.");
			return null;
		}
		public function set framesPerPacket (frames:int) : void
		{
			trace("WARNING Microphone.framesPerPacket property not implemented.");
		}

		/**
		 * The amount by which the microphone boosts the signal. Valid values are 0 to 100. The default value is 50.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get gain () : Number
		{
			return _gain;
		}
		public function set gain (gain:Number) : void
		{
			_gain = gain;
		}

		/**
		 * The index of the microphone, as reflected in the array returned by 
		 * Microphone.names.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get index () : int
		{
			return _index;
		}

		/**
		 * The isSupported property is set to true if the 
		 * Microphone class is supported on the current platform, otherwise it is
		 * set to false.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public static function get isSupported () : Boolean
		{
			return _isSupported;
		}

		/**
		 * Specifies whether the user has denied access to the microphone (true) 
		 * or allowed access (false). When this value changes, 
		 * a status event is dispatched.
		 * For more information, see Microphone.getMicrophone().
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get muted () : Boolean
		{
			return _muted;
		}

		/**
		 * The name of the current sound capture device, as returned by the sound capture hardware.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get name () : String
		{
			return _name;
		}

		/**
		 * An array of strings containing the names of all available sound capture devices. 
		 * The names are returned without 
		 * having to display the Flash Player Privacy Settings panel to the user. This array 
		 * provides the zero-based index of each sound capture device and the 
		 * number of sound capture devices on the system, through the Microphone.names.length property. 
		 * For more information, see the Array class entry.
		 * 
		 *   Calling Microphone.names requires an extensive examination of the hardware, and it
		 * may take several seconds to build the array. In most cases, you can just use the default microphone.Note: To determine the name of the current microphone, 
		 * use the name property.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public static function get names () : Array
		{
			return _names;
		}

		/**
		 * Maximum attenuation of the noise in dB (negative number) used for Speex encoder. If enabled, noise suppression is applied to sound captured from Microphone before
		 * Speex compression. Set to 0 to disable noise suppression. Noise suppression is enabled by default with maximum attenuation of -30 dB. Ignored when Nellymoser
		 * codec is selected.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public function get noiseSuppressionLevel () : int
		{
			trace("WARNING Microphone.noiseSuppressionLevel property not implemented.");
			return null;
		}
		public function set noiseSuppressionLevel (level:int) : void
		{
			trace("WARNING Microphone.noiseSuppressionLevel property not implemented.");
		}

		/**
		 * The rate at which the microphone is capturing sound, in kHz. Acceptable values are 5, 8, 11, 22, and 44. The default value is 8 
		 * kHz if your sound capture device supports this value. Otherwise, the default value is the next available capture level above 8 kHz
		 * that your sound capture device supports, usually 11 kHz.
		 * 
		 *   Note: The actual rate differs slightly from the rate value, as noted
		 * in the following table:rate valueActual frequency4444,100 Hz2222,050 Hz1111,025 Hz88,000 Hz55,512 Hz
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get rate () : int
		{
			return _rate;
		}
		public function set rate (rate:int) : void
		{
			_rate = rate;
		}

		/**
		 * The amount of sound required to activate the microphone and dispatch 
		 * the activity event. The default value is 10.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get silenceLevel () : Number
		{
			return _silenceLevel;
		}

		/**
		 * The number of milliseconds between the time the microphone stops 
		 * detecting sound and the time the activity event is dispatched. The default 
		 * value is 2000 (2 seconds).
		 * 
		 *   To set this value, use the Microphone.setSilenceLevel() method.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get silenceTimeout () : int
		{
			return _silenceTimeout;
		}

		/**
		 * Controls the sound of this microphone object when it is in loopback mode.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get soundTransform () : flash.media.SoundTransform
		{
			return _soundTransform;
		}
		public function set soundTransform (sndTransform:SoundTransform) : void
		{
			_soundTransform = sndTransform;
		}

		/**
		 * Set to true if echo suppression is enabled; false otherwise. The default value is 
		 * false unless the user has selected Reduce Echo in the Flash Player Microphone Settings panel.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get useEchoSuppression () : Boolean
		{
			trace("WARNING Microphone.useEchoSuppression property not implemented.");
			return false;
		}

		/**
		 * @param	index	The index value of the microphone.
		 * @return	A reference to a Microphone object for capturing audio. If enhanced audio fails to initialize, returns null.
		 * @langversion	3.0
		 * @playerversion	Flash 10.3
		 * @playerversion	AIR 2.7
		 */
		public static function getEnhancedMicrophone (index:int =-1) : flash.media.Microphone
		{
			trace("WARNING Microphone.getEnhancedMicrophone property not implemented.");
			return null;
		}

		/**
		 * @param	index	The index value of the microphone.
		 * @return	A reference to a Microphone object for capturing audio.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public static function getMicrophone (index:int =-1) : flash.media.Microphone
		{
			return new Microphone();
		}

		public function Microphone ()
		{
			
		}

		/**
		 * Routes audio captured by a microphone to the local speakers.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function setLoopBack (state:Boolean = true) : void
		{
			_setLoopBack = state;
		}

		/**
		 * @param	silenceLevel	The amount of sound required to activate the microphone
		 *   and dispatch the activity event. Acceptable values range from 0 to 100.
		 * @param	timeout	The number of milliseconds that must elapse without
		 *   activity before Flash Player or Adobe AIR considers sound to have stopped and dispatches the 
		 *   dispatch event. The default value is 2000 (2 seconds). 
		 *   (Note: The default value shown 
		 *   in the signature, -1, is an internal value that indicates to Flash Player or Adobe AIR to use 2000.)
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function setSilenceLevel (silenceLevel:Number, timeout:int =-1) : void
		{
			_silenceLevel = silenceLevel;
			_silenceTimeout = timeout;
		}

		/**
		 * @param	useEchoSuppression	A Boolean value indicating whether to use echo suppression 
		 *   (true) or not (false).
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function setUseEchoSuppression (useEchoSuppression:Boolean) : void
		{
			trace("WARNING Microphone.setUseEchoSuppression property not implemented.");
		}
	}
}