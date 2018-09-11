package flash.display
{
	import flash.__native.GLCanvasRenderingContext2D;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	public final class GraphicsBitmapFill extends Object implements IGraphicsFill, IGraphicsData
	{
		
		public var bitmapData:BitmapData;
		
		public var matrix:Matrix;
		
		public var repeat:Boolean;
		
		public var smooth:Boolean;
		
		private var pattern:CanvasPattern;
		
		public function GraphicsBitmapFill(bitmapData:BitmapData = null, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false)
		{
			super();
			this.bitmapData = bitmapData;
			this.matrix = matrix;
			this.repeat = repeat;
			this.smooth = smooth;
		}
		
		/**
		 * @royaleignorecoercion String
		 */
		public function draw(ctx:CanvasRenderingContext2D,colorTransform:ColorTransform):void
		{
			if (pattern==null&&bitmapData) {
				pattern = ctx.createPattern(bitmapData.image, this.repeat ? "repeat" : "no-repeat");
			}
			ctx.fillStyle = pattern as String;
		}
		
		/**
		 * @royaleignorecoercion String
		 */
		public function gldraw(ctx:GLCanvasRenderingContext2D, colorTransform:ColorTransform):void{
			if (pattern==null&&bitmapData) {
				pattern = ctx.createPattern(bitmapData.image, this.repeat ? "repeat" : "no-repeat");
			}
			ctx.fillStyleIsImage = true;
			ctx.fillStyle = pattern as String;
		}
	}
}
