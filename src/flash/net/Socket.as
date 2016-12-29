package flash.net
{
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	/**
	 * @author lizhi
	 */
	public class Socket extends EventDispatcher
	{
		private var websocket:WebSocket;
		public function Socket (host:String = null, port:int = 0){
			websocket = new WebSocket("ws://"+host+":"+port);
			//websocket.onclose
		}
		public function get bytesAvailable () : uint{
			
		}
		public function get bytesPending () : uint;
		public function get connected () : Boolean;
		public function get endian () : String;
		public function set endian (type:String) : void;
		public function get objectEncoding () : uint;
		public function set objectEncoding (version:uint) : void;
		public function get timeout () : uint;
		public function set timeout (value:uint) : void;
		public function close () : void;
		public function connect (host:String, port:int) : void;
		public function flush () : void;
		public function readBoolean () : Boolean;
		public function readByte () : int;
		public function readBytes (bytes:ByteArray, offset:uint=0, length:uint=0) : void;
		public function readDouble () : Number;
		public function readFloat () : Number;
		public function readInt () : int;
		public function readMultiByte (length:uint, charSet:String) : String;
		public function readObject () : *;
		public function readShort () : int;
		public function readUnsignedByte () : uint;
		public function readUnsignedInt () : uint;
		public function readUnsignedShort () : uint;
		public function readUTF () : String;
		public function readUTFBytes (length:uint) : String;
		public function writeBoolean (value:Boolean) : void;
		public function writeByte (value:int) : void;
		public function writeBytes (bytes:ByteArray, offset:uint=0, length:uint=0) : void;
		public function writeDouble (value:Number) : void;
		public function writeFloat (value:Number) : void;
		public function writeInt (value:int) : void;
		public function writeMultiByte (value:String, charSet:String) : void;
		public function writeObject (object:any) : void;
		public function writeShort (value:int) : void;
		public function writeUnsignedInt (value:uint) : void;
		public function writeUTF (value:String) : void;
		public function writeUTFBytes (value:String) : void;
	}
}
