package flash.ui
{
	import flash.display.NativeMenu;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.net.URLRequest;
	import flash.ui.ContextMenuClipboardItems;
	import flash.ui.ContextMenu;

	/**
	 * Dispatched when a user first generates a 
	 * context menu but before the contents of the context menu are displayed.
	 * @eventType	flash.events.ContextMenuEvent.MENU_SELECT
	 */
	[Event(name="menuSelect", type="flash.events.ContextMenuEvent")] 

	/**
	 * The ContextMenu class provides control over the items displayed in context menus.
	 * 
	 *   <p class="- topic/p "><b class="+ topic/ph hi-d/b ">Mobile Browser Support:</b> This class is not supported in mobile browsers.</p><p class="- topic/p "><i class="+ topic/ph hi-d/i ">AIR profile support:</i> This feature is not supported 
	 * on mobile devices or AIR for TV devices. See 
	 * <xref href="http://help.adobe.com/en_US/air/build/WS144092a96ffef7cc16ddeea2126bb46b82f-8000.html" class="- topic/xref ">
	 * AIR Profile Support</xref> for more information regarding API support across multiple profiles.</p><p class="- topic/p ">In Flash Player, users open the context menu by right-clicking (Windows or Linux) or Control-clicking 
	 * (Macintosh) Flash Player. You can use the methods and properties of the ContextMenu class to 
	 * add custom menu items, control the display of the built-in context menu items (for example, Zoom In, 
	 * and Print), or create copies of menus. In AIR, there are no built-in items and no standard context menu.</p><p class="- topic/p ">In Flash Professional, you can attach a ContextMenu object to a specific button, movie clip, or text
	 * field object, or to an entire movie level. You use the <codeph class="+ topic/ph pr-d/codeph ">contextMenu</codeph> property of the InteractiveObject
	 * class to do this.</p><p class="- topic/p ">In Flex or Flash Builder, only top-level components in the application can have context menus.
	 * For example, if a DataGrid control is a child of a TabNavigator or VBox container, the DataGrid control
	 * cannot have its own context menu.</p><p class="- topic/p ">To add new items to a ContextMenu object, you create a ContextMenuItem object, and then add that
	 * object to the <codeph class="+ topic/ph pr-d/codeph ">ContextMenu.customItems</codeph> array. For more information about creating context
	 * menu items, see the ContextMenuItem class entry.</p><p class="- topic/p ">Flash Player has three types of context menus: the standard menu (which appears when you right-click
	 * in Flash Player), the edit menu (which appears when you right-click a selectable or editable text
	 * field), and an error menu (which appears when a SWF file has failed to load into Flash Player). Only the
	 * standard and edit menus can be modified with the ContextMenu class. Only the edit menu appears in AIR.</p><p class="- topic/p ">Custom menu items always appear at the top of the Flash Player context menu, above any visible
	 * built-in menu items; a separator bar distinguishes built-in and custom menu items. You cannot remove the 
	 * Settings menu item from the context menu.
	 * The Settings menu item is required in Flash so that users can access the settings that affect privacy and
	 * storage on their computers. You also cannot remove the About menu item, which is
	 * required so that users can find out what version of Flash Player they are using. (In AIR, the built-in 
	 * Settings and About menu items are not used.)</p><p class="- topic/p ">You can add no more than 15 custom items to a context menu in Flash Player. In AIR, there is no explicit 
	 * limit imposed on the number of items in a context menu.</p><p class="- topic/p ">You must use the <codeph class="+ topic/ph pr-d/codeph ">ContextMenu()</codeph> constructor to create a ContextMenu object before
	 * calling its methods.</p>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example uses the class <codeph class="+ topic/ph pr-d/codeph ">ContextMenuExample</codeph> 
	 * to remove the default context menu items from the Stage and add a new menu item, which, if
	 * clicked, changes the color of a square on the Stage.  This is accomplished with the following
	 * steps:
	 * <ol class="- topic/ol "><li class="- topic/li ">A property <codeph class="+ topic/ph pr-d/codeph ">myContextMenu</codeph> is declared and then assigned to a new ContextMenu
	 * object and a property <codeph class="+ topic/ph pr-d/codeph ">redRectangle</codeph> of type Sprite is declared.</li><li class="- topic/li ">The method <codeph class="+ topic/ph pr-d/codeph ">removeDefaultItems()</codeph> is called, which removes all built-in context
	 * menu items except Print.</li><li class="- topic/li ">The method <codeph class="+ topic/ph pr-d/codeph ">addCustomMenuItems()</codeph> is called, which places a menu item called 
	 * <codeph class="+ topic/ph pr-d/codeph ">Red to Black</codeph> menu selection into the <codeph class="+ topic/ph pr-d/codeph ">defaultItems</codeph> array by using the 
	 * <codeph class="+ topic/ph pr-d/codeph ">push()</codeph> method of Array.  A <codeph class="+ topic/ph pr-d/codeph ">menuItemSelect</codeph> event listener is added to the 
	 * ContextMenuItem object and the associated method is called <codeph class="+ topic/ph pr-d/codeph ">menuItemSelectHandler()</codeph>.  
	 * This method prints out some statements using <codeph class="+ topic/ph pr-d/codeph ">trace()</codeph> whenever the 
	 * context menu is accessed and <codeph class="+ topic/ph pr-d/codeph ">Red to Black</codeph> is selected.  Also the red square
	 * is removed and replaced with a black one.</li><li class="- topic/li ">An event listener of type <codeph class="+ topic/ph pr-d/codeph ">menuSelect</codeph> is added, along with
	 * the associated method <codeph class="+ topic/ph pr-d/codeph ">menuSelectHandler</codeph>, which simply prints out three statements using
	 * <codeph class="+ topic/ph pr-d/codeph ">trace()</codeph> every time an item in the context menu is opened.</li><li class="- topic/li ">Then <codeph class="+ topic/ph pr-d/codeph ">addChildren()</codeph> draws a red square and adds it
	 * to the display list, where it is immediately displayed.</li><li class="- topic/li ">Finally, <codeph class="+ topic/ph pr-d/codeph ">myContextMenu</codeph> is assigned to the context menu of the <codeph class="+ topic/ph pr-d/codeph ">redRectangle</codeph> sprite
	 * so that the custom context menu is displayed only when the mouse pointer is over the square.</li></ol><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * package {
	 * import flash.ui.ContextMenu;
	 * import flash.ui.ContextMenuItem;
	 * import flash.ui.ContextMenuBuiltInItems;
	 * import flash.events.ContextMenuEvent;
	 * import flash.display.Sprite;
	 * import flash.display.Shape;
	 * import flash.text.TextField;
	 * 
	 *   public class ContextMenuExample extends Sprite {
	 * private var myContextMenu:ContextMenu;
	 * private var menuLabel:String = "Reverse Colors";
	 * private var textLabel:String = "Right Click";
	 * private var redRectangle:Sprite;
	 * private var label:TextField;
	 * private var size:uint = 100;
	 * private var black:uint = 0x000000;
	 * private var red:uint = 0xFF0000;
	 * 
	 *   public function ContextMenuExample() {
	 * myContextMenu = new ContextMenu();
	 * removeDefaultItems();
	 * addCustomMenuItems();
	 * myContextMenu.addEventListener(ContextMenuEvent.MENU_SELECT, menuSelectHandler);
	 * 
	 *   addChildren();
	 * redRectangle.contextMenu = myContextMenu;
	 * }
	 * 
	 *   private function addChildren():void {
	 * redRectangle = new Sprite();
	 * redRectangle.graphics.beginFill(red);
	 * redRectangle.graphics.drawRect(0, 0, size, size);
	 * addChild(redRectangle);
	 * redRectangle.x = size;
	 * redRectangle.y = size;
	 * label = createLabel();
	 * redRectangle.addChild(label);
	 * }
	 * 
	 *   private function removeDefaultItems():void {
	 * myContextMenu.hideBuiltInItems();
	 * var defaultItems:ContextMenuBuiltInItems = myContextMenu.builtInItems;
	 * defaultItems.print = true;
	 * }
	 * 
	 *   private function addCustomMenuItems():void {
	 * var item:ContextMenuItem = new ContextMenuItem(menuLabel);
	 * myContextMenu.customItems.push(item);
	 * item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
	 * }
	 * 
	 *   private function menuSelectHandler(event:ContextMenuEvent):void {
	 * trace("menuSelectHandler: " + event);
	 * }
	 * 
	 *   private function menuItemSelectHandler(event:ContextMenuEvent):void {
	 * trace("menuItemSelectHandler: " + event);
	 * var textColor:uint = (label.textColor == black) ? red : black;
	 * var bgColor:uint = (label.textColor == black) ? black : red;
	 * redRectangle.graphics.clear();
	 * redRectangle.graphics.beginFill(bgColor);
	 * redRectangle.graphics.drawRect(0, 0, size, size);
	 * label.textColor = textColor;
	 * }
	 * 
	 *   private function createLabel():TextField {
	 * var txtField:TextField = new TextField();
	 * txtField.text = textLabel;
	 * return txtField;
	 * }
	 * }
	 * }
	 * </codeblock>
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 */
	public final class ContextMenu extends NativeMenu
	{
		private var _builtInItems:ContextMenuBuiltInItems;
		private var _clipboardItems:ContextMenuClipboardItems;
		private var _clipboardMenu:Boolean = false;
		private var _customItems:Array = [];
		private var _link:URLRequest;
		
		private static var _isSupported:Boolean = true;
		/**
		 * An instance of the ContextMenuBuiltInItems class with the following properties: 
		 * forwardAndBack, loop,
		 * play, print, quality,
		 * rewind, save, and zoom.
		 * Setting these properties to false removes the corresponding menu items from the
		 * specified ContextMenu object. These properties are enumerable and are set to true by
		 * default.
		 * 
		 *   Note: In AIR, context menus do not have built-in items.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get builtInItems () : flash.ui.ContextMenuBuiltInItems { return _builtInItems; }
		public function set builtInItems (value:ContextMenuBuiltInItems) : void { _builtInItems = value; }

		/**
		 * An instance of the ContextMenuClipboardItems class with the following properties: 
		 * cut, copy, paste, delete, selectAll.
		 * Setting one of these properties to false disables the corresponding item in the
		 * clipboard menu.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get clipboardItems () : flash.ui.ContextMenuClipboardItems { return _clipboardItems; }
		public function set clipboardItems (value:ContextMenuClipboardItems) : void { _clipboardItems = value; }

		/**
		 * Specifies whether or not the clipboard menu should be used.  If this value is true,
		 * the clipboardItems property determines which items are enabled or disabled on the clipboard menu.
		 * 
		 *   If the link property is non-null, this clipBoardMenu property is ignored.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get clipboardMenu () : Boolean { return _clipboardMenu; }
		public function set clipboardMenu (value:Boolean) : void { _clipboardMenu = value; }

		/**
		 * An array of ContextMenuItem objects. Each object in the array represents a context menu item that you
		 * have defined. Use this property to add, remove, or modify these custom menu items.
		 * 
		 *   To add new menu items, you create a ContextMenuItem object and then add it to the
		 * customItems array (for example, by using Array.push()). For more information about creating
		 * menu items, see the ContextMenuItem class entry.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function get customItems () : Array { return _customItems; }
		public function set customItems (value:Array) : void { _customItems = value; }

		/**
		 * The isSupported property is set to true if the 
		 * ContextMenu class is supported on the current platform, otherwise it is
		 * set to false.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public static function get isSupported():Boolean { return _isSupported; }

		/**
		 * The URLRequest of the link.  If this property is null, a normal context menu is displayed.
		 * If this property is not null, the link context menu is displayed, and operates on the url specified.
		 * 
		 *   If a link is specified, the clipboardMenu property is ignored.The default value is null.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get link ():flash.net.URLRequest { return _link }
		public function set link (value:URLRequest):void { _link = value; }

		/**
		 * Creates a copy of the menu and all items.
		 * @playerversion	AIR 1.0
		 */
		public function clone():flash.display.NativeMenu
		{
			return null;
		}

		/**
		 * Creates a ContextMenu object.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function ContextMenu()
		{
			
		}

		/**
		 * Hides all built-in menu items (except Settings) in the specified ContextMenu object. If the debugger version of Flash
		 * Player is running, the Debugging menu item appears, although it is dimmed for SWF files that
		 * do not have remote debugging enabled.
		 * 
		 *   This method hides only menu items that appear in the standard context menu; it does not affect
		 * items that appear in the edit and error menus. This method works by setting all the Boolean members of my_cm.builtInItems to false. You can selectively make a built-in item visible by setting its
		 * corresponding member in my_cm.builtInItems to true.
		 * Note: In AIR, context menus do not have built-in items. Calling this method will have no effect.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function hideBuiltInItems():void
		{
			
		}
	}
}
