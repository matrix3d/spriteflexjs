package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestByteArray extends Sprite
	{
		private var loader:URLLoader;	
		public function TestByteArray() 
		{
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, loader_complete);
			loader.load(new URLRequest("../../assets/wood.jpg"));
		}
		
		private function loader_complete(e:Event):void 
		{
			var ba:ByteArray = loader.data as ByteArray;
			for (var i:int = 0; i < Math.min(100,ba.length);i++ ) {
				//trace(ba.readInt());
			}
			ba.position = 0;
			ba.writeInt(100);
			ba.position = 0;
			trace(ba.readInt());
			
			ba = new ByteArray;
			ba.writeInt(100);
			ba.writeInt(200);
			ba.position = 0;
			trace(ba.readInt(),ba.readInt());
		}
	}

}