package jprotoc 
{
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	/**
	 * ...
	 * @author lizhi http://matrix3d.github.io/
	 */
	public class Message 
	{
		public static var messageEncode:Object={};
		public var messageHasFlag:Array = [];
		public var mMessageEncode:Object;
		public function init():void {
		}
		
		public function readFrom(bytes:IDataInput, len:int = -1):void {
			MessageUtils.readFrom(this, bytes, len);
		}
		public function writeTo(bytes:IDataOutput):IDataOutput {
			return MessageUtils.writeTo(this, bytes);
		}
		public function has(number:int):Boolean {
			return messageHasFlag[number];
		}
		public function setHas(number:int, value:Boolean = true):void {
			messageHasFlag[number] = value;
		}
		/*public function toString():String {
			return JSON.stringify(this, null, 4);
		}*/
		public function toJSON2(k:String):Object {
			var messageEncode:Object = mMessageEncode;
			var obj:Object = { };
			if (messageEncode != null)
			for(var key:String in messageEncode) {
				var arr:Array = messageEncode[key];
				var name:String = arr[0];
				var value:Object = this[name];
				if (value) {
					if (value is Array) {
						if (value.length && value[0] is Message) {
							obj[name] = value;
						}else {
							obj[name] ="["+ value + "]";
						}
					}else if(value is Message){
						obj[name] = value;
					}else if(value is String){
						obj[name] = value+"";
					}else if (value is Int64) {
						obj[name] = value+"";
					}else if (value is ByteArray) {
						obj[name] = value + "";
					}else{
						obj[name] = value;
					}
				}
			}
			return obj;
		}
	}

}