package fairygui
{
	import flash.text.TextFormatAlign;

	public class AlignType
	{
		public static const Left:int = 0;
		public static const Center:int = 1;
		public static const Right:int = 2;
		
		public function AlignType()
		{
		}
		
		public static function parse(value:String):int
		{
			switch (value)
			{
				case "left":
					return Left;
				case "center":
					return Center;
				case "right":
					return Right;
				default:
					return Left;
			}
		}
		
		public static function toString2(type:int):String
		{
			return type==Left?TextFormatAlign.LEFT:
				(type==Center?TextFormatAlign.CENTER:TextFormatAlign.RIGHT);
		}
	}
}