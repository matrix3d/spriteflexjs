package flash.display
{
	import flash.__native.GLCanvasRenderingContext2D;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	public final class GraphicsGradientFill extends Object implements IGraphicsFill, IGraphicsData
	{
		
		private var _type:String;
		
		public var colors:Array;
		
		public var alphas:Array;
		
		public var ratios:Array;
		
		public var matrix:Matrix;
		
		private var _spreadMethod:String;
		
		private var _interpolationMethod:String;
		
		public var focalPointRatio:Number;
		
		private var gradient:CanvasGradient;
		public function GraphicsGradientFill(type:String = "linear", colors:Array = null, alphas:Array = null, ratios:Array = null, matrix:* = null, spreadMethod:* = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0.0)
		{
			super();
			this._type = type;
			this.colors = colors;
			this.alphas = alphas;
			this.ratios = ratios;
			this.matrix = matrix;
			this._spreadMethod = spreadMethod;
			this._interpolationMethod = interpolationMethod;
			this.focalPointRatio = focalPointRatio;
		/*if(this._type != GradientType.LINEAR && this._type != GradientType.RADIAL)
		   {
		   Error.throwError(null,2008,"type");
		   }
		   if(this._spreadMethod != "none" && this._spreadMethod != SpreadMethod.PAD && this._spreadMethod != SpreadMethod.REFLECT && this._spreadMethod != SpreadMethod.REPEAT)
		   {
		   Error.throwError(null,2008,"spreadMethod");
		   }
		   if(this._interpolationMethod != InterpolationMethod.LINEAR_RGB && this._interpolationMethod != InterpolationMethod.RGB)
		   {
		   Error.throwError(null,2008,"interpolationMethod");
		   }*/
		}
		
		public function get type():String
		{
			return this._type;
		}
		
		public function set type(value:String):*
		{
			/*if(value != GradientType.LINEAR && value != GradientType.RADIAL)
			   {
			   Error.throwError(null,2008,"type");
			   }*/
			this._type = value;
		}
		
		public function get spreadMethod():String
		{
			return this._spreadMethod;
		}
		
		public function set spreadMethod(value:String):*
		{
			/*if(value != "none" && value != SpreadMethod.PAD && value != SpreadMethod.REFLECT && value != SpreadMethod.REPEAT)
			   {
			   Error.throwError(null,2008,"spreadMethod");
			   }*/
			this._spreadMethod = value;
		}
		
		public function get interpolationMethod():String
		{
			return this._interpolationMethod;
		}
		
		public function set interpolationMethod(value:String):*
		{
			/* if(value != InterpolationMethod.LINEAR_RGB && value != InterpolationMethod.RGB)
			   {
			   Error.throwError(null,2008,"interpolationMethod");
			   }*/
			this._interpolationMethod = value;
		}
		
		/**
		 * @flexjsignorecoercion String
		 */
		public function draw(ctx:CanvasRenderingContext2D,colorTransform:ColorTransform):void
		{
			if (gradient == null) {
				if (type===GradientType.LINEAR) {
					gradient = ctx.createLinearGradient(0, 0, 1, 1);
				}else {
					gradient = ctx.createRadialGradient(0, 0, 1, 0, 0, 1);
				}
			}
			ctx.fillStyle = gradient as String;
		}
		public function gldraw(ctx:GLCanvasRenderingContext2D, colorTransform:ColorTransform):void{
			if (gradient == null) {
				if (type==GradientType.LINEAR) {
					gradient = ctx.createLinearGradient(0, 0, 1, 1);
				}else {
					gradient = ctx.createRadialGradient(0, 0, 1, 0, 0, 1);
				}
			}
			ctx.fillStyle = gradient as String;
			ctx.fillStyleIsImage = false;
		}
	}
}
