package fairygui.utils
{
	import flash.utils.ByteArray;

	public class PixelHitTestData
	{
		public var pixelWidth:int;
		public var scale:Number;		
		public var pixels:Vector.<int>;
		
		public function PixelHitTestData()
		{
		}
		
		public function load(ba:ByteArray):void
		{
			ba.readInt();
			pixelWidth = ba.readInt();
			scale = ba.readByte();
			var len:int = ba.readInt();
			pixels = new Vector.<int>(len);
			for(var i:int=0;i<len;i++)
			{
				var j:int = ba.readByte();
				if(j<0)
					j+=256;
				
				pixels[i] = j;
			}
		}
	}
}