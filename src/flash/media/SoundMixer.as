package flash.media
{
	import flash.utils.ByteArray;
	
	public final class SoundMixer extends Object
	{
		
		public function SoundMixer()
		{
			super();
		}
		
		public static function stopAll():void
		{
			for each(var sound:Sound in Sound.sounds) {
				sound.playing = false;
				try{
					sound.source.stop(0);
				}catch(err:Object){}
			}
		}
		
		public static function computeSpectrum(outputArray:ByteArray, FFTMode:Boolean=false, stretchFactor:int=0):void
		{
		
		}
		
		public static function get bufferTime():int
		{
			return 0;
		}
		
		public static function set bufferTime(param1:int):void
		{
		
		}
		
		public static function get soundTransform():SoundTransform
		{
			return null;
		}
		
		public static function set soundTransform(param1:SoundTransform):void
		{
		
		}
		
		public static function areSoundsInaccessible():Boolean
		{
			return false;
		}
		
		public static function get audioPlaybackMode():String
		{
			return null;
		}
		
		public static function set audioPlaybackMode(mode:String):void
		{
		
		}
		
		public static function get useSpeakerphoneForVoice():Boolean
		{
			return false;
		}
		
		public static function set useSpeakerphoneForVoice(b:Boolean):void
		{
		
		}
	}
}
