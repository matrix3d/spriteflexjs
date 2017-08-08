//
// D:\sdk\airsdk24\frameworks\libs\player\18.0\playerglobal.swc\flash\system\IME
//
package flash.system
{
	import flash.events.EventDispatcher;

	/**
	 * Dispatched when a user has completed an 
	 * input method editor (IME) composition 
	 * and the reading string is available.
	 * @eventType	flash.events.IMEEvent.IME_COMPOSITION
	 */
	[Event(name="imeComposition", type="flash.events.IMEEvent")] 

	/**
	 * The IME class lets you directly manipulate the operating system's input method 
	 * editor (IME) in the Flash runtime application that is running on a client computer. You can 
	 * determine whether an IME is installed, whether or not the IME is currently enabled, and which IME is
	 * enabled. You can disable or enable the IME in the application, and you can perform other limited
	 * functions, depending on the operating system.
	 * 
	 *   <p class="- topic/p "><i class="+ topic/ph hi-d/i ">AIR profile support:</i> This feature is supported 
	 * on desktop operating systems, but it is not supported on all mobile devices. It is also not supported on
	 * AIR for TV devices. You can test for support at run time using the <codeph class="+ topic/ph pr-d/codeph ">IME.isSupported</codeph> property. See 
	 * <xref href="http://help.adobe.com/en_US/air/build/WS144092a96ffef7cc16ddeea2126bb46b82f-8000.html" class="- topic/xref ">
	 * AIR Profile Support</xref> for more information regarding API support across multiple profiles.</p><p class="- topic/p ">IMEs let users type non-ASCII text characters in multibyte languages
	 * such as Chinese, Japanese, and Korean. For more information on working with IMEs, see the 
	 * documentation for the operating system for which you are developing applications.
	 * For additional resources, see the following websites:
	 * <ul class="- topic/ul "><li class="- topic/li "><xref href="http://www.microsoft.com/globaldev/default.mspx" scope="external" class="- topic/xref ">http://www.microsoft.com/globaldev/default.mspx</xref></li><li class="- topic/li "><xref href="http://developer.apple.com/documentation/" scope="external" class="- topic/xref ">http://developer.apple.com/documentation/</xref></li><li class="- topic/li "><xref href="http://java.sun.com" scope="external" class="- topic/xref ">http://java.sun.com</xref></li></ul></p><p class="- topic/p ">If an IME is not active on the user's computer, calls to IME methods or properties, 
	 * other than <codeph class="+ topic/ph pr-d/codeph ">Capabilities.hasIME</codeph>, will fail. Once you manually activate an IME, subsequent ActionScript 
	 * calls to IME methods and properties will work as expected. For example, if you are using a
	 * Japanese IME, it must be activated before any IME method or property is called.</p><p class="- topic/p ">The following table shows the platform coverage of this class:</p><adobetable class="innertable"><tgroup cols="4" class="- topic/tgroup "><thead class="- topic/thead "><row class="- topic/row "><entry class="- topic/entry ">Capability</entry><entry class="- topic/entry ">Windows</entry><entry class="- topic/entry ">Mac OSX</entry><entry class="- topic/entry ">Linux</entry></row></thead><tbody class="- topic/tbody "><row class="- topic/row "><entry class="- topic/entry ">Determine whether the IME is installed: <codeph class="+ topic/ph pr-d/codeph ">Capabilities.hasIME</codeph></entry><entry class="- topic/entry ">Yes</entry><entry class="- topic/entry ">Yes</entry><entry class="- topic/entry ">Yes</entry></row><row class="- topic/row "><entry class="- topic/entry ">Set IME on or off: <codeph class="+ topic/ph pr-d/codeph ">IME.enabled</codeph></entry><entry class="- topic/entry ">Yes</entry><entry class="- topic/entry ">Yes</entry><entry class="- topic/entry ">Yes</entry></row><row class="- topic/row "><entry class="- topic/entry ">Find out whether IME is on or off: <codeph class="+ topic/ph pr-d/codeph ">IME.enabled</codeph></entry><entry class="- topic/entry ">Yes</entry><entry class="- topic/entry ">Yes</entry><entry class="- topic/entry ">Yes</entry></row><row class="- topic/row "><entry class="- topic/entry ">Get or set IME conversion mode: <codeph class="+ topic/ph pr-d/codeph ">IME.conversionMode</codeph></entry><entry class="- topic/entry ">Yes</entry><entry class="- topic/entry ">Yes ~~~~</entry><entry class="- topic/entry ">No</entry></row><row class="- topic/row "><entry class="- topic/entry ">Send IME the string to be converted: <codeph class="+ topic/ph pr-d/codeph ">IME.setCompositionString()</codeph></entry><entry class="- topic/entry ">Yes ~~</entry><entry class="- topic/entry ">No</entry><entry class="- topic/entry ">No</entry></row><row class="- topic/row "><entry class="- topic/entry ">Get from IME the original string before conversion: <codeph class="+ topic/ph pr-d/codeph ">System.ime.addEventListener()</codeph></entry><entry class="- topic/entry ">Yes ~~</entry><entry class="- topic/entry ">No</entry><entry class="- topic/entry ">No</entry></row><row class="- topic/row "><entry class="- topic/entry ">Send request to convert to IME: <codeph class="+ topic/ph pr-d/codeph ">IME.doConversion()</codeph></entry><entry class="- topic/entry ">Yes ~~</entry><entry class="- topic/entry ">No</entry><entry class="- topic/entry ">No</entry></row></tbody></tgroup></adobetable><p class="- topic/p ">~~ Not all Windows IMEs support all of these operations. The only IME
	 * that supports them all is the Japanese IME.</p><p class="- topic/p ">~~~~ On the Macintosh, only the Japanese IME supports these methods, and third-party IMEs do not support them.</p><p class="- topic/p ">The ActionScript 3.0 version of this class does not support Macintosh Classic.</p>
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 */
	public final class IME extends EventDispatcher
	{
		/**
		 * The conversion mode of the current IME.
		 * Possible values are IME mode string constants that indicate the conversion mode:
		 * ALPHANUMERIC_FULLALPHANUMERIC_HALFCHINESEJAPANESE_HIRAGANAJAPANESE_KATAKANA_FULLJAPANESE_KATAKANA_HALFKOREANUNKNOWN (read-only value; this value cannot be set)
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @throws	Error A set attempt was not successful.
		 */
		public static function get conversionMode () : String{
			return null;
		}
		public static function set conversionMode (mode:String) : void{
			
		}

		/**
		 * Indicates whether the system IME is enabled (true) or disabled (false). 
		 * An enabled IME performs multibyte input; a disabled IME performs alphanumeric input.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @throws	Error A set attempt was not successful.
		 */
		public static function get enabled () : Boolean{
			return false;
		}
		public static function set enabled (enabled:Boolean) : void{
			
		}

		/**
		 * The isSupported property is set to true if the IME class is 
		 * available on the current platform, otherwise it is set to false.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public static function get isSupported () : Boolean{
			return false;
		}

		/**
		 * Causes the runtime to abandon any composition that is in progress. Call this method when the user clicks 
		 * outside of the composition area or when the interactive object that has focus is being destroyed or reset. 
		 * The runtime confirms the composition by calling confirmComposition() in the client. The
		 * runtime also resets the IME to inform the operating system that the composition has been abandoned.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public static function compositionAbandoned () : void{
			
		}

		/**
		 * Call this method when the selection within the composition has been updated, either interactively or 
		 * programmatically.
		 * @param	start	Specifies the offset in bytes of the start of the selection.
		 * @param	end	Specifies the offset in bytes of the end of the selection.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public static function compositionSelectionChanged (start:int, end:int) : void{
			
		}

		/**
		 * Instructs the IME to select the first candidate for the current composition string.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @throws	Error The call was not successful.
		 */
		public static function doConversion () : void{
			
		}

		public function IME (){
			
		}

		/**
		 * Sets the IME composition string. When this string is set, the user 
		 * can select IME candidates before committing the result to the text 
		 * field that currently has focus.
		 * If no text field has focus, this method fails and throws an error.
		 * @param	composition	The string to send to the IME.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * 	Need some examples of valid values for the param composition.
		 * @throws	Error The call is not successful.
		 */
		public static function setCompositionString (composition:String) : void{
			
		}
	}
}
