package 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestProtoBuff 
	{
		
		public function TestProtoBuff() 
		{
			var msg:Simple1 = new Simple1;
			msg.email = "ddd";
			var b:ByteArray = new ByteArray;
			msg.writeTo(b);
			b.position = 0;
			var s:String = "";
			for (var i:int = 0; i < b.length;i++ ){
				s += b.readByte().toString(16)+",";
			}
			trace(s);
			
			var msg2:Simple1 = new Simple1;
			b.position = 0;
			msg2.readFrom(b);
			trace(msg2.email);
		}
		
	}

}