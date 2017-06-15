package flash.ui
{
	import flash.ui.ContextMenuClipboardItems;

	/**
	 * The ContextMenuClipboardItems class lets you enable or disable the commands in the clipboard context menu.
	 * 
	 *   <p class="- topic/p ">Enable or disable the context menu clipboard commands using the <codeph class="+ topic/ph pr-d/codeph ">clipboardItems</codeph> property of
	 * the ContextMenu object. The <codeph class="+ topic/ph pr-d/codeph ">clipboardItems</codeph> property is an instance of this ContextMenuClipboardItems 
	 * class. The clipboard context menu is shown in a context menu when the <codeph class="+ topic/ph pr-d/codeph ">clipboardMenu</codeph> property
	 * of the context menu is <codeph class="+ topic/ph pr-d/codeph ">true</codeph>, unless the context menu is for a TextField object. TextField objects
	 * control the display of the context menu and the state of its clipboard items automatically.</p>
	 * @langversion	3.0
	 * @playerversion	Flash 10
	 * @playerversion	AIR 1.5
	 */
	public final class ContextMenuClipboardItems extends Object
	{
		private var _clear:Boolean = false;
		private var _copy:Boolean = false;
		private var _cut:Boolean = false;
		private var _paste:Boolean = false;
		private var _selectAll:Boolean = false;
		
		/**
		 * Enables or disables the 'Delete' or 'Clear' item on the clipboard menu.
		 * This should be enabled only if an object that can be cleared is selected.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get clear():Boolean { return _clear; }
		public function set clear (val:Boolean):void { _clear = val; }

		/**
		 * Enables or disables the 'Copy' item on the clipboard menu.
		 * This should be enabled only if an object that can be copied is selected.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get copy():Boolean { return _copy; }
		public function set copy (val:Boolean):void { _copy = val; }

		/**
		 * Enables or disables the 'Cut' item on the clipboard menu.
		 * This should be enabled only if an object that can be cut is selected.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get cut():Boolean { return _cut; }
		public function set cut (val:Boolean):void { _cut = val; }

		/**
		 * Enables or disables the 'Paste' item on the clipboard menu.
		 * This should be enabled only if pastable data is on the clipboard.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get paste():Boolean { return _paste; }
		public function set paste (val:Boolean):void { _paste = val; }

		/**
		 * Enables or disables the 'Select All' item on the clipboard menu.
		 * This should only be enabled in a context where a selection can be 
		 * expanded to include all similar items, such as in a list or a text editing control.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function get selectAll():Boolean { return _selectAll; }
		public function set selectAll (val:Boolean):void { _selectAll = val; }

		public function clone():ContextMenuClipboardItems
		{
			return null;
		}

		/**
		 * Creates a new ContextMenuClipboardItems object.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function ContextMenuClipboardItems()
		{
			
		}
	}
}