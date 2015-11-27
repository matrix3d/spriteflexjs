package flash.net
{
   import flash.events.EventDispatcher;
   import flash.utils.*;
   
   public class URLStream extends EventDispatcher
   {
       
      public function URLStream()
      {
         super();
      }
      
       public function load(param1:URLRequest) : void{}
      
       public function readBytes(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void{}
      
       public function readBoolean() : Boolean{return false}
      
       public function readByte() : int{return 0}
      
       public function readUnsignedByte() : uint{return 0}
      
       public function readShort() : int{return 0}
      
       public function readUnsignedShort() : uint{return 0}
      
       public function readUnsignedInt() : uint{return 0}
      
       public function readInt() : int{return 0}
      
       public function readFloat() : Number{return 0}
      
       public function readDouble() : Number{return 0}
      
       public function readMultiByte(param1:uint, param2:String) : String { return null; }
      
       public function readUTF() : String{return null}
      
       public function readUTFBytes(param1:uint) : String { return null; }
      
       public function get connected() : Boolean{return false}
      
       public function get bytesAvailable() : uint { return 0; }
      
       public function close() : void{}
      
       public function readObject() : * { return null; }
      
       public function get objectEncoding() : uint { return 0; }
      
       public function set objectEncoding(param1:uint) : void{}
      
       public function get endian() : String { return null; }
      
       public function set endian(param1:String) : void{}
      
       public function get diskCacheEnabled() : Boolean{return false}
      
       public function get position() : Number { return 0; }
      
       public function set position(param1:Number) : void{}
      
       public function get length() : Number { return 0; }
      
       public function stop() : void{}
   }
}
