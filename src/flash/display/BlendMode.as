package flash.display
{
	
	public final class BlendMode extends Object
	{
		
		public static const NORMAL:String = "normal";
		
		public static const LAYER:String = "layer";
		
		public static const MULTIPLY:String = "multiply";
		
		public static const SCREEN:String = "screen";
		
		public static const LIGHTEN:String = "lighten";
		
		public static const DARKEN:String = "darken";
		
		public static const ADD:String = "add";
		
		public static const SUBTRACT:String = "subtract";
		
		public static const DIFFERENCE:String = "difference";
		
		public static const INVERT:String = "invert";
		
		public static const OVERLAY:String = "overlay";
		
		public static const HARDLIGHT:String = "hard-light";// "hardlight";
		
		public static const ALPHA:String = "alpha";
		
		public static const ERASE:String = "erase";
		
		public static const SHADER:String = "shader";
		
		public function BlendMode()
		{
			super();
		}
		/*public static function getCompVal(str:String):String {
			switch (str)
			{
				case LAYER:return null;
				case MULTIPLY:return "multiply";
				case SCREEN:return "screen";
				case LIGHTEN:return "lighten";
				case DARKEN:return "darken";
				case ADD:return "color-burn";
				case SUBTRACT:return "color-dodge";
				case DIFFERENCE:return "difference";
				case INVERT:return null;
				case OVERLAY:return "overlay";
				case HARDLIGHT:return "hard-light";
				case ALPHA:return null;
				case ERASE:return "exclusion";
				case SHADER:return null;
			}
			
			return null;
		}*/
	}
}
