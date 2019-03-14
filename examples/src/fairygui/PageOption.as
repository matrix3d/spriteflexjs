package fairygui
{
	public class PageOption
	{
		private var _controller:Controller;
		private var _id:String;
		
		public function PageOption()
		{
		}
		
		public function set controller(val:Controller):void
		{
			_controller = val;
		}
		
		public function set index(pageIndex:int):void
		{
			_id = _controller.getPageId(pageIndex);
		}
		
		public function set name(pageName:String):void
		{
			_id = _controller.getPageIdByName(pageName);
		}
		
		public function get index():int
		{
			if(_id)
				return _controller.getPageIndexById(_id);
			else
				return -1;
		}
		
		public function get name():String
		{
			if(_id)
				return _controller.getPageNameById(_id);
			else
				return null;
		}
		
		public function clear():void
		{
			_id = null;
		}

		public function set id(id:String):void
		{
			_id = id;
		}
		
		public function get id():String
		{
			return _id;
		}
	}
}