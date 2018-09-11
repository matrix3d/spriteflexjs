package fairygui
{	
	public class Relations
	{
		private var _owner:GObject;
		private var _items:Vector.<RelationItem>;
		
		public var handling:GObject;
		internal var sizeDirty:Boolean;
		
		private static const RELATION_NAMES:Array = 
			[
			"left-left",//0
			"left-center",
			"left-right",
			"center-center",
			"right-left",
			"right-center",
			"right-right",
			"top-top",//7
			"top-middle",
			"top-bottom",
			"middle-middle",
			"bottom-top",
			"bottom-middle",
			"bottom-bottom",
			"width-width",//14
			"height-height",//15
			"leftext-left",//16
			"leftext-right",
			"rightext-left",
			"rightext-right",
			"topext-top",//20
			"topext-bottom",
			"bottomext-top",
			"bottomext-bottom"//23
		];
			
		public function Relations(owner:GObject)
		{
			_owner = owner;
			_items = new Vector.<RelationItem>();
		}
		
		public function add(target:GObject, relationType:int, usePercent:Boolean=false):void
		{
			for each(var item:RelationItem in _items)
			{
				if(item.target==target)
				{
					item.add(relationType, usePercent);
					return;
				}
			}
			var newItem:RelationItem = new RelationItem(_owner);
			newItem.target = target;
			newItem.add(relationType, usePercent);
			_items.push(newItem);
		}
		
		private function addItems(target:GObject, sidePairs:String):void
		{
			var arr:Array = sidePairs.split(",");
			var s:String;
			var usePercent:Boolean;
			var i:int;
			var tid:int;
			
			var newItem:RelationItem = new RelationItem(_owner);
			newItem.target = target;

			for(i=0;i<2;i++)
			{
				s = arr[i];
				if(!s)
					continue;
				
				if(s.charAt(s.length-1)=="%")
				{
					s = s.substr(0, s.length-1);
					usePercent = true;
				}
				else
					usePercent = false;
				var j:int = s.indexOf("-");
				if(j==-1)
					s = s+"-"+s;
				
				tid = RELATION_NAMES.indexOf(s);
				if(tid==-1)
					throw new Error("invalid relation type");

				newItem.internalAdd(tid, usePercent);
			}
			
			_items.push(newItem);
		}
			
		public function remove(target:GObject, relationType:int):void
		{
			var cnt:int = _items.length;
			var i:int = 0;
			while (i < cnt)
			{
				var item:RelationItem = _items[i];
				if (item.target == target)
				{
					item.remove(relationType);
					if (item.isEmpty)
					{
						item.dispose();
						_items.splice(i,1);
						cnt--;
					}
					else
						i++;
				}
				else
					i++;
			}
		}

		public function contains(target:GObject):Boolean
		{
			for each (var item:RelationItem in _items)
			{
				if(item.target==target)
					return true;
			}
			return false;
		}
		
		public function clearFor(target:GObject):void
		{
			var cnt:int = _items.length;
			var i:int = 0;
			while (i < cnt)
			{
				var item:RelationItem = _items[i];
				if (item.target == target)
				{
					item.dispose();
					_items.splice(i,1);
					cnt--;
				}
				else
					i++;
			}
		}
		
		public function clearAll():void
		{
			for each (var item:RelationItem in _items)
			{
				item.dispose();
			}
			_items.length = 0;
		}
		
		public function copyFrom(source:Relations):void
		{
			clearAll();
			
			var arr:Vector.<RelationItem> = source._items;
			for each (var ri:RelationItem in arr)
			{
				var item:RelationItem = new RelationItem(_owner);
				item.copyFrom(ri);
				_items.push(item);
			}
		}
		
		public function dispose():void
		{
			clearAll();
		}

		public function onOwnerSizeChanged(dWidth:Number, dHeight:Number):void
		{
			if(_items.length==0)
				return;
			
			for each (var item:RelationItem in _items)
			{
				item.applyOnSelfResized(dWidth, dHeight);			
			}
		}
		
		public function ensureRelationsSizeCorrect():void
		{
			if(_items.length==0)
				return;
			
			sizeDirty = false;
			for each (var item:RelationItem in _items)
			{
				item.target.ensureSizeCorrect();
			}
		}
		
		final public function get empty():Boolean
		{
			return _items.length==0;
		}
		
		public function setup(xml:XML):void
		{
			var col:XMLList = xml.relation;
			var targetId:String;
			var target:GObject;
			for each(var cxml:XML in col)
			{
				targetId = cxml.@target;
				if(_owner.parent)
				{
					if(targetId)
						target = _owner.parent.getChildById(targetId);
					else
						target = _owner.parent;
				}
				else
				{ 
					//call from component construction
					target = GComponent(_owner).getChildById(targetId);
				}
				if(target)
					addItems(target, cxml.@sidePair);
			}
		}
	}
}
