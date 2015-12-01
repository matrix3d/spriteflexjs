package flash.display
{
   import flash.geom.Matrix;
   
   public final class GraphicsBitmapFill extends Object implements IGraphicsFill, IGraphicsData
   {
       
      public var bitmapData:BitmapData;
      
      public var matrix:Matrix;
      
      public var repeat:Boolean;
      
      public var smooth:Boolean;
      
      public function GraphicsBitmapFill(bitmapData:BitmapData = null, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false)
      {
         super();
         this.bitmapData = bitmapData;
         this.matrix = matrix;
         this.repeat = repeat;
         this.smooth = smooth;
      }
	  
	  public function draw(ctx:CanvasRenderingContext2D):void {
		  if(bitmapData){
			//ctx.fillStyle =ctx.createPattern(bitmapData.image,this.repeat? "repeat":"no-repeat");
			ctx.beginPath();
		  }
	  }
   }
}
