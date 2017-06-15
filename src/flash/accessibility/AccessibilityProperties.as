//
// F:\flexjssdk\frameworks\libs\player\22.0\playerglobal.swc\flash\accessibility\AccessibilityProperties
//
package flash.accessibility
{
	/**
	 * The AccessibilityProperties class lets you control the presentation of Flash objects to accessibility
	 * aids, such as screen readers.
	 * 
	 *   <p class="- topic/p ">You can attach an AccessibilityProperties object to any display object, but Flash Player will read
	 * your AccessibilityProperties object only for certain kinds of objects: entire
	 * SWF files (as represented by <codeph class="+ topic/ph pr-d/codeph ">DisplayObject.root</codeph>), container objects
	 * (<codeph class="+ topic/ph pr-d/codeph ">DisplayObjectContainer</codeph> and subclasses), buttons
	 * (<codeph class="+ topic/ph pr-d/codeph ">SimpleButton</codeph> and subclasses), and text (<codeph class="+ topic/ph pr-d/codeph ">TextField</codeph> and subclasses).</p><p class="- topic/p ">The <codeph class="+ topic/ph pr-d/codeph ">name</codeph> property of these objects is the most important property to specify because
	 * accessibility aids provide the names of objects to users as a basic means of navigation.  Do not
	 * confuse <codeph class="+ topic/ph pr-d/codeph ">AccessibilityProperties.name</codeph> with <codeph class="+ topic/ph pr-d/codeph ">DisplayObject.name</codeph>; these are
	 * separate and unrelated.  The <codeph class="+ topic/ph pr-d/codeph ">AccessibilityProperties.name</codeph> property is a name 
	 * that is read aloud by the accessibility aids, whereas <codeph class="+ topic/ph pr-d/codeph ">DisplayObject.name</codeph> is essentially a
	 * variable name visible only to ActionScript code.</p><p class="- topic/p ">In Flash Professional, the properties of <codeph class="+ topic/ph pr-d/codeph ">AccessibilityProperties</codeph> objects override
	 * the corresponding settings available in the Accessibility panel during authoring.</p><p class="- topic/p ">To determine whether Flash Player is running in an environment that supports accessibility aids, use 
	 * the <codeph class="+ topic/ph pr-d/codeph ">Capabilities.hasAccessibility</codeph> property.  If you modify AccessibilityProperties
	 * objects, you need to call the <codeph class="+ topic/ph pr-d/codeph ">Accessibility.updateProperties()</codeph> method for the changes to
	 * take effect.</p>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example uses the <codeph class="+ topic/ph pr-d/codeph ">AccessibilityExample</codeph>,
	 * <codeph class="+ topic/ph pr-d/codeph ">CustomAccessibleButton</codeph>, <codeph class="+ topic/ph pr-d/codeph ">CustomSimpleButton</codeph>, and <codeph class="+ topic/ph pr-d/codeph ">ButtonDisplayState</codeph> classes
	 * to create an accessibility-compliant menu that works with common screen readers. The main
	 * functionality of the <codeph class="+ topic/ph pr-d/codeph ">AccessibilityProperties</codeph> class is as follows:
	 * 
	 *   <ol TYPE="1" class="- topic/ol "><li class="- topic/li "> Call <codeph class="+ topic/ph pr-d/codeph ">configureAssets</codeph>, which creates a custom button and sets its label and 
	 * description. These are the values that the screen reader conveys to the end user.</li><li class="- topic/li ">Call <codeph class="+ topic/ph pr-d/codeph ">setTimeOut()</codeph> to ensure that Flash Player has enough time to detect the 
	 * screen reader before updating the properties.</li></ol><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Note:</b> Call <codeph class="+ topic/ph pr-d/codeph ">setTimeout()</codeph> before checking <codeph class="+ topic/ph pr-d/codeph ">Accessibility.active</codeph>.
	 * to give Flash Player the 2 seconds it needs to connect to a screen reader,
	 * if one is available. If you do not provide a sufficient delay time, the <codeph class="+ topic/ph pr-d/codeph ">setTimeout</codeph> call might return <codeph class="+ topic/ph pr-d/codeph ">false</codeph>, even
	 * if a screen reader is available.</p><p class="- topic/p ">The following example processes the <codeph class="+ topic/ph pr-d/codeph ">Accessibility.updateProperties()</codeph>
	 * method only if the call to <codeph class="+ topic/ph pr-d/codeph ">Accessibility.active</codeph> returns <codeph class="+ topic/ph pr-d/codeph ">true</codeph>, which 
	 * occurs only if Flash Player is currently connected to an active screen reader. If <codeph class="+ topic/ph pr-d/codeph ">updateProperties</codeph>
	 * is called without an active screen reader, it throws an <codeph class="+ topic/ph pr-d/codeph ">IllegalOperationError</codeph> exception.</p><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * package {
	 * import flash.display.Sprite;
	 * import flash.accessibility.Accessibility;
	 * import flash.utils.setTimeout;
	 * 
	 *   public class AccessibilityPropertiesExample extends Sprite {
	 * public static const BUTTON_WIDTH:uint = 90;
	 * public static const BUTTON_HEIGHT:uint = 20;
	 * 
	 *   private var gutter:uint = 5;
	 * private var menuLabels:Array = new Array("PROJECTS", "PORTFOLIO", "CONTACT");
	 * private var menuDescriptions:Array = new Array("Learn more about our projects"
	 * , "See our portfolio"
	 * , "Get in touch with our team");
	 * 
	 *   public function AccessibilityPropertiesExample() {
	 * configureAssets();
	 * setTimeout(updateAccessibility, 2000); 
	 * }
	 * 
	 *   private function updateAccessibility():void {
	 * trace("Accessibility.active: " + Accessibility.active);
	 * if(Accessibility.active) {
	 * Accessibility.updateProperties();
	 * }
	 * }
	 * 
	 *   private function configureAssets():void {
	 * var child:CustomAccessibleButton;
	 * for(var i:uint; i &lt; menuLabels.length; i++) {
	 * child = new CustomAccessibleButton();
	 * child.y = (numChildren * (BUTTON_HEIGHT + gutter));
	 * child.setLabel(menuLabels[i]);
	 * child.setDescription(menuDescriptions[i]);
	 * addChild(child);
	 * }
	 * }
	 * }
	 * 
	 *   import flash.accessibility.AccessibilityProperties;
	 * import flash.display.Shape;
	 * import flash.display.SimpleButton;
	 * import flash.display.Sprite;
	 * import flash.events.Event;
	 * import flash.text.TextFormat;
	 * import flash.text.TextField;
	 * 
	 *   class CustomAccessibleButton extends Sprite {
	 * private var button:SimpleButton;
	 * private var label1:TextField;
	 * private var description:String;
	 * private var _name:String;
	 * 
	 *   public function CustomAccessibleButton(_width:uint = 0, _height:uint = 0) {
	 * _width = (_width == 0) ? AccessibilityPropertiesExample.BUTTON_WIDTH:_width;
	 * _height = (_height == 0) ? AccessibilityPropertiesExample.BUTTON_HEIGHT:_height;
	 * 
	 *   button = buildButton(_width, _height);
	 * label1 = buildLabel(_width, _height);
	 * 
	 *   addEventListener(Event.ADDED, addedHandler);
	 * }
	 * 
	 *   private function addedHandler(event:Event):void {
	 * trace("addedHandler: " + name);
	 * var accessProps:AccessibilityProperties = new AccessibilityProperties();
	 * accessProps.name = this._name;
	 * accessProps.description = description;
	 * accessibilityProperties = accessProps;
	 * removeEventListener(Event.ADDED, addedHandler);
	 * }
	 * 
	 *   private function buildButton(_width:uint, _height:uint):SimpleButton {
	 * var child:SimpleButton = new CustomSimpleButton(_width, _height);
	 * addChild(child);
	 * return child;
	 * }
	 * 
	 *   private function buildLabel(_width:uint, _height:uint):TextField {
	 * var format:TextFormat = new TextFormat();
	 * format.font = "Verdana";
	 * format.size = 11;
	 * format.color = 0xFFFFFF;
	 * format.align = TextFormatAlign.CENTER;
	 * format.bold = true;
	 * 
	 *   var child:TextField = new TextField();
	 * child.y = 1;
	 * child.width = _width;
	 * child.height = _height;
	 * child.selectable = false;
	 * child.defaultTextFormat = format;
	 * child.mouseEnabled = false;
	 * 
	 *   addChild(child);
	 * return child;
	 * }
	 * 
	 *   public function setLabel(text:String):void {
	 * label1.text = text;
	 * this._name = text;
	 * }
	 * 
	 *   public function setDescription(text:String):void {
	 * description = text;
	 * }
	 * }
	 * 
	 *   class CustomSimpleButton extends SimpleButton {
	 * private var upColor:uint = 0xFFCC00;
	 * private var overColor:uint = 0xCCFF00;
	 * private var downColor:uint = 0x00CCFF;
	 * 
	 *   public function CustomSimpleButton(_width:uint, _height:uint) {
	 * downState = new ButtonDisplayState(downColor, _width, _height);
	 * overState = new ButtonDisplayState(overColor, _width, _height);
	 * upState = new ButtonDisplayState(upColor, _width, _height);
	 * hitTestState = new ButtonDisplayState(upColor, _width, _height);
	 * useHandCursor = true;
	 * }        
	 * }
	 * 
	 *   class ButtonDisplayState extends Shape {
	 * private var bgColor:uint;
	 * private var _width:uint;
	 * private var _height:uint;
	 * 
	 *   public function ButtonDisplayState(bgColor:uint, _width:uint, _height:uint) {
	 * this.bgColor = bgColor;
	 * this._width = _width;
	 * this._height = _height;
	 * draw();
	 * }
	 * 
	 *   private function draw():void {
	 * graphics.beginFill(bgColor);
	 * graphics.drawRect(0, 0, _width, _height);
	 * graphics.endFill();
	 * }
	 * }
	 * }
	 * </codeblock>
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 */
	public class AccessibilityProperties extends Object
	{
		/**
		 * Provides a description for this display object in the accessible presentation.
		 * If you have a lot of information to present about the object, it is
		 * best to choose a concise name and put most of your content in the
		 * description property. 
		 * Applies to whole SWF files, containers, buttons, and text. The default value
		 * is an empty string.
		 * In Flash Professional, this property corresponds to the Description field in the Accessibility panel.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public var description:String;

		/**
		 * If true, causes Flash Player to exclude child objects within this
		 * display object from the accessible presentation.  
		 * The default is false. Applies to whole SWF files and containers.
		 * @playerversion	Flash 9
		 */
		public var forceSimple:Boolean;

		/**
		 * Provides a name for this display object in the accessible presentation. 
		 * Applies to whole SWF files, containers, buttons, and text.  Do not confuse with
		 * DisplayObject.name, which is unrelated. The default value
		 * is an empty string.
		 * In Flash Professional, this property corresponds to the Name field in the Accessibility panel.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public var name:String;

		/**
		 * If true, disables the Flash Player default auto-labeling system.
		 * Auto-labeling causes text objects inside buttons to be treated as button names,
		 * and text objects near text fields to be treated as text field names.
		 * The default is false. Applies only to whole SWF files.
		 * The noAutoLabeling property value is ignored unless you specify it before the
		 * first time an accessibility aid examines your SWF file. If you plan to set 
		 * noAutoLabeling to true, you should do so as early as 
		 * possible in your code.
		 * @playerversion	Flash 9
		 */
		public var noAutoLabeling:Boolean;

		/**
		 * Indicates a keyboard shortcut associated with this display object. 
		 * Supply this string only for UI controls that you have associated with a shortcut key. 
		 * Applies to containers, buttons, and text.  The default value
		 * is an empty string.
		 * 
		 *   Note: Assigning this property does not automatically assign the specified key
		 * combination to this object; you must do that yourself, for example, by
		 * listening for a KeyboardEvent.The syntax for this string uses long names for modifier keys, and
		 * the plus(+) character to indicate key combination. Examples of valid strings are
		 * "Ctrl+F", "Ctrl+Shift+Z", and so on.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public var shortcut:String;

		/**
		 * If true, excludes this display object from accessible presentation.
		 * The default is false. Applies to whole SWF files, containers, buttons, and text.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public var silent:Boolean;

		/**
		 * Creates a new AccessibilityProperties object.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function AccessibilityProperties();
	}
}
