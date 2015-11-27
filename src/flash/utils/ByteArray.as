package flash.utils
{
   public class ByteArray
   {
      
      private static var _defaultObjectEncoding:uint;
      
      public function ByteArray()
      {
         super();
      }
      
     public static function get defaultObjectEncoding() : uint{return 0}
      
     public static function set defaultObjectEncoding(param1:uint) : void{}
      
     public function readBytes(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void{}
      
     public function writeBytes(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void{}
      
     public function writeBoolean(param1:Boolean) : void{}
      
     public function writeByte(param1:int) : void{}
      
     public function writeShort(param1:int) : void{}
      
     public function writeInt(param1:int) : void{}
      
     public function writeUnsignedInt(param1:uint) : void{}
      
     public function writeFloat(param1:Number) : void{}
      
     public function writeDouble(param1:Number) : void{}
      
     public function writeMultiByte(param1:String, param2:String) : void{}
      
     public function writeUTF(param1:String) : void{}
      
     public function writeUTFBytes(param1:String) : void{}
      
     public function readBoolean() : Boolean{return false}
      
     public function readByte() : int{return 0}
      
     public function readUnsignedByte() : uint{return 0}
      
     public function readShort() : int{return 0}
      
     public function readUnsignedShort() : uint{return 0}
      
     public function readInt() : int{return 0}
      
     public function readUnsignedInt() : uint{return 0}
      
     public function readFloat() : Number{return 0}
      
     public function readDouble() : Number{return 0}
      
     public function readMultiByte(param1:uint, param2:String) : String{return null}
      
     public function readUTF() : String{return null}
      
     public function readUTFBytes(param1:uint) : String{return null}
      
     public function get length() : uint{return 0}
      
     public function set length(param1:uint) : void{}
      
     public function writeObject(param1:*) : void{}
      
     public function readObject() : *{return null}
      
      public function deflate() : void
      {
         this._compress("deflate");
      }
      
     private function _compress(param1:String) : void{}
      
      public function compress(algorithm:String = "zlib") : void
      {
         this._compress(algorithm);
      }
      
      public function inflate() : void
      {
         this._uncompress("deflate");
      }
      
     private function _uncompress(param1:String) : void{}
      
      public function uncompress(algorithm:String = "zlib") : void
      {
         this._uncompress(algorithm);
      }
      
      public function toString() : String
      {
         return this._toString();
      }
      
     private function _toString() : String{return null}
      
     public function get bytesAvailable() : uint{return 0}
      
     public function get position() : uint{return 0}
      
     public function set position(param1:uint) : void{}
      
     public function get objectEncoding() : uint{return 0}
      
     public function set objectEncoding(param1:uint) : void{}
      
     public function get endian() : String{return null}
      
     public function set endian(param1:String) : void{}
      
     public function clear() : void{}
      
     public function atomicCompareAndSwapIntAt(param1:int, param2:int, param3:int) : int{return 0}
      
     public function atomicCompareAndSwapLength(param1:int, param2:int) : int{return 0}
      
     public function get shareable() : Boolean{return false}
      
     public function set shareable(param1:Boolean) : void{}
   }
}
