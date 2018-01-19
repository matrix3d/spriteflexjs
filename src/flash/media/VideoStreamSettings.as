package flash.media
{
	public class VideoStreamSettings extends Object
	{
		private var _bandwidth:int = 0;
		private var _codec:String = "";
		private var _fps:Number = 0;
		private var _height:int = 0;
		private var _keyFrameInterval:int;
		private var _quality:int;
		private var _width:int;
		
		public function get bandwidth():int { return _bandwidth; }

		public function get codec():String { return _codec; }

		public function get fps():Number { return _fps; }

		public function get height():int { return _height; }

		public function get keyFrameInterval():int { return _keyFrameInterval; }

		public function get quality():int { return _quality; }

		public function get width():int { return _width; }

		public function setKeyFrameInterval(keyFrameInterval:int):void
		{
			_keyFrameInterval = keyFrameInterval;
		}

		public function setMode(width:int, height:int, fps:Number):void
		{
			_width = width;
			_height = height;
			_fps = fps;
		}

		public function setQuality(bandwidth:int, quality:int):void
		{
			_bandwidth = bandwidth;
			_quality = _quality;
		}

		public function VideoStreamSettings()
		{
			
		}
	}
}
