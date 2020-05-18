package flash.media
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.utils.ByteArray;
	import flash.utils.Timer;

	/**
	 * Dispatched when a camera reports its status.
	 * @eventType	flash.events.StatusEvent.STATUS
	 */
	[Event(name="status", type="flash.events.StatusEvent")] 

	/**
	 * Dispatched when a camera begins or ends a session.
	 * @eventType	flash.events.ActivityEvent.ACTIVITY
	 */
	[Event(name="activity", type="flash.events.ActivityEvent")] 

	/**
	 * Use the Camera class to capture video from the client system's camera. 
	 * Use the Video class to monitor the video locally.  
	 * Use the NetConnection and NetStream classes to transmit the video to Flash Media Server.
	 * Flash Media Server can send the video stream to other servers and broadcast it to other clients running Flash Player.
	 * 
	 *   <p class="- topic/p ">A Camera instance captures video in landscape aspect ratio. On devices that can change the screen orientation,
	 * such as mobile phones, a Video object attached to the camera will only show upright video in a landscape-aspect orientation. 
	 * Thus, mobile apps should use a landscape orientation when displaying video and should not auto-rotate.</p><p class="- topic/p ">As of AIR 2.6, autofocus is enabled automatically on mobile devices with an autofocus camera. If the camera does not support continuous autofocus,
	 * and many mobile device cameras do not, then the camera is focused when the Camera object is attached to a video stream and whenever 
	 * the <codeph class="+ topic/ph pr-d/codeph ">setMode()</codeph> method is called. On desktop computers, autofocus behavior is dependent on the camera driver and settings.</p><p class="- topic/p ">In an AIR application on Android and iOS, the camera does not capture video while an AIR app is not the active, foreground application.
	 * In addition, streaming connections can be lost when the application is in the background. On iOS, the camera video cannot be
	 * displayed when an application uses the GPU rendering mode. The camera video can still be streamed to a server.</p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Mobile Browser Support:</b> This class is not supported in mobile browsers.</p><p class="- topic/p "><i class="+ topic/ph hi-d/i ">AIR profile support:</i> This feature is supported 
	 * on desktop operating systems, but it is not supported on all mobile devices. It is not
	 * supported on AIR for TV devices. See 
	 * <xref href="http://help.adobe.com/en_US/air/build/WS144092a96ffef7cc16ddeea2126bb46b82f-8000.html" class="- topic/xref ">
	 * AIR Profile Support</xref> for more information regarding API support across multiple profiles.</p><p class="- topic/p ">You can test 
	 * for support at run time using the <codeph class="+ topic/ph pr-d/codeph ">Camera.isSupported</codeph> property. 
	 * Note that for AIR for TV devices, <codeph class="+ topic/ph pr-d/codeph ">Camera.isSupported</codeph> is <codeph class="+ topic/ph pr-d/codeph ">true</codeph> but
	 * <codeph class="+ topic/ph pr-d/codeph ">Camera.getCamera()</codeph> always returns <codeph class="+ topic/ph pr-d/codeph ">null</codeph>.</p><p class="- topic/p ">
	 * For information about capturing audio, see the Microphone class.
	 * </p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Important: </b>Flash Player displays a Privacy dialog box that lets the user choose whether 
	 * to allow or deny access to the camera. Make sure your application window size is at least 215 x 138 pixels; 
	 * this is the minimum size required to display the dialog box.
	 * </p><p class="- topic/p ">To create or reference a Camera object, use the <codeph class="+ topic/ph pr-d/codeph ">getCamera()</codeph> method.</p>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example shows the image from a camera after acknowledging the
	 * security warning.  The Stage is set such that it cannot be scaled and is aligned to the
	 * top-left of the player window.  The <codeph class="+ topic/ph pr-d/codeph ">activity</codeph> event is dispatched at the
	 * start and end (if any) of the session and is captured by the <codeph class="+ topic/ph pr-d/codeph ">activityHandler()</codeph>
	 * method, which prints out information about the event.
	 * 
	 *   <p class="- topic/p "><b class="+ topic/ph hi-d/b ">Note:</b> A camera must be attached to your computer for this example
	 * to work correctly.</p><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * 
	 *   package {
	 * import flash.display.Sprite;
	 * import flash.display.StageAlign;
	 * import flash.display.StageScaleMode;
	 * import flash.events.*;
	 * import flash.media.Camera;
	 * import flash.media.Video;
	 * 
	 *   public class CameraExample extends Sprite {
	 * private var video:Video;
	 * 
	 *   public function CameraExample() {
	 * stage.scaleMode = StageScaleMode.NO_SCALE;
	 * stage.align = StageAlign.TOP_LEFT;
	 * 
	 *   var camera:Camera = Camera.getCamera();
	 * 
	 *   if (camera != null) {
	 * camera.addEventListener(ActivityEvent.ACTIVITY, activityHandler);
	 * video = new Video(camera.width * 2, camera.height * 2);
	 * video.attachCamera(camera);
	 * addChild(video);
	 * } else {
	 * trace("You need a camera.");
	 * }
	 * }
	 * 
	 *   private function activityHandler(event:ActivityEvent):void {
	 * trace("activityHandler: " + event);
	 * }
	 * }
	 * }
	 * </codeblock>
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 */
	public final class Camera extends EventDispatcher
	{
		private static var _mediaDevices:Array;
		private var _stream:MediaStream;
		private var _videoElement:HTMLVideoElement;
		private var _cameraStream:Object;
		private var _cameraId:String;
		private var _diffCanvas:HTMLCanvasElement;
		private var _diffContext:CanvasRenderingContext2D;
		private var _motionCanvas:HTMLCanvasElement;
		private var _motionContext:CanvasRenderingContext2D;
		private var _motionTimer:Timer = new Timer(100);;
		private var _motionLevel:int = 50;
		private var _pixelDiffThreshold:int = 32;
		private var _diffWidth:int = 64;
		private var _diffHeight:int = 64;
		private var _diffdata:ImageData;
		private var _activityLevel:int;
		private var _motionTimeout:Timer = new Timer(2000);
		private var _motionDetected:Boolean = false;
		private var _showMotionCanvas:Boolean = false;
		private static var _name:String;
		private static var _names:Array = [];
		private static var _devices:Array = [];
		public static var dispatchObject:DisplayObject = new DisplayObject();
		
		/**
		 * The amount of motion the camera is detecting. Values range from 0 (no motion is being detected) to 
		 * 100 (a large amount of motion is being detected). The value of this property can help you determine if you need to pass a setting 
		 * to the setMotionLevel() method.
		 * If the camera is available but is not yet being used because the
		 * Video.attachCamera() method has not been called, this property
		 * is set to -1.If you are streaming only uncompressed local video, this property is set only if you have assigned a function to the  event 
		 * handler. Otherwise, it is undefined.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get activityLevel () : Number
		{ 
			return _activityLevel;
		}

		/**
		 * The maximum amount of bandwidth the current outgoing video feed can use, in bytes. 
		 * A value of 0 means the feed can use as much bandwidth as needed to maintain the desired frame quality.
		 * To set this property, use the setQuality() method.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get bandwidth () : int { return null }

		/**
		 * The rate at which the camera is capturing data, in frames per second. 
		 * This property cannot be set; however, you can use the setMode() method
		 * to set a related property—fps—which specifies the maximum
		 * frame rate at which you would like the camera to capture data.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get currentFPS () : Number { return null }

		/**
		 * The maximum rate at which the camera can capture data, in frames per second. 
		 * The maximum rate possible depends on the capabilities of the camera; this frame rate may not be achieved.
		 * To set a desired value for this property, use the setMode() method.To determine the rate at which the camera is currently capturing data, use the currentFPS property.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get fps () : Number { return null }

		/**
		 * The current capture height, in pixels. To set a value for this property, 
		 * use the setMode() method.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get height () : int { return null }

		/**
		 * A zero-based integer that specifies the index of the camera, as reflected in
		 * the array returned by the names property.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get index () : int { return null }

		/**
		 * The isSupported property is set to true if the 
		 * Camera class is supported on the current platform, otherwise it is
		 * set to false.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public static function get isSupported () : Boolean
		{ 
			if (navigator.mediaDevices) return true;
			return false;
		}

		/**
		 * The number of video frames transmitted in full (called keyframes) 
		 * instead of being interpolated by the video compression algorithm. 
		 * The default value is 15, which means that every 15th frame is a keyframe.
		 * A value of 1 means that every frame is a keyframe. The allowed values are
		 * 1 through 48.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get keyFrameInterval () : int { return null }

		/**
		 * Indicates whether a local view of what the camera is capturing is compressed
		 * and decompressed (true), as it would be for live transmission using
		 * Flash Media Server, or uncompressed (false). The default value is
		 * false.
		 * 
		 *   Although a compressed stream is useful for testing, such as when previewing
		 * video quality settings, it has a significant processing cost. The local view
		 * is compressed, edited for transmission as it would be over a live connection,
		 * and then decompressed for local viewing.
		 * To set this value, use Camera.setLoopback(). To set the amount of 
		 * compression used when this property is true, use Camera.setQuality().
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get loopback () : Boolean { return null }

		/**
		 * The amount of motion required to invoke the activity event. Acceptable values range from 0 to 100. 
		 * The default value is 50.
		 * Video can be displayed regardless of the value of the motionLevel property. For more information, see 
		 * setMotionLevel().
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get motionLevel () : int 
		{ 
			return _motionLevel;
		}

		/**
		 * The number of milliseconds between the time the camera stops detecting motion and the time the activity event is invoked. The 
		 * default value is 2000 (2 seconds). 
		 * To set this value, use setMotionLevel().
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get motionTimeout () : int { return null }

		/**
		 * A Boolean value indicating whether the user has denied access to the camera
		 * (true) or allowed access (false) in the Flash Player Privacy dialog box.
		 * 
		 *   When this value changes, the statusevent is dispatched.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get muted () : Boolean { return null }

		/**
		 * The name of the current camera, as returned by the camera hardware.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get name () : String 
		{
			return _cameraId;
		}

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public static function get names () : Array 
		{ 
			return _names;
		}

		public function get position () : String { return null }

		/**
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get quality () : int { return null }

		/**
		 * The current capture width, in pixels. To set a desired value for this property, 
		 * use the setMode() method.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get width () : int { return null }
		
		/**
		 * retrieves the available camera stream.
		 */
		public function get cameraStream():MediaStream 
		{
			return _stream;
		}
		
		public function set cameraStream(value:MediaStream):void 
		{
			_cameraId = _name;
			_stream = value;
			_stream.onactive = function (e:Event):void 
			{
				dispatchEvent(new ActivityEvent(ActivityEvent.ACTIVITY, false, false, true));
			}
			
			_stream.oninactive = function (e:Event):void 
			{
				dispatchEvent(new ActivityEvent(ActivityEvent.ACTIVITY, false, false, false)); 
			}
		}
		
		/**
		 * video element used for camera.
		 */
		public function get videoElement():HTMLVideoElement 
		{
			return _videoElement;
		}
		
		public function set videoElement(value:HTMLVideoElement):void 
		{
			_videoElement = value;
		}
		
		public function get showMotionCanvas():Boolean 
		{
			return _showMotionCanvas;
		}
		
		public function set showMotionCanvas(value:Boolean):void 
		{
			_showMotionCanvas = value;
		}

		private static function _scanHardware () : void { }

		public function Camera () 
		{
			_cameraId = _name;
		}

		public function copyToByteArray (rect:Rectangle, destination:ByteArray) : void
		{
			trace("WARNING Camera.copyToByteArray method not implemented.");
		}

		public function copyToVector (rect:Rectangle, destination:Vector.<uint>) : void
		{
			trace("WARNING Camera.copyToVector method not implemented.");
		}
		
		/**
		 * Draws the current camera frame to the destination bitmapdata.
		 * @param	destination		the BitmapData object to use for drawing.
		 */
		public function drawToBitmapData (destination:BitmapData) : void
		{
			destination.fromImage(_videoElement, 0, 0, _videoElement.width, _videoElement.height);
		}

		/**
		 * @param	name	Specifies which camera to get, as determined from the array
		 *   returned by the names property. For most applications, get the default camera 
		 *   by omitting this parameter. To specify a value for this parameter, use the string representation
		 *   of the zero-based index position within the Camera.names array. For example, to specify the third
		 *   camera in the array, use Camera.getCamera("2").
		 * @param facingMode	Used to specify on mobile devices to use front facing camera "user" or the back camera "environment".
		 * @return	If the name parameter is not specified, this method returns a reference
		 *   to the default camera or, if it is in use by another application, to the first
		 *   available camera. (If there is more than one camera installed, the user may specify
		 *   the default camera in the Flash Player Camera Settings panel.) If no cameras are available
		 *   or installed, the method returns null.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public static function getCamera (name:String = null, minWidth:int = 320, minHeight:int = 240, facingMode:String = "user") : flash.media.Camera
		{
			var newCamera:Camera = new Camera();
			
			if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia)
			{
				//https://w3c.github.io/mediacapture-main/getusermedia.html#dom-mediatracksupportedconstraints
				//var constraint:Object = { audio: false, video: true };
				//var constraint:Object = { audio: true, video: { facingMode: "user" } };
				//var constraint:Object = { audio: true, video: { facingMode: "environment" } };
				//var constraint:Object = { audio: true, video: { facingMode: { exact: "environment" } } };
				
				// get all devices
				navigator.mediaDevices.enumerateDevices()
				.then(function(devices:Array):void {
					var foundVideoDevice:Boolean = false;
					
					//trace("What...No Devices? 0 Total: " + devices.length);
					
					for (var i:int = 0; i < devices.length; i++)
					{
						var device:MediaDeviceInfo = devices[i];
						
						if ((name && (device.deviceId == name || device.label == name)) || (!name && Object(device).kind == "videoinput"))
						{
							foundVideoDevice = true;
							
							var videoConstraint:Object = {
								deviceId: {exact: device.deviceId}, 
								facingMode:facingMode,
								width: { min: minWidth, ideal: minWidth },
								height: { min: minHeight, ideal: minHeight }
							};
							
							navigator.mediaDevices.getUserMedia({video: videoConstraint, audio: false} as MediaStreamConstraints)
							.then(function(stream:MediaStream):void {
								//trace("Camera.getCamera() Found Stream for device: " + device.label, stream);
								_name = (device.label != "") ? device.label : device.deviceId;
								newCamera.cameraStream = stream;
								if (newCamera.motionLevel == 50) newCamera.setMotionLevel(50);
								newCamera.dispatchEvent(new ActivityEvent(ActivityEvent.ACTIVITY, false, false, true));
							});
							
							break;
						}
					}
					
					if (!foundVideoDevice) newCamera.dispatchEvent(new ActivityEvent(ActivityEvent.ACTIVITY, false, false, false));
					
				});
			}
			else
			{
				newCamera.dispatchEvent(new ActivityEvent(ActivityEvent.ACTIVITY, false, false, false));
			}
			
			return newCamera;
		}
		
		public function setCursor (value:Boolean) : void 
		{
			trace("WARNING Camera.setCursor method not implemented.");
		}
		
		/**
		 * @param	keyFrameInterval	A value that specifies which video frames are transmitted in full
		 *   (as keyframes) instead of being interpolated by the video compression algorithm. 
		 *   A value of 1 means that every frame is a keyframe, a value of 3 means that every third frame
		 *   is a keyframe, and so on. Acceptable values are 1 through 48.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function setKeyFrameInterval (keyFrameInterval:int) : void
		{
			trace("WARNING Camera.setKeyFrameInterval method not implemented.");
		}

		/**
		 * @param	compress	Specifies whether to use a compressed video stream (true) 
		 *   or an uncompressed stream (false) for a local view of what the camera
		 *   is receiving.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function setLoopback (compress:Boolean = false) : void
		{
			trace("WARNING Camera.setLoopback method not implemented.");
		}

		/**
		 * @param	width	The requested capture width, in pixels. The default value is 160.
		 * @param	height	The requested capture height, in pixels. The default value is 120.
		 * @param	fps	The requested rate at which the camera should capture data, in frames per second.
		 *   The default value is 15.
		 * @param	favorArea	Specifies whether to manipulate the width, height, and frame rate if 
		 *   the camera does not have a native mode that meets the specified requirements. 
		 *   The default value is true, which means that maintaining capture size
		 *   is favored; using this parameter selects the mode that most closely matches 
		 *   width and height values, even if doing so adversely affects 
		 *   performance by reducing the frame rate. To maximize frame rate at the expense 
		 *   of camera height and width, pass false for the favorArea parameter.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function setMode (width:int, height:int, fps:Number, favorArea:Boolean = true) : void
		{
			trace("WARNING Camera.setMode method not implemented.");
		}

		/**
		 * @param	motionLevel	Specifies the amount of motion required to dispatch the
		 *   activity event. Acceptable values range from 0 to 100. The default value is 50.
		 * @param	timeout	Specifies how many milliseconds must elapse without activity 
		 *   before Flash Player considers activity to have stopped and dispatches the activity event.
		 *   The default value is 2000 milliseconds (2 seconds).
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function setMotionLevel (motionLevel:int, timeout:int = 2000) : void
		{
			if (!_diffCanvas)
			{
				_diffCanvas = document.createElement("canvas") as HTMLCanvasElement;
				_diffCanvas.width = _diffWidth;
				_diffCanvas.height = _diffHeight;
				_diffContext = _diffCanvas.getContext("2d") as CanvasRenderingContext2D;
				
				_motionCanvas = document.createElement("canvas") as HTMLCanvasElement;
				_motionCanvas.style.position = "absolute";
				_motionCanvas.style.zIndex = "999";
				_motionCanvas.width = _diffWidth;
				_motionCanvas.height = _diffHeight;
				_motionContext = _motionCanvas.getContext("2d") as CanvasRenderingContext2D;
				if (_showMotionCanvas) document.body.appendChild(_motionCanvas);
			}
			
			_motionLevel = motionLevel;
			
			_motionTimeout.delay = timeout;
			_motionTimeout.addEventListener(TimerEvent.TIMER, onMotionTimeout);
			
			_motionTimer.addEventListener(TimerEvent.TIMER, onMotionTimer);
			_motionTimer.start();
			
		}
		
		private function onMotionTimeout(e:TimerEvent):void 
		{
			//trace("Camera.onMotionTimeout()");
			if (_motionDetected) dispatchEvent(new ActivityEvent(ActivityEvent.MOTION_ENDED));
			_motionTimeout.reset();
			_motionDetected = false;
		}
		
		private function onMotionTimer(e:TimerEvent):void 
		{
			if (_videoElement) 
			{
				_diffContext.globalCompositeOperation = "difference";
				_diffContext.drawImage(_videoElement, 0, 0, _diffWidth, _diffHeight);
				_diffdata = _diffContext.getImageData(0, 0, _diffWidth, _diffHeight);
				processDiff(_diffdata);
				
				_motionContext.putImageData(_diffdata, 0, 0);
				
				_diffContext.globalCompositeOperation = "source-over";
				_diffContext.drawImage(_videoElement, 0, 0, _diffWidth, _diffHeight);
			}
		}
		
		private function processDiff(diffdata:ImageData):void 
		{
			var rgba:Uint8ClampedArray = diffdata.data;
			var len:int = rgba.length;
			var score:int = 0;
			
			for (var i:int = 0; i < len; i += 4) {
				var pixelDiff:Number = rgba[i] * 0.3 + rgba[i + 1] * 0.6 + rgba[i + 2] * 0.1;
				
				// normalize to shade of green
				var normalized:int = Math.min(255, pixelDiff * (255 / _pixelDiffThreshold));
				rgba[i] = 0;
				rgba[i + 1] = normalized;
				rgba[i + 2] = 0;

				if (pixelDiff >= _pixelDiffThreshold) score++;
			}
			
			_activityLevel = score;
			
			//trace("score: " + score + "pixels: " + (_motionLevel / 100) * (len / 8) + ", total pixels: " + (len/8));
			
			if (score > (_motionLevel/100) * (len/128))
			{
				_motionTimeout.reset();
				
				if (!_motionDetected)
				{
					_motionDetected = true;
					dispatchEvent(new ActivityEvent(ActivityEvent.MOTION_DETECTED));
					//trace("Motion Detected: " + score + " of " + (_motionLevel/100) * (len/128) + ", motionLevel: " + _motionLevel);
				}
			}
			else if (_motionDetected)
			{
				if (!_motionTimeout.running) _motionTimeout.start();
			}
		}

		/**
		 * @param	bandwidth	Specifies the maximum amount of bandwidth that the current outgoing video
		 *   feed can use, in bytes per second. To specify that Flash Player video can use as much bandwidth
		 *   as needed to maintain the value of quality, pass 0 for 
		 *   bandwidth. The default value is 16384.
		 * @param	quality	An integer that specifies the required level of picture quality,
		 *   as determined by the amount of compression being applied to each video frame. 
		 *   Acceptable values range from 1 (lowest quality, maximum compression) to 100 (highest 
		 *   quality, no compression). To specify that picture quality can vary as needed to avoid 
		 *   exceeding bandwidth, pass 0 for quality.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function setQuality (bandwidth:int, quality:int) : void
		{
			trace("WARNING Camera.setQuality method not implemented.");
		}
	}
}