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
			
			transformGradient();
		}
		
		private function prepareColors():void 
		{
			_convertedColors = [];
			for (var i:int = 0; i < colors.length; i++) 
			{
				_convertedColors.push(SpriteFlexjs.renderer.getCssColor(colors[i], alphas[i], _colorTransform, null) as String);
			}
		}
		
		private function transformGradient():void 
		{
			if (matrix)
			{
				if (type == GradientType.LINEAR)
				{
					var rotation:Number;
					var pi:Number = 3.14159265358979323846;
					var degree:Number = 180 / pi;
					var radian:Number = pi / 180;
					
					var scaleX:Number = Math.sqrt((matrix.a * matrix.a) + (matrix.c * matrix.c));
					var scaleY:Number = Math.sqrt((matrix.b * matrix.b) + (matrix.d * matrix.d));
					var sign:Number = Math.atan(-(matrix.c) / matrix.a);
					var rad:Number = Math.acos(matrix.a / scaleX);
					
					var deg:Number = rad * degree;
					
					if ((deg > 90 && sign > 0) || (deg < 90 && sign < 0))
					{
						rotation = (360 - deg) * radian;
					}
					else
					{
						rotation = rad;
					}
					var rotationInDegree:Number = rotation * degree;
					
					// apply scale to rectangle
					var bnds:Rectangle = _bounds.clone();
					bnds.inflatePoint(new Point(_bounds.width * scaleX, _bounds.height * scaleY));
					
					// new scaled coordinates
					_startPoint = new Point(bnds.topLeft.x, bnds.bottomRight.y / 2);
					_endPoint = new Point(bnds.bottomRight.x/2, bnds.bottomRight.y / 2);
					
					// apply rotation on rectangle
					var rotationPoint:Point = new Point((bnds.left  + bnds.width) / 2, (bnds.top + bnds.height) / 2);
					_startPoint = getRotatedRectPoint(rotationInDegree, _startPoint, rotationPoint);
					_endPoint = getRotatedRectPoint(rotationInDegree, _endPoint, rotationPoint);
				}
				else // radial
				{
					_startPoint = new Point(matrix.tx, matrix.ty);
					_endPoint = new Point(matrix.tx, matrix.ty);
				}
				
				//trace("ScaleX: " + scaleX + ", ScaleY: " + scaleY + ", rotation: " + rotationInDegree);
				//trace("Transformed: startPoint: " + _startPoint + ", endPoint: " + _endPoint + ", bounds: " + _bounds);
			}
			else
			{
				if (type == GradientType.LINEAR)
				{
					_startPoint = new Point(_bounds.topLeft.x, _bounds.bottomRight.y / 2);
					_endPoint = new Point(_bounds.bottomRight.x, _bounds.bottomRight.y / 2);
				}
				else
				{
					_startPoint = _endPoint = new Point(bounds.x + (bounds.width/2), bounds.y + (bounds.height /2));
				}
			}
			
		}
		
		private function getRotatedRectPoint( angle:Number, point:Point, rotationPoint:Point = null):Point
		{
			var ix:Number = (rotationPoint) ? rotationPoint.x : 0;
			var iy:Number = (rotationPoint) ? rotationPoint.y : 0;
			
			var m:Matrix = new Matrix( 1,0,0,1, point.x - ix, point.y - iy);
			m.rotate(angle);
			return new Point( m.tx + ix, m.ty + iy);
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
			
			transformGradient();
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
					_gradient = ctx.createRadialGradient(_startPoint.x, _startPoint.y, 0, _endPoint.x, _endPoint.y, bounds.width / 1.5);
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
