package fairygui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Ease;
	import com.greensock.easing.EaseLookup;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	
	import fairygui.event.GTouchEvent;
	import fairygui.utils.GTimers;
	import fairygui.utils.ToolSet;
	
	[Event(name = "scroll", type = "flash.events.Event")]
	[Event(name = "scrollEnd", type = "flash.events.Event")]
	[Event(name = "pullDownRelease", type = "flash.events.Event")]
	[Event(name = "pullUpRelease", type = "flash.events.Event")]
	public class ScrollPane extends EventDispatcher
	{
		private var _owner:GComponent;
		private var _container:Sprite;
		private var _maskContainer:Sprite;

		private var _viewWidth:Number;
		private var _viewHeight:Number;
		private var _contentWidth:Number;
		private var _contentHeight:Number;
	
		private var _scrollType:int;
		private var _scrollSpeed:int;
		private var _mouseWheelSpeed:int;
		private var _scrollBarMargin:Margin;
		private var _bouncebackEffect:Boolean;
		private var _touchEffect:Boolean;
		private var _scrollBarDisplayAuto:Boolean;
		private var _vScrollNone:Boolean;
		private var _hScrollNone:Boolean;
		
		private var _displayOnLeft:Boolean;
		private var _snapToItem:Boolean;
		private var _displayInDemand:Boolean;
		private var _mouseWheelEnabled:Boolean;
		private var _pageMode:Boolean;
		private var _pageSizeH:Number;
		private var _pageSizeV:Number;
		private var _inertiaDisabled:Boolean;
		private var _maskDisabled:Boolean;
		
		private var _xPerc:Number, _yPerc:Number;
		private var _xPos:Number, _yPos:Number;
		private var _xOverlap:Number, _yOverlap:Number;
		
		private static var _easeTypeFunc:Ease;
		private var _throwTween:ThrowTween;
		private var _tweening:int;
		private var _tweener:TweenLite;
		
		private var _time1:uint, _time2:uint;
		private var _y1:Number, _y2:Number;
		private var _x1:Number, _x2:Number;
		private var _xOffset:Number, _yOffset:Number;
		
		private var _needRefresh:Boolean;
		private var _holdAreaPoint:Point;
		private var _isHoldAreaDone:Boolean;
		private var _aniFlag:int;
		private var _scrollBarVisible:Boolean;
		
		private var _hzScrollBar:GScrollBar;
		private var _vtScrollBar:GScrollBar;
		
		public var isDragged:Boolean;
		public static var draggingPane:ScrollPane;
		private static var _gestureFlag:int = 0;
		
		private static var sHelperPoint:Point = new Point();
		private static var sHelperRect:Rectangle = new Rectangle();
		
		public static const SCROLL_END:String = "scrollEnd";
		public static const PULL_DOWN_RELEASE:String = "pullDownRelease";
		public static const PULL_UP_RELEASE:String = "pullUpRelease";
		
		public function ScrollPane(owner:GComponent, 
								   scrollType:int,
								   scrollBarMargin:Margin,
								   scrollBarDisplay:int,
								   flags:int,
								   vtScrollBarRes:String,
								   hzScrollBarRes:String):void
		{
			if(_easeTypeFunc==null)
				_easeTypeFunc = EaseLookup.find("Cubic.easeOut");
			_throwTween = new ThrowTween();
			
			_owner = owner;
			owner.opaque = true;

			_scrollBarMargin = scrollBarMargin;
			_scrollType = scrollType;
			_scrollSpeed = UIConfig.defaultScrollSpeed;
			_mouseWheelSpeed = _scrollSpeed*2;
			
			_displayOnLeft = (flags & 1)!=0;
			_snapToItem = (flags & 2)!=0;
			_displayInDemand = (flags & 4)!=0;
			_pageMode = (flags & 8)!=0;
			if(flags & 16)
				_touchEffect = true;
			else if(flags & 32)
				_touchEffect = false;
			else
				_touchEffect = UIConfig.defaultScrollTouchEffect;
			if(flags & 64)
				_bouncebackEffect = true;
			else if(flags & 128)
				_bouncebackEffect = false;
			else
				_bouncebackEffect = UIConfig.defaultScrollBounceEffect;
			_inertiaDisabled = (flags & 256)!=0;
			_maskDisabled = (flags & 512) != 0;
			
			if(scrollBarDisplay==ScrollBarDisplayType.Default)
				scrollBarDisplay = UIConfig.defaultScrollBarDisplay;
			
			_xPerc = 0;
			_yPerc = 0;
			_xPos = 0;
			_yPos = 0;
			_xOverlap = 0;
			_yOverlap = 0;
			_scrollBarVisible = true;
			_mouseWheelEnabled = true;
			_holdAreaPoint = new Point();
			_pageSizeH = 1;
			_pageSizeV = 1;
			
			_maskContainer = new Sprite();
			_maskContainer.mouseEnabled = false;
			_owner._rootContainer.addChild(_maskContainer);
	
			_container = _owner._container;
			_container.x = 0;
			_container.y = 0;
			_container.mouseEnabled = false;			
			_maskContainer.addChild(_container);
			
			if(!_maskDisabled)
				_maskContainer.scrollRect = new Rectangle();

			if(scrollBarDisplay!=ScrollBarDisplayType.Hidden)
			{
				if(_scrollType==ScrollType.Both || _scrollType==ScrollType.Vertical)
				{
					var res:String = vtScrollBarRes?vtScrollBarRes:UIConfig.verticalScrollBar;
					if(res)
					{
						_vtScrollBar = UIPackage.createObjectFromURL(res) as GScrollBar;
						if(!_vtScrollBar)
							throw new Error("cannot create scrollbar from " + res);
						_vtScrollBar.setScrollPane(this, true);
						_owner._rootContainer.addChild(_vtScrollBar.displayObject);
					}
				}
				if(_scrollType==ScrollType.Both || _scrollType==ScrollType.Horizontal)
				{
					res = hzScrollBarRes?hzScrollBarRes:UIConfig.horizontalScrollBar;
					if(res)
					{
						_hzScrollBar = UIPackage.createObjectFromURL(res) as GScrollBar;
						if(!_hzScrollBar)
							throw new Error("cannot create scrollbar from " + res);
						_hzScrollBar.setScrollPane(this, false);
						_owner._rootContainer.addChild(_hzScrollBar.displayObject);
					}
				}
				
				_scrollBarDisplayAuto = scrollBarDisplay==ScrollBarDisplayType.Auto;
				if(_scrollBarDisplayAuto)
				{
					_scrollBarVisible = false;
					if(_vtScrollBar)
						_vtScrollBar.displayObject.visible = false;
					if(_hzScrollBar)
						_hzScrollBar.displayObject.visible = false;
					
					if(Mouse.supportsCursor)
					{
						_owner._rootContainer.addEventListener(MouseEvent.ROLL_OVER, __rollOver);
						_owner._rootContainer.addEventListener(MouseEvent.ROLL_OUT, __rollOut);
					}
				}
			}
			else
				_mouseWheelEnabled = false;
			
			_contentWidth = 0;
			_contentHeight = 0;
			setSize(owner.width, owner.height);
			
			_owner._rootContainer.addEventListener(MouseEvent.MOUSE_WHEEL, __mouseWheel);
			_owner.addEventListener(GTouchEvent.BEGIN, __mouseDown);
			_owner.addEventListener(GTouchEvent.END, __mouseUp);
		}
		
		public function get owner():GComponent
		{
			return _owner;
		}
		
		public function get bouncebackEffect():Boolean
		{
			return _bouncebackEffect;
		}
		
		public function set bouncebackEffect(sc:Boolean):void
		{
			_bouncebackEffect = sc;
		}
		
		public function get touchEffect():Boolean
		{
			return _touchEffect;
		}
		
		public function set touchEffect(sc:Boolean):void
		{
			_touchEffect = sc;
		}
		
		public function set scrollSpeed(val:int):void
		{
			_scrollSpeed = val;
			if(_scrollSpeed==0)
				_scrollSpeed = UIConfig.defaultScrollSpeed;
			_mouseWheelSpeed = _scrollSpeed*2;
		}
		
		public function get scrollSpeed():int
		{
			return _scrollSpeed;
		}
		
		public function get snapToItem():Boolean
		{
			return _snapToItem;
		}
		
		public function set snapToItem(value:Boolean):void
		{
			_snapToItem = value;
		}
		
		public function get mouseWheelEnabled():Boolean
		{
			return _mouseWheelEnabled;
		}
		
		public function set mouseWheelEnabled(value:Boolean):void
		{
			_mouseWheelEnabled = value;
		}
		
		public function get percX():Number
		{
			return _xPerc;
		}
		
		public function set percX(value:Number):void
		{
			setPercX(value, false);
		}
		
		public function setPercX(value:Number, ani:Boolean=false):void
		{
			_owner.ensureBoundsCorrect();
			
			value = ToolSet.clamp01(value);
			if(value != _xPerc)
			{
				_xPerc = value;
				_xPos = _xPerc*_xOverlap;
				posChanged(ani);
			}
		}
		
		public function get percY():Number
		{
			return _yPerc;
		}
		
		public function set percY(value:Number):void
		{
			setPercY(value, false);
		}
		
		public function setPercY(value:Number, ani:Boolean=false):void
		{
			_owner.ensureBoundsCorrect();
			
			value = ToolSet.clamp01(value);
			if(value != _yPerc)
			{
				_yPerc = value;
				_yPos = _yPerc*_yOverlap;
				posChanged(ani);
			}
		}
		
		public function get posX():Number
		{
			return _xPos;
		}
		
		public function set posX(value:Number):void 
		{
			setPosX(value, false);
		}
		
		public function setPosX(value:Number, ani:Boolean=false):void
		{
			_owner.ensureBoundsCorrect();
			
			value = ToolSet.clamp(value, 0, _xOverlap);
			if(value!=_xPos)
			{
				_xPos = value;
				_xPerc = _xOverlap==0?0:_xPos/_xOverlap;
				
				posChanged(ani);
			}
		}
		
		public function get posY():Number 
		{
			return _yPos;
		}
		
		public function set posY(value:Number):void
		{
			setPosY(value, false);
		}
		
		public function setPosY(value:Number, ani:Boolean=false):void
		{
			_owner.ensureBoundsCorrect();
			
			value = ToolSet.clamp(value, 0, _yOverlap);
			if(value!=_yPos)
			{
				_yPos = value;
				_yPerc = _yOverlap==0?0:_yPos/_yOverlap;
				
				posChanged(ani);
			}
		}
		
		public function get isBottomMost():Boolean
		{
			return _yPerc==1 || _yOverlap==0;
		}
		
		public function get isRightMost():Boolean
		{
			return _xPerc==1 || _xOverlap==0;
		}
		
		public function get currentPageX():int
		{
			return _pageMode ? Math.floor(this.posX / _pageSizeH):0;
		}
		
		public function set currentPageX(value:int):void
		{
			if (_pageMode && _xOverlap>0)
				this.setPosX(value * _pageSizeH, false);
		}
		
		public function get currentPageY():int
		{
			return _pageMode ? Math.floor(this.posY / _pageSizeV):0;
		}
		
		public function set currentPageY(value:int):void
		{
			if (_pageMode && _yOverlap>0)
				this.setPosY(value * _pageSizeV, false);
		}
		
		public function get scrollingPosX():Number
		{
			return ToolSet.clamp(-_container.x, 0, _xOverlap);
		}
		
		public function get scrollingPosY():Number
		{
			return ToolSet.clamp(-_container.y, 0, _yOverlap);
		}
		
		public function get contentWidth():Number
		{
			return _contentWidth;
		}
		
		public function get contentHeight():Number
		{
			return _contentHeight;
		}
		
		public function get viewWidth():int
		{
			return _viewWidth;
		}
		
		public function set viewWidth(value:int):void
		{
			value = value + _owner.margin.left + _owner.margin.right;
			if (_vtScrollBar != null)
				value += _vtScrollBar.width;
			_owner.width = value;
		}
		
		public function get viewHeight():int
		{
			return _viewHeight;
		}
		
		public function set viewHeight(value:int):void
		{
			value = value + _owner.margin.top + _owner.margin.bottom;
			if (_hzScrollBar != null)
				value += _hzScrollBar.height;
			_owner.height = value;
		}
		
		private function getDeltaX(move:Number):Number
		{
			return (_pageMode?_pageSizeH:move)/(_contentWidth-_viewWidth);
		}
		
		private function getDeltaY(move:Number):Number
		{
			return (_pageMode?_pageSizeV:move)/(_contentHeight-_viewHeight);
		}
		
		public function scrollTop(ani:Boolean=false):void 
		{
			this.setPercY(0, ani);
		}
		
		public function scrollBottom(ani:Boolean=false):void 
		{
			this.setPercY(1, ani);
		}
		
		public function scrollUp(speed:Number=1, ani:Boolean=false):void 
		{
			this.setPercY(_yPerc - getDeltaY(_scrollSpeed*speed), ani);
		}
		
		public function scrollDown(speed:Number=1, ani:Boolean=false):void
		{
			this.setPercY(_yPerc + getDeltaY(_scrollSpeed*speed), ani);
		}
		
		public function scrollLeft(speed:Number=1, ani:Boolean=false):void
		{
			this.setPercX(_xPerc - getDeltaX(_scrollSpeed*speed), ani);
		}
		
		public function scrollRight(speed:Number=1, ani:Boolean=false):void　
		{
			this.setPercX(_xPerc + getDeltaX(_scrollSpeed*speed), ani);
		}

		/**
		 * @param target GObject: can be any object on stage, not limited to the direct child of this container.
		 * 				or Rectangle: Rect in local coordinates
		 * @param ani If moving to target position with animation
		 * @param setFirst If true, scroll to make the target on the top/left; If false, scroll to make the target any position in view.
		 */
		public function scrollToView(target:*, ani:Boolean=false, setFirst:Boolean=false):void
		{
			_owner.ensureBoundsCorrect();
			if(_needRefresh)
				refresh();
			
			var rect:Rectangle;
			if(target is GObject)
			{
				if (target.parent != _owner)
				{
					GObject(target).parent.localToGlobalRect(target.x, target.y, 
						target.width, target.height, sHelperRect);
					rect = _owner.globalToLocalRect(sHelperRect.x, sHelperRect.y, 
						sHelperRect.width, sHelperRect.height, sHelperRect);
				}
				else
				{
					rect = sHelperRect;
					rect.setTo(target.x, target.y, target.width, target.height);					
				}
			}
			else
				rect = Rectangle(target);			


			if(_yOverlap>0)
			{
				var bottom:Number = _yPos+_viewHeight;
				if(setFirst || rect.y<=_yPos || rect.height>=_viewHeight)
				{
					if(_pageMode)
						this.setPosY(Math.floor(rect.y/_pageSizeV)*_pageSizeV, ani);
					else
						this.setPosY(rect.y, ani);
				}
				else if(rect.y+rect.height>bottom)
				{
					if(_pageMode)
						this.setPosY(Math.floor(rect.y/_pageSizeV)*_pageSizeV, ani);
					else if (rect.height <= _viewHeight/2)
						this.setPosY(rect.y+rect.height*2-_viewHeight, ani);
					else
						this.setPosY(rect.y+rect.height-_viewHeight, ani);
				}
			}
			if(_xOverlap>0)
			{
				var right:Number = _xPos+_viewWidth;
				if(setFirst || rect.x<=_xPos || rect.width>=_viewWidth)
				{
					if(_pageMode)
						this.setPosX(Math.floor(rect.x/_pageSizeH)*_pageSizeH, ani);
					else
						this.setPosX(rect.x, ani);
				}
				else if(rect.x+rect.width>right)
				{
					if(_pageMode)
						this.setPosX(Math.floor(rect.x/_pageSizeH)*_pageSizeH, ani);
					else if (rect.width <= _viewWidth/2)
						this.setPosX(rect.x+rect.width*2-_viewWidth, ani);
					else
						this.setPosX(rect.x+rect.width-_viewWidth, ani);
				}
			}
			
			if(!ani && _needRefresh)
				refresh();
		}
		
		/**
		 * @param obj obj must be the direct child of this container
		 */
		public function isChildInView(obj:GObject):Boolean
		{
			if(_yOverlap>0)
			{
				var dist:Number = obj.y+_container.y;
				if(dist<-obj.height-20 || dist>_viewHeight+20)
					return false;
			}
			
			if(_xOverlap>0)
			{
				dist = obj.x + _container.x;
				if(dist<-obj.width-20 || dist>_viewWidth+20)
					return false;
			}
			
			return true;
		}
		
		public function cancelDragging():void
		{
			_owner.removeEventListener(GTouchEvent.DRAG, __mouseMove);
			
			if (draggingPane == this)
				draggingPane = null;
			
			_gestureFlag = 0;
			isDragged = false;
			_maskContainer.mouseChildren = true;
		}
		
		internal function onOwnerSizeChanged():void
		{
			setSize(_owner.width, _owner.height);
			posChanged(false);
		}
		
		internal function adjustMaskContainer():void
		{
			var mx:Number, my:Number;
			if (_displayOnLeft && _vtScrollBar != null)
				mx = Math.floor(_owner.margin.left + _vtScrollBar.width);
			else
				mx = Math.floor(_owner.margin.left);
			my = Math.floor(_owner.margin.top);
			mx += _owner._alignOffset.x;
			my += _owner._alignOffset.y;
			
			_maskContainer.x = mx;
			_maskContainer.y = my;
		}
		
		private function setSize(aWidth:Number, aHeight:Number):void 
		{
			adjustMaskContainer();
			
			if(_hzScrollBar)
			{
				_hzScrollBar.y = aHeight - _hzScrollBar.height;
				if(_vtScrollBar)
				{
					_hzScrollBar.width = aWidth - _vtScrollBar.width - _scrollBarMargin.left - _scrollBarMargin.right;
					if(_displayOnLeft)
						_hzScrollBar.x = _scrollBarMargin.left + _vtScrollBar.width;
					else
						_hzScrollBar.x = _scrollBarMargin.left;
				}
				else
				{
					_hzScrollBar.width = aWidth - _scrollBarMargin.left - _scrollBarMargin.right;
					_hzScrollBar.x = _scrollBarMargin.left;
				}
			}
			if(_vtScrollBar)
			{
				if(!_displayOnLeft)
					_vtScrollBar.x = aWidth - _vtScrollBar.width;
				if(_hzScrollBar)
					_vtScrollBar.height = aHeight - _hzScrollBar.height - _scrollBarMargin.top - _scrollBarMargin.bottom;
				else
					_vtScrollBar.height = aHeight - _scrollBarMargin.top - _scrollBarMargin.bottom;
				_vtScrollBar.y = _scrollBarMargin.top;
			}
			
			_viewWidth = aWidth;
			_viewHeight = aHeight;
			if(_hzScrollBar && !_hScrollNone)
				_viewHeight -= _hzScrollBar.height;
			if(_vtScrollBar && !_vScrollNone)
				_viewWidth -= _vtScrollBar.width;
			_viewWidth -= (_owner.margin.left+_owner.margin.right);
			_viewHeight -= (_owner.margin.top+_owner.margin.bottom);
			
			_viewWidth = Math.max(1, _viewWidth);
			_viewHeight = Math.max(1, _viewHeight);
			_pageSizeH = _viewWidth;
			_pageSizeV = _viewHeight;
			
			handleSizeChanged();
		}

		internal function setContentSize(aWidth:Number, aHeight:Number):void
		{
			if(_contentWidth==aWidth && _contentHeight==aHeight)
				return;
			
			_contentWidth = aWidth;
			_contentHeight = aHeight;
			handleSizeChanged();
		}
		
		internal function changeContentSizeOnScrolling(deltaWidth:Number, deltaHeight:Number,
													   deltaPosX:Number, deltaPosY:Number):void
		{
			_contentWidth += deltaWidth;
			_contentHeight += deltaHeight;
			
			if (isDragged)
			{
				if (deltaPosX != 0)
					_container.x -= deltaPosX;
				if (deltaPosY != 0)
					_container.y -= deltaPosY;
				
				validateHolderPos();
				
				_xOffset += deltaPosX;
				_yOffset += deltaPosY;
				
				var tmp:Number = _y2 - _y1;
				_y1 = _container.y;
				_y2 = _y1 + tmp;
				
				tmp = _x2 - _x1;
				_x1 = _container.x;
				_x2 = _x1 + tmp;
				
				_yPos = -_container.y;
				_xPos = -_container.x;
			}
			else if (_tweening == 2)
			{
				if (deltaPosX != 0)
				{
					_container.x -= deltaPosX;
					_throwTween.start.x -= deltaPosX;
				}
				if (deltaPosY != 0)
				{
					_container.y -= deltaPosY;
					_throwTween.start.y -= deltaPosY;
				}
			}
			
			handleSizeChanged(true);
		}
		
		private function handleSizeChanged(onScrolling:Boolean=false):void
		{
			if(_displayInDemand)
			{
				if(_vtScrollBar)
				{
					if(_contentHeight<=_viewHeight)
					{
						if(!_vScrollNone)
						{
							_vScrollNone = true;
							_viewWidth += _vtScrollBar.width;
						}
					}
					else
					{
						if(_vScrollNone)
						{
							_vScrollNone = false;
							_viewWidth -= _vtScrollBar.width;
						}
					}
				}
				if(_hzScrollBar)
				{
					if(_contentWidth<=_viewWidth)
					{
						if(!_hScrollNone)
						{
							_hScrollNone = true;
							_viewHeight += _hzScrollBar.height;
						}
					}
					else
					{
						if(_hScrollNone)
						{
							_hScrollNone = false;
							_viewHeight -= _hzScrollBar.height;
						}
					}
				}
			}

			if(_vtScrollBar)
			{
				if(_viewHeight<_vtScrollBar.minSize)
					//没有使用_vtScrollBar.visible是因为ScrollBar用了一个trick，它并不在owner的DisplayList里，因此_vtScrollBar.visible是无效的
					_vtScrollBar.displayObject.visible = false;
				else
				{
					_vtScrollBar.displayObject.visible = _scrollBarVisible && !_vScrollNone;
					if(_contentHeight==0)
						_vtScrollBar.displayPerc = 0;
					else
						_vtScrollBar.displayPerc = Math.min(1, _viewHeight/_contentHeight);
				}
			}
			if(_hzScrollBar)
			{
				if(_viewWidth<_hzScrollBar.minSize)
					_hzScrollBar.displayObject.visible = false;
				else
				{
					_hzScrollBar.displayObject.visible = _scrollBarVisible && !_hScrollNone;
					if(_contentWidth==0)
						_hzScrollBar.displayPerc = 0;
					else
						_hzScrollBar.displayPerc = Math.min(1, _viewWidth/_contentWidth);
				}
			}
			
			if (!_maskDisabled)
			{
				var rect:Rectangle = _maskContainer.scrollRect;
				rect.x = -_owner._alignOffset.x;
				rect.y = -_owner._alignOffset.y;
				rect.width = _viewWidth;
				rect.height = _viewHeight;
				_maskContainer.scrollRect = rect;
			}

			if (_scrollType == ScrollType.Horizontal || _scrollType == ScrollType.Both)
				_xOverlap = Math.ceil(Math.max(0, _contentWidth - _viewWidth));
			else
				_xOverlap = 0;
			if (_scrollType == ScrollType.Vertical || _scrollType == ScrollType.Both)
				_yOverlap = Math.ceil(Math.max(0, _contentHeight - _viewHeight));
			else
				_yOverlap = 0;
			
			if(_tweening==0 && onScrolling)
			{
				//如果原来是在边缘，且不在缓动状态，那么尝试继续贴边。（如果在缓动状态，需要修改tween的终值，暂时未支持）
				if(_xPerc==0 || _xPerc==1)
				{
					_xPos = _xPerc * _xOverlap;
					_container.x = -_xPos;
				}
				if(_yPerc==0 || _yPerc==1)
				{
					_yPos = _yPerc * _yOverlap;
					_container.y = -_yPos;
				}
			}
			else
			{
				//边界检查
				_xPos = ToolSet.clamp(_xPos, 0, _xOverlap);
				_xPerc = _xOverlap>0?_xPos/_xOverlap:0;
				
				_yPos = ToolSet.clamp(_yPos, 0, _yOverlap);
				_yPerc = _yOverlap>0?_yPos/_yOverlap:0;
			}
			
			validateHolderPos();
			
			if (_vtScrollBar != null)
				_vtScrollBar.scrollPerc = _yPerc;
			if (_hzScrollBar != null)
				_hzScrollBar.scrollPerc = _xPerc;
		}
		
		private function validateHolderPos():void
		{
			_container.x = ToolSet.clamp(_container.x, -_xOverlap, 0);
			_container.y = ToolSet.clamp(_container.y, -_yOverlap, 0);
		}
		
		private function posChanged(ani:Boolean):void
		{
			if (_aniFlag == 0)
				_aniFlag = ani ? 1 : -1;
			else if (_aniFlag == 1 && !ani)
				_aniFlag = -1;
			
			_needRefresh = true;
			GTimers.inst.callLater(refresh);
			
			//如果在甩手指滚动过程中用代码重新设置滚动位置，要停止滚动
			if(_tweening==2)
				killTween();
		}
		
		private function killTween():void
		{
			if(_tweening==1)
			{
				_tweener.totalTime(_tweener.totalDuration());
			}
			else if(_tweening==2)
			{
				_tweener.kill();
				_tweener = null;
				_tweening = 0;

				validateHolderPos();
				syncScrollBar(true);
				dispatchEvent(new Event(SCROLL_END));
			}			
		}
		
		private function refresh():void
		{
			_needRefresh = false;
			GTimers.inst.remove(refresh);			

			if(_pageMode)
			{
				var page:int;
				var delta:Number;
				if(_yOverlap>0 && _yPerc!=1 && _yPerc!=0)
				{
					page = Math.floor(_yPos / _pageSizeV);
					delta = _yPos - page*_pageSizeV;
					if(delta>_pageSizeV/2)
						page++;
					_yPos = page * _pageSizeV;
					if(_yPos>_yOverlap)
					{
						_yPos = _yOverlap;
						_yPerc = 1;
					}
					else
						_yPerc = _yPos / _yOverlap;
				}
				
				if(_xOverlap>0 && _xPerc!=1 && _xPerc!=0)
				{
					page = Math.floor(_xPos / _pageSizeH);
					delta = _xPos - page*_pageSizeH;
					if(delta>_pageSizeH/2)
						page++;
					_xPos = page * _pageSizeH;
					if(_xPos>_xOverlap)
					{
						_xPos = _xOverlap;
						_xPerc = 1;
					}
					else
						_xPerc = _xPos / _xOverlap;
				}
			}
			else if(_snapToItem)
			{
				var pt:Point = _owner.getSnappingPosition(_xPerc==1?0:_xPos, _yPerc==1?0:_yPos, sHelperPoint);
				if (_xPerc != 1 && pt.x!=_xPos)
				{
					_xPos = pt.x;
					_xPerc = _xPos / _xOverlap;
					if(_xPerc>1)
					{
						_xPerc = 1;
						_xPos = _xOverlap;
					}
				}
				if (_yPerc != 1 && pt.y!=_yPos)
				{
					_yPos = pt.y;
					_yPerc = _yPos / _yOverlap;
					if(_yPerc>1)
					{
						_yPerc = 1;
						_yPos = _yOverlap;
					}
				}
			}
			
			refresh2();
			
			dispatchEvent(new Event(Event.SCROLL));
			
			if (_needRefresh) //user change scroll pos in on scroll
			{
				_needRefresh = false;
				GTimers.inst.remove(refresh);

				refresh2();
			}
			_aniFlag = 0;
		}
		
		private function refresh2():void
		{
			var contentXLoc:int = int(_xPos);
			var contentYLoc:int = int(_yPos);
			
			if(_aniFlag==1 && !isDragged)
			{
				var toX:Number = _container.x;
				var toY:Number = _container.y;
				
				if(_yOverlap>0)
				{
					toY = -contentYLoc;
				}
				else
				{
					if(_container.y!=0)
						_container.y = 0;
				}
				if(_xOverlap>0)
				{
					toX = -contentXLoc;
				}
				else
				{
					if(_container.x!=0)
						_container.x = 0;
				}
				
				if(toX!=_container.x || toY!=_container.y)
				{
					if(_tweener!=null)
						_tweener.kill();
					
					_maskContainer.mouseChildren = false;
					_tweening = 1;
					
					_tweener = TweenLite.to(_container, 0.5, { x:toX, y:toY,
						onUpdate:__tweenUpdate, onComplete:__tweenComplete, 
						ease:_easeTypeFunc } );
				}
			}
			else
			{
				if(_tweener!=null)
					killTween();
				
				//如果在拖动的过程中Refresh，这里要进行处理，保证拖动继续正常进行
				if (isDragged)
				{
					_xOffset += _container.x - (-contentXLoc);
					_yOffset += _container.y - (-contentYLoc);
				}
				
				_container.y = -contentYLoc;
				_container.x = -contentXLoc;
				
				//如果在拖动的过程中Refresh，这里要进行处理，保证手指离开是滚动正常进行
				if (isDragged)
				{
					_y1 = _y2 = _container.y;
					_x1 = _x2 = _container.x;
				}

				if(_vtScrollBar)
					_vtScrollBar.scrollPerc = _yPerc;
				if(_hzScrollBar)
					_hzScrollBar.scrollPerc = _xPerc;
			}
		}
		
		private function syncPos():void
		{
			if(_xOverlap>0)
			{
				_xPos = ToolSet.clamp(-_container.x, 0, _xOverlap);
				_xPerc = _xPos / _xOverlap;
			}
			
			if(_yOverlap>0)
			{
				_yPos = ToolSet.clamp(-_container.y, 0, _yOverlap);
				_yPerc = _yPos / _yOverlap;
			}
		}
		
		private function syncScrollBar(end:Boolean=false):void
		{
			if(end)
			{
				if(_vtScrollBar)
				{
					if(_scrollBarDisplayAuto)
						showScrollBar(false);
				}
				if(_hzScrollBar)
				{
					if(_scrollBarDisplayAuto)
						showScrollBar(false);
				}
				_maskContainer.mouseChildren = true;
			}
			else
			{
				if(_vtScrollBar)
				{
					_vtScrollBar.scrollPerc = _yOverlap == 0 ? 0 : ToolSet.clamp(-_container.y, 0, _yOverlap) / _yOverlap;
					if(_scrollBarDisplayAuto)
						showScrollBar(true);
				}
				if(_hzScrollBar)
				{
					_hzScrollBar.scrollPerc =  _xOverlap == 0 ? 0 : ToolSet.clamp(-_container.x, 0, _xOverlap) / _xOverlap;
					if(_scrollBarDisplayAuto)
						showScrollBar(true);
				}
			}
		}

		private function __mouseDown(e:Event):void
		{
			if(!_touchEffect)
				return;

			if(_tweener!=null)
				killTween();

			_x1 = _x2 = _container.x;
			_y1 = _y2 = _container.y;
			
			_xOffset = _maskContainer.mouseX - _container.x;
			_yOffset = _maskContainer.mouseY - _container.y;
			
			_time1 = _time2 = getTimer();
			_holdAreaPoint.x = _maskContainer.mouseX;
			_holdAreaPoint.y = _maskContainer.mouseY;
			_isHoldAreaDone = false;
			isDragged = false;
			
			_owner.addEventListener(GTouchEvent.DRAG, __mouseMove);
		}
		
		private function __mouseMove(e:GTouchEvent):void
		{
			if(!_touchEffect)
				return;
			
			if (draggingPane != null && draggingPane != this || GObject.draggingObject != null) //已经有其他拖动
				return;
			
			var sensitivity:int;
			if (GRoot.touchScreen)
				sensitivity = UIConfig.touchScrollSensitivity;
			else
				sensitivity = 8;
			
			var diff:Number, diff2:Number;
			var sv:Boolean, sh:Boolean, st:Boolean;
			
			if (_scrollType == ScrollType.Vertical) 
			{
				if (!_isHoldAreaDone)
				{
					//表示正在监测垂直方向的手势
					_gestureFlag |= 1;
					
					diff = Math.abs(_holdAreaPoint.y - _maskContainer.mouseY);
					if (diff < sensitivity)
						return;
					
					if ((_gestureFlag & 2) != 0) //已经有水平方向的手势在监测，那么我们用严格的方式检查是不是按垂直方向移动，避免冲突
					{
						diff2 = Math.abs(_holdAreaPoint.x - _maskContainer.mouseX);
						if (diff < diff2) //不通过则不允许滚动了
							return;
					}
				}
				
				sv = true;
			}
			else if (_scrollType == ScrollType.Horizontal) 
			{
				if (!_isHoldAreaDone)
				{
					_gestureFlag |= 2;
					
					diff = Math.abs(_holdAreaPoint.x - _maskContainer.mouseX);
					if (diff < sensitivity)
						return;
					
					if ((_gestureFlag & 1) != 0)
					{
						diff2 = Math.abs(_holdAreaPoint.y - _maskContainer.mouseY);
						if (diff < diff2)
							return;
					}
				}
				
				sh = true;
			}
			else
			{
				_gestureFlag = 3;
				
				if (!_isHoldAreaDone)
				{
					diff = Math.abs(_holdAreaPoint.y - _maskContainer.mouseY);
					if (diff < sensitivity)
					{
						diff = Math.abs(_holdAreaPoint.x - _maskContainer.mouseX);
						if (diff < sensitivity)
							return;
					}
				}
				
				sv = sh = true;
			}
			
			var t:uint = getTimer();
			if (t - _time2 > 50)
			{
				_time2 = _time1;
				_time1 = t;
				st = true;
			}
			
			if(sv)
			{
				var y:int = _maskContainer.mouseY - _yOffset;
				if (y > 0) 
				{
					if (!_bouncebackEffect || _inertiaDisabled)
						_container.y = 0;
					else
						_container.y = int(y * 0.5);
				}
				else if (y < -_yOverlap) 
				{
					if (!_bouncebackEffect || _inertiaDisabled)
						_container.y = -int(_yOverlap);
					else
						_container.y = int((y- _yOverlap) * 0.5);
				}
				else 
				{
					_container.y = y;
				}
				
				if (st)
				{
					_y2 = _y1;
					_y1 = _container.y;
				}
			}
			
			if(sh)
			{
				var x:int = _maskContainer.mouseX - _xOffset;
				if (x > 0) 
				{
					if (!_bouncebackEffect || _inertiaDisabled)
						_container.x = 0;
					else
						_container.x = int(x * 0.5);
				}
				else if (x < 0 - _xOverlap) 
				{
					if (!_bouncebackEffect || _inertiaDisabled)
						_container.x = -int(_xOverlap);
					else
						_container.x = int( (x - _xOverlap) * 0.5);
				}
				else 
				{
					_container.x = x;
				}
				
				if (st)
				{
					_x2 = _x1;
					_x1 = _container.x;
				}
			}
			
			draggingPane = this;
			_maskContainer.mouseChildren = false;
			_isHoldAreaDone = true;
			isDragged = true;
			syncPos();
			syncScrollBar();

			dispatchEvent(new Event(Event.SCROLL));
		}
		
		private function __mouseUp(e:Event):void
		{
			_owner.removeEventListener(GTouchEvent.DRAG, __mouseMove);
			
			if (draggingPane == this)
				draggingPane = null;
			
			_gestureFlag = 0;
			
			if (!isDragged || !_touchEffect || _inertiaDisabled)
			{
				isDragged = false;
				_maskContainer.mouseChildren = true;
				return;
			}
			
			isDragged = false;
			_maskContainer.mouseChildren = true;
			
			var time:Number = (getTimer() - _time2) / 1000;
			if(time==0)
				time = 0.001;
			var yVelocity:Number = (_container.y - _y2) / time * 2 * UIConfig.defaultTouchScrollSpeedRatio;
			var xVelocity:Number = (_container.x - _x2) / time * 2 * UIConfig.defaultTouchScrollSpeedRatio;
			var duration:Number = 0.3;
			
			_throwTween.start.x = _container.x;
			_throwTween.start.y = _container.y;
			
			var change1:Point = _throwTween.change1;
			var change2:Point = _throwTween.change2;
			var endX:Number = 0;
			var endY:Number = 0;
			var page:int;
			var delta:Number;
			var fireRelease:int = 0;
			var testPageSize:Number;
			
			if(_scrollType==ScrollType.Both || _scrollType==ScrollType.Horizontal)
			{
				if (_container.x > UIConfig.touchDragSensitivity)
					fireRelease = 1;
				else if (_container.x <  -_xOverlap - UIConfig.touchDragSensitivity)
					fireRelease = 2;
				
				change1.x = ThrowTween.calculateChange(xVelocity, duration);
				change2.x = 0;
				endX = _container.x + change1.x;
				
				if(_pageMode && endX<0 && endX>-_xOverlap)
				{
					page = Math.floor(-endX / _pageSizeH);
					testPageSize = Math.min(_pageSizeH, _contentWidth - (page + 1) * _pageSizeH);
					delta = -endX - page*_pageSizeH;
					//页面吸附策略
					if (Math.abs(change1.x) > _pageSizeH)//如果滚动距离超过1页,则需要超过页面的一半，才能到更下一页
					{
						if (delta > testPageSize * 0.5)
							page++;
					}
					else //否则只需要页面的1/3，当然，需要考虑到左移和右移的情况
					{
						if (delta > testPageSize * (change1.x < 0 ? 0.3 : 0.7))
							page++;
					}
					
					//重新计算终点
					endX = -page * _pageSizeH;
					if (endX < -_xOverlap) //最后一页未必有_pageSizeH那么大
						endX = -_xOverlap;
					
					change1.x = endX - _container.x;
				}
			}
			else
				change1.x = change2.x = 0;
			
			if(_scrollType==ScrollType.Both || _scrollType==ScrollType.Vertical)
			{
				if (_container.y > UIConfig.touchDragSensitivity)
					fireRelease = 1;
				else if (_container.y <  -_yOverlap - UIConfig.touchDragSensitivity)
					fireRelease = 2;
				
				change1.y = ThrowTween.calculateChange(yVelocity, duration);
				change2.y = 0;
				endY = _container.y + change1.y;
				
				if(_pageMode && endY < 0 && endY > -_yOverlap)
				{
					page = Math.floor(-endY / _pageSizeV);
					testPageSize = Math.min(_pageSizeV, _contentHeight - (page + 1) * _pageSizeV);
					delta = -endY - page * _pageSizeV;
					if (Math.abs(change1.y) > _pageSizeV)
					{
						if (delta > testPageSize * 0.5)
							page++;
					}
					else
					{
						if (delta > testPageSize * (change1.y < 0 ? 0.3 : 0.7))
							page++;
					}
					
					endY = -page * _pageSizeV;
					if (endY < -_yOverlap)
						endY = -_yOverlap;
					
					change1.y = endY - _container.y;
				}
			}
			else
				change1.y = change2.y = 0;
			
			if (_snapToItem && !_pageMode)
			{
				endX = -endX;
				endY = -endY;
				var pt:Point = _owner.getSnappingPosition(endX, endY, sHelperPoint);
				endX = -pt.x;
				endY = -pt.y;
				change1.x = endX - _container.x;
				change1.y = endY - _container.y;
			}
			
			if(_bouncebackEffect)
			{			
				if (endX>0)
					change2.x = 0 - _container.x - change1.x;
				else if (endX<-_xOverlap)
					change2.x = -_xOverlap - _container.x - change1.x;
				
				if (endY>0)
					change2.y = 0 - _container.y - change1.y;
				else if (endY<-_yOverlap)
					change2.y = -_yOverlap - _container.y - change1.y;
			}
			else
			{
				if (endX>0)
					change1.x = 0 - _container.x;
				else if (endX<-_xOverlap)
					change1.x = -_xOverlap - _container.x;
				
				if (endY>0)
					change1.y = 0 - _container.y;
				else if (endY<-_yOverlap)
					change1.y = -_yOverlap - _container.y;
			}
			
			_throwTween.value = 0;
			_throwTween.change1 = change1;
			_throwTween.change2 = change2;
			
			if(_tweener!=null)
				killTween();
			
			_tweening = 2;			
			_tweener = TweenLite.to(_throwTween, duration, { value:1, 
				onUpdate:__tweenUpdate2, onComplete:__tweenComplete2, 
				ease:_easeTypeFunc } );
			
			if (fireRelease == 1)
				dispatchEvent(new Event(PULL_DOWN_RELEASE));
			else if (fireRelease == 2)
				dispatchEvent(new Event(PULL_UP_RELEASE));
		}
		
		private function __mouseWheel(evt:MouseEvent):void
		{
			if(!_mouseWheelEnabled
				&& (!_vtScrollBar || !_vtScrollBar._rootContainer.hitTestObject(DisplayObject(evt.target)))
				&& (!_hzScrollBar || !_hzScrollBar._rootContainer.hitTestObject(DisplayObject(evt.target)))
				)
				return;
			
			var delta:Number = evt.delta;
			if (_xOverlap > 0 && _yOverlap == 0)
			{
				if(delta<0)
					this.setPercX(_xPerc + getDeltaX(_mouseWheelSpeed), false);
				else
					this.setPercX(_xPerc - getDeltaX(_mouseWheelSpeed), false);
			}
			else
			{
				if(delta<0)
					this.setPercY(_yPerc + getDeltaY(_mouseWheelSpeed), false);
				else
					this.setPercY(_yPerc - getDeltaY(_mouseWheelSpeed), false);
			}
		}
		
		private function __rollOver(evt:Event):void
		{
			showScrollBar(true);
		}
		
		private function __rollOut(evt:Event):void
		{
			showScrollBar(false);
		}
		
		private function showScrollBar(val:Boolean):void
		{
			if(val)
			{
				__showScrollBar(true);
				GTimers.inst.remove(__showScrollBar);
			}
			else
				GTimers.inst.add(500, 1, __showScrollBar, val);
		}
		
		private function __showScrollBar(val:Boolean):void
		{
			_scrollBarVisible = val && _viewWidth>0 && _viewHeight>0;
			if(_vtScrollBar)
				_vtScrollBar.displayObject.visible = _scrollBarVisible &&　!_vScrollNone;
			if(_hzScrollBar)
				_hzScrollBar.displayObject.visible = _scrollBarVisible &&　!_hScrollNone;
		}
		
		private function __tweenUpdate():void
		{
			syncScrollBar();
			
			dispatchEvent(new Event(Event.SCROLL));
		}
		
		private function __tweenComplete():void
		{
			_tweener = null;
			_tweening = 0;
			
			validateHolderPos();
			syncScrollBar(true);
			
			dispatchEvent(new Event(Event.SCROLL));
		}

		private function __tweenUpdate2():void
		{
			_throwTween.update(_container);
			
			syncPos();
			syncScrollBar();

			dispatchEvent(new Event(Event.SCROLL));
		}
		
		private function __tweenComplete2():void
		{			
			_tweener = null;
			_tweening = 0;
			
			validateHolderPos();
			syncPos();
			syncScrollBar(true);

			dispatchEvent(new Event(Event.SCROLL));
			dispatchEvent(new Event(SCROLL_END));
		}
	}
}
import flash.display.DisplayObject;
import flash.geom.Point;

class ThrowTween
{
	public var value:Number;
	public var start:Point;
	public var change1:Point;
	public var change2:Point;
	
	private static var checkpoint:Number = 0.05;
	
	public function ThrowTween()
	{
		start = new Point();
		change1 = new Point();
		change2 = new Point();
	}
	
	public function update(obj:DisplayObject):void
	{
		obj.x = int(start.x + change1.x * value + change2.x * value * value);
		obj.y = int(start.y + change1.y * value + change2.y * value * value);
	}
	
	static public function calculateChange(velocity:Number, duration:Number):Number
	{
		return (duration * checkpoint * velocity) / easeOutCubic(checkpoint, 0, 1, 1);
	}
	
	static public function easeOutCubic(t:Number, b:Number, c:Number, d:Number):Number
	{
		return c * ((t = t / d - 1) * t * t + 1) + b;
	}
}

