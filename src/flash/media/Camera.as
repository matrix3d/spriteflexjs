package flash.media
{
	import flash.events.EventDispatcher;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	[Event(name = "videoFrame", type = "flash.events.Event")]
	[Event(name = "status", type = "flash.events.StatusEvent")]
	[Event(name = "activity", type = "flash.events.ActivityEvent")]
	public final class Camera extends EventDispatcher
	{
		
		public function Camera()
		{
			super();
		}
		
		private static function _scanHardware():void
		{
		}
		
		public static function get names():Array
		{
			return null;
		}
		
		public static function get isSupported():Boolean
		{
			return false;
		}
		
		public static function getCamera(param1:String = null):Camera
		{
			return null;
		}
		
		public function get activityLevel():Number
		{
			return 0;
		}
		
		public function get bandwidth():int
		{
			return 0;
		}
		
		public function get currentFPS():Number
		{
			return 0;
		}
		
		public function get fps():Number
		{
			return 0;
		}
		
		public function get height():int
		{
			return 0;
		}
		
		public function get index():int
		{
			return 0;
		}
		
		public function get keyFrameInterval():int
		{
			return 0;
		}
		
		public function get loopback():Boolean
		{
			return false;
		}
		
		public function get motionLevel():int
		{
			return 0;
		}
		
		public function get motionTimeout():int
		{
			return 0;
		}
		
		public function get muted():Boolean
		{
			return false;
		}
		
		public function get name():String
		{
			return null;
		}
		
		public function get position():String
		{
			return null;
		}
		
		public function get quality():int
		{
			return 0;
		}
		
		public function get width():int
		{
			return 0;
		}
		
		public function setCursor(param1:Boolean):void
		{
		
		}
		
		public function setKeyFrameInterval(param1:int):void
		{
		
		}
		
		public function setLoopback(param1:Boolean = false):void
		{
		
		}
		
		public function setMode(param1:int, param2:int, param3:Number, param4:Boolean = true):void
		{
		
		}
		
		public function setMotionLevel(param1:int, param2:int = 2000):void
		{
		
		}
		
		public function setQuality(param1:int, param2:int):void
		{
		
		}
		
		public function drawToBitmapData(param1:BitmapData):void
		{
		
		}
		
		public function copyToByteArray(param1:Rectangle, param2:ByteArray):void
		{
		
		}
		
		public function copyToVector(param1:Rectangle, param2:Vector.<uint>):void
		{
		
		}
	}
}
