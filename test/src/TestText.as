package 
{
	import flash.__native.WebGLRenderer;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import spriteflexjs.Stats;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestText extends Sprite
	{
		
		public function TestText() 
		{
			//SpriteFlexjs.wmode = "gpu batch";
			//SpriteFlexjs.renderer = new WebGLRenderer;
			
			var tf:TextField = new TextField;
			tf.x = 100;
			trace(tf.defaultTextFormat);
			tf.text = "hello";
			tf.textColor = 0xff0000;
			tf.defaultTextFormat=(new TextFormat(null, null, 0xff00));
			tf.appendText("\ndd");
			tf.text += "dd";
			tf.setTextFormat(new TextFormat(null, 50, 0xff00),1);
			addChild(tf);
			
			
			tf.height = 100;
			graphics.beginFill(0,.1);
			graphics.drawRect(0, 0, 100, 100);
			
			addChild(new Stats);
		}
		
	}

}