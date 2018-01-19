package flash.media
{
	/**
	 * The MicrophoneEnhancedOptions class provides configuration options for enhanced audio (acoustic echo cancellation). 
	 * Acoustic echo cancellation allows multiple parties to communicate in an audio/video chat application without
	 * using headsets.
	 * 
	 *   <p class="- topic/p ">To use acoustic echo cancellation, call <codeph class="+ topic/ph pr-d/codeph ">Microphone.getEnhancedMicrophone()</codeph> to get a reference to 
	 * an enhanced Microphone object. Set the <codeph class="+ topic/ph pr-d/codeph ">Microphone.enhancedOptions</codeph>
	 * property to an instance of the <codeph class="+ topic/ph pr-d/codeph ">MicrophoneEnhancedOptions</codeph> class.
	 * </p>
	 * @langversion	3.0
	 * @playerversion	Flash 10.3
	 * @playerversion	AIR 2.7
	 */
	public final class MicrophoneEnhancedOptions extends Object
	{
		/**
		 * Enable automatic gain control. A time-domain automatic gain control algorithm is used
		 * with noise gating. The default value is off.
		 * @langversion	3.0
		 * @playerversion	Flash 10.3
		 * @playerversion	AIR 2.7
		 */
		public function get autoGain () : Boolean { return null; }
		public function set autoGain (enabled:Boolean) : void {}

		/**
		 * Specifies the echo path (in milliseconds) used for acoustic echo cancellation. A longer 
		 * echo path results in better echo cancellation. A longer echo path also causes a longer delay 
		 * and requires more computational complexity. The default value is 128 (recommended). The other 
		 * possible value is 256.
		 * @langversion	3.0
		 * @playerversion	Flash 10.3
		 * @playerversion	AIR 2.7
		 */
		public function get echoPath () : int { return null; }
		public function set echoPath (echoPath:int) : void {}

		/**
		 * Indicates whether the Microphone input detected a voice.
		 * 
		 *   Possible values are: -1, not enabled; 0, a voice is not detected; 1, a voice is detected.
		 * @langversion	3.0
		 * @playerversion	Flash 10.3
		 * @playerversion	AIR 2.7
		 */
		public function get isVoiceDetected () : int { return null; }
		public function set isVoiceDetected (voiceDetected:int) : void {}

		/**
		 * Controls enhanced microphone mode. The default value is FULL_DUPLEX for all microphones that aren't USB.
		 * The default value for USB microphones is HALF_DUPLEX.
		 * See MicrophoneEnhancedMode for possible values and descriptions.
		 * @langversion	3.0
		 * @playerversion	Flash 10.3
		 * @playerversion	AIR 2.7
		 */
		public function get mode () : String { return ""; }
		public function set mode (mode:String) : void {}

		/**
		 * Enable non-linear processing. Non-linear processing
		 * suppresses the residual echo when one person is talking. The time-domain non-linear 
		 * processing technique is used. Turn off non-linear 
		 * processing for music sources. The default value is true which turns on non-linear processing.
		 * @langversion	3.0
		 * @playerversion	Flash 10.3
		 * @playerversion	AIR 2.7
		 */
		public function get nonLinearProcessing () : Boolean { return false; }
		public function set nonLinearProcessing (enabled:Boolean) : void {}

		public function MicrophoneEnhancedOptions () {}
	}
}