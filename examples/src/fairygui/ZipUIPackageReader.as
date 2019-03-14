package fairygui
{
	import flash.utils.ByteArray;
	
	import fairygui.utils.ZipReader;
	
	public class ZipUIPackageReader implements IUIPackageReader
	{
		private var _desc:ZipReader;
		private var _files:ZipReader;
		
		public function ZipUIPackageReader(desc:ByteArray, res:ByteArray)
		{
			_desc = new ZipReader(desc);
			if(res && res.length)
				_files = new ZipReader(res);
			else
				_files = _desc;
		}
		
		public function readDescFile(fileName:String):String
		{
			var ba:ByteArray = _desc.getEntryData(fileName);				
			var str:String = ba.readUTFBytes(ba.length);
			ba.clear();
			
			return str;
		}
		
		public function readResFile(fileName:String):ByteArray
		{
			return _files.getEntryData(fileName);
		}
	}
}