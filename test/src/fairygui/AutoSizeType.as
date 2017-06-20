package fairygui
{
	public class AutoSizeType
	{		
		public static const None:int = 0;
		public static const Both:int = 1;
		public static const Height:int = 2;
		public static const Shrink:int = 3;
		
		public function AutoSizeType()
		{
		}
		
		public static function parse(value:String):int
		{
			switch (value)
			{
				case "none":
					return None;
				case "both":
					return Both;
				case "height":
					return Height;
				case "shrink":
					return Shrink;
				default:
					return None;
			}
		}
	}
}