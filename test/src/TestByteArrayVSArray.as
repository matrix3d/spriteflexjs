package 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
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
			var num:int = 1000000;
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			byte.length = num * 4;
			var t:int = getTimer();
			for (var i:int = 0; i < num;i++ ){
				byte.writeFloat(.1);
			}
			tf.text = "bytearray:"+(getTimer() - t)+" ";
			t = getTimer();
			var arr:Array = [];
			for (i = 0; i < num;i++ ){
				arr.push(.1);
			}
			tf.appendText("array push:" + (getTimer() - t) + " ");
			
			t = getTimer();
			arr = [];
			for (i = 0; i < num;i++ ){
				arr[i]=.1;
			}
			tf.appendText("array [i]:"+(getTimer() - t) + " ");
			
			var tarr:Float32Array = new Float32Array(num);
			t = getTimer();
			for (i = 0; i < num;i++ ){
				tarr[i] = .1;
			}
			tf.appendText("float32array:" + (getTimer() - t) + "");
			
			
			var aarr:ArrayBuffer = new ArrayBuffer(num*4);
			t = getTimer();
			for (i = 0; i < num;i++ ){
				aarr[i] = .1;
			}
			tf.appendText(" ArrayBuffer:" + (getTimer() - t) + "");
			
			var tobj:Object = new Int8Array(num);
			t = getTimer();
			for (i = 0; i < num;i++ ){
				tobj[i] = .1;
			}
			tf.appendText(" i8:" + (getTimer() - t) + "");
			
			tobj = new Uint8Array(num);
			t = getTimer();
			for (i = 0; i < num;i++ ){
				tobj[i] = .1;
			}
			tf.appendText(" ui8:" + (getTimer() - t) + "");
			
			tobj = new Uint8ClampedArray(num);
			t = getTimer();
			for (i = 0; i < num;i++ ){
				tobj[i] = .1;
			}
			tf.appendText(" ui8clamp:" + (getTimer() - t) + "");
			
			tobj = new Int16Array(num);
			t = getTimer();
			for (i = 0; i < num;i++ ){
				tobj[i] = .1;
			}
			tf.appendText(" i16:" + (getTimer() - t) + "");
			
			tobj = new Uint16Array(num);
			t = getTimer();
			for (i = 0; i < num;i++ ){
				tobj[i] = .1;
			}
			tf.appendText(" ui16:" + (getTimer() - t) + "");
			
			tobj = new Int32Array(num);
			t = getTimer();
			for (i = 0; i < num;i++ ){
				tobj[i] = .1;
			}
			tf.appendText(" i32:" + (getTimer() - t) + "");
			
			tobj = new Uint32Array(num);
			t = getTimer();
			for (i = 0; i < num;i++ ){
				tobj[i] = .1;
			}
			tf.appendText(" ui32:" + (getTimer() - t) + "");
			
			tobj = new Float64Array(num);
			t = getTimer();
			for (i = 0; i < num;i++ ){
				tobj[i] = .1;
			}
			tf.appendText(" f64:" + (getTimer() - t) + "");
			
			var dv:DataView = new DataView(new ArrayBuffer(num * 4));
			t = getTimer();
			for (i = 0; i < num;i++ ){
				dv.setFloat32(i * 4, .1);
			}
			tf.appendText(" dv:" + (getTimer() - t) + "");
			
			var ab:ArrayBuffer = new ArrayBuffer(4);
			var abdv:DataView = new DataView(ab);
			var abf32:Float32Array = new Float32Array(ab);
			abdv.setFloat32(0, .1,true);
			trace(abf32[0]);
			abf32[0] = .3;
			trace(abdv.getFloat32(0,true));
		}
		
	}
}