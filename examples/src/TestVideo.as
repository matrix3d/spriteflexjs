package 
{
	import flash.display.Sprite;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.media.VideoCodec;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class TestVideo extends Sprite
	{
		private var _videoCamera:Video;
		private var _videoURL:Video;
		private var _videoBytes:Video;
		private var _netConnection:NetConnection;
		private var _netConnection2:NetConnection;
		private var _netStream:NetStream;
		private var _netStream2:NetStream;
		private var _ld:URLLoader;
		private var _bytes:ByteArray;
		private var _motionText:TextField;
		
		public function TestVideo() 
		{
			SpriteFlexjs.autoSize = true;
			
			this.name = "TestVideo";
			
			// Webcam and Motion Detecton
			var cam:Camera = Camera.getCamera(null, 360, 203);
			cam.showMotionCanvas = true;
			//cam.setMotionLevel(10);
			cam.addEventListener(ActivityEvent.ACTIVITY, onCameraActivity);
			cam.addEventListener(ActivityEvent.MOTION_DETECTED, onMotionDetected);
			cam.addEventListener(ActivityEvent.MOTION_ENDED, onMotionEnded);
			_videoCamera = new Video(360, 203);
			_videoCamera.name = "CameraVideo";
			_videoCamera.attachCamera(cam);
			addChild(_videoCamera);
			
			_motionText = new TextField();
			_motionText.defaultTextFormat = new TextFormat("Arial", 18);
			_motionText.text = "Camera Motion:";
			_motionText.y = _videoCamera.height + 5;
			_motionText.x = 30;
			addChild(_motionText);
			
			// Video streamed from a file.
			var videoBox:Sprite = new Sprite();
			videoBox.x = 400;
			videoBox.name = "StandardVideo";
			videoBox.buttonMode = true;
			videoBox.mouseEnabled = true;
			videoBox.mouseChildren = true;
			_videoURL = new Video(360, 203);
			_videoURL.name = "BuckBunny";
			videoBox.addChild(_videoURL);
			addChild(videoBox);
			videoBox.addEventListener(MouseEvent.CLICK, onVideoBoxClicked);
			
			
			var urlVideoText:TextField = new TextField();
			urlVideoText.defaultTextFormat = new TextFormat("Arial", 18);
			urlVideoText.text = "Standard video stream from URL";
			urlVideoText.x = 400;
			urlVideoText.y = _videoURL.height + 5;
			addChild(urlVideoText);
			
			_netConnection = new NetConnection();
			_netConnection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_netConnection.connect(null);
			
			// Video streamed from raw bytes in seamless loop.
			_videoBytes = new Video(608, 354);
			_videoBytes.name = "BytesVideo";
			_videoBytes.loop = true;
			_videoBytes.y = 300;
			addChild(_videoBytes);
			
			var bytesVideoText:TextField = new TextField();
			bytesVideoText.defaultTextFormat = new TextFormat("Arial", 18);
			bytesVideoText.text = "Seamless loop using video bytes.  Requires fragmented MP4 or WEBM file.";
			bytesVideoText.x = 5;
			bytesVideoText.y = _videoBytes.y + _videoBytes.height + 5;
			addChild(bytesVideoText);
			
			var req:URLRequest = new URLRequest("../assets/media/video/t-rex.webm");
			_ld = new URLLoader();
			_ld.dataFormat = URLLoaderDataFormat.BINARY;
			_ld.addEventListener(Event.COMPLETE, function(e:Event):void {
				_bytes = _ld.data as ByteArray;
				_netConnection2 = new NetConnection();
				_netConnection2.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				_netConnection2.connect(null);
			});
			_ld.load(req);
		}
		
		private function onVideoBoxClicked(e:MouseEvent):void 
		{
			trace("Video Box clicked!!!");
		}
		
		private function connectStream():void 
		{
			_netStream = new NetStream(_netConnection);
			_netStream.loop = true;
			_netStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_netStream.client = new CustomClient();
			
			_videoURL.attachNetStream(_netStream); // must attach stream first
			_netStream.play("../assets/media/video/frag_bunny.mp4");
		}
		
		private function connectByteStream():void 
		{
			_netStream2 = new NetStream(_netConnection2);
			_netStream2.loop = true;
			_netStream2.mimeCodec = VideoCodec.VP8; // Codec must be specified. Use MP4 for IE and WebM for everything else.
			_netStream2.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_netStream2.client = new CustomClient();
			_videoBytes.attachNetStream(_netStream2); // must attach stream first
			
			_netStream2.play(null);
			_netStream2.appendBytes(_bytes);
		}
		
		private function onMotionEnded(e:ActivityEvent):void 
		{
			//trace("TestVideo.onMotionEnded()");
			_motionText.text = "Camera Motion: Motion Ended";
			_motionText.textColor = 0xFF8000;
		}
		
		private function onMotionDetected(e:ActivityEvent):void 
		{
			//trace("TestVideo.onMotionDetected()");
			_motionText.text = "Camera Motion: Motion Detected";
			_motionText.textColor = 0x008000;
		}
		
		private function onCameraActivity(e:ActivityEvent):void 
		{
			//trace("TestVideo.onCameraActivity() " + e.currentTarget.name + " activating: " + e.activating);
			if (!e.activating)
			{
				_motionText.text = "Camera Disconnected";
				_motionText.textColor = 0xFF0000;
			}
		}
		
		private function netStatusHandler(event:NetStatusEvent):void 
		{
			//trace("netStatusHandler: " + event.info.code);
			switch (event.info.code) 
			{
				case "NetConnection.Connect.Success":
					if (event.currentTarget == _netConnection)
					{
						if (!_netStream) connectStream();
					}
					else
					{
						if (!_netStream2) connectByteStream();
					}
					break;
				case "NetStream.Play.Start":
					trace("NetStream.Play.Start");
					break;
				case "NetStream.Play.StreamNotFound":
					trace("NetStream.Play.StreamNotFound: " + _netStream.url);
					break;
			}
		}
	}

}

class CustomClient 
{
	public function onMetaData(info:Object):void {
		trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height);
	}
	public function onCuePoint(info:Object):void {
		trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
	}
	public function onXMPData(info:Object):void {
		trace("xmpdata", info);
	}
	public function onPlayStatus(info:Object):void {
		trace("playstatus", info);
	}
}