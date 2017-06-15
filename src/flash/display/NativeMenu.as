package flash.display
{
	import flash.events.EventDispatcher;

	/**
	 * Dispatched by the NativeMenu object when a key equivalent is pressed and immediately before the menu is displayed.
	 * @eventType	flash.events.Event.PREPARING
	 */
	[Event(name="preparing", type="flash.events.Event")] 

	/**
	 * Dispatched by this NativeMenu object immediately before the 
	 * menu is displayed.
	 * @eventType	flash.events.Event.DISPLAYING
	 */
	[Event(name="displaying", type="flash.events.Event")] 

	/**
	 * Dispatched by this NativeMenu object when one of its menu items or an item 
	 * in one of its descendant submenus is selected.
	 * @eventType	flash.events.Event.SELECT
	 */
	[Event(name="select", type="flash.events.Event")] 

	/**
	 * The NativeMenu class contains methods and properties for defining native menus.
	 * 
	 *   <p class="- topic/p "><i class="+ topic/ph hi-d/i ">AIR profile support:</i> This feature is supported 
	 * on all desktop operating systems, but is not supported on mobile devices or AIR for TV devices. You can test 
	 * for support at run time using the <codeph class="+ topic/ph pr-d/codeph ">NativeMenu.isSupported</codeph> property. See 
	 * <xref href="http://help.adobe.com/en_US/air/build/WS144092a96ffef7cc16ddeea2126bb46b82f-8000.html" class="- topic/xref ">
	 * AIR Profile Support</xref> for more information regarding API support across multiple profiles.</p><p class="- topic/p ">A native menu is a menu that is controlled and drawn by the operating system rather than by your application. 
	 * AIR supports the following types of native menus:</p><ul class="- topic/ul "><li class="- topic/li "><b class="+ topic/ph hi-d/b ">Application menus</b> are supported on OS X. Use the <codeph class="+ topic/ph pr-d/codeph ">NativeApplication.supportsMenu</codeph> property to test whether 
	 * application menus are supported on the host operating system. An application menu is displayed on the Menu bar at the top of the 
	 * Mac desktop. OS X provides a default menu for every application, but many of the menu commands are not functional. You can add
	 * event listeners to the default items, replace individual menus and items, or even replace the default menu entirely.
	 * Access the application menu object using the NativeApplication <codeph class="+ topic/ph pr-d/codeph ">menu</codeph> property.</li><li class="- topic/li "><b class="+ topic/ph hi-d/b ">Window menus</b> are supported on Windows and Linux. Use the <codeph class="+ topic/ph pr-d/codeph ">NativeWindow.supportsMenu</codeph> property to
	 * test whether window menus are supported on the host operating system. A window menu is displayed below the window title bar. The area
	 * occupied by the menu is not part of the window stage. Applications cannot draw into this area. Assign a menu to a window using the 
	 * NativeWindow <codeph class="+ topic/ph pr-d/codeph ">menu</codeph> property.</li><li class="- topic/li "><b class="+ topic/ph hi-d/b ">Dock icon menus</b> are supported on OS X. Use the <codeph class="+ topic/ph pr-d/codeph ">NativeApplication.supportsDockIcon</codeph> property to test whether
	 * dock icons are supported on the host operating system. Items in a dock icon menu are displayed above the default items provided by
	 * the operating system. The default items cannot be accessed by application code. Assign a menu to the <codeph class="+ topic/ph pr-d/codeph ">menu</codeph> property of
	 * the application's DockIcon object.</li><li class="- topic/li "><b class="+ topic/ph hi-d/b ">System tray icon menus</b> are supported on Windows and most Linux operating systems. Use the 
	 * <codeph class="+ topic/ph pr-d/codeph ">NativeApplication.supportsSystemTrayIcon</codeph> property to test whether system tray icons are supported on the host
	 * operating system. A system tray icon menu is displayed in response to a right-click on the icon, in much the same fashion as
	 * a context menu. Assign a menu to the <codeph class="+ topic/ph pr-d/codeph ">menu</codeph> property of the application's SystemTrayIcon object.</li><li class="- topic/li "><b class="+ topic/ph hi-d/b ">Context menus</b> are supported on all operating systems. Context menus are displayed in response to a user interface event, 
	 * such as a right-click or a command-click on an InteractiveObject displayed in the application. The UI mechanism for showing the menu
	 * varies by host operating system and hardware. Assign a menu to the <codeph class="+ topic/ph pr-d/codeph ">contextMenu</codeph> property of an
	 * InteractiveObject. In AIR, a context menu can be created with either the NativeMenu class or the ContextMenu class. In
	 * Flash Player, only the ContextMenu class can be used. ContextMenus in AIR do not have built-in items; a default context menu is
	 * not displayed.</li><li class="- topic/li "><b class="+ topic/ph hi-d/b ">Pop-up menus</b> are supported on all operating systems. Pop-up menus are functionally the same as context menus, but
	 * are displayed using the menu <codeph class="+ topic/ph pr-d/codeph ">display()</codeph> method rather than as a response to a user interface event. A pop-up
	 * menu is not attached to any other object. Simply create the native menu and call the <codeph class="+ topic/ph pr-d/codeph ">display()</codeph> method.</li></ul><p class="- topic/p ">A menu object contains menu items. A menu item can represent a command, a submenu, or a separator line.
	 * Add menu items to a menu using the <codeph class="+ topic/ph pr-d/codeph ">addItem()</codeph> or <codeph class="+ topic/ph pr-d/codeph ">addItemAt()</codeph> method. The display order of the menu items 
	 * matches the order of the items in the menu's <codeph class="+ topic/ph pr-d/codeph ">items</codeph> array.</p><p class="- topic/p ">To create a submenu, add a menu item to the parent menu object. Assign the menu object representing 
	 * the submenu to the <codeph class="+ topic/ph pr-d/codeph ">submenu</codeph> property of the matching menu item in the parent menu.</p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Note:</b> The root menu of window and application menus must contain only submenu items; items
	 * that do not represent submenus may not be displayed and are contrary to user expectation for
	 * these types of menus.</p><p class="- topic/p ">Menus dispatch <codeph class="+ topic/ph pr-d/codeph ">select</codeph> events when a command item in the menu or one of its
	 * submenus is selected. (Submenu and separator items are not selectable.) The
	 * <codeph class="+ topic/ph pr-d/codeph ">target</codeph> property of the event object references the 
	 * selected item.</p><p class="- topic/p ">Menus dispatch <codeph class="+ topic/ph pr-d/codeph ">preparing</codeph> events just before the menu is displayed and when a key equivalent attached
	 * to one of the items in the menu is pressed. You
	 * can use this event to update the contents of the menu based on the current 
	 * state of the application.</p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Note:</b> If you are using the Flex Framework, consider using the FlexNativeMenu class. 
	 * It is typically easier to define menus declaratively in MXML than it is to write ActionScript code to create the menu 
	 * structure item-by-item.</p>
	 * @langversion	3.0
	 * @playerversion	AIR 1.0
	 */
	public class NativeMenu extends EventDispatcher
	{
		/**
		 * Creates a new NativeMenu object.
		 * @langversion	3.0
		 * @playerversion	AIR 1.0
		 */
		public function NativeMenu()
		{
			
		}
	}
}
