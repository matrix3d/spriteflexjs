package 
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestHungryHeroGPU extends TestHungryHero
	{
		
		public function TestHungryHeroGPU() 
		{
			CONFIG::js_only{
				SpriteFlexjs.wmode = "gpu batch";
			}
			
		}
		
	}

}