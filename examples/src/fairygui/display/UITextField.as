package fairygui.display
{
	import flash.text.TextField;
	
	import fairygui.GObject;
	
	public class UITextField extends TextField implements UIDisplayObject 
	{
		private var _owner:GObject;
		
		public function UITextField(owner:GObject)
		{
			_owner = owner;
		}
		
		public function get owner():GObject
		{
			return _owner;
		}
	}
}

