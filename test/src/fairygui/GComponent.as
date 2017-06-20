package fairygui 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import fairygui.display.UISprite;
	import fairygui.utils.GTimers;
	import fairygui.utils.PixelHitTest;
	import fairygui.utils.PixelHitTestData;

	[Event(name = "dropEvent", type = "fairygui.event.DropEvent")]
	public class GComponent extends GObject
	{
		private var _sortingChildCount:int;
		private var _opaque:Boolean;
		private var _hitArea:PixelHitTest;
		
		protected var _margin:Margin;
		protected var _trackBounds:Boolean;
		protected var _boundsChanged:Boolean;
		
		internal var _buildingDisplayList:Boolean;
		internal var _children:Vector.<GObject>;
		internal var _controllers:Vector.<Controller>;
		internal var _transitions:Vector.<Transition>;
		internal var _rootContainer:Sprite;
		internal var _container:Sprite;
		internal var _scrollPane:ScrollPane;
		internal var _alignOffset:Point;
		
		private var _childrenRenderOrder:int;
		private var _apexIndex:int;
		
		public function GComponent():void
		{
			_children = new Vector.<GObject>();
			_controllers = new Vector.<Controller>();
			_transitions = new Vector.<Transition>();
			_margin = new Margin();
			_alignOffset = new Point();
		}
		
		override protected function createDisplayObject():void
		{
			_rootContainer = new UISprite(this);
			_rootContainer.mouseEnabled = false;
			setDisplayObject(_rootContainer);			
			_container = _rootContainer;
		}
		
		public override function dispose():void
		{
			var i:int;
			
			var transCnt:int = _transitions.length;
			for (i = 0; i < transCnt; ++i)
			{
				var trans:Transition = _transitions[i];
				trans.dispose();
			}
			
			var numChildren:int = _children.length; 
			for (i=numChildren-1; i>=0; --i)
			{
				var obj:GObject = _children[i];
				obj.parent = null; //avoid removeFromParent call
				obj.dispose(); 
			}
			
			_boundsChanged = false;
			super.dispose();
		}
		
		final public function get displayListContainer():DisplayObjectContainer
		{
			return _container;
		}
		
		public function addChild(child:GObject):GObject
		{
			addChildAt(child, _children.length);
			return child;
		}
		
		public function addChildAt(child:GObject, index:int):GObject
		{
			if(!child)
				throw new Error("child is null");

			var numChildren:int = _children.length; 
			
			if (index >= 0 && index <= numChildren)
			{
				if (child.parent == this)
				{
					setChildIndex(child, index); 
				}
				else
				{
					child.removeFromParent();
					child.parent = this;
					
					var cnt:int = _children.length;
					if(child.sortingOrder!=0)
					{
						_sortingChildCount++;
						index = getInsertPosForSortingChild(child);
					}
					else if(_sortingChildCount>0)
					{
						if(index > (cnt-_sortingChildCount))
							index = cnt - _sortingChildCount;
					}
					
					if (index == cnt) 
						_children.push(child);
					else
						_children.splice(index, 0, child);
					
					childStateChanged(child);
					setBoundsChangedFlag();
				}

				return child;
			}
			else
			{
				throw new RangeError("Invalid child index");
			}
		}

		private function getInsertPosForSortingChild(target:GObject):int
		{
			var cnt:int = _children.length;
			var i:int;
			for (i = 0; i < cnt; i++)
			{
				var child:GObject = _children[i];
				if (child == target)
					continue;
				
				if (target.sortingOrder < child.sortingOrder)
					break;
			}
			return i;
		}
		
		public function removeChild(child:GObject, dispose:Boolean=false):GObject
		{
			var childIndex:int = _children.indexOf(child);
			if (childIndex != -1)
			{
				removeChildAt(childIndex, dispose);
			}
			return child;
		}

		public function removeChildAt(index:int, dispose:Boolean=false):GObject
		{
			if (index >= 0 && index < numChildren)
			{
				var child:GObject = _children[index];				
				child.parent = null;
				
				if(child.sortingOrder!=0)
					_sortingChildCount--;
				
				_children.splice(index, 1);
				if(child.inContainer)
				{
					_container.removeChild(child.displayObject);
					
					if (_childrenRenderOrder == ChildrenRenderOrder.Arch)
						GTimers.inst.callLater(buildNativeDisplayList);
				}
				
				if(dispose)
					child.dispose();
				
				setBoundsChangedFlag();
				
				return child;
			}
			else
			{
				throw new RangeError("Invalid child index");
			}
		}

		public function removeChildren(beginIndex:int=0, endIndex:int=-1, dispose:Boolean=false):void
		{
			if (endIndex < 0 || endIndex >= numChildren) 
				endIndex = numChildren - 1;
			
			for (var i:int=beginIndex; i<=endIndex; ++i)
				removeChildAt(beginIndex, dispose);
		}
		
		public function getChildAt(index:int):GObject
		{
			if (index >= 0 && index < numChildren)
				return _children[index];
			else
				throw new RangeError("Invalid child index");
		}
		
		public function getChild(name:String):GObject
		{
			var cnt:int = _children.length;
			for (var i:int=0; i<cnt; ++i)
			{
				if (_children[i].name == name) 
					return _children[i];
			}
			
			return null;
		}
		
		public function getVisibleChild(name:String):GObject
		{
			var cnt:int = _children.length;
			for (var i:int=0; i<cnt; ++i)
			{
				var child:GObject = _children[i];
				if (child.finalVisible && child.name==name) 
					return child;
			}
			
			return null;
		}
		
		public function getChildInGroup(name:String, group:GGroup):GObject
		{
			var cnt:int = _children.length;
			for (var i:int=0; i<cnt; ++i)
			{
				var child:GObject = _children[i];
				if (child.group==group && child.name == name) 
					return child;
			}
			
			return null;
		}
		
		internal function getChildById(id:String):GObject
		{
			var cnt:int = _children.length;
			for (var i:int=0; i<cnt; ++i)
			{
				if (_children[i]._id == id) 
					return _children[i];
			}
			
			return null;
		}
		
		public function getChildIndex(child:GObject):int
		{
			return _children.indexOf(child);
		}
		
		public function setChildIndex(child:GObject, index:int):void
		{
			var oldIndex:int = _children.indexOf(child);
			if (oldIndex == -1) 
				throw new ArgumentError("Not a child of this container");
			
			if(child.sortingOrder!=0) //no effect
				return;
			
			var cnt:int = _children.length;
			if(_sortingChildCount>0)
			{
				if (index > (cnt - _sortingChildCount - 1))
					index = cnt - _sortingChildCount - 1;
			}
			
			_setChildIndex(child, oldIndex, index);
		}
		
		public function setChildIndexBefore(child:GObject, index:int):int
		{
			var oldIndex:int = _children.indexOf(child);
			if (oldIndex == -1) 
				throw new ArgumentError("Not a child of this container");
			
			if(child.sortingOrder!=0) //no effect
				return oldIndex;
			
			var cnt:int = _children.length;
			if(_sortingChildCount>0)
			{
				if (index > (cnt - _sortingChildCount - 1))
					index = cnt - _sortingChildCount - 1;
			}
			
			if (oldIndex < index)
				return _setChildIndex(child, oldIndex, index - 1);
			else
				return _setChildIndex(child, oldIndex, index);
		}
		
		private function _setChildIndex(child:GObject, oldIndex:int, index:int):int
		{
			var cnt:int = _children.length;
			if(index>cnt)
				index = cnt;
			
			if(oldIndex==index)
				return index;
			
			_children.splice(oldIndex, 1);
			_children.splice(index, 0, child);
			
			if(child.inContainer)
			{			
				var displayIndex:int;
				var g:GObject;
				var i:int;
				
				if (_childrenRenderOrder == ChildrenRenderOrder.Ascent)
				{
					for(i=0;i<index;i++)
					{
						g = _children[i];
						if(g.inContainer)
							displayIndex++;
					}
					if(displayIndex==_container.numChildren)
						displayIndex--;
					_container.setChildIndex(child.displayObject, displayIndex);
				}
				else if (_childrenRenderOrder == ChildrenRenderOrder.Descent)
				{
					for (i = cnt - 1; i > index; i--)
					{
						g = _children[i];
						if (g.inContainer)
							displayIndex++;
					}
					if(displayIndex==_container.numChildren)
						displayIndex--;
					_container.setChildIndex(child.displayObject, displayIndex);
				}
				else
				{
					GTimers.inst.callLater(buildNativeDisplayList);
				}

				setBoundsChangedFlag();
			}
			
			return index;
		}
		
		public function swapChildren(child1:GObject, child2:GObject):void
		{
			var index1:int = _children.indexOf(child1);
			var index2:int = _children.indexOf(child2);
			if (index1 == -1 || index2 == -1)
				throw new ArgumentError("Not a child of this container");
			swapChildrenAt(index1, index2);
		}
		
		public function swapChildrenAt(index1:int, index2:int):void
		{
			var child1:GObject = _children[index1];
			var child2:GObject = _children[index2];

			setChildIndex(child1, index2);
			setChildIndex(child2, index1);
		}

		final public function get numChildren():int 
		{ 
			return _children.length; 
		}
		
		public function isAncestorOf(child:GObject):Boolean
		{
			if (child == null)
				return false;
			
			var p:GComponent = child.parent;
			while(p)
			{
				if(p == this)
					return true;
				
				p = p.parent;
			}
			return false;
		}

		public function addController(controller:Controller):void
		{
			_controllers.push(controller);
			controller._parent = this;
			applyController(controller);
		}
		
		public function getControllerAt(index:int):Controller
		{
			return _controllers[index];
		}
		
		public function getController(name:String):Controller
		{
			var cnt:int = _controllers.length;
			for (var i:int=0; i<cnt; ++i)
			{
				var c:Controller = _controllers[i];
				if (c.name == name) 
					return c;
			}
			
			return null;
		}
		
		public function removeController(c:Controller):void
		{
			var index:int = _controllers.indexOf(c);
			if(index==-1)
				throw new Error("controller not exists");
			
			c._parent = null;
			_controllers.splice(index,1);
			
			for each(var child:GObject in _children)
				child.handleControllerChanged(c);
		}
		
		final public function get controllers():Vector.<Controller>
		{
			return _controllers;
		}
		
		internal function childStateChanged(child:GObject):void
		{
			if(_buildingDisplayList)
				return;
			
			var cnt:int = _children.length;
			var g:GObject;
			var i:int;
			
			if(child is GGroup)
			{
				for (i = 0; i < cnt; i++)
				{
					g = _children[i];
					if(g.group==child)
						childStateChanged(g);
				}
				return;
			}
			
			if(!child.displayObject)
				return;
			
			if(child.finalVisible)
			{
				if(!child.displayObject.parent)
				{
					var index:int;				
					if (_childrenRenderOrder == ChildrenRenderOrder.Ascent)
					{
						for (i = 0; i < cnt; i++)
						{
							g = _children[i];
							if (g == child)
								break;
							
							if (g.displayObject != null && g.displayObject.parent != null)
								index++;
						}
						_container.addChildAt(child.displayObject, index);
					}
					else if (_childrenRenderOrder == ChildrenRenderOrder.Descent)
					{
						for (i = cnt - 1; i >= 0; i--)
						{
							g = _children[i];
							if (g == child)
								break;
							
							if (g.displayObject != null && g.displayObject.parent != null)
								index++;
						}
						_container.addChildAt(child.displayObject, index);
					}
					else
					{
						_container.addChild(child.displayObject);
						
						GTimers.inst.callLater(buildNativeDisplayList);
					}
				}
			}
			else
			{
				if(child.displayObject.parent)
				{
					_container.removeChild(child.displayObject);
					if (_childrenRenderOrder == ChildrenRenderOrder.Arch)
					{
						GTimers.inst.callLater(buildNativeDisplayList);
					}
				}
			}
		}
		
		private function buildNativeDisplayList():void
		{
			var cnt:int = _children.length;
			if (cnt == 0)
				return;
			
			var i:int;
			var child:GObject;
			switch (_childrenRenderOrder)
			{
				case ChildrenRenderOrder.Ascent:
					{
						for (i = 0; i < cnt; i++)
						{
							child = _children[i];
							if (child.displayObject != null && child.finalVisible)
								_container.addChild(child.displayObject);
						}
					}
					break;
				case ChildrenRenderOrder.Descent:
					{
						for (i = cnt - 1; i >= 0; i--)
						{
							child = _children[i];
							if (child.displayObject != null && child.finalVisible)
								_container.addChild(child.displayObject);
						}
					}
					break;
				
				case ChildrenRenderOrder.Arch:
					{
						for (i = 0; i < _apexIndex; i++)
						{
							child = _children[i];
							if (child.displayObject != null && child.finalVisible)
								_container.addChild(child.displayObject);
						}
						for (i = cnt - 1; i >= _apexIndex; i--)
						{
							child = _children[i];
							if (child.displayObject != null && child.finalVisible)
								_container.addChild(child.displayObject);
						}
					}
					break;
			}
		}
		
		internal function applyController(c:Controller):void
		{
			for each(var child:GObject in _children)
			{
				child.handleControllerChanged(c);
			}
		}
		
		internal function applyAllControllers():void
		{
			var cnt:int = _controllers.length;
			for (var i:int=0; i<cnt; ++i)
			{
				applyController(_controllers[i]);
			}
		}
		
		internal function adjustRadioGroupDepth(obj:GObject, c:Controller):void
		{
			var cnt:int = _children.length;
			var i:int;
			var child:GObject;
			var myIndex:int = -1, maxIndex:int = -1;
			for(i=0;i<cnt;i++)
			{
				child = _children[i];
				if(child==obj)
				{
					myIndex = i;
				}
				else if((child is GButton) 
					&& GButton(child).relatedController==c)
				{
					if(i>maxIndex)
						maxIndex = i;
				}
			}
			if(myIndex<maxIndex)
				this.swapChildrenAt(myIndex, maxIndex);
		}
		
		public function getTransitionAt(index:int):Transition
		{
			return _transitions[index];
		}
		
		public function getTransition(transName:String):Transition
		{
			var cnt:int = _transitions.length;
			for (var i:int = 0; i < cnt; ++i)
			{
				var trans:Transition = _transitions[i];
				if (trans.name == transName)
					return trans;
			}
			
			return null;
		}
		
		final public function get scrollPane():ScrollPane
		{
			return _scrollPane;
		}
		
		public function isChildInView(child:GObject):Boolean
		{
			if (_scrollPane != null)
			{
				return _scrollPane.isChildInView(child);
			}
			else if (_container.scrollRect != null)
			{
				return child.x + child.width >= 0 && child.x <= this.width
					&& child.y + child.height >= 0 && child.y <= this.height;
			}
			else
				return true;
		}
		
		virtual public function getFirstChildInView():int
		{
			var cnt:int = _children.length;
			for (var i:int = 0; i < cnt; ++i)
			{
				var child:GObject = _children[i];
				if (isChildInView(child))
					return i;
			}
			return -1;
		}
		
		final public function get opaque():Boolean
		{
			return _opaque;
		}
		
		public function set opaque(value:Boolean):void
		{
			if(_opaque!=value)
			{
				_opaque = value;
				if(_opaque)
					updateOpaque();
				else
					_rootContainer.graphics.clear();
				_rootContainer.mouseEnabled = this.touchable && (_opaque || _hitArea!=null);
			}
		}
		
		final public function get hitArea():PixelHitTest
		{
			return _hitArea;
		}
		
		public function set hitArea(value:PixelHitTest):void
		{
			if(_rootContainer.hitArea!=null)
				_rootContainer.removeChild(_rootContainer.hitArea);

			_hitArea = value;
			if(_hitArea!=null)
			{
				_rootContainer.hitArea = _hitArea.createHitAreaSprite();
				_rootContainer.addChild(_rootContainer.hitArea);
				_rootContainer.mouseChildren = false;
			}
			else
			{
				_rootContainer.hitArea = null;
				_rootContainer.mouseChildren = this.touchable;
			}
			_rootContainer.mouseEnabled = this.touchable && (_opaque || _hitArea!=null);
		}
		
		internal function handleTouchable(val:Boolean):void
		{
			_rootContainer.mouseEnabled = val && (_opaque || _hitArea!=null);
			_rootContainer.mouseChildren = val && _hitArea==null;
		}
		
		public function get margin():Margin
		{
			return _margin;
		}
		
		public function set margin(value:Margin):void
		{
			_margin.copy(value);
			if(_container.scrollRect!=null)
			{
				_container.x = _margin.left + _alignOffset.x;
				_container.y = _margin.top + _alignOffset.y;
			}
			handleSizeChanged();
		}
		
		public function get childrenRenderOrder():int
		{
			return _childrenRenderOrder;
		}
		
		public function set childrenRenderOrder(value:int):void
		{
			if (_childrenRenderOrder != value)
			{
				_childrenRenderOrder = value;
				buildNativeDisplayList();
			}
		}
		
		public function get apexIndex():int
		{
			return _apexIndex;
		}
		
		public function set apexIndex(value:int):void
		{
			if (_apexIndex != value)
			{
				_apexIndex = value;
				
				if (_childrenRenderOrder == ChildrenRenderOrder.Arch)
					buildNativeDisplayList();
			}
		}
		
		public function get mask():DisplayObject
		{
			return _container.mask;
		}
		
		public function set mask(value:DisplayObject):void
		{
			_container.mask = value;
		}
		
		protected function updateOpaque():void
		{
			var w:Number = this.width;
			var h:Number = this.height;
			if(w==0)
				w = 1;
			if(h==0)
				h = 1;

			var g:Graphics = _rootContainer.graphics;
			g.clear();
			g.lineStyle(0,0,0);
			g.beginFill(0,0);
			g.drawRect(0,0,w,h);
			g.endFill();
		}
		
		protected function updateClipRect():void
		{
			var rect:Rectangle = _container.scrollRect;
			var w:Number = this.width - (_margin.left + _margin.right);
			var h:Number = this.height - (_margin.top + _margin.bottom);
			if(w<=0)
				w = 0;
			if(h<=0)
				h = 0;
			rect.width = w;
			rect.height = h;
			_container.scrollRect = rect;
		}
		
		protected function setupScroll(scrollBarMargin:Margin,
										scroll:int,
										scrollBarDisplay:int,
										flags:int,
										vtScrollBarRes:String,
										hzScrollBarRes:String):void
		{
			if (_rootContainer == _container)
			{
				_container = new Sprite();
				_rootContainer.addChild(_container);
			}
			_scrollPane = new ScrollPane(this, scroll, scrollBarMargin, scrollBarDisplay, flags,
				vtScrollBarRes, hzScrollBarRes);
		}
		
		protected function setupOverflow(overflow:int):void
		{
			if(overflow==OverflowType.Hidden)
			{
				if (_rootContainer == _container)
				{
					_container = new Sprite();
					_rootContainer.addChild(_container);
				}
					
				_container.scrollRect = new Rectangle();
				updateClipRect();
				
				_container.x = _margin.left;
				_container.y = _margin.top;
			}
			else if(_margin.left!=0 || _margin.top!=0)
			{
				if (_rootContainer == _container)
				{
					_container = new Sprite();
					_rootContainer.addChild(_container);
				}
				
				_container.x = _margin.left;
				_container.y = _margin.top;
			}
		}
		
		override protected function handleSizeChanged():void
		{
			if(_scrollPane)
				_scrollPane.onOwnerSizeChanged();
			if(_container.scrollRect)
				updateClipRect();
			
			if(_opaque)
				updateOpaque();
		}
		
		override protected function handleGrayedChanged():void
		{
			var c:Controller = getController("grayed");
			if(c!=null)
			{
				c.selectedIndex = this.grayed?1:0;
				return;
			}
			
			var v:Boolean = this.grayed;
			var cnt:int = _children.length;
			for (var i:int=0; i<cnt; ++i)
			{
				_children[i].grayed = v;
			}
		}
		
		public function setBoundsChangedFlag():void
		{
			if(!_scrollPane && !_trackBounds)
				return;
			
			if(!_boundsChanged)
			{
				_boundsChanged = true;
				GTimers.inst.add(0, 1, __render);
			}
		}

		private function __render():void
		{
			if(_boundsChanged)
				updateBounds();
		}

		public function ensureBoundsCorrect():void
		{
			if(_boundsChanged)
				updateBounds();
		}
		
		protected function updateBounds():void
		{
			var ax:int, ay:int, aw:int, ah:int;
			if(_children.length>0)
			{
				ax = int.MAX_VALUE, ay = int.MAX_VALUE;
				var ar:int = int.MIN_VALUE, ab:int = int.MIN_VALUE;
				var tmp:int;
	
				for each(child in _children)
				{
					child.ensureSizeCorrect();
				}
				
				for each(var child:GObject in _children)
				{
					tmp = child.x;
					if(tmp<ax)
						ax = tmp;
					tmp = child.y;
					if(tmp<ay)
						ay = tmp;
					tmp = child.x + child.actualWidth;
					if(tmp>ar)
						ar = tmp;
					tmp = child.y + child.actualHeight;
					if(tmp>ab)
						ab = tmp;
				}
				aw = ar-ax;
				ah = ab-ay;
			}
			else
			{
				ax = 0;
				ay = 0;
				aw = 0;
				ah = 0;
			}
			
			setBounds(ax, ay, aw, ah);
		}
		
		protected function setBounds(ax:int, ay:int, aw:int, ah:int):void
		{
			_boundsChanged = false;

			if(_scrollPane)
				_scrollPane.setContentSize(Math.round(ax+aw),  Math.round(ay+ah));
		}
		
		public function get viewWidth():int
		{
			if (_scrollPane != null)
				return _scrollPane.viewWidth;
			else
				return this.width - _margin.left - _margin.right;
		}
		
		public function set viewWidth(value:int):void
		{
			if (_scrollPane != null)
				_scrollPane.viewWidth = value;
			else
				this.width = value + _margin.left + _margin.right;
		}
		
		public function get viewHeight():int
		{
			if (_scrollPane != null)
				return _scrollPane.viewHeight;
			else
				return this.height - _margin.top - _margin.bottom;
		}
		
		public function set viewHeight(value:int):void
		{
			if (_scrollPane != null)
				_scrollPane.viewHeight = value;
			else
				this.height = value + _margin.top + _margin.bottom;
		}
		
		public function getSnappingPosition(xValue:Number, yValue:Number, resultPoint:Point=null):Point
		{
			if(!resultPoint)
				resultPoint = new Point();
			
			var cnt:int = _children.length;
			if(cnt==0)
			{
				resultPoint.x = xValue;
				resultPoint.y = yValue;
				return resultPoint;
			}
			
			ensureBoundsCorrect();			
			
			var obj:GObject = null;
			var prev:GObject;
			
			var i:int = 0;
			if (yValue != 0)
			{
				for (; i < cnt; i++)
				{
					obj = _children[i];
					if (yValue < obj.y)
					{
						if (i == 0)
						{
							yValue = 0;
							break;
						}
						else
						{
							prev = _children[i - 1];
							if (yValue < prev.y + prev.height / 2) //top half part
								yValue = prev.y;
							else//bottom half part
								yValue = obj.y;
							break;
						}
					}
				}
				
				if (i == cnt)
					yValue = obj.y;
			}
			
			if (xValue != 0)
			{
				if (i > 0)
					i--;
				for (; i < cnt; i++)
				{
					obj = _children[i];
					if (xValue < obj.x)
					{
						if (i == 0)
						{
							xValue = 0;
							break;
						}
						else
						{
							prev = _children[i - 1];
							if (xValue < prev.x + prev.width / 2) //top half part
								xValue = prev.x;
							else//bottom half part
								xValue = obj.x;
							break;
						}
					}
				}
				
				if (i == cnt)
					xValue = obj.x;
			}
			
			resultPoint.x = xValue;
			resultPoint.y = yValue;
			return resultPoint;
		}
		
		internal function childSortingOrderChanged(child:GObject, oldValue:int, newValue:int):void
		{
			if (newValue == 0)
			{
				_sortingChildCount--;
				setChildIndex(child, _children.length);
			}
			else
			{
				if (oldValue == 0)
					_sortingChildCount++;
				
				var oldIndex:int = _children.indexOf(child);
				var index:int = getInsertPosForSortingChild(child);
				if (oldIndex < index)
					_setChildIndex(child, oldIndex, index - 1);
				else
					_setChildIndex(child, oldIndex, index);
			}
		}
		
		override public function constructFromResource():void
		{
			constructFromResource2(null, 0);
		}
		
		internal function constructFromResource2(objectPool:Vector.<GObject>, poolIndex:int):void
		{
			var xml:XML = packageItem.owner.getComponentData(packageItem);
			
			var str:String;
			var arr:Array;
			
			_underConstruct = true;
			
			str = xml.@size;
			arr = str.split(",");
			_sourceWidth = int(arr[0]);
			_sourceHeight = int(arr[1]);
			_initWidth = _sourceWidth;
			_initHeight = _sourceHeight;
			
			setSize(_sourceWidth, _sourceHeight);
			
			str = xml.@pivot;
			if(str)
			{
				arr = str.split(",");
				str = xml.@anchor;
				internalSetPivot(parseFloat(arr[0]), parseFloat(arr[1]), str=="true");
			}
			
			str = xml.@opaque;
			if(str!="false")
				this.opaque = true;
			
			str = xml.@hitTest;
			if(str)
			{
				arr = str.split(",");
				var hitTestData:PixelHitTestData = packageItem.owner.getPixelHitTestData(arr[0]);
				if (hitTestData != null)
					this.hitArea = new PixelHitTest(hitTestData, parseInt(arr[1]), parseInt(arr[2]));
			}
			
			var overflow:int;
			str = xml.@overflow;
			if(str)
				overflow = OverflowType.parse(str);
			else
				overflow = OverflowType.Visible;
			
			str = xml.@margin;
			if(str)
				_margin.parse(str);			
			
			if(overflow==OverflowType.Scroll)
			{
				var scroll:int;
				str = xml.@scroll;
				if(str)
					scroll = ScrollType.parse(str);
				else
					scroll = ScrollType.Vertical;
				
				var scrollBarDisplay:int;
				str = xml.@scrollBar;
				if(str)
					scrollBarDisplay = ScrollBarDisplayType.parse(str);
				else
					scrollBarDisplay = ScrollBarDisplayType.Default;
				var scrollBarFlags:int = parseInt(xml.@scrollBarFlags);
				
				var scrollBarMargin:Margin = new Margin();
				str = xml.@scrollBarMargin;
				if(str)
					scrollBarMargin.parse(str);
				
				var vtScrollBarRes:String;
				var hzScrollBarRes:String;
				str = xml.@scrollBarRes;
				if(str)
				{
					arr = str.split(",");
					vtScrollBarRes = arr[0];
					hzScrollBarRes = arr[1];
				}
				
				setupScroll(scrollBarMargin, scroll, scrollBarDisplay, scrollBarFlags, 
					vtScrollBarRes, hzScrollBarRes);
			}
			else
				setupOverflow(overflow);
			
			_buildingDisplayList = true;
			
			var col:XMLList = xml.controller;
			var controller:Controller;
			for each(var cxml:XML in col)
			{
				controller = new Controller();
				_controllers.push(controller);
				controller._parent = this;
				controller.setup(cxml);
			}

			var child:GObject;			
			var displayList:Vector.<DisplayListItem> = packageItem.displayList;
			var childCount:int = displayList.length;
			var i:int;
			for (i = 0; i < childCount; i++)
			{
				var di:DisplayListItem = displayList[i];
				
				if (objectPool != null)
				{
					child = objectPool[poolIndex + i];
				}
				else if (di.packageItem)
				{
					child = UIObjectFactory.newObject(di.packageItem);
					child.packageItem = di.packageItem;
					child.constructFromResource();
				}
				else
					child = UIObjectFactory.newObject2(di.type);
				
				child._underConstruct = true;
				child.setup_beforeAdd(di.desc);
				child.parent = this;
				_children.push(child);
			}
			this.relations.setup(xml);
			
			for (i = 0; i < childCount; i++)
				_children[i].relations.setup(displayList[i].desc);
			
			for (i = 0; i < childCount; i++)
			{
				child = _children[i];
				child.setup_afterAdd(displayList[i].desc);
				child._underConstruct = false;
			}
			
			str = xml.@mask;
			if(str)
				this.mask = getChildById(str).displayObject;

			col = xml.transition;
			var trans:Transition;
			for each(cxml in col)
			{
				trans = new Transition(this);
				_transitions.push(trans);
				trans.setup(cxml);
			}
			
			if(_transitions.length>0)
			{
				this.addEventListener(Event.ADDED_TO_STAGE, __addedToStage);
				this.addEventListener(Event.REMOVED_FROM_STAGE, __removedFromStage);
			}
			
			applyAllControllers();
			
			_buildingDisplayList = false;
			_underConstruct = false;
			
			buildNativeDisplayList();
			setBoundsChangedFlag();
			
			constructFromXML(xml);
		}

		protected function constructFromXML(xml:XML):void
		{
			
		}
		
		override public function setup_afterAdd(xml:XML):void
		{
			super.setup_afterAdd(xml);
			
			var str:String = xml.@controller;
			if(str)
			{
				var arr:Array = str.split(",");
				for(var i:int=0;i<arr.length;i+=2)
				{
					var cc:Controller = getController(arr[i]);
					if(cc)
						cc.selectedPageId = arr[i+1];
				}
			}
		}
		
		private function __addedToStage(evt:Event):void
		{
			var cnt:int = _transitions.length;
			for (var i:int = 0; i < cnt; ++i)
			{
				var trans:Transition = _transitions[i];
				if (trans.autoPlay)
					trans.play(null, null, trans.autoPlayRepeat, trans.autoPlayDelay);
			}
		}
		
		private function __removedFromStage(evt:Event):void
		{
			var cnt:int = _transitions.length;
			for (var i:int = 0; i < cnt; ++i)
			{
				_transitions[i].OnOwnerRemovedFromStage();
			}
		}
	}	
}
