package flash.display
{
	import flash.__native.GLCanvasRenderingContext2D;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public final class GraphicsGradientFill extends Object implements IGraphicsFill, IGraphicsData
	{
		
		private var _type:String;
		
		public var colors:Array;
		
		public var alphas:Array;
		
		public var ratios:Array;
		
		private var _bounds:Rectangle;
		
		public var matrix:Matrix;
		
		private var _spreadMethod:String;
		
		private var _interpolationMethod:String;
		
		public var focalPointRatio:Number;
		
		private var _gradient:CanvasGradient;
		private var _startPoint:Point;
		private var _endPoint:Point;
		private var _convertedColors:Array;
		private var _convertedRatios:Array;
		private var _colorTransform:ColorTransform;
		
		public function GraphicsGradientFill(type:String = "linear", colors:Array = null, alphas:Array = null, ratios:Array = null, bounds:Rectangle = null, matrix:Matrix = null, spreadMethod:* = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0.0)
		{
			super();
			this._type = type;
			this.colors = colors;
			this.alphas = alphas;
			this.ratios = ratios;
			_bounds = (bounds) ? bounds : new Rectangle();
			this.matrix = matrix;
			this._spreadMethod = spreadMethod;
			this._interpolationMethod = interpolationMethod;
			this.focalPointRatio = focalPointRatio;
			
			// convert ratios
			_convertedRatios = [];
			for (var i:int = 0; i < ratios.length; i++) 
			{
				_convertedRatios.push(ratios[i] / 255);
			}
			
			// prepare start and end points from matrix
			if (matrix)
			{
				//trace("bounds: " + _bounds);
				_startPoint = new Point(-(_bounds.width *2), _bounds.height);
				_endPoint = new Point(_bounds.width * 2, _bounds.height);
				
				if (type == GradientType.RADIAL)
				{
					_startPoint = new Point(0, 0);
					_endPoint = new Point(0, 0);
				}
				
				_startPoint = matrix.transformPoint(_startPoint);
				_endPoint = matrix.transformPoint(_endPoint);
				//trace("startPoint: " + _startPoint + ", endPoint: " + _endPoint);
			}
			else
			{
				_startPoint = new Point(_bounds.x, _bounds.y);
				_endPoint = new Point(_bounds.width, _bounds.y);
			}
			
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
		
		private function prepareColors():void 
		{
			_convertedColors = [];
			for (var i:int = 0; i < colors.length; i++) 
			{
				_convertedColors.push(SpriteFlexjs.renderer.getCssColor(colors[i], alphas[i], _colorTransform, null) as String);
			}
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
		
		public function get bounds():Rectangle 
		{
			return _bounds;
		}
		
		public function set bounds(value:Rectangle):void 
		{
			_bounds = value;
			
			if (matrix)
			{
				_startPoint = new Point(-(_bounds.width *2), _bounds.height);
				_endPoint = new Point(_bounds.width * 2, _bounds.height);
				
				if (type == GradientType.RADIAL)
				{
					_startPoint = new Point(0, 0);
					_endPoint = new Point(0, 0);
					//trace("startPoint: " + _startPoint + ", endPoint: " + _endPoint);
				}
				
				_startPoint = matrix.transformPoint(_startPoint);
				_endPoint = matrix.transformPoint(_endPoint);
				//trace("Transformed: startPoint: " + _startPoint + ", endPoint: " + _endPoint);
			}
			else
			{
				_startPoint = new Point(_bounds.x, _bounds.y);
				_endPoint = new Point(_bounds.width, _bounds.y);
			}
		}
		
		public function get gradient():CanvasGradient 
		{
			return _gradient;
		}
		
		public function get startPoint():Point 
		{
			return _startPoint;
		}
		
		public function get endPoint():Point 
		{
			return _endPoint;
		}
		
		/**
		 * @royaleignorecoercion String
		 */
		public function draw(ctx:CanvasRenderingContext2D,colorTransform:ColorTransform):void
		{
			if (_gradient == null)
			{
				if (type === GradientType.LINEAR) {
					_gradient = ctx.createLinearGradient(_startPoint.x, _startPoint.y, _endPoint.x, _endPoint.y);
				}else {
					_gradient = ctx.createRadialGradient(_startPoint.x, _startPoint.y, 0, _endPoint.x, _endPoint.y, bounds.width / 2);
				}
				
				if (!_colorTransform || _colorTransform != colorTransform)
				{
					_colorTransform = colorTransform;
					prepareColors();
				}
				
				for (var i:int = 0; i < colors.length; i++) 
				{
					_gradient.addColorStop(_convertedRatios[i], _convertedColors[i]);
				}
			}
			
			ctx.fillStyle = _gradient as String;
		}
		public function gldraw(ctx:GLCanvasRenderingContext2D, colorTransform:ColorTransform):void{
			if (_gradient == null) {
				if (type==GradientType.LINEAR) {
					_gradient = ctx.createLinearGradient(0, 0, 1, 1);
				}else {
					_gradient = ctx.createRadialGradient(0, 0, 1, 0, 0, 1);
				}
			}
			ctx.fillStyle = _gradient as String;
			ctx.fillStyleIsImage = false;
		}
	}
}
