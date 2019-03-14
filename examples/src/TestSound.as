package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestSound extends Sprite
	{
		
		public function TestSound() 
		{
			var sound:Sound = new Sound(new URLRequest("../../assets/media/sounds/bgGame.mp3"));
			sound.play();
			
			stage.addEventListener(MouseEvent.CLICK, stage_click);
		}
		
		private function stage_click(e:MouseEvent):void 
		{
			SoundMixer.stopAll();
		}
		
	}

}