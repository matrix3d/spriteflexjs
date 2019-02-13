package flash.display
{
	import flash.__native.GLCanvasRenderingContext2D;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	public final class GraphicsEndFill extends Object implements IGraphicsFill, IGraphicsData
	{
		public var fill:IGraphicsFill;
		public var _worldMatrix:Matrix = new Matrix;
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
					ctx.globalAlpha = colorTransform.alphaMultiplier;
				}else{
					ctx.globalAlpha = 1;
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
		/**
		 * @royaleignorecoercion flash.display.GraphicsBitmapFill
		 */
		public function gldraw(ctx:GLCanvasRenderingContext2D, colorTransform:ColorTransform):void{
			if (fill) {
				/*if(fill is GraphicsBitmapFill){
					var bfill:GraphicsBitmapFill = fill as GraphicsBitmapFill;
					if (bfill.matrix) {
						var m:Matrix = bfill.matrix;
					}
					ctx.globalAlpha = colorTransform.alphaMultiplier;
				}else{
					ctx.globalAlpha = 1;
				}*/
				var m:Matrix = fill["matrix"];
				if(m){
					//ctx.save();
					_worldMatrix.copyFrom(m);
				}else{
					_worldMatrix.identity();
				}
				var temp:Matrix = ctx.matr;
				ctx.transform2(_worldMatrix);
				ctx.fill();
				ctx.matr = temp;
				//if (m) {
					//ctx.restore();
				//}
			}
		}
	}
}
