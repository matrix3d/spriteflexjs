package fairygui.display
{
	import fairygui.GObject;
	import fairygui.text.RichTextField;
	
	public class UIRichTextField extends RichTextField implements UIDisplayObject 
	{
		private var _owner:GObject;
		
		public function UIRichTextField(owner:GObject)
		{
			_owner = owner;
		}
		
		public function get owner():GObject
		{
			return _owner;
		}
	}
}
