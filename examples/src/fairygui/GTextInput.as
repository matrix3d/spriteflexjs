package fairygui
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.system.Capabilities;
	import flash.system.IME;
	import flash.text.TextFieldType;
	
	import fairygui.utils.ToolSet;

	public class GTextInput extends GTextField
	{
		private var _changed:Boolean;
		private var _promptText:String;
		private var _password:Boolean;
		
		public var disableIME:Boolean;
		
		public function GTextInput()
		{
			super();
			this.focusable = true;
			
			_textField.wordWrap = true;
			
			_textField.addEventListener(KeyboardEvent.KEY_DOWN, __textChanged);
			_textField.addEventListener(Event.CHANGE, __textChanged);
			_textField.addEventListener(FocusEvent.FOCUS_IN, __focusIn);
			_textField.addEventListener(FocusEvent.FOCUS_OUT, __focusOut);
		}

		public function set maxLength(val:int):void
		{
			_textField.maxChars = val;
		}
		
		public function get maxLength():int
		{
			return _textField.maxChars;
		}
		
		public function set editable(val:Boolean):void
		{
			if(val)
			{
				_textField.type = TextFieldType.INPUT;
				_textField.selectable = true;
			}
			else
			{
				_textField.type = TextFieldType.DYNAMIC;
				_textField.selectable = false;
			}
		}
		
		public function get editable():Boolean
		{
			return _textField.type == TextFieldType.INPUT;
		}
		
		public function get promptText():String
		{
			return _promptText;
		}
		
		public function set promptText(value:String):void
		{
			_promptText = value;
			renderNow();
		}
		
		public function get restrict():String
		{
			return _textField.restrict;
		}
		
		public function set restrict(value:String):void
		{
			_textField.restrict = value;
		}
		
		public function get password():Boolean
		{
			return _password;
		}
		
		public function set password(val:Boolean):void
		{
			if(_password != val)
			{
				_password = val;
				render();
			}
		}
		
		override protected function createDisplayObject():void
		{ 
			super.createDisplayObject();
			
			_textField.type = TextFieldType.INPUT;
			_textField.selectable = true;
			_textField.mouseEnabled = true;
		}
		
		override public function get text():String
		{
			if(_changed)
			{
				_changed = false;
				_text = _textField.text.replace(/\r\n/g, "\n");
				_text = _text.replace(/\r/g, "\n");
			}
			return _text;
		}
		
		override protected function updateAutoSize():void
		{
			//输入文本不支持自动大小
		}
		
		override protected function render():void
		{
			renderNow(true);
		}
		
		override protected function renderNow(updateBounds:Boolean=true):void
		{
			var w:Number, h:Number;
			w = this.width;
			if(w!=_textField.width)
				_textField.width = w;
			h = this.height+_fontAdjustment;
			if(h!=_textField.height)
				_textField.height = h;
			_yOffset = -_fontAdjustment;
			_textField.y = this.y+_yOffset;
			
			if(!_text && _promptText)
			{
				_textField.displayAsPassword = false;
				_textField.htmlText = ToolSet.parseUBB(ToolSet.encodeHTML(_promptText));
			}
			else
			{
				_textField.displayAsPassword = _password;
				_textField.text = _text;
			}
			_changed = false;
		}
		
		override protected function handleSizeChanged():void
		{
			_textField.width = this.width;
			_textField.height = this.height+_fontAdjustment;
		}
		
		override public function setup_beforeAdd(xml:XML):void
		{
			super.setup_beforeAdd(xml);
			
			_promptText = xml.@prompt;
			var str:String = xml.@maxLength;
			if(str)
				_textField.maxChars = parseInt(str);
			str = xml.@restrict;
			if(str)
				_textField.restrict = str;
			_password = xml.@password=="true";
		}
		
		override public function setup_afterAdd(xml:XML):void
		{
			super.setup_afterAdd(xml);
			
			if(!_text)
			{
				if(_promptText)
				{
					_textField.displayAsPassword = false;
					_textField.htmlText = ToolSet.parseUBB(ToolSet.encodeHTML(_promptText));
				}			
			}
		}
		
		private function __textChanged(evt:Event):void
		{
			_changed = true;
			TextInputHistory.inst.markChanged(_textField);
		}
		
		private function __focusIn(evt:Event):void
		{
			if(disableIME && Capabilities.hasIME)
				IME.enabled = false;
			
			if(!_text && _promptText)
			{
				_textField.displayAsPassword = _password;
				_textField.text = "";
			}
			TextInputHistory.inst.startRecord(_textField);
		}
		
		private function __focusOut(evt:Event):void
		{
			if(disableIME && Capabilities.hasIME)
				IME.enabled = true;
			
			_text = _textField.text;
			TextInputHistory.inst.stopRecord(_textField);
			_changed = false;
			
			if(!_text && _promptText)
			{
				_textField.displayAsPassword = false;
				_textField.htmlText = ToolSet.parseUBB(ToolSet.encodeHTML(_promptText));
			}
		}
	}
}