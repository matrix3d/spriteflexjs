package fairygui
{
	import flash.text.TextField;

	public class TextInputHistory
	{
		private static var _inst:TextInputHistory;
		public static function get inst():TextInputHistory
		{
			if(_inst==null)
				_inst = new TextInputHistory();
			return _inst;
		}
		
		private var _undoBuffer:Vector.<String>;
		private var _redoBuffer:Vector.<String>;
		private var _currentText:String;
		private var _textField:TextField;
		private var _lock:Boolean;
		
		public var maxHistoryLength:int = 5;
		
		public function TextInputHistory()
		{
			_undoBuffer = new Vector.<String>();
			_redoBuffer = new Vector.<String>();
		}
		
		public function startRecord(textField:TextField):void
		{
			_undoBuffer.length = 0;
			_redoBuffer.length = 0;
			_textField = textField;
			_lock = false;
			_currentText = textField.text;
		}
		
		public function markChanged(textField:TextField):void
		{
			if(_textField!=textField)
				return;
			
			if(_lock)
				return;
			
			var newText:String = _textField.text;
			if(_currentText == newText)
				return;
			
			_undoBuffer.push(_currentText);
			if(_undoBuffer.length>maxHistoryLength)
				_undoBuffer.splice(0,1);
			
			_currentText = newText;
		}
		
		public function stopRecord(textField:TextField):void
		{
			if(_textField!=textField)
				return;
			
			_undoBuffer.length = 0;
			_redoBuffer.length = 0;
			_textField = null;
			_currentText = null;
		}
		
		public function undo(textField:TextField):void
		{
			if(_textField!=textField)
				return;
			
			if(_undoBuffer.length==0)
				return;
			
			var text:String = _undoBuffer.pop();
			_redoBuffer.push(_currentText);
			_lock = true;
			_textField.text = text;
			_currentText = text;
			_lock = false;
		}
		
		public function redo(textField:TextField):void
		{
			if(_textField!=textField)
				return;
			
			if(_redoBuffer.length==0)
				return;
			
			var text:String = _redoBuffer.pop();
			_undoBuffer.push(_currentText);
			_lock = true;
			_textField.text = text;
			var dlen:int = text.length-_currentText.length;
			if(dlen>0)
				_textField.setSelection(_textField.caretIndex+dlen, _textField.caretIndex+dlen);
			_currentText = text;
			_lock = false;
		}
	}
}