package fairygui.display
{
	import fairygui.GObject;
	
	public class UIMovieClip extends MovieClip implements UIDisplayObject 
	{
		private var _owner:GObject;
		
		public function UIMovieClip(owner:GObject)
		{
			_owner = owner;
		}
		
		public function get owner():GObject
		{
			return _owner;
		}
	}
}