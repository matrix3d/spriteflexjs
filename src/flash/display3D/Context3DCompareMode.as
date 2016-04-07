package flash.display3D
{
	
	public final class Context3DCompareMode extends Object
	{
		
		public static const ALWAYS:String = "always";//int = gl.ALWAYS;//
		
		public static const NEVER:String = "never";//int = gl.NEAREST;//
		
		public static const LESS:String = "less";//int = gl.LESS;//
		
		public static const LESS_EQUAL:String = "lessEqual";//int = gl.LESS|gl.EQUAL;//
		
		public static const EQUAL:String = "equal";//int = gl.EQUAL;//
		
		public static const GREATER_EQUAL:String = "greaterEqual";//int = gl.GREATER|gl.EQUAL;//
		
		public static const GREATER:String = "greater";//int = gl.GREATER;//
		
		public static const NOT_EQUAL:String = "notEqual";//int = gl.NOTEQUAL;//
		
		public function Context3DCompareMode()
		{
			super();
		}
		
		public static function getGLVal(gl:WebGLRenderingContext,str:String):int
		{
			switch (str)
			{
				case ALWAYS: 
					return gl.ALWAYS;
				case NEVER: 
					return gl.NEAREST;
				case LESS: 
					return gl.LESS;
				case LESS_EQUAL: 
					return gl.LESS | gl.EQUAL;
				case EQUAL: 
					return gl.EQUAL;
				case GREATER_EQUAL: 
					return gl.GREATER | gl.EQUAL;
				case GREATER: 
					return gl.GREATER;
				case NOT_EQUAL: 
					return gl.NOTEQUAL;
			}
			
			return 0;
		}
	}
}
