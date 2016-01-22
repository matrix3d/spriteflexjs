package 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestText extends Sprite
	{
		
		public function TestText() 
		{
			var tf:TextField = new TextField;
			trace(tf.defaultTextFormat);
			tf.text = "你好";
			tf.textColor = 0xff0000;
			tf.defaultTextFormat=(new TextFormat(null, null, 0xff00));
			tf.appendText("dd");
			tf.text += "dd";
			tf.setTextFormat(new TextFormat(null, 50, 0xff00),1);
			addChild(tf);
			tf.height = 100;
			graphics.beginFill(0,.1);
			graphics.drawRect(0, 0, 100, 100);
		}
		
	}

}