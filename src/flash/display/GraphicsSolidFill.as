package flash.display
{
   public final class GraphicsSolidFill extends Object implements IGraphicsFill, IGraphicsData
   {
       
      public var color:uint = 0;
      
      public var alpha:Number = 1.0;
      
      public function GraphicsSolidFill(color:uint = 0, alpha:Number = 1.0)
      {
         super();
         this.color = color;
         this.alpha = alpha;
      }
	  public function draw(ctx:CanvasRenderingContext2D):void {
		ctx.fillStyle="rgba("+(color>>16&0xff)+","+(color>>8&0xff)+","+(color&0xff)+","+this.alpha+")";
		  ctx.beginPath();
	  }
   }
}
