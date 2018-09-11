package fairygui
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.system.Capabilities;
	import flash.system.TouchscreenType;
	import flash.text.TextField;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import fairygui.display.UIDisplayObject;
	import fairygui.event.FocusChangeEvent;
	import fairygui.utils.ToolSet;
	
	[Event(name = "focusChanged", type = "fairygui.event.FocusChangeEvent")]
	public class GRoot extends GComponent
	{
		private var _nativeStage:Stage;
		private var _modalLayer:GGraph;
		private var _popupStack:Vector.<GObject>;
		private var _justClosedPopups:Vector.<GObject>;
		private var _modalWaitPane:GObject;
		private var _focusedObject:GObject;
		private var _tooltipWin:GObject;
		private var _defaultTooltipWin:GObject;
		private var _hitUI:Boolean;
		private var _contextMenuDisabled:Boolean;
		private var _volumeScale:Number;
		private var _designResolutionX:int;
		private var _designResolutionY:int;
		private var _screenMatchMode:int;
		
		private static var _inst:GRoot;
		
		public var buttonDown:Boolean;
		public var ctrlKeyDown:Boolean;
		public var shiftKeyDown:Boolean;
		
		public static var touchScreen:Boolean;
		public static var touchPointInput:Boolean;
		public static var eatUIEvents:Boolean;
		public static var contentScaleFactor:Number = 1;
		
		public static function get inst():GRoot
		{
			if(_inst==null)
				new GRoot();
			return _inst;
		}
		
		public function GRoot():void 
		{
			if(_inst==null)
				_inst = this;

			_volumeScale = 1;
			_contextMenuDisabled = Capabilities.playerType=="Desktop";
			_popupStack = new Vector.<GObject>();
			_justClosedPopups = new Vector.<GObject>();
			displayObject.addEventListener(Event.ADDED_TO_STAGE, __addedToStage);
		}
		
		public function get nativeStage():Stage
		{
			return _nativeStage;
		}
		
		public function setContentScaleFactor(designResolutionX:int, designResolutionY:int, 
											  screenMatchMode:int=ScreenMatchMode.MatchWidthOrHeight):void
		{
			_designResolutionX = designResolutionX;
			_designResolutionY = designResolutionY;
			_screenMatchMode = screenMatchMode;
			
			if(_designResolutionX==0) //backward compability
				_screenMatchMode = ScreenMatchMode.MatchWidth;
			else if(_designResolutionY==0) //backward compability
				_screenMatchMode = ScreenMatchMode.MatchHeight;
			
			applyScaleFactor();
		}
		
		private function applyScaleFactor():void
		{
			var screenWidth:int = _nativeStage.stageWidth;
			var screenHeight:int = _nativeStage.stageHeight;
			
			if(_designResolutionX==0 || _designResolutionY==0)
			{
				this.setSize(screenWidth, screenHeight);
				return;
			}
			
			var dx:int = _designResolutionX;
			var dy:int = _designResolutionY;
			if (screenWidth > screenHeight && dx < dy || screenWidth < screenHeight && dx > dy) 
			{
				//scale should not change when orientation change
				var tmp:int = dx;
				dx = dy;
				dy = tmp;
			}			
			
			if (_screenMatchMode == ScreenMatchMode.MatchWidthOrHeight)
			{
				var s1:Number = screenWidth/dx;
				var s2:Number = screenHeight/dy; 
				contentScaleFactor = Math.min(s1, s2);
			}
			else if (_screenMatchMode == ScreenMatchMode.MatchWidth)
				contentScaleFactor = screenWidth / dx;
			else
				contentScaleFactor = screenHeight / dy;
			
			this.setSize(Math.round(screenWidth/contentScaleFactor),Math.round(screenHeight/contentScaleFactor));
			this.scaleX = contentScaleFactor;
			this.scaleY = contentScaleFactor;
		}
		
		public function setFlashContextMenuDisabled(value:Boolean):void
		{
			_contextMenuDisabled = value;
			if(_nativeStage)
			{
				if(_contextMenuDisabled)
				{
					_nativeStage.addEventListener("rightMouseDown"/*MouseEvent.RIGHT_MOUSE_DOWN*/, __stageMouseDownCapture, true);
					_nativeStage.addEventListener("rightMouseUp"/*MouseEvent.RIGHT_MOUSE_UP*/, __stageMouseUpCapture, true);
				}
				else
				{
					_nativeStage.removeEventListener("rightMouseDown"/*MouseEvent.RIGHT_MOUSE_DOWN*/, __stageMouseDownCapture, true);
					_nativeStage.removeEventListener("rightMouseUp"/*MouseEvent.RIGHT_MOUSE_UP*/, __stageMouseUpCapture, true);
				}
			}
		}
		
		public function showWindow(win:Window):void 
		{
			addChild(win);
			win.requestFocus();
			
			if(win.x>this.width)
				win.x = this.width - win.width;
			else if(win.x+win.width<0)
				win.x = 0;
			
			if(win.y>this.height)
				win.y = this.height - win.height;
			else if(win.y+win.height<0)
				win.y = 0;
			
			adjustModalLayer();
		}
		
		public function hideWindow(win:Window):void
		{
			win.hide();
		}
		
		public function hideWindowImmediately(win:Window):void
		{
			if(win.parent==this)
				removeChild(win);
			
			adjustModalLayer();
		}
		
		public function bringToFront(win: Window):void {
			var cnt: int = this.numChildren;
			var i:int;
			if(this._modalLayer.parent!=null && !win.modal)
				i = this.getChildIndex(this._modalLayer) - 1;
			else
				i = cnt - 1;
			
			for(;i >= 0;i--) {
				var g: GObject = this.getChildAt(i);
				if(g==win)
					return;
				if(g is Window)
					break;
			}
			
			if(i>=0)
				this.setChildIndex(win, i);
		}

		public function showModalWait(msg:String=null):void
		{
			if (UIConfig.globalModalWaiting != null)
			{
				if (_modalWaitPane == null)
					_modalWaitPane = UIPackage.createObjectFromURL(UIConfig.globalModalWaiting);
				_modalWaitPane.setSize(this.width, this.height);
				_modalWaitPane.addRelation(this, RelationType.Size);
				
				addChild(_modalWaitPane);
				_modalWaitPane.text = msg;
			}
		}
		
		public function closeModalWait():void
		{
			if (_modalWaitPane != null && _modalWaitPane.parent != null)
				removeChild(_modalWaitPane);
		}
		
		public function closeAllExceptModals():void
		{
			var arr:Vector.<GObject> = _children.slice();
			var cnt:int = arr.length;
			for(var i:int=0;i<cnt;i++)
			{
				var g:GObject = arr[i];
				if((g is Window) && !(g as Window).modal)
					(g as Window).hide();
			}
		}
		
		public function closeAllWindows():void
		{
			var arr:Vector.<GObject> = _children.slice();
			var cnt:int = arr.length;
			for(var i:int=0;i<cnt;i++)
			{
				var g:GObject = arr[i];
				if(g is Window)
					(g as Window).hide();
			}
		}
		
		public function getTopWindow():Window
		{
			var cnt:int = this.numChildren;
			for(var i:int=cnt-1;i>=0;i--) {
				var g:GObject = this.getChildAt(i);
				if(g is Window) {
					return Window(g);
				}
			}
			
			return null;
		}
		
		public function getWindowBefore(win:Window):Window 
		{
			var cnt:int = this.numChildren;
			var ok:Boolean = false;
			for(var i:int=cnt-1;i>=0;i--)
			{
				var g:GObject = this.getChildAt(i);
				if(g is Window)
				{
					if(ok)
						return Window(g);
					
					if(g==win)
						ok = true;
				}
			}
			
			return null;
		}
		
		public function get hasModalWindow():Boolean
		{
			return _modalLayer.parent!=null;
		}
		
		public function get modalWaiting():Boolean
		{
			return _modalWaitPane && _modalWaitPane.inContainer;
		}
		
		public function showPopup(popup:GObject, target:GObject=null, downward:Object=null):void 
		{
			if(_popupStack.length>0)
			{
				var k:int = _popupStack.indexOf(popup);
				if(k!=-1)
				{
					for(var i:int=_popupStack.length-1;i>=k;i--)
					{
						closePopup(_popupStack.pop());
					}
				}
			}
			_popupStack.push(popup);
			
			addChild(popup);
			adjustModalLayer();
			
			var pos:Point;
			var sizeW:int, sizeH:int;
			if(target)
			{
				pos = target.localToRoot();
				sizeW = target.width;
				sizeH = target.height;
			}
			else
			{
				pos = this.globalToLocal(nativeStage.mouseX, nativeStage.mouseY);
			}
			var xx:Number, yy:Number;
			xx = pos.x;
			if(xx+popup.width>this.width)
				xx = xx+sizeW-popup.width;
			yy = pos.y+sizeH;
			if((downward==null && yy+popup.height>this.height)
				|| downward==false) {
				yy = pos.y - popup.height - 1;
				if(yy<0) {
					yy = 0;
					xx += sizeW/2;
				}
			}
			
			popup.setXY(int(xx),int(yy));
		}
		
		public function togglePopup(popup:GObject, target:GObject=null, downward:Object=null):void
		{
			if(_justClosedPopups.indexOf(popup)!=-1)
				return;
			
			showPopup(popup, target, downward);
		}
		
		public function hidePopup(popup:GObject=null):void
		{
			if(popup!=null)
			{
				var k:int = _popupStack.indexOf(popup);
				if(k!=-1)
				{
					for(var i:int=_popupStack.length-1;i>=k;i--)
						closePopup(_popupStack.pop());
				}
			}
			else
			{
				var cnt:int = _popupStack.length;
				for(i=cnt-1;i>=0;i--)
					closePopup(_popupStack[i]);
				_popupStack.length = 0;
			}
		}
		
		public function get hasAnyPopup():Boolean
		{
			 return _popupStack.length != 0;
		}
		
		private function closePopup(target:GObject):void
		{
			if (target.parent != null)
			{
				if (target is Window)
					Window(target).hide();
				else
					removeChild(target);
			}
		}
		
		public function showTooltips(msg:String):void
		{
			if(_defaultTooltipWin==null)
			{
				var resourceURL:String = UIConfig.tooltipsWin;
				if(!resourceURL)
				{
					trace("UIConfig.tooltipsWin not defined");
					return;
				}
				
				_defaultTooltipWin = UIPackage.createObjectFromURL(resourceURL);
			}
			
			_defaultTooltipWin.text = msg;
			showTooltipsWin(_defaultTooltipWin);
		}
		
		public function showTooltipsWin(tooltipWin:GObject, position:Point=null):void
		{
			hideTooltips();
			
			_tooltipWin = tooltipWin;

			var xx:int;
			var yy:int;
			if(position==null)
			{
				xx = _nativeStage.mouseX+10;
				yy = _nativeStage.mouseY+20;
			}
			else
			{
				xx = position.x;
				yy = position.y;
			}
			var pt:Point = this.globalToLocal(xx, yy);
			xx = pt.x;
			yy = pt.y;
			
			if(xx+_tooltipWin.width>this.width)
			{
				xx = xx - _tooltipWin.width - 1;
				if(xx<0)
					xx = 10;
			}
			if(yy+_tooltipWin.height>this.height) {
				yy = yy - _tooltipWin.height - 1;
				if(xx - _tooltipWin.width - 1 > 0)
					xx = xx - _tooltipWin.width - 1;
				if(yy<0)
					yy = 10;
			}
			
			_tooltipWin.x = xx;
			_tooltipWin.y = yy;
			addChild(_tooltipWin);
		}
		
		public function hideTooltips():void
		{
			if(_tooltipWin!=null)
			{
				if(_tooltipWin.parent)
					removeChild(_tooltipWin);
				_tooltipWin = null;
			}
		}
		
		public function getObjectUnderMouse():GObject
		{
			return getObjectUnderPoint(_nativeStage.mouseX, _nativeStage.mouseY);
		}
		
		public function getObjectUnderPoint(globalX:Number, globalY:Number):GObject
		{
			var objs:Array = _nativeStage.getObjectsUnderPoint(new Point(globalX, globalY));
			if(!objs || objs.length==0)
				return null;
			else
				return ToolSet.displayObjectToGObject(objs[objs.length-1]);
		}
		
		public function get focus():GObject
		{
			if(_focusedObject && !_focusedObject.onStage)
				_focusedObject = null;
			
			return _focusedObject;
		}
		
		public function set focus(value:GObject):void
		{
			if(value && (!value.focusable || !value.onStage))
				throw new Error("invalid focus target");
			
			setFocus(value);
			if(value is GTextInput)
				_nativeStage.focus = TextField(GTextInput(value).displayObject);
		}
		
		private function setFocus(value:GObject):void
		{
			if(_focusedObject!=value)
			{
				var old:GObject;
				if(_focusedObject!=null && _focusedObject.onStage)
					old = _focusedObject;
				_focusedObject = value;
				dispatchEvent(new FocusChangeEvent(FocusChangeEvent.CHANGED, old, value));
			}
		}
		
		public function get volumeScale():Number
		{
			return _volumeScale;
		}
		
		public function set volumeScale(value:Number):void
		{
			_volumeScale = value;
		}
		
		public function playOneShotSound(sound:Sound, volumeScale:Number=1):void
		{
			var vs:Number = _volumeScale * volumeScale;
			if(vs==1)
				sound.play();
			else
				sound.play(0, 0, new SoundTransform(vs));
		}

		private function adjustModalLayer():void 
		{
			var cnt:int = this.numChildren;
			
			if (_modalWaitPane != null && _modalWaitPane.parent != null)
				setChildIndex(_modalWaitPane, cnt - 1);
			
			for(var i:int=cnt-1;i>=0;i--) {
				var g:GObject = this.getChildAt(i);
				if((g is Window) && (g as Window).modal) {
					if(_modalLayer.parent==null)
						addChildAt(_modalLayer, i);
					else
						setChildIndexBefore(_modalLayer, i);
					return;
				}
			}
			
			if(_modalLayer.parent!=null)
				removeChild(_modalLayer);
		}
		
		private function __addedToStage(evt:Event):void
		{
			displayObject.removeEventListener(Event.ADDED_TO_STAGE, __addedToStage);

			_nativeStage = displayObject.stage;

			touchScreen = Capabilities.os.toLowerCase().slice(0, 3) != "win" 
				&& Capabilities.os.toLowerCase().slice(0, 3) != "mac"
				&& Capabilities.touchscreenType!=TouchscreenType.NONE;
			
			if(touchScreen)
			{
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				touchPointInput = true;
			}

			_nativeStage.addEventListener(MouseEvent.MOUSE_DOWN, __stageMouseDownCapture, true);
			_nativeStage.addEventListener(MouseEvent.MOUSE_DOWN, __stageMouseDown, false, 1);
			_nativeStage.addEventListener(MouseEvent.MOUSE_UP, __stageMouseUpCapture, true);
			_nativeStage.addEventListener(MouseEvent.MOUSE_UP, __stageMouseUp, false, 1);
			if(_contextMenuDisabled)
			{
				_nativeStage.addEventListener("rightMouseDown"/*MouseEvent.RIGHT_MOUSE_DOWN*/, __stageMouseDownCapture, true);
				_nativeStage.addEventListener("rightMouseUp"/*MouseEvent.RIGHT_MOUSE_UP*/, __stageMouseUpCapture, true);
			}

			_modalLayer = new GGraph();	
			_modalLayer.setSize(this.width, this.height);
			_modalLayer.drawRect(0,0,0,UIConfig.modalLayerColor, UIConfig.modalLayerAlpha);
			_modalLayer.addRelation(this, RelationType.Size);
			
			if(Capabilities.os.toLowerCase().slice(0,3)=="win" 
				|| Capabilities.os.toLowerCase().slice(0,3)=="mac")
				_nativeStage.addEventListener(Event.RESIZE, __winResize);
			else
				_nativeStage.addEventListener("orientationChange", __orientationChange);
			__winResize(null);
		}
		
		private function __stageMouseDownCapture(evt:MouseEvent):void 
		{
			ctrlKeyDown = evt.ctrlKey;
			shiftKeyDown = evt.shiftKey;
			buttonDown = true;
			_hitUI = evt.target!=_nativeStage;
			
			var mc:DisplayObject = evt.target as DisplayObject;
			while(mc!=_nativeStage && mc!=null) {
				if(mc is UIDisplayObject)
				{
					var gg:GObject = UIDisplayObject(mc).owner;
					if(gg.touchable && gg.focusable)
					{
						this.setFocus(gg);
						break;
					}
				}
				mc = mc.parent;
			}
			
			if(_tooltipWin!=null)
				hideTooltips();
			
			_justClosedPopups.length = 0;
			if(_popupStack.length>0) 
			{
				mc = evt.target as DisplayObject;
				var handled:Boolean = false;
				while(mc!=_nativeStage && mc!=null) {
					if(mc is UIDisplayObject)
					{
						var pindex:int = _popupStack.indexOf(UIDisplayObject(mc).owner);
						if(pindex!=-1)
						{
							for(var i:int=_popupStack.length-1;i>pindex;i--)
							{
								var popup:GObject = _popupStack.pop();
								closePopup(popup);
								_justClosedPopups.push(popup);
							}
							handled = true;
							break;
						}
					}
					mc = mc.parent;
				}
				
				if(!handled)
				{
					var cnt:int = _popupStack.length;
					for(i=cnt-1;i>=0;i--)
					{
						popup = _popupStack[i];
						closePopup(popup);
						_justClosedPopups.push(popup);
					}
					_popupStack.length = 0;
				}
			}
		}
		
		private function __stageMouseDown(evt:MouseEvent):void 
		{
			if(evt.eventPhase==EventPhase.AT_TARGET)
				__stageMouseDownCapture(evt);
			
			if(eatUIEvents && evt.target!=_nativeStage)
				evt.stopImmediatePropagation();
		}
		
		private function __stageMouseUpCapture(evt:MouseEvent):void 
		{
			buttonDown = false;
		}
		
		private function __stageMouseUp(evt:MouseEvent):void
		{		
			if(evt.eventPhase==EventPhase.AT_TARGET)
				__stageMouseUpCapture(evt);
			
			if(eatUIEvents && (_hitUI || evt.target!=_nativeStage))
				evt.stopImmediatePropagation();
			
			_hitUI = false;
		}
		
		private function __winResize(evt:Event):void
		{
			applyScaleFactor();
		}
		
		private function __orientationChange(evt:Event):void
		{
			applyScaleFactor();
		}
	}
	
	
}