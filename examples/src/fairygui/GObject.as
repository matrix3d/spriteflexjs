package fairygui
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	
	import fairygui.event.DragEvent;
	import fairygui.event.GTouchEvent;
	import fairygui.event.IBubbleEvent;
	import fairygui.utils.ColorMatrix;
	import fairygui.utils.GTimers;
	import fairygui.utils.SimpleDispatcher;
	import fairygui.utils.ToolSet;
	
	[Event(name = "startDrag", type = "fairygui.event.DragEvent")]
	[Event(name = "endDrag", type = "fairygui.event.DragEvent")]
	[Event(name = "dragMoving", type = "fairygui.event.DragEvent")]
	[Event(name = "beginGTouch", type = "fairygui.event.GTouchEvent")]
	[Event(name = "endGTouch", type = "fairygui.event.GTouchEvent")]
	[Event(name = "dragGTouch", type = "fairygui.event.GTouchEvent")]
	[Event(name = "clickGTouch", type = "fairygui.event.GTouchEvent")]
	public class GObject extends EventDispatcher
	{
		public var data:Object;
		public var packageItem:PackageItem;
		public static var draggingObject:GObject;
		
		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		private var _alpha:Number;
		private var _rotation:Number;
		private var _visible:Boolean;
		private var _touchable:Boolean;
		private var _grayed:Boolean;
		private var _draggable:Boolean;
		private var _scaleX:Number;
		private var _scaleY:Number;		
		private var _pivotX:Number;
		private var _pivotY:Number;
		private var _pivotAsAnchor:Boolean;
		private var _pivotOffsetX:Number;
		private var _pivotOffsetY:Number;
		private var _sortingOrder:int;
		private var _internalVisible:Boolean;
		private var _handlingController:Boolean;
		private var _focusable:Boolean;
		private var _tooltips:String;
		private var _pixelSnapping:Boolean;
		
		private var _relations:Relations;
		private var _group:GGroup;
		private var _gears:Vector.<GearBase>;
		private var _displayObject:DisplayObject;
		private var _dragBounds:Rectangle;
		
		protected var _yOffset:int;
		//Size的实现方式，有两种，0-GObject的w/h等于DisplayObject的w/h。1-GObject的sourceWidth/sourceHeight等于DisplayObject的w/h，剩余部分由scale实现
		protected var _sizeImplType:int;
		
		internal var _parent:GComponent;
		internal var _dispatcher:SimpleDispatcher;
		internal var _rawWidth:Number;
		internal var _rawHeight:Number;
		internal var _sourceWidth:int;
		internal var _sourceHeight:int;
		internal var _initWidth:int;
		internal var _initHeight:int;
		internal var _id:String;
		internal var _name:String;
		internal var _underConstruct:Boolean;
		internal var _gearLocked:Boolean;
		
		internal static var _gInstanceCounter:uint;
		
		internal static const XY_CHANGED:int = 1;
		internal static const SIZE_CHANGED:int = 2;
		internal static const SIZE_DELAY_CHANGE:int = 3;
		
		public function GObject()
		{
			_x = 0;
			_y = 0;
			_width = 0;
			_height = 0;
			_rawWidth = 0;
			_rawHeight = 0;
			_id = "_n" + _gInstanceCounter++;
			_name = "";
			_alpha = 1;
			_rotation = 0;
			_visible = true;
			_internalVisible = true;
			_touchable = true;
			_scaleX = 1;
			_scaleY = 1;
			_pivotX = 0;
			_pivotY = 0;
			_pivotOffsetX = 0;
			_pivotOffsetY = 0;
			
			createDisplayObject();
			
			_relations = new Relations(this);
			_dispatcher = new SimpleDispatcher();
			_gears = new Vector.<GearBase>(8, true);
		}

		final public function get id():String
		{
			return _id;
		}

		final public function get name():String
		{
			return _name;
		}

		final public function set name(value:String):void
		{
			_name = value;
		}

		final public function get x():Number
		{
			return _x;
		}
		
		final public function set x(value:Number):void
		{
			setXY(value, _y);
		}
		
		final public function get y():Number
		{
			return _y;
		}
		
		final public function set y(value:Number):void
		{
			setXY(_x, value);
		}
		
		final public function setXY(xv:Number, yv:Number):void
		{
			if(_x!=xv || _y!=yv)
			{
				var dx:Number = xv-_x;
				var dy:Number = yv-_y;
				_x = xv;
				_y = yv;
				
				handlePositionChanged();
				if(this is GGroup)
					GGroup(this).moveChildren(dx, dy);
				
				updateGear(1);
				
				if (parent != null && !(parent is GList))
				{
					_parent.setBoundsChangedFlag();
					_dispatcher.dispatch(this, XY_CHANGED);
				}
				
				if (draggingObject == this && !sUpdateInDragging)
					this.localToGlobalRect(0,0,this.width,this.height,sGlobalRect);
			}
		}
		
		public function get pixelSnapping():Boolean
		{
			return _pixelSnapping;
		}
		
		public function set pixelSnapping(value:Boolean):void
		{
			if(_pixelSnapping!=value)
			{
				_pixelSnapping = value;
				handlePositionChanged();
			}
		}
		
		public function center(restraint:Boolean=false):void
		{
			var r:GComponent;
			if (parent != null)
				r = parent;
			else
				r = this.root;
			
			this.setXY(int((r.width-this.width)/2), int((r.height-this.height)/2));
			if (restraint)
			{
				this.addRelation(r, RelationType.Center_Center);
				this.addRelation(r, RelationType.Middle_Middle);
			}
		}
		
		final public function get width():Number
		{
			if(!this._underConstruct)
			{
				ensureSizeCorrect();
				if(_relations.sizeDirty)
					_relations.ensureRelationsSizeCorrect();
			}
			return _width;
		}
		
		final public function set width(value:Number):void
		{
			setSize(value, _rawHeight);
		}
		
		final public function get height():Number
		{
			if(!this._underConstruct)
			{
				ensureSizeCorrect();
				if(_relations.sizeDirty)
					_relations.ensureRelationsSizeCorrect();
			}
			return _height;
		}
		
		final public function set height(value:Number):void
		{
			setSize(_rawWidth, value);
		}
		
		public function setSize(wv:Number, hv:Number, ignorePivot:Boolean = false):void
		{
			if(_rawWidth!=wv || _rawHeight!=hv)
			{
				_rawWidth = wv;
				_rawHeight = hv;
				if(wv<0)
					wv = 0;
				if(hv<0)
					hv = 0;
				var dWidth:Number = wv-_width;
				var dHeight:Number = hv-_height;
				_width = wv;
				_height = hv;
				
				handleSizeChanged();
				if(_pivotX!=0 || _pivotY!=0)
				{
					if(!_pivotAsAnchor)
					{
						if(!ignorePivot)
							this.setXY(this.x-_pivotX*dWidth, this.y-_pivotY*dHeight);
						updatePivotOffset();
					}
					else
						applyPivot();
				}
				
				updateGear(2);
				
				if(_parent)
				{
					_parent.setBoundsChangedFlag();					
					_relations.onOwnerSizeChanged(dWidth, dHeight);
				}
				
				_dispatcher.dispatch(this, SIZE_CHANGED);
			}
		}
		
		public function ensureSizeCorrect():void
		{
		}
		
		final public function get sourceHeight():int
		{
			return _sourceHeight;
		}

		final public function get sourceWidth():int
		{
			return _sourceWidth;
		}
		
		final public function get initHeight():int
		{
			return _initHeight;
		}
		
		final public function get initWidth():int
		{
			return _initWidth;
		}

		final public function get actualWidth():Number
		{
			return this.width*_scaleX;
		}
		
		final public function get actualHeight():Number
		{
			return this.height*_scaleY;
		}		
		
		final public function get scaleX():Number
		{
			return _scaleX;
		}
		
		final public function set scaleX(value:Number):void
		{
			setScale(value, _scaleY);
		}
		
		final public function get scaleY():Number
		{
			return _scaleY;
		}
		
		final public function set scaleY(value:Number):void
		{
			setScale(_scaleX, value);
		}
		
		final public function setScale(sx:Number, sy:Number):void
		{
			if(_scaleX!=sx || _scaleY!=sy)
			{
				_scaleX = sx;
				_scaleY = sy;
				handleScaleChanged();
				applyPivot();
				
				updateGear(2);
			}
		}
		
		final public function get pivotX():Number
		{
			return _pivotX;
		}
		
		final public function set pivotX(value:Number):void
		{
			setPivot(value, _pivotY);
		}
		
		final public function get pivotY():Number
		{
			return _pivotY;
		}
		
		final public function set pivotY(value:Number):void
		{
			setPivot(_pivotX, value);
		}
		
		final public function setPivot(xv:Number, yv:Number, asAnchor:Boolean=false):void
		{
			if(_pivotX!=xv || _pivotY!=yv || _pivotAsAnchor!=asAnchor)
			{
				_pivotX = xv;
				_pivotY = yv;
				_pivotAsAnchor = asAnchor;
				
				updatePivotOffset();
				handlePositionChanged();
			}
		}
		
		protected function internalSetPivot(xv:Number, yv:Number, asAnchor:Boolean):void
		{
			_pivotX = xv;
			_pivotY = yv;
			_pivotAsAnchor = asAnchor;
			if(_pivotAsAnchor)
				handlePositionChanged();
		}
		
		private function updatePivotOffset():void
		{
			if(_pivotX!=0 || _pivotY!=0)
			{
				var rot:int = this.normalizeRotation;
				if(rot!=0 || _scaleX!=1 || _scaleY!=1)
				{				
					var rotInRad:Number = rot * ToolSet.DEG_TO_RAD;
					var cos:Number = Math.cos(rotInRad);
					var sin:Number = Math.sin(rotInRad);
					var a:Number   = _scaleX *  cos;
					var b:Number   = _scaleX *  sin;
					var c:Number   = _scaleY * -sin;
					var d:Number   = _scaleY *  cos;
					var px:Number  = _pivotX * _width;
					var py:Number  = _pivotY * _height;
					_pivotOffsetX  = px -  (a * px + c * py);
					_pivotOffsetY  = py - (d * py + b * px);
				}
				else
				{
					_pivotOffsetX = 0;
					_pivotOffsetY = 0;
				}
			}
			else
			{
				_pivotOffsetX = 0;
				_pivotOffsetY = 0;
			}
		}
		
		private function applyPivot():void
		{
			if(_pivotX!=0 || _pivotY!=0)
			{
				updatePivotOffset();
				handlePositionChanged();
			}
		}
		
		final public function get touchable():Boolean
		{
			return _touchable;
		}
		
		public function set touchable(value:Boolean):void
		{
			_touchable = value;
			if((this is GImage) || (this is GMovieClip) 
				|| (this is GTextField) && !(this is GTextInput) && !(this is GRichTextField))
				//Touch is not supported by GImage/GMovieClip/GTextField
				return;
			
			if(_displayObject is InteractiveObject)
			{
				if(this is GComponent)
				{
					GComponent(this).handleTouchable(_touchable);
				}
				else
				{
					InteractiveObject(_displayObject).mouseEnabled = _touchable;
					if(_displayObject is DisplayObjectContainer)
						DisplayObjectContainer(_displayObject).mouseChildren = _touchable;
				}
			}
		}
		
		final public function get grayed():Boolean
		{
			return _grayed;
		}
		
		public function set grayed(value:Boolean):void
		{
			if(_grayed!=value)
			{
				_grayed = value;
				handleGrayedChanged();
				updateGear(3);
			}
		}
		
		final public function get enabled():Boolean
		{
			return !_grayed && _touchable;
		}
		
		public function set enabled(value:Boolean):void
		{
			this.grayed = !value;
			this.touchable = value; 
		}
		
		final public function get rotation():Number
		{
			return _rotation;
		}
		
		public function set rotation(value:Number):void
		{
			if(_rotation!=value)
			{
				_rotation = value;
				if(_displayObject)
					_displayObject.rotation = this.normalizeRotation;
				
				applyPivot();
				updateGear(3);
			}
		}
		
		public function get normalizeRotation():Number
		{
			var rot:Number = _rotation%360;
			if(rot>180)
				rot = rot-360;
			else if(rot<-180)
				rot = 360+rot;
			return rot;
		}
		
		final public function get alpha():Number
		{
			return _alpha;
		}
		
		public function set alpha(value:Number):void
		{
			if(_alpha!=value)
			{
				_alpha = value;
				updateAlpha();
			}
		}
		
		protected function updateAlpha():void
		{
			if(_displayObject)
				_displayObject.alpha = _alpha;
			updateGear(3);
		}
		
		final public function get visible():Boolean
		{
			return _visible;
		}
		
		public function set visible(value:Boolean):void
		{
			if(_visible!=value)
			{
				_visible = value;
				if(_displayObject)
					_displayObject.visible = _visible;
				if(_parent)
				{
					_parent.childStateChanged(this);
					_parent.setBoundsChangedFlag();
				}
			}
		}

		public function get finalVisible():Boolean
		{
			return _visible && _internalVisible && (!_group || _group.finalVisible);
		}
		
		final public function get sortingOrder():int
		{
			return _sortingOrder;
		}
		
		public function set sortingOrder(value:int):void
		{
			if(value<0)
				value = 0;
			if(_sortingOrder!=value)
			{
				var old:int = _sortingOrder;
				_sortingOrder = value;
				if(_parent!=null)
					_parent.childSortingOrderChanged(this, old, _sortingOrder);
			}
		}
		
		final public function get focusable():Boolean
		{
			return _focusable;
		}
		
		public function set focusable(value:Boolean):void
		{
			_focusable = value;
		}
		
		public function get focused():Boolean
		{
			return  this.root.focus == this;
		}
		
		public function requestFocus():void
		{
			var p:GObject = this;
			while(p && !p._focusable)
				p = p.parent;
			if(p!=null)
				this.root.focus = p;
		}
		
		final public function get tooltips():String
		{
			return _tooltips;
		}
		
		public function set tooltips(value:String):void
		{
			if(_tooltips && Mouse.supportsCursor)
			{
				this.removeEventListener(MouseEvent.ROLL_OVER, __rollOver);
				this.removeEventListener(MouseEvent.ROLL_OUT, __rollOut);
			}
			
			_tooltips = value;
			if(_tooltips && Mouse.supportsCursor)
			{
				this.addEventListener(MouseEvent.ROLL_OVER, __rollOver);
				this.addEventListener(MouseEvent.ROLL_OUT, __rollOut);
			}
		}
		
		private function __rollOver(evt:Event):void
		{
			GTimers.inst.callDelay(100, __doShowTooltips);
		}
		
		private function __doShowTooltips(r:GRoot):void
		{
			this.root.showTooltips(_tooltips);
		}
		
		private function __rollOut(evt:Event):void
		{		
			GTimers.inst.remove(__doShowTooltips);
			this.root.hideTooltips();
		}
		
		public function get blendMode():String
		{
			return _displayObject.blendMode;
		}
		
		public function set blendMode(value:String):void
		{
			_displayObject.blendMode = value;
		}
		
		public function get filters():Array
		{
			return _displayObject.filters;
		}
		
		public function set filters(value:Array):void
		{
			_displayObject.filters = value;
		}
		
		final public function get inContainer():Boolean
		{
			return _displayObject!=null && _displayObject.parent!=null;
		}
		
		final public function get onStage():Boolean
		{
			return _displayObject!=null && _displayObject.stage!=null;
		}
		
		final public function get resourceURL():String
		{
			if(packageItem!=null)
				return "ui://"+packageItem.owner.id + packageItem.id;
			else
				return null;
		}
		
		final public function set group(value:GGroup):void
		{
			_group = value;
		}
		
		final public function get group():GGroup
		{
			return _group;
		}
		
		final public function getGear(index:int):GearBase
		{
			var gear:GearBase = _gears[index];
			if (gear == null)
			{
				switch (index)
				{
					case 0:
						gear = new GearDisplay(this);
						break;
					case 1:
						gear = new GearXY(this);
						break;
					case 2:
						gear = new GearSize(this);
						break;
					case 3:
						gear = new GearLook(this);
						break;
					case 4:
						gear = new GearColor(this);
						break;
					case 5:
						gear = new GearAnimation(this);
						break;
					case 6:
						gear = new GearText(this);
						break;
					case 7:
						gear = new GearIcon(this);
						break;
					default:
						throw new Error("FairyGUI: invalid gear index!");
				}
				_gears[index] = gear;
			}
			return gear;
		}
		
		protected function updateGear(index:int):void
		{
			if(_underConstruct || _gearLocked)
				return;
			
			var gear:GearBase = _gears[index];
			if ( gear!= null && gear.controller!=null)
				gear.updateState();
		}
		
		internal function checkGearController(index:int, c:Controller):Boolean
		{
			return _gears[index] != null && _gears[index].controller==c;
		}
		
		internal function updateGearFromRelations(index:int, dx:Number, dy:Number):void
		{
			if (_gears[index] != null)
				_gears[index].updateFromRelations(dx, dy);
		}
		
		internal function addDisplayLock():uint
		{
			var gearDisplay:GearDisplay = GearDisplay(_gears[0]);
			if(gearDisplay && gearDisplay.controller)
			{
				var ret:uint = gearDisplay.addLock();
				checkGearDisplay();
				
				return ret;
			}
			else
				return 0;
		}
		
		internal function releaseDisplayLock(token:uint):void
		{
			var gearDisplay:GearDisplay = GearDisplay(_gears[0]);
			if(gearDisplay && gearDisplay.controller)
			{
				gearDisplay.releaseLock(token);
				checkGearDisplay();
			}
		}
		
		private function checkGearDisplay():void
		{
			if(_handlingController)
				return;
			
			var connected:Boolean = _gears[0]==null || GearDisplay(_gears[0]).connected;
			if(connected!=_internalVisible)
			{
				_internalVisible = connected;
				if(_parent)
					_parent.childStateChanged(this);
			}
		}

		final public function get gearXY():GearXY
		{
			return GearXY(getGear(1));
		}
		
		final public function get gearSize():GearSize
		{
			return GearSize(getGear(2));
		}
		
		final public function get gearLook():GearLook
		{
			return GearLook(getGear(3));
		}
		
		final public function get relations():Relations
		{
			return _relations;
		}
		
		final public function addRelation(target:GObject, relationType:int, usePercent:Boolean = false):void
		{
			_relations.add(target, relationType, usePercent);
		}
	
		final public function removeRelation(target:GObject, relationType:int):void
		{
			_relations.remove(target, relationType);
		}
		
		final public function get displayObject():DisplayObject
		{
			return _displayObject;
		}
		
		final protected function setDisplayObject(value:DisplayObject):void
		{
			_displayObject = value;
		}
		
		final public function get parent():GComponent
		{
			return _parent;
		}
		
		final public function set parent(val:GComponent):void
		{
			_parent = val;
		}
		
		final public function removeFromParent():void
		{
			if(_parent)
				_parent.removeChild(this);
		}
		
		public function get root():GRoot
		{
			if(this is GRoot)
				return GRoot(this);
			
			var p:GObject = _parent;
			while(p)
			{
				if(p is GRoot)
					return GRoot(p);
				p = p.parent;
			}
			return GRoot.inst;
		}
		
		final public function get asCom():GComponent
		{
			return this as GComponent;
		}
		
		final public function get asButton():GButton
		{
			return this as GButton;
		}
		
		final public function get asLabel():GLabel
		{
			return this as GLabel;
		}
		
		final public function get asProgress():GProgressBar
		{
			return this as GProgressBar;
		}
		
		final public function get asTextField():GTextField
		{
			return this as GTextField;
		}
		
		final public function get asRichTextField():GRichTextField
		{
			return this as GRichTextField;
		}
		
		final public function get asTextInput():GTextInput
		{
			return this as GTextInput;
		}
		
		final public function get asLoader():GLoader
		{
			return this as GLoader;
		}
		
		final public function get asList():GList
		{
			return this as GList;
		}
		
		final public function get asGraph():GGraph
		{
			return this as GGraph;
		}
		
		final public function get asGroup():GGroup
		{
			return this as GGroup;
		}
		
		final public function get asSlider():GSlider
		{
			return this as GSlider;
		}
		
		final public function get asComboBox():GComboBox
		{
			return this as GComboBox;
		}
		
		final public function get asImage():GImage
		{
			return this as GImage;
		}
		
		final public function get asMovieClip():GMovieClip
		{
			return this as GMovieClip;
		}
		
		public function get text():String
		{
			return null;
		}
		
		public function set text(value:String):void
		{
		}
		
		public function get icon():String
		{
			return null;
		}
		
		public function set icon(value:String):void
		{
		}
		
		public function dispose():void
		{
			removeFromParent();
			_relations.dispose();
		}

		public function addClickListener(listener:Function):void
		{
			addEventListener(GTouchEvent.CLICK, listener);
		}
		
		public function removeClickListener(listener:Function):void
		{
			removeEventListener(GTouchEvent.CLICK, listener);	
		}
		
		public function hasClickListener():Boolean
		{
			return hasEventListener(GTouchEvent.CLICK);
		}
		
		public function addXYChangeCallback(listener:Function):void
		{
			_dispatcher.addListener(XY_CHANGED, listener);
		}
		
		public function addSizeChangeCallback(listener:Function):void
		{
			_dispatcher.addListener(SIZE_CHANGED, listener);
		}
		
		internal function addSizeDelayChangeCallback(listener:Function):void
		{
			_dispatcher.addListener(SIZE_DELAY_CHANGE, listener);
		}
		
		public function removeXYChangeCallback(listener:Function):void
		{
			_dispatcher.removeListener(XY_CHANGED, listener);
		}
		
		public function removeSizeChangeCallback(listener:Function):void
		{
			_dispatcher.removeListener(SIZE_CHANGED, listener);
		}
		
		internal function removeSizeDelayChangeCallback(listener:Function):void
		{
			_dispatcher.removeListener(SIZE_DELAY_CHANGE, listener);
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			super.addEventListener(type, listener, false, priority, useWeakReference);
			
			if(_displayObject!=null)
			{
				if(MTOUCH_EVENTS.indexOf(type)!=-1)
					initMTouch();
				else
				{
					if(type=="rightClick" && (this is GComponent))
						GComponent(this).opaque = true;
					
					_displayObject.addEventListener(type, _reDispatch, useCapture, priority, useWeakReference);
				}
			}
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			super.removeEventListener(type, listener, false);

			if(_displayObject!=null && !this.hasEventListener(type))
			{
				_displayObject.removeEventListener(type, _reDispatch, true);
				_displayObject.removeEventListener(type, _reDispatch, false);
			}
		}
		
		private function _reDispatch(evt:Event):void
		{
			var nevt:Event = evt.clone();
			this.dispatchEvent(nevt);
			if(evt.bubbles && (nevt is IBubbleEvent) && IBubbleEvent(nevt).propagationStopped)
				evt.stopPropagation();
		}
		
		final public function get draggable():Boolean
		{
			return _draggable;
		}
		
		final public function set draggable(value:Boolean):void
		{
			if (_draggable != value)
			{
				_draggable = value;
				initDrag();
			}
		}
		
		final public function get dragBounds():Rectangle
		{
			return _dragBounds;
		}
		
		final public function set dragBounds(value:Rectangle):void
		{
			_dragBounds = value;
		}
		
		public function startDrag(touchPointID:int=-1):void
		{
			if (_displayObject.stage==null)
				return;
			
			dragBegin(null);
			triggerDown(touchPointID);
		}
		
		public function stopDrag():void
		{
			dragEnd();
		}
		
		public function get dragging():Boolean
		{
			return draggingObject==this;
		}
		
		public function localToGlobal(ax:Number=0, ay:Number=0):Point
		{
			if(_pivotAsAnchor)
			{
				ax += _pivotX*_width;
				ay += _pivotY*_height;
			}
			sHelperPoint.x = ax;
			sHelperPoint.y = ay;
			return _displayObject.localToGlobal(sHelperPoint);
		}
		
		public function globalToLocal(ax:Number=0, ay:Number=0):Point
		{
			sHelperPoint.x = ax;
			sHelperPoint.y = ay;
			var pt:Point = _displayObject.globalToLocal(sHelperPoint);
			if(_pivotAsAnchor)
			{
				pt.x -= _pivotX*_width;
				pt.y -= _pivotY*_height;
			}
			return pt;
		}
		
		public function localToRoot(ax:Number=0, ay:Number=0):Point
		{
			if(_pivotAsAnchor)
			{
				ax += _pivotX*_width;
				ay += _pivotY*_height;
			}
			
			sHelperPoint.x = ax;
			sHelperPoint.y = ay;
			var pt:Point = _displayObject.localToGlobal(sHelperPoint);
			pt.x /= GRoot.contentScaleFactor;
			pt.y /= GRoot.contentScaleFactor;
			return pt;
		}
		
		public function rootToLocal(ax:Number=0, ay:Number=0):Point
		{
			sHelperPoint.x = ax;
			sHelperPoint.y = ay;
			sHelperPoint.x *= GRoot.contentScaleFactor;
			sHelperPoint.y *= GRoot.contentScaleFactor;
			var pt:Point = _displayObject.globalToLocal(sHelperPoint);
			if(_pivotAsAnchor)
			{
				pt.x -= _pivotX*_width;
				pt.y -= _pivotY*_height;
			}
			return pt;
		}
		
		public function localToGlobalRect(ax:Number=0, ay:Number=0, aWidth:Number=0, aHeight:Number=0, 
										  resultRect:Rectangle = null):Rectangle
		{
			if(resultRect==null)
				resultRect = new Rectangle();
			var pt:Point = this.localToGlobal(ax, ay);
			resultRect.x = pt.x;
			resultRect.y = pt.y;
			pt = this.localToGlobal(ax+aWidth, ay+aHeight);
			resultRect.right = pt.x;
			resultRect.bottom = pt.y;
			return resultRect;
		}
		
		public function globalToLocalRect(ax:Number=0, ay:Number=0, aWidth:Number=0, aHeight:Number=0, 
										  resultRect:Rectangle = null):Rectangle
		{
			if(resultRect==null)
				resultRect = new Rectangle();
			var pt:Point = this.globalToLocal(ax, ay);
			resultRect.x = pt.x;
			resultRect.y = pt.y;
			pt = this.globalToLocal(ax+aWidth, ay+aHeight);
			resultRect.right = pt.x;
			resultRect.bottom = pt.y;
			return resultRect;
		}
		
		protected function createDisplayObject():void
		{
		}

		protected function switchDisplayObject(newObj:DisplayObject):void
		{
			if(newObj==_displayObject)
				return;
			
			var old:DisplayObject = _displayObject;
			if(_displayObject.parent!=null)
			{
				var i:int = _displayObject.parent.getChildIndex(_displayObject);
				_displayObject.parent.addChildAt(newObj, i);
				_displayObject.parent.removeChild(_displayObject);
			}
			_displayObject = newObj;
			_displayObject.x = old.x;
			_displayObject.y = old.y;
			_displayObject.rotation = old.rotation;
			_displayObject.alpha = old.alpha;
			_displayObject.visible = old.visible;
			_displayObject.scaleX = old.scaleX;
			_displayObject.scaleY = old.scaleY;
			if((_displayObject is InteractiveObject) && (old is InteractiveObject))
			{
				InteractiveObject(_displayObject).mouseEnabled = InteractiveObject(old).mouseEnabled;
				if(_displayObject is DisplayObjectContainer)
					DisplayObjectContainer(_displayObject).mouseChildren = DisplayObjectContainer(old).mouseChildren;
			}
		}

		protected function handlePositionChanged():void
		{
			if(_displayObject)
			{
				var xv:Number = _x;
				var yv:Number = _y+_yOffset;
				if(_pivotAsAnchor)
				{					
					xv -= _pivotX*_width;
					yv -= _pivotY*_height;
				}
				if(_pixelSnapping)
				{
					xv = Math.round(xv);
					yv = Math.round(yv);
				}
				_displayObject.x = xv+_pivotOffsetX;
				_displayObject.y = yv+_pivotOffsetY;
			}
		}
		
		protected function handleSizeChanged():void
		{
			if(_displayObject!=null && _sizeImplType==1 && _sourceWidth!=0 && _sourceHeight!=0)
			{
				_displayObject.scaleX = _width/_sourceWidth*_scaleX;
				_displayObject.scaleY = _height/_sourceHeight*_scaleY;
			}
		}
		
		protected function handleScaleChanged():void
		{
			if(_displayObject!=null)
			{
				if( _sizeImplType==0 || _sourceWidth==0 || _sourceHeight==0)
				{
					_displayObject.scaleX = _scaleX;
					_displayObject.scaleY = _scaleY;
				}
				else
				{
					_displayObject.scaleX = _width/_sourceWidth*_scaleX;
					_displayObject.scaleY = _height/_sourceHeight*_scaleY;
				}
			}
		}
		
		public function handleControllerChanged(c:Controller):void
		{
			_handlingController = true;
			for (var i:int = 0; i < 8; i++)
			{
				var gear:GearBase = _gears[i];
				if (gear != null && gear.controller == c)
					gear.apply();
			}
			_handlingController = false;
			
			checkGearDisplay();
		}
		
		protected function handleGrayedChanged():void
		{
			if(_displayObject)
			{
				if(_grayed)
					_displayObject.filters = ToolSet.GRAY_FILTERS;
				else
					_displayObject.filters = null;
			}	
		}
		
		public function constructFromResource():void
		{
		}

		public function setup_beforeAdd(xml:XML):void
		{
			var str:String;
			var arr:Array;
			
			_id = xml.@id;
			_name = xml.@name;
			
			str = xml.@xy;
			arr = str.split(",");
			this.setXY(parseInt(arr[0]), parseInt(arr[1]));
			
			str = xml.@size;
			if(str)
			{
				arr = str.split(",");
				_initWidth = parseInt(arr[0]);
				_initHeight = parseInt(arr[1]);
				setSize(_initWidth,_initHeight, true);
			}
			
			str = xml.@scale;
			if(str)
			{
				arr = str.split(",");
				setScale(parseFloat(arr[0]), parseFloat(arr[1]));
			}
			
			str = xml.@rotation;
			if(str)
				this.rotation = parseInt(str);
			
			str = xml.@alpha;
			if(str)
				this.alpha = parseFloat(str);
			
			str = xml.@pivot;
			if(str)
			{
				arr = str.split(",");
				var n1:Number = parseFloat(arr[0]);
				var n2:Number = parseFloat(arr[1])
				//旧版本的兼容性处理
				if(n1>2)
				{
					if(_sourceWidth!=0)
						n1 = n1/_sourceWidth;
					else
						n1 = 0;
				}
				
				if(n2>2)
				{
					if(_sourceHeight!=0)
						n2 = n2/_sourceHeight;
					else
						n2 = 0;
				}
				str = xml.@anchor;
				this.setPivot(n1, n2, str=="true");
			}
			else
				this.setPivot(0,0,false);
			
			if(xml.@touchable=="false")
				this.touchable = false;
			if(xml.@visible=="false")
				this.visible = false;
			if(xml.@grayed=="true")
				this.grayed = true;
			this.tooltips = xml.@tooltips;
			
			str = xml.@blend;
			if (str)
				this.blendMode = str;
			
			str = xml.@filter;
			if (str)
			{
				switch (str)
				{
					case "color":
						str = xml.@filterData;
						arr = str.split(",");
						var cm:ColorMatrix = new ColorMatrix();
						cm.adjustBrightness(parseFloat(arr[0]));
						cm.adjustContrast(parseFloat(arr[1]));
						cm.adjustSaturation(parseFloat(arr[2]));
						cm.adjustHue(parseFloat(arr[3]));
						var cf:ColorMatrixFilter = new ColorMatrixFilter(cm);						
						this.filters = [cf];
						break;
				}
			}
		}
		
		private static var GearXMLKeys:Object = {
				"gearDisplay":0,
				"gearXY":1,
				"gearSize":2,
				"gearLook":3,
				"gearColor":4,
				"gearAni":5,
				"gearText":6,
				"gearIcon":7
			};
		
		public function setup_afterAdd(xml:XML):void
		{
			var s:String = xml.@group;
			if(s)
				_group = _parent.getChildById(s) as GGroup;
			
			var col:Object = xml.elements();
			for each(var cxml:XML in col)
			{
				var index:* = GearXMLKeys[cxml.name().localName];
				if(index!=undefined)
					getGear(int(index)).setup(cxml);
			}
		}
		
		//touch support
		//-------------------------------------------------------------------
		private var _touchPointId:int;
		private var _lastClick:int;
		private var _buttonStatus:int;
		private var _touchDownPoint:Point;
		private static const MTOUCH_EVENTS:Array = 
			[GTouchEvent.BEGIN, GTouchEvent.DRAG, GTouchEvent.END, GTouchEvent.CLICK];
		
		public function get isDown():Boolean
		{
			return _buttonStatus==1;
		}
		
		public function triggerDown(touchPointID:int=-1):void
		{
			var st:Stage = _displayObject.stage;
			if(st!=null)
			{
				_buttonStatus = 1;
				if(!GRoot.touchPointInput)
				{
					_displayObject.stage.addEventListener(MouseEvent.MOUSE_UP, __stageMouseup, false, 20);
					if(hasEventListener(GTouchEvent.DRAG))
						_displayObject.stage.addEventListener(MouseEvent.MOUSE_MOVE, __mousemove);
				}
				else
				{
					_touchPointId = touchPointID;
					_displayObject.stage.addEventListener(TouchEvent.TOUCH_END, __stageMouseup, false, 20);
					if(hasEventListener(GTouchEvent.DRAG))
						_displayObject.stage.addEventListener(TouchEvent.TOUCH_MOVE, __mousemove);
				}
			}
		}
		
		private function initMTouch():void
		{
			if(this is GComponent)
			{	/*GComponent is by default not opaque for optimization.
				if a click listener registered, we set opaque to true
				*/
				GComponent(this).opaque = true;
			}
			if(!GRoot.touchPointInput)
			{
				_displayObject.addEventListener(MouseEvent.MOUSE_DOWN, __mousedown);
				_displayObject.addEventListener(MouseEvent.MOUSE_UP, __mouseup);
			}
			else
			{
				_displayObject.addEventListener(TouchEvent.TOUCH_BEGIN, __mousedown);
				_displayObject.addEventListener(TouchEvent.TOUCH_END, __mouseup);
			}
		}
		
		private function __mousedown(evt:Event):void
		{
			var devt:GTouchEvent = new GTouchEvent(GTouchEvent.BEGIN);
			devt.copyFrom(evt);
			this.dispatchEvent(devt);
			if(devt.isPropagationStop)
				evt.stopPropagation();
			
			if(_touchDownPoint==null)
				_touchDownPoint = new Point();
			
			if(!GRoot.touchPointInput)
			{
				_touchDownPoint.x = MouseEvent(evt).stageX;
				_touchDownPoint.y = MouseEvent(evt).stageY;
				triggerDown();
			}
			else
			{
				_touchDownPoint.x = TouchEvent(evt).stageX;
				_touchDownPoint.y = TouchEvent(evt).stageY;
				triggerDown(TouchEvent(evt).touchPointID);
			}
		}
		
		private function __mousemove(evt:Event):void
		{
			if(_buttonStatus!=1
				|| GRoot.touchPointInput && _touchPointId!=TouchEvent(evt).touchPointID)
				return;
			
			if(GRoot.touchPointInput)
			{
				var sensitivity:int = UIConfig.touchDragSensitivity;
				if(_touchDownPoint!=null 
					&& Math.abs(_touchDownPoint.x - TouchEvent(evt).stageX) < sensitivity
					&& Math.abs(_touchDownPoint.y - TouchEvent(evt).stageY) < sensitivity)
					return;
			}
			else
			{
				sensitivity = UIConfig.clickDragSensitivity;
				if(_touchDownPoint!=null 
					&& Math.abs(_touchDownPoint.x - MouseEvent(evt).stageX) < sensitivity
					&& Math.abs(_touchDownPoint.y - MouseEvent(evt).stageY) < sensitivity)
					return;
			}
			
			var devt:GTouchEvent = new GTouchEvent(GTouchEvent.DRAG);
			devt.copyFrom(evt);
			this.dispatchEvent(devt);
			if(devt.isPropagationStop)
				evt.stopPropagation();
		}
		
		private function __mouseup(evt:Event):void
		{
			if(_buttonStatus!=1
				|| GRoot.touchPointInput && _touchPointId!=TouchEvent(evt).touchPointID)
				return;
			
			_buttonStatus = 2;
		}
		
		private function __stageMouseup(evt:Event):void
		{
			if(!GRoot.touchPointInput)
			{
				evt.currentTarget.removeEventListener(MouseEvent.MOUSE_UP, __stageMouseup);
				evt.currentTarget.removeEventListener(MouseEvent.MOUSE_MOVE, __mousemove);
			}
			else
			{
				if(_touchPointId!=TouchEvent(evt).touchPointID)
					return;
				
				evt.currentTarget.removeEventListener(TouchEvent.TOUCH_END, __stageMouseup);
				evt.currentTarget.removeEventListener(TouchEvent.TOUCH_MOVE, __mousemove);
			}
			
			if(_buttonStatus==2)
			{
				var cc:int = 1;
				var now:int = getTimer();
				if(now-_lastClick<500)
				{
					cc = 2;
					_lastClick = 0;
				}
				else
					_lastClick = now;

				var devt:GTouchEvent = new GTouchEvent(GTouchEvent.CLICK);
				devt.copyFrom(evt, cc);

				this.dispatchEvent(devt);
			}
			
			_buttonStatus = 0;
			
			devt = new GTouchEvent(GTouchEvent.END);
			devt.copyFrom(evt);
			this.dispatchEvent(devt);
		}
		//-------------------------------------------------------------------
		
		//drag support
		//-------------------------------------------------------------------
		private static var sGlobalDragStart:Point = new Point();
		private static var sGlobalRect:Rectangle = new Rectangle();
		private static var sHelperPoint:Point = new Point();
		private static var sDragHelperRect:Rectangle = new Rectangle();
		private static var sUpdateInDragging:Boolean;
		
		private function initDrag():void
		{
			if(_draggable)
				addEventListener(GTouchEvent.BEGIN, __begin);
			else
				removeEventListener(GTouchEvent.BEGIN, __begin);
		}
		
		private function dragBegin(evt:GTouchEvent):void
		{
			if(draggingObject!=null)
			{
				draggingObject.stopDrag();
				draggingObject = null;
			}
			
			if(evt!=null)
			{
				sGlobalDragStart.x = evt.stageX;
				sGlobalDragStart.y = evt.stageY;
			}
			else
			{
				sGlobalDragStart.x = _displayObject.stage.mouseX;
				sGlobalDragStart.y = _displayObject.stage.mouseY;
			}
			this.localToGlobalRect(0,0,this.width,this.height,sGlobalRect);
			draggingObject = this;
			
			addEventListener(GTouchEvent.DRAG, __dragging);
			addEventListener(GTouchEvent.END, __dragEnd);
		}
		
		private function dragEnd():void
		{
			if (draggingObject==this)
			{
				removeEventListener(GTouchEvent.DRAG, __dragStart);
				removeEventListener(GTouchEvent.END, __dragEnd);
				removeEventListener(GTouchEvent.DRAG, __dragging);
				draggingObject = null;
			}
		}
		
		private function __begin(evt:GTouchEvent):void
		{
			if((evt.realTarget is TextField) && TextField(evt.realTarget).type==TextFieldType.INPUT)
				return;
			
			addEventListener(GTouchEvent.DRAG, __dragStart);
		}
		
		private function __dragStart(evt:GTouchEvent):void
		{
			removeEventListener(GTouchEvent.DRAG, __dragStart);
			
			if((evt.realTarget is TextField) && TextField(evt.realTarget).type==TextFieldType.INPUT)
				return;
			
			var dragEvent:DragEvent = new DragEvent(DragEvent.DRAG_START);
			dragEvent.stageX = evt.stageX;
			dragEvent.stageY = evt.stageY;
			dragEvent.touchPointID = evt.touchPointID;
			dispatchEvent(dragEvent);
			
			if (!dragEvent.isDefaultPrevented())
				dragBegin(evt);
		}
		
		private function __dragging(evt:GTouchEvent):void
		{				
			if(this.parent==null)
				return;
			
			var xx:Number = evt.stageX - sGlobalDragStart.x + sGlobalRect.x;
			var yy:Number = evt.stageY - sGlobalDragStart.y　+ sGlobalRect.y;
			
			if (_dragBounds!=null)
			{
				var rect:Rectangle = GRoot.inst.localToGlobalRect(_dragBounds.x, _dragBounds.y,
					_dragBounds.width,_dragBounds.height, sDragHelperRect);
				if (xx < rect.x)
					xx = rect.x;
				else if(xx + sGlobalRect.width > rect.right)
				{
					xx = rect.right - sGlobalRect.width;
					if (xx < rect.x)
						xx = rect.x;
				}
				
				if(yy < rect.y)
					yy = rect.y;
				else if(yy + sGlobalRect.height > rect.bottom)
				{
					yy = rect.bottom - sGlobalRect.height;
					if(yy < rect.y)
						yy = rect.y;
				}
			}
			
			sUpdateInDragging = true;
			var pt:Point = this.parent.globalToLocal(xx, yy);
			this.setXY(Math.round(pt.x), Math.round(pt.y));
			sUpdateInDragging = false;
			
			
			var dragEvent:DragEvent = new DragEvent(DragEvent.DRAG_MOVING);
			dragEvent.stageX = evt.stageX;
			dragEvent.stageY = evt.stageY;
			dragEvent.touchPointID = evt.touchPointID;
			dispatchEvent(dragEvent);
		}
		
		private function __dragEnd(evt:GTouchEvent):void
		{
			if (draggingObject==this)
			{
				stopDrag();
				
				var dragEvent:DragEvent = new DragEvent(DragEvent.DRAG_END);
				dragEvent.stageX = evt.stageX;
				dragEvent.stageY = evt.stageY;
				dragEvent.touchPointID = evt.touchPointID;
				dispatchEvent(dragEvent);
			}
		}
		//-------------------------------------------------------------------
	}
}
