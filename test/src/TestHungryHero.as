package 
{
	import com.hsharma.hungryHero.HungryHero1;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import spriteflexjs.Stats;
	/**
	 * ...
	 * @author lizhi
	 */
	[SWF(frameRate="60", width="1024", height="768", backgroundColor="0x000000")]
	public class TestHungryHero extends Sprite
	{
		
		public function TestHungryHero() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			addChild(new HungryHero1);
			addChild(new Stats);
		}
		
	}

}