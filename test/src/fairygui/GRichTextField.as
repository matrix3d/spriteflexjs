package fairygui
{
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import fairygui.display.UIRichTextField;
	import fairygui.text.RichTextField;
	import fairygui.utils.ToolSet;
	
	public class GRichTextField extends GTextField
	{
		protected var _richTextField:RichTextField;
		
		public function GRichTextField()
		{
			super();
		}
		
		override protected function createDisplayObject():void
		{ 
			_richTextField = new UIRichTextField(this);
			_textField = _richTextField.nativeTextField;
			setDisplayObject(_richTextField);
		}

		public function get ALinkFormat():TextFormat {
			return _richTextField.ALinkFormat;
		}
		
		public function set ALinkFormat(val:TextFormat):void {
			_richTextField.ALinkFormat = val;
			render();
		}
		
		public function get AHoverFormat():TextFormat {
			return _richTextField.AHoverFormat;
		}
		
		public function set AHoverFormat(val:TextFormat):void {
			_richTextField.AHoverFormat = val;
			render();
		}
		
		override protected function updateAutoSize():void
		{
			//as版的RichText不支持自动宽度
			if(_heightAutoSize)
				_textField.autoSize = TextFieldAutoSize.LEFT;
			else
				_textField.autoSize = TextFieldAutoSize.NONE;
		}

		override protected function render():void
		{
			renderNow(true);
		}
		
		override protected function renderNow(updateBounds:Boolean=true):void
		{
			_richTextField.defaultTextFormat = _textFormat;
			if(_ubbEnabled)
				_richTextField.text = ToolSet.parseUBB(_text);
			else
				_richTextField.text = _text;
			
			var renderSingleLine:Boolean = _richTextField.numLines<=1;
			
			_textWidth = Math.ceil(_richTextField.textWidth);
			if(_textWidth>0)
				_textWidth+=5;
			_textHeight = Math.ceil(_richTextField.textHeight);
			if(_textHeight>0)
			{
				if(renderSingleLine)
					_textHeight+=1;
				else
					_textHeight+=4;
			}
			
			if(_heightAutoSize)
			{
				_richTextField.height = _textHeight+_fontAdjustment;
				
				_updatingSize = true;
				this.height = _textHeight;
				_updatingSize = false;
			}
		}
		
		override protected function handleSizeChanged():void
		{
			if(!_updatingSize)
			{
				_richTextField.width = this.width;
				_richTextField.height = this.height+_fontAdjustment;
			}
		}
	}
}
