package 
{
	import flash.__native.WebGLRenderer;
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
			
		}
		
	}

}