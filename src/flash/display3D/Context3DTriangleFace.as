package flash.display3D
{
	
	public final class Context3DTriangleFace extends Object
	{
		
		public static const NONE:String = "none";//int =gl.NONE;//
		
		public static const BACK:String = "back";//int = gl.BACK;//
		
		public static const FRONT:String = "front";//int = gl.FRONT;//
		
		public static const FRONT_AND_BACK:String = "frontAndBack";//int = gl.FRONT_AND_BACK; //
		
		public function Context3DTriangleFace()
		{
			super();
		}
		
		public static function getGLVal(gl:WebGLRenderingContext,str:String):int
		{
			switch (str)
			{
			case NONE: 
				return gl.NONE;
			case BACK: 
				return gl.FRONT;
			case FRONT: 
				return gl.BACK;
			case FRONT_AND_BACK: 
				return gl.FRONT_AND_BACK;
			}
			return 0;
		}
	}
}
