package 
{
	import fairygui.ButtonMode;
	import flash.display.Sprite;
	import game.ui.comps.ButtonTestUI;
	import morn.core.components.Button;
	import morn.core.components.Component;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestMornui extends ButtonTestUI
	{
		
		public function TestMornui() 
		{
			var com:Button = new Button(null, "fdsafds");
			addChild(com);
			trace(com);
		}
		
	}

}