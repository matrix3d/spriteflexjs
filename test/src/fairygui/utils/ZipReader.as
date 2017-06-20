package fairygui.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class ZipReader
	{
		private var _stream:ByteArray;
		private var _entries:Object;
		
		public function ZipReader(ba:ByteArray):void {
			_stream = ba;
			_stream.endian = Endian.LITTLE_ENDIAN;
			_entries = {};
			
			readEntries();
		}
		
		public function get entries():Object
		{
			return _entries;
		}

		private function readEntries():void {
			_stream.position = _stream.length - 22;
			var buf:ByteArray = new ByteArray();
			buf.endian = Endian.LITTLE_ENDIAN;
			_stream.readBytes(buf, 0, 22);
			buf.position = 10;
			var entryCount:int = buf.readUnsignedShort();
			buf.position = 16;
			_stream.position = buf.readUnsignedInt();
			buf.length = 0;
			
			for(var i:int = 0; i < entryCount; i++) {
				_stream.readBytes(buf, 0, 46);
				buf.position = 28;
				var len:uint = buf.readUnsignedShort();
				var name:String = _stream.readUTFBytes(len);
				var len2:int = buf.readUnsignedShort()+buf.readUnsignedShort();
				_stream.position += len2;
				var lastChar:String = name.charAt(name.length-1);
				if(lastChar=="/" || lastChar=="\\")
					continue;
				
				name = name.replace(/\\/g, "/");
				var e:ZipEntry = new ZipEntry();
				e.name = name;
				buf.position = 10;
				e.compress = buf.readUnsignedShort();
				buf.position = 16;
				e.crc = buf.readUnsignedInt();
				e.size = buf.readUnsignedInt();
				e.sourceSize = buf.readUnsignedInt();
				buf.position = 42;
				e.offset = buf.readUnsignedInt() + 30 + len;
				
				_entries[name] = e;
			}
		}
		
		public function getEntryData(n:String):ByteArray {
			var entry:ZipEntry = _entries[n];
			if(!entry)
				return null;
			
			var ba:ByteArray = new ByteArray();
			if(!entry.size)
				return ba;
			
			_stream.position = entry.offset;			
			_stream.readBytes(ba, 0, entry.size);
			if(entry.compress) 
				ba.inflate();
			
			return ba;
		}
	}
}

import flash.utils.ByteArray;

class ZipEntry
{
	public var name:String;
	public var offset:uint;
	public var size:uint;
	public var sourceSize:uint;
	public var compress:int;
	public var crc:uint;
	
	public function ZipEntry() {}
}