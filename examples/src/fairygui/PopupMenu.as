package fairygui
{
	import flash.events.Event;
	
	import fairygui.event.ItemEvent;

	public class PopupMenu
	{
		protected var _contentPane:GComponent;
		protected var _list:GList;
		
		public function PopupMenu(resourceURL:String=null)
		{
			if(!resourceURL)
			{
				resourceURL = UIConfig.popupMenu;
				if(!resourceURL)
					throw new Error("UIConfig.popupMenu not defined");
			}
			
			_contentPane = GComponent(UIPackage.createObjectFromURL(resourceURL));
			_contentPane.addEventListener(Event.ADDED_TO_STAGE, __addedToStage);
			
			_list = GList(_contentPane.getChild("list"));
			_list.removeChildrenToPool();
			
			_list.addRelation(_contentPane, RelationType.Width);
			_list.removeRelation(_contentPane, RelationType.Height);
			_contentPane.addRelation(_list, RelationType.Height);
			
			_list.addEventListener(ItemEvent.CLICK, __clickItem);
		}
		
		public function dispose():void
		{
			_contentPane.dispose();
		}
		
		public function addItem(caption:String, callback:Function=null):GButton
		{
			var item:GButton = _list.addItemFromPool().asButton;
			item.title = caption;
			item.data = callback;
			item.grayed = false;
			item.useHandCursor = false;
			var c:Controller = item.getController("checked");
			if(c!=null)
				c.selectedIndex = 0;
			return item;
		}
		
		public function addItemAt(caption:String, index:int, callback:Function=null):GButton
		{
			var item:GButton = _list.getFromPool().asButton;
			_list.addChildAt(item, index);
			item.title = caption;
			item.data = callback;
			item.grayed = false;
			item.useHandCursor = false;
			var c:Controller = item.getController("checked");
			if(c!=null)
				c.selectedIndex = 0;
			return item;
		}
		
		public function addSeperator():void
		{
			if(UIConfig.popupMenu_seperator==null)
				throw new Error("UIConfig.popupMenu_seperator not defined");
			
			list.addItemFromPool(UIConfig.popupMenu_seperator);
		}
		
		public function getItemName(index:int):String
		{
			var item:GButton = GButton(_list.getChildAt(index));
			return item.name;
		}
		
		public function setItemText(name:String, caption:String):void 
		{
			var item:GButton = _list.getChild(name).asButton;
			item.title = caption;
		}
		
		public function setItemVisible(name:String, visible:Boolean):void
		{
			var item:GButton = _list.getChild(name).asButton;
			if (item.visible != visible)
			{
				item.visible = visible;
				_list.setBoundsChangedFlag();
			}
		}
		
		public function setItemGrayed(name:String, grayed:Boolean):void
		{
			var item:GButton = _list.getChild(name).asButton;
			item.grayed = grayed;
		}
		
		public function setItemCheckable(name:String, checkable:Boolean):void
		{
			var item:GButton = _list.getChild(name).asButton;
			var c:Controller = item.getController("checked");
			if(c!=null)
			{
				if(checkable)
				{
					if(c.selectedIndex==0)
						c.selectedIndex = 1;
				}
				else
					c.selectedIndex = 0;
			}
		}
		
		public function setItemChecked(name:String, checked:Boolean):void
		{
			var item:GButton = _list.getChild(name).asButton;
			var c:Controller = item.getController("checked");
			if(c!=null)
				c.selectedIndex = checked?2:1;
		}
		
		public function isItemChecked(name:String):Boolean
		{
			var item:GButton = _list.getChild(name).asButton;
			var c:Controller = item.getController("checked");
			if(c!=null)
				return c.selectedIndex==2;
			else
				return false;
		}
		
		public function removeItem(name:String):Boolean
		{
			var item:GButton = GButton(_list.getChild(name));
			if(item!=null)
			{
				var index:int = _list.getChildIndex(item);
				_list.removeChildToPoolAt(index);
				return true;
			}
			else
				return false;
		}
		
		public function clearItems():void
		{
			_list.removeChildrenToPool();
		}
		
		public function get itemCount():int
		{
			return _list.numChildren;
		}
		
		public function get contentPane():GComponent
		{
			return _contentPane;
		}
		
		public function get list():GList
		{
			return _list;
		}
		
		public function show(target:GObject=null, downward:Object=null):void
		{
			var r:GRoot = target!=null?target.root:GRoot.inst;
			r.showPopup(this.contentPane, (target is GRoot)?null:target, downward);
		}

		private function __clickItem(evt:ItemEvent):void
		{
			var item:GButton = evt.itemObject.asButton;
			if(item==null)
				return;
			
			if(item.grayed)
			{
				_list.selectedIndex = -1;
				return;
			}
			
			var c:Controller = item.getController("checked");
			if(c!=null && c.selectedIndex!=0)
			{
				if(c.selectedIndex==1)
					c.selectedIndex = 2;
				else
					c.selectedIndex = 1;
			}
			
			var r:GRoot = GRoot(_contentPane.parent);
			r.hidePopup(this.contentPane);
			if(item.data!=null)
			{
				if(item.data.length==1)
					item.data(evt);
				else
					item.data();
			}
		}
		
		private function __addedToStage(evt:Event):void
		{
			_list.selectedIndex = -1;
			_list.resizeToFit(int.MAX_VALUE, 10);
		}
	}
}