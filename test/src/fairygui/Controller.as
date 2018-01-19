package fairygui
{
	import flash.events.EventDispatcher;
	
	import fairygui.event.StateChangeEvent;
	
	[Event(name = "stateChanged", type = "fairygui.event.StateChangeEvent")]
	public class Controller extends EventDispatcher
	{
		private var _name:String;
		private var _selectedIndex:int;
		private var _previousIndex:int;
		private var _pageIds:Array;
		private var _pageNames:Array;
		private var _pageTransitions:Vector.<PageTransition>;
		private var _playingTransition:Transition;
		
		internal var _parent:GComponent;
		internal var _autoRadioGroupDepth:Boolean;
		
		private static var _nextPageId:uint;
		
		public function Controller()
		{
			_pageIds = [];
			_pageNames = [];
			_selectedIndex = -1;
			_previousIndex = -1;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get parent():GComponent
		{
			return _parent;
		}
		
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void
		{
			if(_selectedIndex!=value)
			{
				if (value > _pageIds.length - 1)
					throw new Error("index out of bounds: " + value);
				
				_previousIndex = _selectedIndex;
				_selectedIndex = value;
				_parent.applyController(this);
				
				this.dispatchEvent(new StateChangeEvent(StateChangeEvent.CHANGED));
				
				if (_playingTransition != null)
				{
					_playingTransition.stop();
					_playingTransition = null;
				}
				
				if (_pageTransitions != null)
				{
					for each (var pt:PageTransition in _pageTransitions)
					{
						if (pt.toIndex == _selectedIndex && (pt.fromIndex == -1 || pt.fromIndex == _previousIndex))
						{
							_playingTransition = parent.getTransition(pt.transitionName);
							break;
						}
					}
					
					if (_playingTransition != null)
						_playingTransition.play(function():void { _playingTransition = null; });
				}
			}
		}
		
		//功能和设置selectedIndex一样，但不会触发事件
		public function setSelectedIndex(value:int):void
		{
			if(_selectedIndex!=value)
			{
				if (value > _pageIds.length - 1)
					throw new Error("index out of bounds: " + value);
				
				_previousIndex = _selectedIndex;
				_selectedIndex = value;
				_parent.applyController(this);
				
				if (_playingTransition != null)
				{
					_playingTransition.stop();
					_playingTransition = null;
				}
			}
		}
		
		public function get previsousIndex():int
		{
			return _previousIndex;
		}
		
		public function get selectedPage():String
		{
			if(_selectedIndex==-1)
				return null;
			else
				return _pageNames[_selectedIndex];
		}
		
		public function set selectedPage(val:String):void
		{
			var i:int = _pageNames.indexOf(val);
			if(i==-1)
				i = 0;
			this.selectedIndex = i;
		}
		
		//功能和设置selectedPage一样，但不会触发事件
		public function setSelectedPage(value:String):void
		{
			var i:int = _pageNames.indexOf(value);
			if(i==-1)
				i = 0;
			this.setSelectedIndex(i);
		}
		
		public function get previousPage():String
		{
			if(_previousIndex==-1)
				return null;
			else
				return _pageNames[_previousIndex];
		}
		
		public function get pageCount():int
		{
			return _pageIds.length;
		}
		
		public function getPageName(index:int):String
		{
			return _pageNames[index];
		}
		
		public function addPage(name:String=""):void
		{
			addPageAt(name, _pageIds.length);
		}
		
		public function addPageAt(name:String, index:int):void
		{
			var nid:String = "_"+(_nextPageId++);
			if(index==_pageIds.length)
			{
				_pageIds.push(nid);
				_pageNames.push(name);
			}
			else
			{
				_pageIds.splice(index, 0, nid);
				_pageNames.splice(index, 0, name);
			}
		}
		
		public function removePage(name:String):void
		{
			var i:int = _pageNames.indexOf(name);
			if(i!=-1)
			{
				_pageIds.splice(i,1);
				_pageNames.splice(i,1);
				if(_selectedIndex>=_pageIds.length)
					this.selectedIndex = _selectedIndex-1;
				else
					_parent.applyController(this);
			}
		}
		
		public function removePageAt(index:int):void
		{
			_pageIds.splice(index,1);
			_pageNames.splice(index,1);
			if(_selectedIndex>=_pageIds.length)
				this.selectedIndex = _selectedIndex-1;
			else
				_parent.applyController(this);
		}
		
		public function clearPages():void
		{
			_pageIds.length = 0;
			_pageNames.length = 0;
			if(_selectedIndex!=-1)
				this.selectedIndex = -1;
			else
				_parent.applyController(this);
		}
		
		public function hasPage(aName:String):Boolean
		{
			return _pageNames.indexOf(aName)!=-1;
		}
		
		public function getPageIndexById(aId:String):int
		{
			return _pageIds.indexOf(aId);
		}
		
		public function getPageIdByName(aName:String):String
		{
			var i:int = _pageNames.indexOf(aName);
			if(i!=-1)
				return _pageIds[i];
			else
				return null;
		}
		
		public function getPageNameById(aId:String):String
		{
			var i:int = _pageIds.indexOf(aId);
			if(i!=-1)
				return _pageNames[i];
			else
				return null;
		}
		
		public function getPageId(index:int):String
		{
			return _pageIds[index];
		}
		
		public function get selectedPageId():String
		{
			if(_selectedIndex==-1)
				return null;
			else
				return _pageIds[_selectedIndex];
		}
		
		public function set selectedPageId(val:String):void
		{
			var i:int = _pageIds.indexOf(val);
			this.selectedIndex = i;
		}
		
		public function set oppositePageId(val:String):void
		{
			var i:int = _pageIds.indexOf(val);
			if(i>0)
				this.selectedIndex = 0;
			else if(_pageIds.length>1)
				this.selectedIndex = 1;
		}
		
		public function get previousPageId():String
		{
			if(_previousIndex==-1)
				return null;
			else
				return _pageIds[_previousIndex];
		}
		
		public function setup(xml:XML):void
		{
			_name = xml.@name;
			_autoRadioGroupDepth = xml.@autoRadioGroupDepth=="true";
			
			var i:int;
			var k:int;
			var str:String = xml.@pages;
			if(str)
			{
				var arr:Array = str.split(",");
				var cnt:int = arr.length;
				for(i=0;i<cnt;i+=2)
				{
					_pageIds.push(arr[i]);
					_pageNames.push(arr[i+1]);
				}
			}

			str = xml.@transitions;
			if(str)
			{
				_pageTransitions = new Vector.<PageTransition>();
				arr = str.split(",");
				cnt = arr.length;
				for(i=0;i<cnt;i++)
				{
					str = arr[i];
					if(!str)
						continue;
					
					var pt:PageTransition = new PageTransition();
					k = str.indexOf("=");
					pt.transitionName = str.substr(k+1);
					str = str.substring(0, k);
					k = str.indexOf("-");
					pt.toIndex = parseInt(str.substring(k+1));
					str = str.substring(0,k);
					if(str=="*")
						pt.fromIndex = -1;
					else
						pt.fromIndex = parseInt(str);
					_pageTransitions.push(pt);
				}
			}
			
			if(_parent && _pageIds.length>0)
				_selectedIndex = 0;
			else
				_selectedIndex = -1;
		}
	}
}

class PageTransition
{
	public var transitionName:String;
	public var fromIndex:int;
	public var toIndex:int;
	
	public function PageTransition()
	{
	}
}
