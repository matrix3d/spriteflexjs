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
	 * Use the Microphone class to monitor or capture audio from a microphone.
	 * 
	 *   <p class="- topic/p ">
	 * To get a reference to a Microphone instance, use the <codeph class="+ topic/ph pr-d/codeph ">Microphone.getMicrophone()</codeph> method 
	 * or the <codeph class="+ topic/ph pr-d/codeph ">Microphone.getEnhancedMicrophone()</codeph> method. An enhanced microphone instance can 
	 * perform acoustic echo cancellation. Use acoustic echo cancellation to create real-time audio/video applications
	 * that don't require headsets. 
	 * </p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Create a real-time chat application</b></p><p class="- topic/p ">To create a real-time chat application, capture audio and send it to Flash Media Server.
	 * Use the NetConnection and NetStream classes to send the audio stream to Flash Media Server. 
	 * Flash Media Server can broadcast the audio to other clients.
	 * To create a chat application that doesn't require headsets, use acoustic echo
	 * cancellation. Acoustic echo cancellation prevents the feedback loop that occurs when audio enters a microphone, 
	 * travels out the speakers, and enters the microphone again. To use acoustic echo cancellation, call 
	 * the <codeph class="+ topic/ph pr-d/codeph ">Microphone.getEnhancedMicrophone()</codeph> method to get a reference to a Microphone instance.
	 * Set <codeph class="+ topic/ph pr-d/codeph ">Microphone.enhancedOptions</codeph> to an instance of the <codeph class="+ topic/ph pr-d/codeph ">MicrophoneEnhancedOptions</codeph> class to 
	 * configure settings.</p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Play microphone audio locally</b></p><p class="- topic/p ">Call the Microphone <codeph class="+ topic/ph pr-d/codeph ">setLoopback()</codeph> method to route the microphone audio directly to
	 * the local computer or device audio output. Uncontrolled audio feedback is an inherent danger and is likely
	 * to occur whenever the audio output can be picked up by the microphone input. The 
	 * <codeph class="+ topic/ph pr-d/codeph ">setUseEchoSuppression()</codeph> method can reduce, but not eliminate, the risk of feedback
	 * amplification.</p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Capture microphone audio for local recording or processing</b></p><p class="- topic/p ">To capture microphone audio, listen for the <codeph class="+ topic/ph pr-d/codeph ">sampleData</codeph> events dispatched by a
	 * Microphone instance. The SampleDataEvent object dispatched for this event contains the audio data.</p><p class="- topic/p ">For information about capturing video, see the Camera class.</p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Runtime microphone support</b></p><p class="- topic/p ">The Microphone class is not supported in Flash Player running in a mobile browser.</p><p class="- topic/p "><i class="+ topic/ph hi-d/i ">AIR profile support:</i> The Microphone class is supported 
	 * on desktop operating systems, but it is not supported on all mobile devices.
	 * It is not supported on AIR for TV devices.  See 
	 * <xref href="http://help.adobe.com/en_US/air/build/WS144092a96ffef7cc16ddeea2126bb46b82f-8000.html" class="- topic/xref ">
	 * AIR Profile Support</xref> for more information regarding API support across multiple profiles.</p><p class="- topic/p ">You can test for support at run time using the <codeph class="+ topic/ph pr-d/codeph ">Microphone.isSupported</codeph> property.
	 * Note that for AIR for TV devices, <codeph class="+ topic/ph pr-d/codeph ">Microphone.isSupported</codeph> is <codeph class="+ topic/ph pr-d/codeph ">true</codeph> but
	 * <codeph class="+ topic/ph pr-d/codeph ">Microphone.getMicrophone()</codeph> always returns <codeph class="+ topic/ph pr-d/codeph ">null</codeph>.</p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Privacy controls</b></p><p class="- topic/p ">
	 * Flash Player displays a Privacy dialog
	 * box that lets the user choose whether to allow or deny access to
	 * the microphone. Your application window size must be at least 215 x 138
	 * pixels, the minimum size required to display the dialog box, or access is denied automatically.
	 * </p><p class="- topic/p ">Content running in the AIR application sandbox does not need permission to access the microphone
	 * and no dialog is displayed. AIR content running outside the application sandbox does require permission
	 * and the Privacy dialog is displayed.</p>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example captures sound using echo suppression from a microphone after the 
	 * user allows access to their computer's microphone. 
	 * The <codeph class="+ topic/ph pr-d/codeph ">Security.showSettings()</codeph> method displays the Flash Player dialog box, which requests
	 * permission to access the user's microphone. The call to <codeph class="+ topic/ph pr-d/codeph ">setLoopBack(true)</codeph> reroutes
	 * input to the local speaker, so you can hear the sound while you run the example.
	 * 
	 *   <p class="- topic/p ">Two listeners listen for <codeph class="+ topic/ph pr-d/codeph ">activity</codeph> and 
	 * <codeph class="+ topic/ph pr-d/codeph ">status</codeph> events.  The <codeph class="+ topic/ph pr-d/codeph ">activity</codeph> event is dispatched at the
	 * start and end (if any) of the session and is captured by the <codeph class="+ topic/ph pr-d/codeph ">activityHandler()</codeph>
	 * method, which traces information on the event.  The <codeph class="+ topic/ph pr-d/codeph ">status</codeph> event is dispatched if
	 * the attached microphone object reports any status information; it is captured and traced using
	 * the <codeph class="+ topic/ph pr-d/codeph ">statusHandler()</codeph> method.</p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Note:</b> A microphone must be attached to your computer for this example
	 * to work correctly.</p><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * 
	 *   package {
	 * import flash.display.Sprite;
	 * import flash.events.*;
	 * import flash.media.Microphone;
	 * import flash.system.Security;
	 * 
	 *   public class MicrophoneExample extends Sprite {
	 * public function MicrophoneExample() {
	 * var mic:Microphone = Microphone.getMicrophone();
	 * Security.showSettings("2");
	 * mic.setLoopBack(true);
	 * 
	 *   if (mic != null) {
	 * mic.setUseEchoSuppression(true);
	 * mic.addEventListener(ActivityEvent.ACTIVITY, activityHandler);
	 * mic.addEventListener(StatusEvent.STATUS, statusHandler);
	 * }
	 * }
	 * 
	 *   private function activityHandler(event:ActivityEvent):void {
	 * trace("activityHandler: " + event);
	 * }
	 * 
	 *   private function statusHandler(event:StatusEvent):void {
	 * trace("statusHandler: " + event);
	 * }
	 * }
	 * }
	 * </codeblock>
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
		 * @internal	Document this better with examples.
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
		 * Returns a reference to an enhanced Microphone object that can 
		 * perform acoustic echo cancellation. Use acoustic echo cancellation to create audio/video chat applications
		 * that don't require headsets.
		 * 
		 *   The index parameter for the Microphone.getEnhancedMicrophone() method and the Microphone.getMicrophone()
		 * method work the same way.Important: At any given time you can have only a single instance of enhanced microphone device.
		 * All other Microphone instances stop providing audio data and receive a StatusEvent with the 
		 * code property Microphone.Unavailable. When enhanced audio fails to initialize, 
		 * calls to this method return null, setting a value for Microphone.enhancedOptions has no effect, 
		 * and all existing Microphone instances function as before.To configure an enhanced Microphone object, set the Microphone.enhancedOptions property. The following
		 * code uses an enhanced Microphone object and full-duplex acoustic echo cancellation in a local test:
		 * var mic:Microphone = Microphone.getEnhancedMicrophone();
		 * var options:MicrophoneEnhancedOptions = new MicrophoneEnhancedOptions();
		 * options.mode = MicrophoneEnhancedMode.FULL_DUPLEX;
		 * mic.enhancedOptions = options;
		 * mic.setLoopBack(true);
		 * The setUseEchoSuppression() method is ignored when using acoustic echo cancellation.
		 * 
		 *   When a SWF file tries to access the object returned by Microphone.getEnhancedMicrophone()
		 * —for example, when you call NetStream.attachAudio()—
		 * Flash Player displays a Privacy dialog box that lets the user choose whether to 
		 * allow or deny access to the microphone. (Make sure your Stage size is at least 
		 * 215 x 138 pixels; this is the minimum size Flash Player requires to display the dialog box.)
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
		 * Returns a reference to a Microphone object for capturing audio.
		 * To begin capturing the audio, you must attach the Microphone
		 * object to a NetStream object (see NetStream.attachAudio()).
		 * 
		 *   Multiple calls to Microphone.getMicrophone() reference the same microphone. 
		 * Thus, if your code contains the lines mic1 = Microphone.getMicrophone() 
		 * and
		 * mic2 = Microphone.getMicrophone()  
		 * , both mic1 and mic2 
		 * reference the same (default) microphone.
		 * In general, you should not pass a value for index. Simply call 
		 * air.Microphone.getMicrophone()
		 * to return a reference to the default microphone. 
		 * Using the Microphone Settings section in the Flash Player settings panel, the user can specify the default 
		 * microphone the application should use. (The user access the Flash Player settings panel by right-clicking
		 * Flash Player content running in a web browser.) If you pass a value for index, you can 
		 * reference a microphone other than the one the user chooses. You can use index in 
		 * rare cases—for example, if your application is capturing audio from two microphones 
		 * at the same time. Content running in Adobe AIR also uses the Flash Player setting for the default 
		 * microphone.
		 * Use the Microphone.index property to get the index value of the current
		 * Microphone object. You can then pass this value to other methods of the
		 * Microphone class.
		 * 
		 *   When a SWF file tries to access the object returned by Microphone.getMicrophone()
		 * —for example, when you call NetStream.attachAudio()—
		 * Flash Player displays a Privacy dialog box that lets the user choose whether to 
		 * allow or deny access to the microphone. (Make sure your Stage size is at least 
		 * 215 x 138 pixels; this is the minimum size Flash Player requires to display the dialog box.)
		 * 
		 *   When the user responds to this dialog box, a status event is dispatched
		 * that indicates the user's response. You can also check the Microphone.muted
		 * property to determine if the user has allowed or denied access to the microphone.
		 * 
		 *   If Microphone.getMicrophone() returns null, either the microphone is in use 
		 * by another application, or there are no microphones installed on the system. To determine 
		 * whether any microphones are installed, use Microphones.names.length. To display 
		 * the Flash Player Microphone Settings panel, which lets the user choose the microphone to be 
		 * referenced by Microphone.getMicrophone, use Security.showSettings().
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
		 * @internal	Document this better with examples.
		 */
		public function setLoopBack (state:Boolean = true) : void
		{
			_setLoopBack = state;
		}

		/**
		 * Sets the minimum input level that should be considered sound and (optionally) the amount
		 * of silent time signifying that silence has actually begun.
		 * To prevent the microphone from detecting sound at all, pass a value of 100 for 
		 * silenceLevel; the activity event is never dispatched. To determine the amount of sound the microphone is currently detecting, use Microphone.activityLevel. Speex includes voice activity detection (VAD) and automatically reduces bandwidth when no voice is detected. 
		 * When using the Speex codec, Adobe recommends that you set the silence level to 0.Activity detection is the ability to detect when audio levels suggest that a person is talking. 
		 * When someone is not talking, bandwidth can be saved because there is no need to send the associated
		 * audio stream. This information can also be used for visual feedback so that users know 
		 * they (or others) are silent.Silence values correspond directly to activity values. Complete silence is an activity value of 0. 
		 * Constant loud noise (as loud as can be registered based on the current gain setting) is an activity value 
		 * of 100. After gain is appropriately adjusted, your activity value is less than your silence value when
		 * you're not talking; when you are talking, the activity value exceeds your silence value.This method is similar to Camera.setMotionLevel(); both methods are used to
		 * specify when the activity event is dispatched. However, these methods have 
		 * a significantly different impact on publishing streams:Camera.setMotionLevel() is designed to detect motion and does not affect bandwidth
		 * usage. Even if a video stream does not detect motion, video is still sent.Microphone.setSilenceLevel() is designed to optimize bandwidth. When an audio
		 * stream is considered silent, no audio data is sent. Instead, a single message is sent, indicating 
		 * that silence has started.
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
		 * Specifies whether to use the echo suppression feature of the audio codec. The default value is 
		 * false unless the user has selected Reduce Echo in the Flash Player Microphone 
		 * Settings panel.
		 * 
		 *   Echo suppression is an effort to reduce the effects of audio feedback, which is caused when
		 * sound going out the speaker is picked up by the microphone on the same system. (This is different
		 * from acoustic echo cancellation, which completely removes the feedback. The setUseEchoSuppression() method
		 * is ignored when you call the getEnhancedMicrophone() method to use acoustic echo cancellation.)Generally, echo suppression is advisable when the sound being captured is played through 
		 * speakers — instead of a headset —. If your SWF file allows users to specify the
		 * sound output device, you may want to call Microphone.setUseEchoSuppression(true) 
		 * if they indicate they are using speakers and will be using the microphone as well. Users can also adjust these settings in the Flash Player Microphone Settings panel.
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