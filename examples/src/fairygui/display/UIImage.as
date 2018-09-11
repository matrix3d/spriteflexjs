package fairygui.display
{
	import flash.display.Bitmap;
	
	import fairygui.GObject;
	
	public class UIImage extends Bitmap implements UIDisplayObject 
	{
		private var _owner:GObject;
		
		public function UIImage(owner:GObject)
		{
			_owner = owner;
		}
		
		public function get owner():GObject
		{
			return _owner;
		}
	}
}

