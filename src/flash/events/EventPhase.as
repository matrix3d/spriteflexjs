//
// D:\sdk\airsdk24\frameworks\libs\player\18.0\playerglobal.swc\flash\events\EventPhase
//
package flash.events
{
	/**
	 * The EventPhase class provides values for the <codeph class="+ topic/ph pr-d/codeph ">eventPhase</codeph> property of the Event class.
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 * @playerversion	Lite 4
	 */
	public final class EventPhase extends Object
	{
		/**
		 * The target phase, which is the second phase of the event flow.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public static const AT_TARGET : uint = 2;

		/**
		 * The bubbling phase, which is the third phase of the event flow.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public static const BUBBLING_PHASE : uint = 3;

		/**
		 * The capturing phase, which is the first phase of the event flow.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public static const CAPTURING_PHASE : uint = 1;

		public function EventPhase ();
	}
}
