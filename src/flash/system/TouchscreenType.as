//
// D:\sdk\airsdk24\frameworks\libs\player\18.0\playerglobal.swc\flash\system\TouchscreenType
//
package flash.system
{
	/**
	 * The TouchscreenType class is an enumeration class that provides values for the different types of touch screens.
	 * 
	 *   <p class="- topic/p ">Use the values defined by the TouchscreenType class with the <codeph class="+ topic/ph pr-d/codeph ">Capabilities.touchscreenType</codeph>
	 * property.</p>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example is a simple test that indicates the current state of the "Num Lock" and "Caps Lock" keys
	 * as well as the type of keybaord and touch screen type in the running environment. When testing this example, click the
	 * text field to see the property values:
	 * <codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * import flash.events.~~;
	 * import flash.display.~~;
	 * import flash.ui.Keyboard;
	 * import flash.system.Capabilities;
	 * import flash.text.TextField;
	 * 
	 *   var keyboardInfoTxt:TextField = new TextField();
	 * keyboardInfoTxt.x = 30;
	 * keyboardInfoTxt.y = 50;
	 * keyboardInfoTxt.width = 300;
	 * keyboardInfoTxt.height = 100;
	 * keyboardInfoTxt.border = true;
	 * 
	 *   addChild(keyboardInfoTxt);
	 * 
	 *   addEventListener (MouseEvent.CLICK, getScreenKeyboardType);
	 * 
	 *   function getScreenKeyboardType(e:MouseEvent):void{
	 * keyboardInfoTxt.text= "Caps Lock is : " + String(flash.ui.Keyboard.capsLock)+ "\n" + 
	 * "Num Lock is : " + String(flash.ui.Keyboard.numLock) +"\n" + 
	 * "Has Virtual Keyboard : " + String(flash.ui.Keyboard.hasVirtualKeyboard) + "\n" + 
	 * "Physical Keyboard Type : " + flash.ui.Keyboard.physicalKeyboardType + "\n" + 
	 * "flash.system.Capabilities.touchscreenType is : " + flash.system.Capabilities.touchscreenType;
	 * }
	 * </codeblock>
	 * @langversion	3.0
	 * @playerversion	Flash 10.1
	 * @playerversion	AIR 2
	 */
	public final class TouchscreenType extends Object
	{
		/**
		 * A touchscreen designed to respond to finger touches.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public static const FINGER : String = "finger";

		/**
		 * The computer or device does not have a supported touchscreen.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public static const NONE : String = "none";

		/**
		 * A touchscreen designed for use with a stylus.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public static const STYLUS : String = "stylus";

		public function TouchscreenType ();
	}
}
