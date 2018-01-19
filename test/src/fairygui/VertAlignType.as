package fairygui
{
	public class VertAlignType
	{
		public static const Top:int = 0;
		public static const Middle:int = 1;
		public static const Bottom:int = 2;
		
		public function VertAlignType()
		{
		}
		
		public static function parse(value:String):int
		{
			switch (value)
			{
				case "top":
					return Top;
				case "middle":
					return Middle;
				case "bottom":
					return Bottom;
				default:
					return Top;
			}
		}
	}
}