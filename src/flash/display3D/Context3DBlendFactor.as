package flash.display3D
{
   public final class Context3DBlendFactor extends Object
   {
      
      public static const ONE:String="one";//int = WebGLRenderingContext.ONE;//
      
      public static const ZERO:String="zero";//int = WebGLRenderingContext.ZERO;//
      
      public static const SOURCE_ALPHA:String="sourceAlpha";//int = WebGLRenderingContext.SRC_ALPHA;//
      
      public static const SOURCE_COLOR:String="sourceColor";//int = WebGLRenderingContext.SRC_COLOR;//
      
      public static const ONE_MINUS_SOURCE_ALPHA:String="oneMinusSourceAlpha";//int = WebGLRenderingContext.ONE_MINUS_SRC_ALPHA;//
      
      public static const ONE_MINUS_SOURCE_COLOR:String="oneMinusSourceColor";//int = WebGLRenderingContext.ONE_MINUS_SRC_COLOR;//
      
      public static const DESTINATION_ALPHA:String="destinationAlpha";//int = WebGLRenderingContext.DST_ALPHA;//
      
      public static const DESTINATION_COLOR:String="destinationColor";//int = WebGLRenderingContext.DST_COLOR;//
      
      public static const ONE_MINUS_DESTINATION_ALPHA:String="oneMinusDestinationAlpha";//int = WebGLRenderingContext.ONE_MINUS_DST_ALPHA;//
      
      public static const ONE_MINUS_DESTINATION_COLOR:String="oneMinusDestinationColor";//int = WebGLRenderingContext.ONE_MINUS_DST_COLOR;//
       
      public function Context3DBlendFactor()
      {
         super();
      }
	  
	  public static function getGLVal(str:String):int {
		 switch(str) {
			case ONE:
				return WebGLRenderingContext.ONE;
			case ZERO:
				return WebGLRenderingContext.ZERO;
			case SOURCE_ALPHA:
				return WebGLRenderingContext.SRC_ALPHA;
			case SOURCE_COLOR:
				return WebGLRenderingContext.SRC_COLOR;
			case ONE_MINUS_SOURCE_ALPHA:
				return WebGLRenderingContext.ONE_MINUS_SRC_ALPHA;
			case ONE_MINUS_SOURCE_COLOR:
				return WebGLRenderingContext.ONE_MINUS_SRC_COLOR;
			case DESTINATION_ALPHA:
				return WebGLRenderingContext.DST_ALPHA;
			case DESTINATION_COLOR:
				return WebGLRenderingContext.DST_COLOR;
			case ONE_MINUS_DESTINATION_ALPHA:
				return WebGLRenderingContext.ONE_MINUS_DST_ALPHA;
			case ONE_MINUS_DESTINATION_COLOR:
				return WebGLRenderingContext.ONE_MINUS_DST_COLOR;
		 }
		 return 0;
	  }
   }
}
