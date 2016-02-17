package flash.display
{
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	public final class GraphicsEndFill extends Object implements IGraphicsFill, IGraphicsData
	{
		public var fill:IGraphicsFill;
		public function GraphicsEndFill()
		{
			super();
		}
		
		public function draw(ctx:CanvasRenderingContext2D,colorTransform:ColorTransform):void
		{
			if (fill) {
				if(fill is GraphicsBitmapFill){
					var bfill:GraphicsBitmapFill = fill as GraphicsBitmapFill;
					if (bfill.matrix) {
						var m:Matrix = bfill.matrix;
					}
				}
				if(m){
					ctx.save();
					ctx.transform(m.a, m.b, m.c, m.d, m.tx, m.ty);
				}
				ctx.fill();
				if (m) {
					ctx.restore();
				}
			}
		}
	}
}
