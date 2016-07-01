package flash.display
{
   public final class GraphicsPathCommand extends Object
   {
      
      public static const NO_OP:int = 0;
      
      public static const MOVE_TO:int = 1;
      
      public static const LINE_TO:int = 2;
      
      public static const CURVE_TO:int = 3;
      
      public static const WIDE_MOVE_TO:int = 4;
      
      public static const WIDE_LINE_TO:int = 5;
      
      public static const CUBIC_CURVE_TO:int = 6;
	  
      public static const ARC:int = 7;
	  
	  public static const CLOSE_PATH:int = 8;
	  public static const DRAW_TRIANGLES:int = 9;
       
      public function GraphicsPathCommand()
      {
         super();
      }
   }
}
