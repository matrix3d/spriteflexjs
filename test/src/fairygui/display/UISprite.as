package fairygui.display
{
	import fairygui.GObject;
	import flash.display.Sprite;

	public class UISprite extends Sprite implements UIDisplayObject 
	{
		private var _owner:GObject;
		
		public function UISprite(owner:GObject)
		{
			_owner = owner;
		}
		
		public function get owner():GObject
		{
			return _owner;
		}
	}
}
