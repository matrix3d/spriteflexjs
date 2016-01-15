package flash.display3D
{
	
	public final class Context3DCompareMode extends Object
	{
		
		public static const ALWAYS:String = "always";//int = WebGLRenderingContext.ALWAYS;//
		
		public static const NEVER:String = "never";//int = WebGLRenderingContext.NEAREST;//
		
		public static const LESS:String = "less";//int = WebGLRenderingContext.LESS;//
		
		public static const LESS_EQUAL:String = "lessEqual";//int = WebGLRenderingContext.LESS|WebGLRenderingContext.EQUAL;//
		
		public static const EQUAL:String = "equal";//int = WebGLRenderingContext.EQUAL;//
		
		public static const GREATER_EQUAL:String = "greaterEqual";//int = WebGLRenderingContext.GREATER|WebGLRenderingContext.EQUAL;//
		
		public static const GREATER:String = "greater";//int = WebGLRenderingContext.GREATER;//
		
		public static const NOT_EQUAL:String = "notEqual";//int = WebGLRenderingContext.NOTEQUAL;//
		
		public function Context3DCompareMode()
		{
			super();
		}
		
		public static function getGLVal(str:String):int
		{
			switch (str)
			{
				case ALWAYS: 
					return WebGLRenderingContext.ALWAYS;
				case NEVER: 
					return WebGLRenderingContext.NEAREST;
				case LESS: 
					return WebGLRenderingContext.LESS;
				case LESS_EQUAL: 
					return WebGLRenderingContext.LESS | WebGLRenderingContext.EQUAL;
				case EQUAL: 
					return WebGLRenderingContext.EQUAL;
				case GREATER_EQUAL: 
					return WebGLRenderingContext.GREATER | WebGLRenderingContext.EQUAL;
				case GREATER: 
					return WebGLRenderingContext.GREATER;
				case NOT_EQUAL: 
					return WebGLRenderingContext.NOTEQUAL;
			}
			
			return 0;
		}
	}
}
