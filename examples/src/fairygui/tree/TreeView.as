package fairygui.tree
{
	import flash.events.Event;
	
	import fairygui.GButton;
	import fairygui.GList;
	import fairygui.GObject;
	import fairygui.event.ItemEvent;
	
	public class TreeView
	{
		private var _list:GList;
		private var _root:TreeNode;
		private var _listener:ITreeListener;
		private var _indent:int;
		
		public function TreeView(list:GList)
		{
			_list = list;
			_list.addEventListener(ItemEvent.CLICK, __clickItem);
			
			_root = new TreeNode(true);
			_root.setTree(this);
			_root.setCell(_list);
			_root.expanded = true;
			
			_indent = 15;
		}
		
		final public function get list():GList
		{
			return _list;
		}
		
		final public function get root():TreeNode
		{
			return _root;
		}
		
		final public function get indent():int
		{
			return _indent;
		}
		
		final public function set indent(value:int):void
		{
			_indent = value;
		}
		
		final public function get listener():ITreeListener
		{
			return _listener;
		}
		
		final public function set listener(value:ITreeListener):void
		{
			_listener = value;
		}
		
		public function getSelectedNode():TreeNode
		{
			if(_list.selectedIndex!=-1)
				return TreeNode(_list.getChildAt(_list.selectedIndex).data);
			else
				return null;
		}
		
		public function getSelection():Vector.<TreeNode>
		{
			var sels:Vector.<int> = _list.getSelection();
			var cnt:int = sels.length;
			var ret:Vector.<TreeNode> = new Vector.<TreeNode>();
			for(var i:int=0;i<cnt;i++)
			{
				var node:TreeNode = TreeNode(_list.getChildAt(sels[i]).data);
				ret.push(node);
			}
			return ret;
		}
		
		public function addSelection(node:TreeNode, scrollItToView:Boolean=false):void
		{
			var parentNode:TreeNode = node.parent;
			while(parentNode!=null && parentNode!=_root)
			{
				parentNode.expanded = true;
				parentNode = parentNode.parent;
			}
			
			if(!node.cell)
				return;
			
			_list.addSelection(_list.getChildIndex(node.cell), scrollItToView);
		}
		
		public function removeSelection(node:TreeNode):void
		{
			if(!node.cell)
				return;
			
			_list.removeSelection(_list.getChildIndex(node.cell));
		}
		
		public function clearSelection():void
		{
			_list.clearSelection();
		}
		
		public function getNodeIndex(node:TreeNode):int
		{
			return _list.getChildIndex(node.cell);
		}
		
		public function updateNode(node:TreeNode):void
		{
			if(node.cell==null)
				return;
			
			_listener.treeNodeRender(node, node.cell);
		}
		
		public function updateNodes(nodes:Vector.<TreeNode>):void
		{
			var cnt:int = nodes.length;
			for(var i:int=0;i<cnt;i++)
			{
				var node:TreeNode = nodes[i];
				if(node.cell==null)
					return;
				
				_listener.treeNodeRender(node, node.cell);
			}
		}
		
		public function expandAll(folderNode:TreeNode):void
		{
			folderNode.expanded = true;
			var cnt:int = folderNode.numChildren;
			for(var i:int=0;i<cnt;i++)
			{
				var node:TreeNode = folderNode.getChildAt(i);
				if(node.isFolder)
					expandAll(node);
			}
		}
		
		public function collapseAll(folderNode:TreeNode):void
		{
			if(folderNode!=_root)
				folderNode.expanded = false;
			var cnt:int = folderNode.numChildren;
			for(var i:int=0;i<cnt;i++)
			{
				var node:TreeNode = folderNode.getChildAt(i);
				if(node.isFolder)
					collapseAll(node);
			}
		}
		
		private function createCell(node:TreeNode):void
		{
			node.setCell(_listener.treeNodeCreateCell(node));
			node.cell.data = node;
			
			var indentObj:GObject = node.cell.getChild("indent");
			if(indentObj!=null)
				indentObj.width = (node.level-1)*_indent;
			
			var expandButton:GButton = GButton(node.cell.getChild("expandButton"));
			if(expandButton)
			{
				if(node.isFolder)
				{
					expandButton.visible = true;
					expandButton.addClickListener(__clickExpandButton);
					expandButton.data = node;
					expandButton.selected = node.expanded;
				}
				else
					expandButton.visible = false;
			}
			
			_listener.treeNodeRender(node, node.cell);
		}
		
		internal function afterInserted(node:TreeNode):void
		{
			createCell(node);
			
			var index:int = getInsertIndexForNode(node);
			_list.addChildAt(node.cell, index);
			_listener.treeNodeRender(node, node.cell);
			
			if(node.isFolder && node.expanded)
				checkChildren(node, index);
		}
		
		private function getInsertIndexForNode(node:TreeNode):int
		{
			var prevNode:TreeNode = node.getPrevSibling();
			if(prevNode==null)
				prevNode = node.parent;
			var insertIndex:int = _list.getChildIndex(prevNode.cell)+1;
			var myLevel:int = node.level;
			var cnt:int = _list.numChildren;
			for(var i:int=insertIndex;i<cnt;i++)
			{
				var testNode:TreeNode = TreeNode(_list.getChildAt(i).data);
				if(testNode.level<=myLevel)
					break;
				
				insertIndex++;
			}
			
			return insertIndex;			
		}
		
		internal function afterRemoved(node:TreeNode):void
		{
			removeNode(node);
		}
		
		internal function afterExpanded(node:TreeNode):void
		{
			if(node!=_root)
				_listener.treeNodeWillExpand(node, true);

			if(node.cell==null)
				return;
			
			if(node!=_root)
			{
				_listener.treeNodeRender(node, node.cell);
				
				var expandButton:GButton = GButton(node.cell.getChild("expandButton"));
				if(expandButton)
					expandButton.selected = true;
			}

			if(node.cell.parent!=null)
				checkChildren(node, _list.getChildIndex(node.cell));
		}
		
		internal function afterCollapsed(node:TreeNode):void
		{
			if(node!=_root)
				_listener.treeNodeWillExpand(node, false);
			
			if(node.cell==null)
				return;
			
			if(node!=_root)
			{
				_listener.treeNodeRender(node, node.cell);
				
				var expandButton:GButton = GButton(node.cell.getChild("expandButton"));
				if(expandButton)
					expandButton.selected = false;
			}
			
			if(node.cell.parent!=null)
				hideFolderNode(node);
		}
		
		internal function afterMoved(node:TreeNode):void
		{
			if(!node.isFolder)
				_list.removeChild(node.cell);
			else
				hideFolderNode(node);
			
			var index:int = getInsertIndexForNode(node);
			_list.addChildAt(node.cell, index);
			
			if(node.isFolder && node.expanded)
				checkChildren(node, index);
		}
		
		private function checkChildren(folderNode:TreeNode, index:int):int
		{
			var cnt:int = folderNode.numChildren;
			for(var i:int=0;i<cnt;i++)
			{
				index++;
				var node:TreeNode = folderNode.getChildAt(i);
				if(node.cell==null)
					createCell(node);

				if(!node.cell.parent)
					_list.addChildAt(node.cell, index);

				if(node.isFolder && node.expanded)
					index = checkChildren(node, index);
			}
			
			return index;
		}
		
		private function hideFolderNode(folderNode:TreeNode):void
		{
			var cnt:int = folderNode.numChildren;
			for(var i:int=0;i<cnt;i++)
			{
				var node:TreeNode = folderNode.getChildAt(i);
				if(node.cell && node.cell.parent!=null)
					_list.removeChild(node.cell);
				if(node.isFolder && node.expanded)
					hideFolderNode(node);
			}
		}
		
		private function removeNode(node:TreeNode):void
		{
			if(node.cell!=null)
			{
				if(node.cell.parent!=null)
					_list.removeChild(node.cell);
				_list.returnToPool(node.cell);
				node.cell.data = null;
				node.setCell(null);
			}
			
			if(node.isFolder)
			{
				var cnt:int = node.numChildren;
				for(var i:int=0;i<cnt;i++)
				{
					var node2:TreeNode = node.getChildAt(i);
					removeNode(node2);
				}
			}
		}
		
		private function __clickExpandButton(evt:Event):void
		{
			var expandButton:GButton = GButton(evt.currentTarget);
			var node:TreeNode = TreeNode(expandButton.parent.data);
			if(_list.scrollPane!=null)
			{
				var posY:Number = _list.scrollPane.posY;
				if(expandButton.selected)
					node.expanded = true;
				else
					node.expanded = false;
				_list.scrollPane.posY = posY;
				_list.scrollPane.scrollToView(node.cell);
			}
			else
			{
				if(expandButton.selected)
					node.expanded = true;
				else
					node.expanded = false;
			}
		}
		
		private function __clickItem(evt:ItemEvent):void
		{
			if(_list.scrollPane!=null)
				var posY:Number = _list.scrollPane.posY;
			
			var node:TreeNode = TreeNode(evt.itemObject.data);			
			_listener.treeNodeClick(node, evt);
			
			if(_list.scrollPane!=null)
			{
				_list.scrollPane.posY = posY;
				_list.scrollPane.scrollToView(node.cell);
			}
		}
	}
}
