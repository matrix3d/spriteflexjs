package fairygui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	
	import fairygui.event.GTouchEvent;
	import fairygui.event.StateChangeEvent;
	import fairygui.utils.GTimers;
	import fairygui.utils.ToolSet;
	
	[Event(name = "stateChanged", type = "fairygui.event.StateChangeEvent")]
	public class GButton extends GComponent
	{
		protected var _titleObject:GObject;
		protected var _iconObject:GObject;
		protected var _relatedController:Controller;
		
		private var _mode:int;
		private var _selected:Boolean;
		private var _title:String;
		private var _selectedTitle:String;
		private var _icon:String;
		private var _selectedIcon:String;
		private var _sound:String;
		private var _soundVolumeScale:Number;
		private var _pageOption:PageOption;
		private var _buttonController:Controller;
		private var _changeStateOnClick:Boolean;
		private var _linkedPopup:GObject;
		private var _hasDisabledPage:Boolean;
		private var _downEffect:int;
		private var _downEffectValue:Number;
		private var _useHandCursor:Boolean;
		
		private var _over:Boolean;
		
		public static const UP:String = "up";
		public static const DOWN:String = "down";
		public static const OVER:String = "over";
		public static const SELECTED_OVER:String = "selectedOver";
		public static const DISABLED:String = "disabled";
		public static const SELECTED_DISABLED:String = "selectedDisabled";
		
		public function GButton()
		{
			super();
			
			_mode = ButtonMode.Common;
			_title = "";
			_icon = "";
			_sound = UIConfig.buttonSound;
			_soundVolumeScale = UIConfig.buttonSoundVolumeScale;
			_pageOption = new PageOption();
			_changeStateOnClick = true;
			_downEffectValue = 0.8;
			_useHandCursor = UIConfig.buttonUseHandCursor;
			if(_useHandCursor)
			{			
				Sprite(this.displayObject).buttonMode = true;
				Sprite(this.displayObject).useHandCursor = true;
			}
		}

		override public function get icon():String
		{
			return _icon;
		}

		override public function set icon(value:String):void
		{
			_icon = value;
			value = (_selected && _selectedIcon)?_selectedIcon:_icon;
			if(_iconObject!=null)
				_iconObject.icon = value;
			updateGear(7);
		}
		
		final public function get selectedIcon():String
		{
			return _selectedIcon;
		}
		
		public function set selectedIcon(value:String):void
		{
			_selectedIcon = value;
			value = (_selected && _selectedIcon)?_selectedIcon:_icon;
			if(_iconObject!=null)
				_iconObject.icon = value;
		}

		final public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
			if(_titleObject)
				_titleObject.text = (_selected && _selectedTitle)?_selectedTitle:_title;
			updateGear(6);
		}
		
		final override public function get text():String
		{
			return this.title;
		}
		
		override public function set text(value:String):void
		{
			this.title = value;
		}
		
		final public function get selectedTitle():String
		{
			return _selectedTitle;
		}
		
		public function set selectedTitle(value:String):void
		{
			_selectedTitle = value;
			if(_titleObject)
				_titleObject.text = (_selected && _selectedTitle)?_selectedTitle:_title;
		}
		
		final public function get titleColor():uint
		{
			var tf:GTextField = getTextField();
			if(tf)
				return tf.color;
			else
				return 0;
		}
		
		public function set titleColor(value:uint):void
		{
			var tf:GTextField = getTextField();
			if(tf)
				tf.color = value;
			updateGear(4);
		}
		
		final public function get titleFontSize():int
		{
			var tf:GTextField = getTextField();
			if(tf)
				return tf.fontSize;
			else
				return 0;
		}
		
		public function set titleFontSize(value:int):void
		{
			var tf:GTextField = getTextField();
			if(tf)
				tf.fontSize = value;
		}
		
		final public function get sound():String
		{
			return _sound;
		}
		
		public function set sound(val:String):void
		{
			_sound = val;
		}
		
		public function get soundVolumeScale():Number
		{
			return _soundVolumeScale;
		}
		
		public function set soundVolumeScale(value:Number):void
		{
			_soundVolumeScale = value;
		}

		public function set selected(val:Boolean):void
		{
			if(_mode==ButtonMode.Common)
				return;
			
			if(_selected!=val)
			{
				_selected = val;
				setCurrentState();
				if(_selectedTitle && _titleObject)
					_titleObject.text = _selected?_selectedTitle:_title;
				if(_selectedIcon)
				{
					var str:String = _selected?_selectedIcon:_icon;
					if(_iconObject!=null)
						_iconObject.icon = str;
				}
				if(_relatedController
					&& _parent
					&& !_parent._buildingDisplayList)
				{
					if(_selected)
					{
						_relatedController.selectedPageId = _pageOption.id;
						if(_relatedController._autoRadioGroupDepth)
							_parent.adjustRadioGroupDepth(this, _relatedController);
					}
					else if(_mode==ButtonMode.Check && _relatedController.selectedPageId==_pageOption.id)
						_relatedController.oppositePageId = _pageOption.id;
				}
			}
		}
		
		final public function get selected():Boolean
		{
			return _selected;
		}
		
		final public function get mode():int
		{
			return _mode;
		}
		
		public function set mode(value:int):void
		{
			if(_mode!=value)
			{
				if(value==ButtonMode.Common)
					this.selected = false;
				_mode = value;
			}
		}
		
		final public function get useHandCursor():Boolean
		{
			return _useHandCursor;
		}
		
		public function set useHandCursor(value:Boolean):void
		{
			_useHandCursor = value;
			Sprite(this.displayObject).buttonMode = _useHandCursor;
			Sprite(this.displayObject).useHandCursor = _useHandCursor;
		}

		final public function get relatedController():Controller
		{
			return _relatedController;
		}
		
		public function set relatedController(val:Controller):void
		{
			if(val!=_relatedController)
			{
				_relatedController = val;
				_pageOption.controller = val;
				_pageOption.clear();
			}
		}
		
		final public function get pageOption():PageOption
		{
			return _pageOption;
		}
		
		final public function get changeStateOnClick():Boolean
		{
			return _changeStateOnClick;
		}
		
		final public function set changeStateOnClick(value:Boolean):void
		{
			_changeStateOnClick = value;
		}
		
		final public function get linkedPopup():GObject
		{
			return _linkedPopup;
		}
		
		final public function set linkedPopup(value:GObject):void
		{
			_linkedPopup = value;
		}
		
		public function addStateListener(listener:Function):void
		{
			addEventListener(StateChangeEvent.CHANGED, listener);
		}
		
		public function removeStateListener(listener:Function):void
		{
			removeEventListener(StateChangeEvent.CHANGED, listener);
		}
		
		public function fireClick(downEffect:Boolean=true):void
		{
			if(downEffect && _mode==ButtonMode.Common)
			{
				setState(OVER);
				GTimers.inst.add(100, 1, setState, DOWN);
				GTimers.inst.add(200, 1, setState, UP);
			}
			__click(null);
		}
		
		public function getTextField():GTextField
		{
			if(_titleObject is GTextField)
				return GTextField(_titleObject);
			else if(_titleObject is GLabel)
				return GLabel(_titleObject).getTextField();
			else if(_titleObject is GButton)
				return GButton(_titleObject).getTextField();
			else
				return null;
		}
		
		protected function setState(val:String):void
		{
			if(_buttonController)
				_buttonController.selectedPage = val;

			if(_downEffect==1)
			{
				var cnt:int = this.numChildren;
				if(val==DOWN || val==SELECTED_OVER || val==SELECTED_DISABLED)
				{
					var r:int = _downEffectValue * 255;
					var color:uint = (r<<16)+(r<<8)+r;
					for(var i:int=0;i<cnt;i++)
					{
						var obj:GObject = this.getChildAt(i);
						if((obj is IColorGear) && !(obj is GTextField))
							IColorGear(obj).color = color;
					}
				}
				else
				{
					for(i=0;i<cnt;i++)
					{
						obj = this.getChildAt(i);
						if((obj is IColorGear) && !(obj is GTextField))
							IColorGear(obj).color = 0xFFFFFF;
					}
				}
			}
			else if(_downEffect==2)				
			{
				if(val==DOWN || val==SELECTED_OVER || val==SELECTED_DISABLED)
					setScale(_downEffectValue, _downEffectValue);
				else
					setScale(1, 1);
			}
		}
		
		protected function setCurrentState():void
		{
			if(this.grayed && _buttonController && _buttonController.hasPage(DISABLED))
			{
				if(_selected)
					setState(SELECTED_DISABLED);
				else
					setState(DISABLED);
			}
			else
			{
				if(_selected)
					setState(_over?SELECTED_OVER:DOWN);
				else
					setState(_over?OVER:UP);
			}
		}
		
		override public function handleControllerChanged(c:Controller):void
		{
			super.handleControllerChanged(c);
			
			if(_relatedController==c)
				this.selected = _pageOption.id==c.selectedPageId;
		}
		
		override protected function handleGrayedChanged():void
		{
			if(_buttonController && _buttonController.hasPage(DISABLED))
			{
				if(this.grayed) {
					if(_selected)
						setState(SELECTED_DISABLED);
					else
						setState(DISABLED);
				}
				else
				{
					if(_selected)
						setState(DOWN);
					else
						setState(UP);
				}
			}
			else
				super.handleGrayedChanged();
		}
		
		override protected function constructFromXML(xml:XML):void
		{
			super.constructFromXML(xml);
			
			xml = xml.Button[0];
			
			var str:String;
			str = xml.@mode;
			if(str)
				_mode = ButtonMode.parse(str);
			
			_sound = xml.@sound;
			str = xml.@volume;
			if(str)
				_soundVolumeScale = parseInt(str)/100;
			
			str = xml.@downEffect;
			if(str)
			{
				_downEffect = str=="dark"?1:(str=="scale"?2:0);
				str = xml.@downEffectValue;
				_downEffectValue = parseFloat(str);
			}
			
			_buttonController = getController("button");
			_titleObject = getChild("title");
			_iconObject = getChild("icon");
			if (_titleObject != null)
				_title = _titleObject.text;
			if (_iconObject != null)
				_icon = _iconObject.icon;
			
			if(_mode==ButtonMode.Common)
				setState(UP);
			
			this.opaque = true;
			
			if(!GRoot.touchScreen)
			{
				displayObject.addEventListener(MouseEvent.ROLL_OVER, __rollover);
				displayObject.addEventListener(MouseEvent.ROLL_OUT, __rollout);
			}
			this.addEventListener(GTouchEvent.BEGIN, __mousedown);
			this.addEventListener(GTouchEvent.END, __mouseup);
			this.addEventListener(GTouchEvent.CLICK, __click, false, 1000);
		}
		
		override public function setup_afterAdd(xml:XML):void
		{
			super.setup_afterAdd(xml);
			
			if(_downEffect==2)
				this.setPivot(0.5, 0.5);
			
			xml = xml.Button[0];
			if(xml)
			{
				var str:String;
				str = xml.@title;
				if(str)
					this.title = str;
				str = xml.@icon;
				if(str)
					this.icon = str;
				str = xml.@selectedTitle;
				if(str)
					this.selectedTitle = str;
				str = xml.@selectedIcon;;
				if(str)
					this.selectedIcon = str;
				
				str = xml.@titleColor;
				if(str)
					this.titleColor = ToolSet.convertFromHtmlColor(str);
				
				str = xml.@titleFontSize;
				if(str)
					this.titleFontSize = parseInt(str);
				
				if(xml.@sound!=undefined)
					_sound = xml.@sound;
				str = xml.@volume;
				if(str)
					_soundVolumeScale = parseInt(str)/100;
				
				str = xml.@controller;
				if(str)
					_relatedController = _parent.getController(xml.@controller);
				else
					_relatedController = null;
				_pageOption.id = xml.@page;
				this.selected = xml.@checked=="true";
			}
		}
		
		private function __rollover(evt:Event):void
		{
			if(!_buttonController || !_buttonController.hasPage(OVER))
				return;
			
			_over = true;
			if(this.isDown)
				return;
			
			if(this.grayed && _buttonController.hasPage(DISABLED))
				return;
			
			setState(_selected?SELECTED_OVER:OVER);
		}
		
		private function __rollout(evt:Event):void
		{
			if(!_buttonController || !_buttonController.hasPage(OVER))
				return;
			
			_over = false;
			if(this.isDown)
				return;
			
			if(this.grayed && _buttonController.hasPage(DISABLED))
				return;

			setState(_selected?DOWN:UP);
		}
		
		private function __mousedown(evt:Event):void
		{
			if(_mode==ButtonMode.Common)
			{
				if(this.grayed && _buttonController && _buttonController.hasPage(DISABLED))
					setState(SELECTED_DISABLED);
				else
					setState(DOWN);
			}
			
			if(_linkedPopup!=null)
			{
				if(_linkedPopup is Window)
					Window(_linkedPopup).toggleStatus();
				else
					this.root.togglePopup(_linkedPopup, this);
			}
		}
		
		private function __mouseup(evt:Event):void
		{
			if(_mode==ButtonMode.Common)
			{
				if(this.grayed && _buttonController && _buttonController.hasPage(DISABLED))
					setState(DISABLED);
				else if (_over)
					setState(OVER);
				else
					setState(UP);
			}
			else
			{
				if(!_over
					&&_buttonController 
					&& (_buttonController.selectedPage==OVER || _buttonController.selectedPage==SELECTED_OVER))
				{
					setCurrentState();
				}
			}
		}
		
		private function __click(evt:Event):void
		{
			if(_sound)
			{
				var pi:PackageItem = UIPackage.getItemByURL(_sound);
				if(pi)
				{
					var sound:Sound = pi.owner.getSound(pi);
					if(sound)
						GRoot.inst.playOneShotSound(sound, _soundVolumeScale);
				}
			}
			
			if(!_changeStateOnClick)
				return;
			
			if(_mode==ButtonMode.Check)
			{
				this.selected = !_selected;
				dispatchEvent(new StateChangeEvent(StateChangeEvent.CHANGED));
			}
			else if(_mode==ButtonMode.Radio)
			{
				if(!_selected)
				{
					this.selected = true;
					dispatchEvent(new StateChangeEvent(StateChangeEvent.CHANGED));
				}
			}
		}
	}
}