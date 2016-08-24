package flash.system
{
	
	public final class Capabilities extends Object
	{
		
		public function Capabilities()
		{
			super();
		}
		
		public static function get isEmbeddedInAcrobat():Boolean  { return false }

		
		public static function get hasEmbeddedVideo():Boolean  { return false }

		
		public static function get hasAudio():Boolean  { return false }

		
		public static function get avHardwareDisable():Boolean  { return false }

		
		public static function get hasAccessibility():Boolean  { return false }

		
		public static function get hasAudioEncoder():Boolean  { return false }

		
		public static function get hasMP3():Boolean  { return false }

		
		public static function get hasPrinting():Boolean  { return false }

		
		public static function get hasScreenBroadcast():Boolean  { return false }

		
		public static function get hasScreenPlayback():Boolean  { return false }

		
		public static function get hasStreamingAudio():Boolean  { return false }

		
		public static function get hasStreamingVideo():Boolean  { return false }

		
		public static function get hasVideoEncoder():Boolean  { return false }

		
		public static function get isDebugger():Boolean  { return false }

		
		public static function get localFileReadDisable():Boolean  { return false }

		
		public static function get language():String  { return null }

		
		public static function get manufacturer():String  { return null }

		
		public static function get os():String  { return null }

		
		public static function get cpuArchitecture():String  { return null }

		
		public static function get playerType():String  { return "spriteflexjs" }

		
		public static function get serverString():String  { return null }

		
		public static function get version():String  { return null }

		
		public static function get screenColor():String  { return null }

		
		public static function get pixelAspectRatio():Number  { return 0 }

		
		public static function get screenDPI():Number  { return 0 }

		
		public static function get screenResolutionX():Number  { return 0 }

		
		public static function get screenResolutionY():Number  { return 0 }

		
		public static function get touchscreenType():String  { return null }

		
		public static function get hasIME():Boolean  { return false }

		
		public static function get hasTLS():Boolean  { return false }

		
		public static function get maxLevelIDC():String  { return null }

		
		public static function get supports32BitProcesses():Boolean  { return false }

		
		public static function get supports64BitProcesses():Boolean  { return false }

		
		public static function hasMultiChannelAudio(param1:String):Boolean  { return false }
	}
}
