package flash.media
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.ActivityEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.NetStream;
	import flash.media.Camera;
	import flash.display.Bitmap; 

	/**
	 * The Video class displays live or recorded video in an application 
	 * without embedding the video in your SWF file.  
	 * This class creates a Video object that plays 
	 * either of the following kinds of video: recorded video files stored on a server or locally,
	 * or live video captured by the user. 
	 * A Video object is a display object on the application's display list and represents
	 * the visual space in which the video runs in a user interface.
	 * 
	 *   <p class="- topic/p ">
	 * When used with Flash Media Server, the Video object allows you to
	 * send live video captured by a user to the server and then
	 * broadcast it from the server to other users.
	 * Using these features, you can develop media applications such as
	 * a simple video player, a video player with multipoint publishing from
	 * one server to another, or a video sharing application for a user community.
	 * </p><p class="- topic/p ">
	 * Flash Player 9 and later supports publishing and playback of FLV files encoded 
	 * with either the Sorenson Spark or On2 VP6 codec and also supports an alpha channel. The On2 
	 * VP6 video codec uses less bandwidth than older technologies and offers additional deblocking 
	 * and deringing filters. See the flash.net.NetStream class for more information about video playback and supported 
	 * formats.</p><p class="- topic/p ">
	 * Flash Player 9.0.115.0 and later supports mipmapping to optimize runtime rendering quality and performance. 
	 * For video playback, Flash Player uses mipmapping optimization if you set the Video object's <codeph class="+ topic/ph pr-d/codeph ">smoothing</codeph>
	 * property to <codeph class="+ topic/ph pr-d/codeph ">true</codeph>. 
	 * </p><p class="- topic/p ">
	 * As with other display objects on the display list,
	 * you can control various properties of Video objects. For example,
	 * you can move the Video object around on the Stage by using its <codeph class="+ topic/ph pr-d/codeph ">x</codeph> and
	 * <codeph class="+ topic/ph pr-d/codeph ">y</codeph> properties, you can change its size using its <codeph class="+ topic/ph pr-d/codeph ">height</codeph>
	 * and <codeph class="+ topic/ph pr-d/codeph ">width</codeph> properties, and so on. 
	 * </p><p class="- topic/p ">
	 * To play a video stream, use <codeph class="+ topic/ph pr-d/codeph ">attachCamera()</codeph> or <codeph class="+ topic/ph pr-d/codeph ">attachNetStream()</codeph>
	 * to attach the video to the Video object. Then, add the Video object
	 * to the display list using <codeph class="+ topic/ph pr-d/codeph ">addChild()</codeph>.
	 * </p><p class="- topic/p ">
	 * If you are using Flash Professional, you can also place the Video object on the Stage
	 * rather than adding it with <codeph class="+ topic/ph pr-d/codeph ">addChild()</codeph>, like this:
	 * </p><ol class="- topic/ol "><li class="- topic/li ">If the Library panel isn't visible, select Window &gt; Library to display it.</li><li class="- topic/li ">Add an embedded Video object to the library by clicking the Options menu on
	 * the right side of the Library panel title bar and selecting New Video.</li><li class="- topic/li ">In the Video Properties dialog box, name the embedded Video object for use in the library
	 * and click OK.</li><li class="- topic/li ">Drag the Video object to the Stage and use the Property Inspector to give it
	 * a unique instance name, such as <codeph class="+ topic/ph pr-d/codeph ">my_video</codeph>.(Do not name it Video.)</li></ol><p class="- topic/p ">In AIR applications on the desktop, playing video in fullscreen mode disables any power and screen saving
	 * features(when allowed by the operating system).</p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Note:</b> 
	 * The Video class is not a subclass of the InteractiveObject class, so
	 * it cannot dispatch mouse events. However, you can call the <codeph class="+ topic/ph pr-d/codeph ">addEventListener()</codeph> method
	 * on the display object container that contains the Video object.
	 * </p>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example uses a Video object with the NetConnection and 
	 * NetStream classes to load and play an FLV file. To run this example, you need an FLV file 
	 * whose name and location match the variable passed to <codeph class="+ topic/ph pr-d/codeph ">videoURL</codeph>, 
	 * in this case, an FLV file called Video.flv that is in the same directory as the SWF file.
	 * <p class="- topic/p ">In this example, the code that creates the Video and NetStream objects and calls
	 * <codeph class="+ topic/ph pr-d/codeph ">Video.attachNetStream()</codeph> and <codeph class="+ topic/ph pr-d/codeph ">NetStream.play()</codeph> is placed 
	 * in a handler function. The handler is called only if the
	 * attempt to connect to the NetConnection object is successful, which is 
	 * when the <codeph class="+ topic/ph pr-d/codeph ">netStatus</codeph> event returns an info object with a <codeph class="+ topic/ph pr-d/codeph ">code</codeph>
	 * property that indicates success. 
	 * It is recommended that you wait for a successful connection before calling 
	 * <codeph class="+ topic/ph pr-d/codeph ">NetStream.play()</codeph>. </p><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * 
	 *   package {
	 * import flash.display.Sprite;
	 * import flash.events.*;
	 * import flash.media.Video;
	 * import flash.net.NetConnection;
	 * import flash.net.NetStream;
	 * 
	 *   public class VideoExample extends Sprite {
	 * private var videoURL:String = "Video.mp4";
	 * private var connection:NetConnection;
	 * private var stream:NetStream;
	 * 
	 *   public function VideoExample() {
	 * connection = new NetConnection();
	 * connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
	 * connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
	 * connection.connect(null);
	 * }
	 * 
	 *   private function netStatusHandler(event:NetStatusEvent):void {
	 * switch(event.info.code) {
	 * case "NetConnection.Connect.Success":
	 * connectStream();
	 * break;
	 * case "NetStream.Play.StreamNotFound":
	 * trace("Unable to locate video: " + videoURL);
	 * break;
	 * }
	 * }
	 * 
	 *   private function connectStream():void {
	 * stream = new NetStream(connection);
	 * stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
	 * stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
	 * var video:Video = new Video();
	 * video.attachNetStream(stream);
	 * stream.play(videoURL);
	 * addChild(video);
	 * }
	 * 
	 *   private function securityErrorHandler(event:SecurityErrorEvent):void {
	 * trace("securityErrorHandler: " + event);
	 * }
	 * 
	 *   private function asyncErrorHandler(event:AsyncErrorEvent):void {
	 * // ignore AsyncErrorEvent events.
	 * }
	 * }
	 * }
	 * </codeblock>
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 * @playerversion	Lite 4
	 */
	public class Video extends DisplayObject
	{
		private var _videoElement:HTMLVideoElement;
		private var _image:Image;
		
		private var _deblocking:int = 0;
		private var _smoothing:Boolean = false;
		private var _videoHeight:int = 0;
		private var _videoWidth:int = 0;
		private var _camera:Camera;
		private var _netStream:NetStream;
		private var _loop:Boolean = false;
		private var _url:String;
		private var _width:int;
		private var _height:int;
		private var _rect:Rectangle;
		
		/**
		 * Indicates the type of filter applied to decoded video as part of post-processing.
		 * The default value is 0, which lets the video compressor apply a deblocking filter as needed.
		 * 
		 *   Compression of video can result in undesired artifacts. You can use the 
		 * deblocking property to set filters that reduce blocking and,
		 * for video compressed using the On2 codec, ringing.Blocking refers to visible imperfections between the boundaries
		 * of the blocks that compose each video frame. Ringing refers to distorted
		 * edges around elements within a video image.Two deblocking filters are available: one in the Sorenson codec and one in the On2 VP6 codec.
		 * In addition, a deringing filter is available when you use the On2 VP6 codec. 
		 * To set a filter, use one of the following values:0—Lets the video compressor apply the deblocking filter as needed.1—Does not use a deblocking filter.2—Uses the Sorenson deblocking filter.3—For On2 video only, uses the On2 deblocking filter but no deringing filter.4—For On2 video only, uses the On2 deblocking and deringing filter.5—For On2 video only, uses the On2 deblocking and a higher-performance
		 * On2 deringing filter.If a value greater than 2 is selected for video when you are using
		 * the Sorenson codec, the Sorenson decoder defaults to 2.Using a deblocking filter has an effect on overall playback performance, and it is usually
		 * not necessary for high-bandwidth video. If a user's system is not powerful enough, 
		 * the user may experience difficulties playing back video with a deblocking filter enabled.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get deblocking():int { return _deblocking; }
		public function set deblocking(value:int):void { _deblocking = value; }

		/**
		 * Specifies whether the video should be smoothed(interpolated) when it is scaled. For
		 * smoothing to work, the runtime must be in high-quality mode(the default). The default value
		 * is false(no smoothing).
		 * For video playback using Flash Player 9.0.115.0 and later versions, set this property to
		 * true to take advantage of mipmapping image optimization.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get smoothing():Boolean { return _smoothing; }
		public function set smoothing(value:Boolean):void { _smoothing = value; }

		/**
		 * An integer specifying the height of the video stream, in pixels. For live streams, this
		 * value is the same as the Camera.height
		 * property of the Camera object that is capturing the video stream. For recorded video files, this
		 * value is the height of the video.
		 * You may want to use this property, for example, to ensure that the user is seeing the
		 * video at the same size at which it was captured,
		 * regardless of the actual size of the Video object on the Stage.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get videoHeight():int { return _videoHeight; }

		/**
		 * An integer specifying the width of the video stream, in pixels. For live streams, this
		 * value is the same as the Camera.width
		 * property of the Camera object that is capturing the video stream. For recorded video files, this
		 * value is the width of the video.
		 * 
		 *   You may want to use this property, for example, to ensure that the user is seeing the
		 * video at the same size at which it was captured,
		 * regardless of the actual size of the Video object on the Stage.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get videoWidth():int { return _videoWidth; }

		/**
		 * Specifies a video stream from a camera to be displayed
		 * within the boundaries of the Video object in the application.
		 * 
		 *   Use this method to attach live video captured by the user
		 * to the Video object. You can play the live video locally on the same computer
		 * or device on which it is being captured, or you can send it to Flash Media Server and
		 * use the server to stream it to other users.
		 * Note: In an iOS AIR application, camera video cannot be displayed when the application
		 * uses GPU rendering mode.
		 * @param	camera	A Camera object that is capturing video data. 
		 *   To drop the connection to the Video object, pass null.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function attachCamera(camera:Camera):void
		{
			_camera = camera;
			
			if (_camera.cameraStream)
			{
				_videoElement.src = URL.createObjectURL( _camera.cameraStream ) || String(_camera.cameraStream);
				_camera.videoElement = _videoElement as HTMLVideoElement;
			}
			else
			{
				_camera.addEventListener(ActivityEvent.ACTIVITY, function(e:ActivityEvent):void {
					if (e.activating)
					{
						_videoElement.src = URL.createObjectURL( _camera.cameraStream ) || String(_camera.cameraStream);
						_camera.videoElement = _videoElement as HTMLVideoElement;
					}
				});
			}
		}

		/**
		 * Specifies a video stream to be displayed within the boundaries of the Video object 
		 * in the application.
		 * The video stream is either a video file played 
		 * with NetStream.play(), a Camera object, or null. 
		 * If you use a video file, it can be stored on the local file system or on
		 * Flash Media Server.
		 * If the value of the netStream argument is 
		 * null, the video is no longer played in the Video object.
		 * 
		 *   You do not need to use this method if a video file contains only audio; the audio
		 * portion of video files is played automatically
		 * when you call NetStream.play(). To control the audio 
		 * associated with a video file, use the soundTransform property 
		 * of the NetStream object that plays the video file.
		 * @param	netStream	A NetStream object. To drop the connection to the Video object, pass
		 *   null.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function attachNetStream(netStream:NetStream):void
		{
			_netStream = netStream;
			_netStream.playbackTarget = _videoElement;
			_videoElement.src = _netStream.url;
		}

		/**
		 * Clears the image currently displayed in the Video object(not the video stream). This method is useful for 
		 * handling the current image. For example, you can clear the last image or display standby information 
		 * without hiding the Video object.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function clear():void
		{
			
		}
		
		/**
		 * Repeats video continously.  For smoother loops use netSteam with raw video bytes. 
		 */
		public function get loop():Boolean 
		{
			return _loop;
		}
		
		public function set loop(value:Boolean):void 
		{
			_loop = value;
			if (!_netStream) _videoElement.loop = value;
		}
		
		override public function get width():Number  { 
			return _width;
		}
		
		override public function set width(v:Number):void 
		{
			_width = v;
		}
		
		override public function get height():Number  { 
			return _height;
		}
		
		override public function set height(v:Number):void  
		{ 
			_height = v;
		}
		

		/**
		 * Creates a new Video instance. If no values for the width and
		 * height parameters are supplied, 
		 * the default values are used. You can also set the width and height properties of the
		 * Video object after the initial construction, using Video.width and
		 * Video.height.
		 * When a new Video object is created, values of zero for width or height are not allowed; 
		 * if you pass zero, the defaults will be applied.
		 * 
		 *   After creating the Video, call the
		 * DisplayObjectContainer.addChild() or DisplayObjectContainer.addChildAt()
		 * method to add the Video object to a parent DisplayObjectContainer object.
		 * @param	width	The width of the video, in pixels.
		 * @param	height	The height of the video, in pixels.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function Video(width:int = 320, height:int = 240)
		{
			this.width = width;
			this.height = height;
			updateTransforms();
			
			_videoElement = document.createElement("video") as HTMLVideoElement;
			_videoElement.width = width;
			_videoElement.height = height;
			_videoElement.style.width = width + "px";
			_videoElement.style.height = height + "px";
		}
		
		override public function __update(ctx:CanvasRenderingContext2D):void 
		{
			if (_videoElement && visible)
			{
				var m:Matrix = transform.concatenatedMatrix;
				SpriteFlexjs.renderer.renderVideo(ctx, _videoElement, m, _videoElement.width, _videoElement.height, blendMode, transform.concatenatedColorTransform);
				SpriteFlexjs.drawCounter++;
			}
			
			SpriteFlexjs.dirtyGraphics = true;
		}
	}
}
