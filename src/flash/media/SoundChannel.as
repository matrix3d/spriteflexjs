package flash.media
{
	import flash.events.EventDispatcher;
	
	[Event(name = "soundComplete", type = "flash.events.Event")]
	public final class SoundChannel extends EventDispatcher
	{
		
		public function SoundChannel()
		{
			super();
		}
		
		public function get position():Number
		{
			return 0;
		}
		
		public function get soundTransform():SoundTransform
		{
			return null;
		}
		
		public function set soundTransform(param1:SoundTransform):void
		{
		
		}
		
		public function stop():void
		{
		
		}
		
		public function get leftPeak():Number
		{
			return 0;
		}
		
		public function get rightPeak():Number
		{
			return 0;
		}
	}
}
