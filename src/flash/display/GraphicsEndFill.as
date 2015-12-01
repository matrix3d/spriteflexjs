package flash.display
{
   public final class GraphicsEndFill extends Object implements IGraphicsFill, IGraphicsData
   {
       
      public function GraphicsEndFill()
      {
         super();
      }
	  public function draw(ctx:CanvasRenderingContext2D):void {
		ctx.closePath();
		ctx.fill();;
	  }
   }
}
