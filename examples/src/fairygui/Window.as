package fairygui
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import fairygui.event.DragEvent;
	
	public class Window extends GComponent
	{
		private var _contentPane:GComponent;
		private var _modalWaitPane:GObject;
		private var _closeButton:GObject;
		private var _dragArea:GObject;
		private var _contentArea:GObject;
		private var _frame:GComponent;
		private var _modal:Boolean;
		
		private var _uiSources:Vector.<IUISource>;
		private var _inited:Boolean;
		private var _loading:Boolean;
		
		protected var _requestingCmd:int;
		
		public var bringToFontOnClick:Boolean;

		public function Window():void
		{
			super();
			this.focusable = true;
			_uiSources = new Vector.<IUISource>();
			bringToFontOnClick = UIConfig.bringWindowToFrontOnClick;
			
			displayObject.addEventListener(Event.ADDED_TO_STAGE, __onShown);
			displayObject.addEventListener(Event.REMOVED_FROM_STAGE, __onHidden);
			displayObject.addEventListener(MouseEvent.MOUSE_DOWN, __mouseDown, true);
		}
		
		public function addUISource(source:IUISource):void
		{
			_uiSources.push(source);
		}
		
		public function set contentPane(val:GComponent):void
		{
			if(_contentPane!=val)
			{
				if(_contentPane!=null)
					removeChild(_contentPane);
				_contentPane = val;
				if(_contentPane!=null)
				{
					addChild(_contentPane);
					this.setSize(_contentPane.width, _contentPane.height);
					_contentPane.addRelation(this, RelationType.Size);
					_frame = _contentPane.getChild("frame") as GComponent;
					if (_frame != null)
					{
						this.closeButton = _frame.getChild("closeButton");
						this.dragArea = _frame.getChild("dragArea");
						this.contentArea = _frame.getChild("contentArea");
					}
				}
			}
		}
		
		public function get contentPane():GComponent
		{
			return _contentPane;
		}
		
		public function get frame():GComponent
		{
			return _frame;
		}
		
		public function get closeButton():GObject
		{
			return _closeButton;
		}
		
		public function set closeButton(value:GObject):void
		{
			if(_closeButton!=null)
				_closeButton.removeClickListener(closeEventHandler);
			_closeButton = value;
			if (_closeButton != null)
				_closeButton.addClickListener(closeEventHandler); 
		}
		
		public function get dragArea():GObject
		{
			return _dragArea;
		}
		
		public function set dragArea(value:GObject):void
		{
			if (_dragArea != value)
			{
				if (_dragArea != null)
				{
					_dragArea.draggable = false;
					_dragArea.removeEventListener(DragEvent.DRAG_START, __dragStart);
				}

				_dragArea = value;
				if (_dragArea != null)
				{
					if ((_dragArea is GGraph) && GGraph(_dragArea).displayObject == null)
						_dragArea.asGraph.drawRect(0,0,0,0,0);
					_dragArea.draggable = true;
					_dragArea.addEventListener(DragEvent.DRAG_START, __dragStart);
				}
			}
		}
		
		public function get contentArea():GObject
		{
			return _contentArea;
		}
		
		public function set contentArea(value:GObject):void
		{
			_contentArea = value;
		}

		public function show():void
		{
			GRoot.inst.showWindow(this);
		}
		
		public function showOn(root:GRoot):void
		{
			root.showWindow(this);
		}

		public function hide():void
		{
			if(this.isShowing)
				doHideAnimation();
		}
		
		public function hideImmediately():void
		{
			var r:GRoot = (parent is GRoot)?GRoot(parent):null;
			if(!r)
				r = GRoot.inst;
			r.hideWindowImmediately(this);
		}
		
		public function centerOn(r:GRoot, restraint:Boolean=false):void
		{
			this.setXY(int((r.width-this.width)/2), int((r.height-this.height)/2));
			if(restraint)
			{
				this.addRelation(r, RelationType.Center_Center);
				this.addRelation(r, RelationType.Middle_Middle);
			}
		}

		public function toggleStatus():void
		{
			if (isTop)
				hide();
			else
				show();
		}

		public function get isShowing():Boolean
		{
			return parent != null;
		}

		public function get isTop():Boolean
		{
			return parent != null && parent.getChildIndex(this) == parent.numChildren - 1;
		}
		
		public function get modal():Boolean
		{
			return _modal;
		}

		public function set modal(val:Boolean):void
		{
			_modal=val;
		}
		
		public function bringToFront():void
		{
			this.root.bringToFront(this);
		}

		public function showModalWait(requestingCmd:int=0):void
		{
			if (requestingCmd != 0)
				_requestingCmd=requestingCmd;
			
			if(UIConfig.windowModalWaiting)
			{
				if(!_modalWaitPane)
					_modalWaitPane = UIPackage.createObjectFromURL(UIConfig.windowModalWaiting);
	
				layoutModalWaitPane();
				
				addChild(_modalWaitPane);
			}
		}
		
		protected function layoutModalWaitPane():void
		{
			if(_contentArea!=null)
			{
				var pt:Point = _frame.localToGlobal();
				pt = this.globalToLocal(pt.x, pt.y);
				_modalWaitPane.setXY(pt.x+_contentArea.x, pt.y+_contentArea.y);
				_modalWaitPane.setSize(_contentArea.width, _contentArea.height);
			}
			else
				_modalWaitPane.setSize(this.width, this.height);
		}

		public function closeModalWait(requestingCmd:int=0):Boolean
		{
			if (requestingCmd != 0)
			{
				if (_requestingCmd != requestingCmd)
					return false;
			}
			_requestingCmd=0;
			
			if (_modalWaitPane && _modalWaitPane.parent!=null)
				removeChild(_modalWaitPane);
			
			return true;
		}

		public function get modalWaiting():Boolean
		{
			return _modalWaitPane && _modalWaitPane.parent!=null;
		}

		public function init():void
		{
			if (_inited || _loading)
				return;
			
			if(_uiSources.length>0)
			{
				_loading = false;
				var cnt:int = _uiSources.length;
				for(var i:int=0;i<cnt;i++)
				{
					var lib:IUISource = _uiSources[i];
					if(!lib.loaded)
					{
						lib.load(__uiLoadComplete);
						_loading = true;
					}
				}
				
				if(!_loading)
					_init();
			}
			else
				_init();
		}
		
		protected function onInit():void
		{
		}

		protected function onShown():void
		{
		}

		protected function onHide():void
		{
		}
		
		protected function doShowAnimation():void
		{
			onShown();
		}
		
		protected function doHideAnimation():void
		{
			this.hideImmediately();
		}

		private function __uiLoadComplete():void
		{
			var cnt:int = _uiSources.length;
			for(var i:int=0;i<cnt;i++)
			{
				var lib:IUISource = _uiSources[i];
				if(!lib.loaded)
					return;
			}
			
			_loading = false;
			_init();
		}
		
		private function _init():void
		{
			_inited = true;
			onInit();
			
			if(this.isShowing)
				doShowAnimation();
		}
		
		override public function dispose():void
		{
			displayObject.removeEventListener(Event.ADDED_TO_STAGE, __onShown);
			displayObject.removeEventListener(Event.REMOVED_FROM_STAGE, __onHidden);
			if (parent != null)
				this.hideImmediately();
			
			super.dispose();
		}
		
		protected function closeEventHandler(evt:Event):void
		{
			hide();
		}
		
		private function __onShown(evt:Event):void
		{
			if (evt.target == displayObject)
			{
				if(!_inited)
					init();
				else
					doShowAnimation();
			}
		}

		private function __onHidden(evt:Event):void
		{
			if (evt.target == displayObject)
			{
				closeModalWait();
				onHide();
			}
		}
		
		private function __mouseDown(evt:Event):void
		{
			if (this.isShowing && bringToFontOnClick)
			{
				bringToFront();
			}
		}

		private function __dragStart(evt:DragEvent):void
		{
			evt.preventDefault();
			
			this.startDrag(evt.touchPointID);
		}
	}
}
