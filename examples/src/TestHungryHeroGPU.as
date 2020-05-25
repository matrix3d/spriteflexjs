package 
{
	import flash.__native.WebGLRenderer;
	import flash.text.TextField;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestHungryHeroGPU extends TestHungryHero
	{
		
		public function TestHungryHeroGPU() 
		{
			CONFIG::js_only{
				SpriteFlexjs.renderer = new WebGLRenderer;
				SpriteFlexjs.wmode = "gpu batch";
			}
			
			var tf:TextField = new TextField;
			addChild(tf);
			tf.autoSize="left"
			tf.htmlText="<font size='140' color='#ff0000'>a</font><font size='20' color='#ff0000'>b</font>"
		}
		
	}

}