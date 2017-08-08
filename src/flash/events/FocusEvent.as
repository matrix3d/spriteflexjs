//
// D:\sdk\airsdk24\frameworks\libs\player\18.0\playerglobal.swc\flash\events\FocusEvent
//
package flash.events
{
	import flash.display.InteractiveObject;
	import flash.events.Event;

	/// @eventType	flash.events.FocusEvent.FOCUS_IN
	[Event(name="focusIn", type="flash.events.FocusEvent")] 

	/// @eventType	flash.events.FocusEvent.FOCUS_OUT
	[Event(name="focusOut", type="flash.events.FocusEvent")] 

	/// @eventType	flash.events.FocusEvent.KEY_FOCUS_CHANGE
	[Event(name="keyFocusChange", type="flash.events.FocusEvent")] 

	/// @eventType	flash.events.FocusEvent.MOUSE_FOCUS_CHANGE
	[Event(name="mouseFocusChange", type="flash.events.FocusEvent")] 

	/**
	 * An object dispatches a FocusEvent object when the user changes the focus from one object 
	 * in the display list to another. There are four types of focus events:
	 * <ul class="- topic/ul "><li class="- topic/li "><codeph class="+ topic/ph pr-d/codeph ">FocusEvent.FOCUS_IN</codeph></li><li class="- topic/li "><codeph class="+ topic/ph pr-d/codeph ">FocusEvent.FOCUS_OUT</codeph></li><li class="- topic/li "><codeph class="+ topic/ph pr-d/codeph ">FocusEvent.KEY_FOCUS_CHANGE</codeph></li><li class="- topic/li "><codeph class="+ topic/ph pr-d/codeph ">FocusEvent.MOUSE_FOCUS_CHANGE</codeph></li></ul>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example uses the <codeph class="+ topic/ph pr-d/codeph ">FocusEventExample</codeph> and 
	 * <codeph class="+ topic/ph pr-d/codeph ">CustomSprite</codeph> classes to show how focus can be used in conjunction with items drawn on the Stage to capture events and print information.  
	 * This example carries out the following tasks:
	 * <ol class="- topic/ol "><li class="- topic/li ">It declares the properties <codeph class="+ topic/ph pr-d/codeph ">child</codeph> (of type Sprite) and <codeph class="+ topic/ph pr-d/codeph ">childCount</codeph> (of type uint).</li><li class="- topic/li ">A <codeph class="+ topic/ph pr-d/codeph ">for</codeph> loop creates five light blue squares at (0,0). It begins by
	 * assigning <codeph class="+ topic/ph pr-d/codeph ">child</codeph> to a new CustomSprite instance. Each time a CustomSprite
	 * object is created, the following happens:
	 * <ul class="- topic/ul "><li class="- topic/li ">The <codeph class="+ topic/ph pr-d/codeph ">size</codeph> property of type uint is set to 50 pixels and <codeph class="+ topic/ph pr-d/codeph ">bgColor</codeph> is set
	 * to light blue. </li><li class="- topic/li ">The <codeph class="+ topic/ph pr-d/codeph ">buttonMode</codeph> and <codeph class="+ topic/ph pr-d/codeph ">useHandCursor</codeph> properties of the 
	 * Sprite class are set to <codeph class="+ topic/ph pr-d/codeph ">true</codeph> within the constructor.</li><li class="- topic/li ">An event listener of type <codeph class="+ topic/ph pr-d/codeph ">click</codeph> is instantiated, along with the associated subscriber
	 * <codeph class="+ topic/ph pr-d/codeph ">clickHandler()</codeph>.  The subscriber method creates a local variable <codeph class="+ topic/ph pr-d/codeph ">target</codeph> of
	 * type Sprite and assigns it whichever box was clicked. The Stage's focus is then assigned to 
	 * <codeph class="+ topic/ph pr-d/codeph ">target</codeph>.</li><li class="- topic/li ">The <codeph class="+ topic/ph pr-d/codeph ">draw()</codeph> method is called, which creates a 50 x 50 pixel square by
	 * calling the <codeph class="+ topic/ph pr-d/codeph ">beginFill()</codeph>, <codeph class="+ topic/ph pr-d/codeph ">drawRect()</codeph>, and <codeph class="+ topic/ph pr-d/codeph ">endFill()</codeph> methods of 
	 * the Graphics class and the instance properties.</li></ul></li><li class="- topic/li ">In the for loop, the <codeph class="+ topic/ph pr-d/codeph ">configureListeners()</codeph> method is called, which instantiates three event 
	 * listeners/subscribers:
	 * <ul class="- topic/ul "><li class="- topic/li "><codeph class="+ topic/ph pr-d/codeph ">focusIn</codeph>/<codeph class="+ topic/ph pr-d/codeph ">focusInHandler()</codeph> is dispatched after the <codeph class="+ topic/ph pr-d/codeph ">click</codeph> event
	 * for whichever display list object (box) is clicked.</li><li class="- topic/li "><codeph class="+ topic/ph pr-d/codeph ">focusOut</codeph>/<codeph class="+ topic/ph pr-d/codeph ">focusOutHandler()</codeph> is dispatched when another box is clicked or 
	 * if the focus leaves the Stage (for example, by clicking outside Flash Player).</li><li class="- topic/li "><codeph class="+ topic/ph pr-d/codeph ">keyFocusChange</codeph>/<codeph class="+ topic/ph pr-d/codeph ">keyFocusChangeHandler()</codeph> is dispatched if you use the Tab key
	 * or the left-arrow or right-arrow keys to select a display list object. The <codeph class="+ topic/ph pr-d/codeph ">keyFocusChangeHandler()</codeph>
	 * method traps the left-arrow and right-arrow keys, however, and calls the <codeph class="+ topic/ph pr-d/codeph ">preventDefault()</codeph> method
	 * to disable them.</li></ul></li><li class="- topic/li ">In the <codeph class="+ topic/ph pr-d/codeph ">for</codeph> loop, each square is added to the display list and displayed (all in 
	 * the same area) by means of <codeph class="+ topic/ph pr-d/codeph ">addChild()</codeph>.</li><li class="- topic/li ">The constructor then calls <codeph class="+ topic/ph pr-d/codeph ">refreshLayout()</codeph>, which distributes the orange
	 * squares across the top (y = 0) of the display with 5 pixels separating each square.</li></ol><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * package {
	 * import flash.display.Sprite;
	 * import flash.display.DisplayObject;
	 * import flash.events.FocusEvent;
	 * import flash.events.IEventDispatcher;
	 * 
	 *   public class FocusEventExample extends Sprite {
	 * private var gutter:uint = 5;
	 * private var childCount:uint = 5;
	 * 
	 *   public function FocusEventExample() {
	 * var child:Sprite;
	 * for(var i:uint; i &lt; childCount; i++) {
	 * child = new CustomSprite();
	 * configureListeners(child);
	 * addChild(child);
	 * }
	 * refreshLayout();
	 * }
	 * 
	 *   private function configureListeners(dispatcher:IEventDispatcher):void {
	 * dispatcher.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
	 * dispatcher.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
	 * dispatcher.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler);
	 * dispatcher.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler);
	 * }
	 * 
	 *   private function refreshLayout():void {
	 * var ln:uint = numChildren;
	 * var child:DisplayObject = getChildAt(0);
	 * var lastChild:DisplayObject = child;
	 * for(var i:uint = 1; i &lt; ln; i++) {
	 * child = getChildAt(i);
	 * child.x = lastChild.x + lastChild.width + gutter;
	 * lastChild = child;
	 * }
	 * }
	 * 
	 *   private function focusInHandler(event:FocusEvent):void {
	 * var target:CustomSprite = CustomSprite(event.target);
	 * trace("focusInHandler: " + target.name);
	 * }
	 * 
	 *   private function focusOutHandler(event:FocusEvent):void {
	 * var target:CustomSprite = CustomSprite(event.target);
	 * trace("focusOutHandler: " + target.name);
	 * }
	 * 
	 *   private function keyFocusChangeHandler(event:FocusEvent):void {
	 * if(event.keyCode == 39 || event.keyCode == 37){
	 * event.preventDefault()
	 * }
	 * var target:CustomSprite = CustomSprite(event.target);
	 * trace("keyFocusChangeHandler: " + target.name);
	 * }
	 * private function mouseFocusChangeHandler(event:FocusEvent):void {
	 * var target:CustomSprite = CustomSprite(event.target);
	 * trace("mouseFocusChangeHandler: " + target.name);
	 * }
	 * }
	 * }
	 * 
	 *   import flash.display.Sprite;
	 * import flash.events.MouseEvent;
	 * 
	 *   class CustomSprite extends Sprite {
	 * private var size:uint = 50;
	 * private var bgColor:uint = 0x00CCFF;
	 * 
	 *   public function CustomSprite() {
	 * buttonMode = true;
	 * useHandCursor = true;
	 * addEventListener(MouseEvent.CLICK, clickHandler);
	 * draw(size, size);
	 * }
	 * 
	 *   private function draw(w:uint, h:uint):void {
	 * graphics.beginFill(bgColor);
	 * graphics.drawRect(0, 0, w, h);
	 * graphics.endFill();
	 * }
	 * 
	 *   private function clickHandler(event:MouseEvent):void {
	 * var target:Sprite = Sprite(event.target);
	 * trace("clickHandler: " + target.name);
	 * stage.focus = target;
	 * }
	 * }
	 * </codeblock>
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 * @playerversion	Lite 4
	 */
	public class FocusEvent extends Event
	{
		/**
		 * Defines the value of the type property of a focusIn event object. 
		 * This event has the following properties:PropertyValuebubblestruecancelablefalse; there is no default behavior to cancel.currentTargetThe object that is actively processing the Event 
		 * object with an event listener.keyCode0; applies only to keyFocusChange events.relatedObjectThe complementary InteractiveObject instance that is affected by the change in focus.shiftKeyfalse; applies only to keyFocusChange events.targetThe InteractiveObject instance that has just received focus. 
		 * The target is not always the object in the display list 
		 * that registered the event listener. Use the currentTarget 
		 * property to access the object in the display list that is currently processing the event.
		 * directionThe direction from which focus was assigned. This property reports
		 * the value of the direction parameter of the assignFocus() method of the stage. 
		 * If the focus changed through some other means, the value will always be FocusDirection.NONE.
		 * Applies only to focusIn events. For all other focus events the value will be 
		 * FocusDirection.NONE.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public static const FOCUS_IN : String = "focusIn";

		/**
		 * Defines the value of the type property of a focusOut event object. 
		 * This event has the following properties:PropertyValuebubblestruecancelablefalse; there is no default behavior to cancel.currentTargetThe object that is actively processing the Event 
		 * object with an event listener.keyCode0; applies only to keyFocusChange events.relatedObjectThe complementary InteractiveObject instance that is affected by the change in focus.shiftKeyfalse; applies only to keyFocusChange events.targetThe InteractiveObject instance that has just lost focus. 
		 * The target is not always the object in the display list 
		 * that registered the event listener. Use the currentTarget 
		 * property to access the object in the display list that is currently processing the event.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public static const FOCUS_OUT : String = "focusOut";

		/**
		 * Defines the value of the type property of a keyFocusChange event object.
		 * 
		 *   This event has the following properties:PropertyValuebubblestruecancelabletrue; call the preventDefault() method
		 * to cancel default behavior.currentTargetThe object that is actively processing 
		 * the Event 
		 * object with an event listener.keyCodeThe key code value of the key pressed to trigger a keyFocusChange event.relatedObjectThe complementary InteractiveObject instance that is affected by the change in focus.shiftKeytrue if the Shift key modifier is activated; false otherwise.targetThe InteractiveObject instance that currently has focus. 
		 * The target is not always the object in the display list 
		 * that registered the event listener. Use the currentTarget 
		 * property to access the object in the display list that is currently processing the event.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public static const KEY_FOCUS_CHANGE : String = "keyFocusChange";

		/**
		 * Defines the value of the type property of a mouseFocusChange event object. 
		 * This event has the following properties:PropertyValuebubblestruecancelabletrue; call the preventDefault() method 
		 * to cancel default behavior.currentTargetThe object that is actively processing the Event 
		 * object with an event listener.keyCode0; applies only to keyFocusChange events.relatedObjectThe complementary InteractiveObject instance that is affected by the change in focus.shiftKeyfalse; applies only to keyFocusChange events.targetThe InteractiveObject instance that currently has focus. 
		 * The target is not always the object in the display list 
		 * that registered the event listener. Use the currentTarget 
		 * property to access the object in the display list that is currently processing the event.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public static const MOUSE_FOCUS_CHANGE : String = "mouseFocusChange";

		/**
		 * If true, the relatedObject property is set to null for 
		 * reasons related to security sandboxes.  If the nominal value of relatedObject is a reference to a
		 * DisplayObject in another sandbox, relatedObject is set to
		 * null unless there is permission in both directions across this sandbox boundary.  Permission is
		 * established by calling Security.allowDomain() from a SWF file, or by providing
		 * a policy file from the server of an image file, and setting the LoaderContext.checkPolicyFile
		 * property when loading the image.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	Lite 4
		 */
		public function get isRelatedObjectInaccessible () : Boolean{
			return false;
		}
		public function set isRelatedObjectInaccessible (value:Boolean) : void{
			
		}

		/**
		 * The key code value of the key pressed to trigger a keyFocusChange event.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get keyCode () : uint{
			return 0;
		}
		public function set keyCode (value:uint) : void{
		}

		/**
		 * A reference to the complementary InteractiveObject instance that is affected by the
		 * change in focus. For example, when a focusOut event occurs, the
		 * relatedObject represents the InteractiveObject instance that has gained focus.
		 * The value of this property can be null in two circumstances: if there no related object, 
		 * or there is a related object, but it is in a security sandbox to which you don't have access.
		 * Use the isRelatedObjectInaccessible() property to determine which of these reasons applies.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get relatedObject () : flash.display.InteractiveObject{
			return null;
		}
		public function set relatedObject (value:InteractiveObject) : void{
			
		}

		/**
		 * Indicates whether the Shift key modifier is activated, in which case the value is 
		 * true. Otherwise, the value is false. This property is 
		 * used only if the FocusEvent is of type keyFocusChange.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get shiftKey () : Boolean{
			return false;
		}
		public function set shiftKey (value:Boolean) : void{
			
		}

		/**
		 * Creates a copy of the FocusEvent object and sets the value of each property to match that of the original.
		 * @return	A new FocusEvent object with property values that match those of the original.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		override public function clone () : flash.events.Event{
			return null;
		}

		/**
		 * Creates an Event object with specific information relevant to focus events.
		 * Event objects are passed as parameters to event listeners.
		 * @param	type	The type of the event. Possible values are:
		 *   FocusEvent.FOCUS_IN, FocusEvent.FOCUS_OUT, FocusEvent.KEY_FOCUS_CHANGE, and FocusEvent.MOUSE_FOCUS_CHANGE.
		 * @param	bubbles	Determines whether the Event object participates in the bubbling stage of the event flow.
		 * @param	cancelable	Determines whether the Event object can be canceled.
		 * @param	relatedObject	Indicates the complementary InteractiveObject instance that is affected by the change in focus. For example, when a focusIn event occurs, relatedObject represents the InteractiveObject that has lost focus.
		 * @param	shiftKey	Indicates whether the Shift key modifier is activated.
		 * @param	keyCode	Indicates the code of the key pressed to trigger a keyFocusChange event.
		 * @param	direction	Indicates from which direction the target interactive object is being activated. Set to
		 *   FocusDirection.NONE (the default value) for all events other than focusIn.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function FocusEvent (type:String, bubbles:Boolean = true, cancelable:Boolean = false, relatedObject:InteractiveObject = null, shiftKey:Boolean = false, keyCode:uint = 0){
			super(type, bubbles, cancelable);
		}

		/**
		 * Returns a string that contains all the properties of the FocusEvent object. The string is in the following format:
		 * [FocusEvent type=value bubbles=value cancelable=value relatedObject=value shiftKey=value] keyCode=value]
		 * @return	A string that contains all the properties of the FocusEvent object.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		/*public function toString () : String{
			return null;
		}*/
	}
}
