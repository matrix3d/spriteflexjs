package flash.display3D
{
   public final class Context3DCompareMode extends Object
   {
      
      public static const ALWAYS:int = WebGLRenderingContext.ALWAYS;//"always";
      
      public static const NEVER:int = WebGLRenderingContext.NEAREST;//"never";
      
      public static const LESS:int = WebGLRenderingContext.LESS;//"less";
      
      public static const LESS_EQUAL:int = WebGLRenderingContext.LESS|WebGLRenderingContext.EQUAL;//"lessEqual";
      
      public static const EQUAL:int = WebGLRenderingContext.EQUAL;//"equal";
      
      public static const GREATER_EQUAL:int = WebGLRenderingContext.GREATER|WebGLRenderingContext.EQUAL;//"greaterEqual";
      
      public static const GREATER:int = WebGLRenderingContext.GREATER;//"greater";
      
      public static const NOT_EQUAL:int = WebGLRenderingContext.NOTEQUAL;//"notEqual";
       
      public function Context3DCompareMode()
      {
         super();
      }
   }
}
