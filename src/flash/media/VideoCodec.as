package flash.media
{
	public final class VideoCodec extends Object
	{
		public static const H264AVC : String = 'video/mp4; codecs="avc1.64001F, mp4a.40.2"';
		//public static const SORENSON : String = "";
		public static const VP8 : String = 'video/webm; codecs="vorbis,vp8"';
		public static const VP9 : String = 'video/webm; codecs="vorbis,vp9"';

		public function VideoCodec ();
	}
}