package flash.utils
{
	
	/**
	 * ...
	 * @author lizhi http://matrix3d.github.io/
	 */
	//http://www.ruanyifeng.com/blog/2012/09/xmlhttprequest_level_2.html
	public class ByteArray
	{
		private static var _defaultObjectEncoding:uint;
		public var dataView:DataView;
		private var _endian:String = Endian.BIG_ENDIAN;
		private var isLittleEndian:Boolean = false;
		private var _position:int = 0;
		private var _length:int = 0;
		public function ByteArray()
		{
			dataView = new DataView(new ArrayBuffer(0));
			super();
		}
		
		public static function get defaultObjectEncoding():uint  { return 0 }
		
		public static function set defaultObjectEncoding(param1:uint):void  {/**/ }
		
		public function readBytes(b:ByteArray, offset:uint = 0, length:uint = 0):void  {
			b.position = offset;
			b.writeBytes(this, position, length);
		}
		
		public function writeBytes(b:ByteArray, offset:uint = 0, length:uint = 0):void  {
			if (length===0) {
				length = b.length - offset;
			}
			beforWrite(length);
			b.position = offset;
			for (var i:int = 0; i < length;i++ ) {
				writeByte(b.readByte());
			}
		}
		
		public function writeBoolean(v:Boolean):void  {
			beforWrite(1);
			dataView.setInt8(_position, v?1:0);
			_position++;
		}
		
		public function writeByte(v:int):void  {
			beforWrite(1);
			dataView.setInt8(_position, v);
			_position++;
		}
		
		public function writeShort(v:int):void  {
			beforWrite(2);
			dataView.setInt16(_position, v, isLittleEndian);
			_position += 2;
		}
		
		public function writeInt(v:int):void  {
			beforWrite(4);
			dataView.setInt32(_position, v, isLittleEndian);
			_position += 4;
		}
		
		public function writeUnsignedInt(v:uint):void  {
			beforWrite(4);
			dataView.setUint32(_position, v, isLittleEndian);
			_position += 4;
		}
		
		public function writeFloat(v:Number):void  {
			beforWrite(4);
			dataView.setFloat32(_position, v, isLittleEndian);
			_position += 4;
		}
		
		public function writeDouble(v:Number):void  {
			beforWrite(8);
			dataView.setFloat64(_position, v, isLittleEndian);
			_position += 8;
		}
		
		public function writeMultiByte(str:String, charSet:String):void  {
			try{
				var encoder:TextEncoder = new TextEncoder(charSet);
				var u8:Uint8Array = encoder.encode(str);
			}catch(err:Object){
				u8 = new Uint8Array(str.split('').map(function(c:String):Number { return c.charCodeAt(0); } ));
			}
			for (var i:int = 0; i < u8.length;i++ ) {
				writeByte(u8[i]);
			}
		}
		
		public function writeUTF(v:String):void  {
			_position += 2;
			var start:int = _position;
			writeUTFBytes(v);
			var end:int = _position;
			_position = start - 2;
			writeShort(start - end);
			_position = end;
		}
		
		public function writeUTFBytes(v:String):void
		{
			writeMultiByte(v, "utf-8");
		}
		
		public function readBoolean():Boolean  {
			var v:Boolean = dataView.getInt8(_position) != 0;
			_position++;
			return v;
		}
		
		public function readByte():int  { 
			var v:int = dataView.getInt8(_position);
			_position++;
			return v;
		}
		
		public function readUnsignedByte():uint  { 
			var v:uint = dataView.getUint8(_position);
			_position++;
			return v;
		}
		
		public function readShort():int  { 
			var v:int = dataView.getInt16(_position,isLittleEndian);
			_position+=2;
			return v;
		}
		
		public function readUnsignedShort():uint  { 
			var v:uint = dataView.getUint16(_position,isLittleEndian);
			_position+=2;
			return v;
		}
		
		public function readInt():int  { 
			var v:int = dataView.getInt32(_position,isLittleEndian);
			_position+=4;
			return v;
		}
		
		public function readUnsignedInt():uint  { 
			var v:uint = dataView.getUint32(_position,isLittleEndian);
			_position+=4;
			return v;
		}
		
		public function readFloat():Number  { 
			var v:Number = dataView.getFloat32(_position,isLittleEndian);
			_position+=4;
			return v;
		}
		
		public function readDouble():Number  { 
			var v:Number = dataView.getFloat64(_position,isLittleEndian);
			_position+=8;
			return v;
		}
		
		public function readMultiByte(length:uint, charSet:String):String  {
			try{
				var u8:Uint8Array = new Uint8Array(length);
				u8.set(new Uint8Array(_slice(dataView.buffer,_position, _position + length)));
				var decoder:TextDecoder = new TextDecoder(charSet);
				var str:String = decoder.decode(u8);
			}catch (err:Object){
				//str = String.fromCharCode.apply(null, u8);
				str = "";
				for (var i:int = 0; i < length;i++ ){
					str += String.fromCharCode(dataView.getUint8(_position + i));
				}
			}
			_position += length;
			return str;
		}
		
		public function readUTF():String  { 
			return readUTFBytes(readUnsignedShort());
		}
		
		public function readUTFBytes(length:uint):String  { 
			return readMultiByte(length, "utf-8");
		}
		
		public function get length():uint  { 
			return _length;//dataView.byteLength;
		}
		
		public function set length(v:uint):void  {
			_length = v;
			var u8:Uint8Array = new Uint8Array(v);
			u8.set(new Uint8Array(dataView.buffer.byteLength > v?_slice(dataView.buffer,0, v):dataView.buffer));
			dataView = new DataView(u8.buffer);
		}
		
		private function beforWrite(len:int):void {
			if ((_position+len) > length) {
				length = _position + len;
			}
		}
		
		public function writeObject(param1:*):void  {/**/ }
		
		public function readObject():*  { return null }
		
		public function deflate():void
		{
			this._compress("deflate");
		}
		
		private function _compress(param1:String):void  {/**/ }
		
		public function compress(algorithm:String = "zlib"):void
		{
			this._compress(algorithm);
		}
		
		public function inflate():void
		{
			this._uncompress("deflate");
		}
		
		private function _uncompress(param1:String):void  {/**/ }
		
		public function uncompress(algorithm:String = "zlib"):void
		{
			this._uncompress(algorithm);
		}
		
		public function toString():String
		{
			return this._toString();
		}
		
		private function _toString():String  { 
			position = 0;
			return readUTFBytes(length);
		}
		
		public function get bytesAvailable():uint  { 
			return length - position; 
		}
		
		public function get position():uint  { return _position }
		
		public function set position(p:uint):void  {
			_position = p;
		}
		
		public function get objectEncoding():uint  { return 0 }
		
		public function set objectEncoding(param1:uint):void  {/**/ }
		
		public function get endian():String  { return _endian; }
		
		public function set endian(v:String):void  {
			_endian = v;
			isLittleEndian = v === Endian.LITTLE_ENDIAN;
		}
		
		public function clear():void  {
			position = 0;
			length = 0;
		}
		
		public function atomicCompareAndSwapIntAt(param1:int, param2:int, param3:int):int  { return 0 }
		
		public function atomicCompareAndSwapLength(param1:int, param2:int):int  { return 0 }
		
		public function get shareable():Boolean  { return false }
		
		public function set shareable(param1:Boolean):void  {/**/ }
		
		//http://stackoverflow.com/questions/21440050/arraybuffer-prototype-slice-shim-for-ie
		private static function _slice(buff:ArrayBuffer, begin:Number, end:Number):ArrayBuffer{
			try{
				var newbuffer:ArrayBuffer = buff.slice(begin, end);
			}catch (err:Object){
				if (end===0){
					end = buff.byteLength;
				}
				newbuffer = new ArrayBuffer(end - begin);
				var rb:Uint8Array = new Uint8Array(newbuffer);
				var sb:Uint8Array = new Uint8Array(buff, begin, end - begin);
				rb.set(sb);
			}
			return newbuffer;
		}
	}
}
