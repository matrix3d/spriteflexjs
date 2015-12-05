package flash.display3D
{
   public final class Context3DTriangleFace extends Object
   {
      
      public static const NONE:String= "none";//int =WebGLRenderingContext.NONE;//
      
      public static const BACK:String="back";//int = WebGLRenderingContext.BACK;//
      
      public static const FRONT:String="front";//int = WebGLRenderingContext.FRONT;//
      
      public static const FRONT_AND_BACK:String="frontAndBack";//int = WebGLRenderingContext.FRONT_AND_BACK; //
       
      public function Context3DTriangleFace()
      {
         super();
      }
	  
	  public static function getGLVal(str:String):int {
		 switch(str) {
			case NONE:
				return WebGLRenderingContext.NONE;
			case BACK:
				return WebGLRenderingContext.BACK;
			case FRONT:
				return WebGLRenderingContext.FRONT;
			case FRONT_AND_BACK:
				return WebGLRenderingContext.FRONT_AND_BACK;
		 }
				
				
		return 0;		
		}
   }
}
