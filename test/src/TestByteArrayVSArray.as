package 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestByteArrayVSArray extends Sprite
	{
		
		public function TestByteArrayVSArray() 
		{
			var tf:TextField = new TextField;
			tf.autoSize = "left";
			addChild(tf);
			var byte:ByteArray = new ByteArray;
			byte.length = 1000000 * 4;
			var t:int = getTimer();
			for (var i:int = 0; i < 1000000;i++ ){
				byte.writeFloat(.1);
			}
			tf.text = (getTimer() - t)+" ";
			t = getTimer();
			var arr:Array = [];
			for (i = 0; i < 1000000;i++ ){
				arr.push(.1);
			}
			tf.appendText((getTimer() - t) + " ");
			
			var tarr:Float32Array = new Float32Array(1000000);
			t = getTimer();
			for (i = 0; i < 1000000;i++ ){
				tarr[i] = .1;
			}
			tf.appendText((getTimer() - t)+"");
		}
		
	}

}