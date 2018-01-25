package flash.display
{
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author lizhi http://matrix3d.github.io/
	 */
	public final class Graphics extends Object
	{
		public var graphicsData:Vector.<IGraphicsData> = new Vector.<IGraphicsData>;
		public var gradientFills:Vector.<GraphicsGradientFill> = new Vector3D.<GraphicsGradientFill>;
		public var lastStroke:GraphicsStroke;
		public var lastFill:IGraphicsFill;
		private var pathPool:Array = [];
		private var pathPoolPos:int = 0;
		private var lastPath:GraphicsPath;
		private var _bound:Rectangle;
		private var _rect:Rectangle;
		private var lockBound:Boolean = false;
		public static var debug:Boolean = false;
		public var _worldMatrix:Matrix = new Matrix;
		public function Graphics()
		{
			super();
		}
		
		public function clear():void
		{
			SpriteFlexjs.dirtyGraphics = true;
			lastStroke = null;
			lastPath = null;
			pathPoolPos = 0;
			graphicsData = new Vector.<IGraphicsData>;
			_bound = null;
			//_bound.setTo(Number.MAX_VALUE,Number.MAX_VALUE,-Number.MAX_VALUE,-Number.MAX_VALUE);
		}
		
		public function beginFill(color:uint, alpha:Number = 1.0):void
		{
			endStrokAndFill();
			lastFill = new GraphicsSolidFill(color, alpha);
			graphicsData.push(lastFill);
		}
		
		public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:* = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void
		{
			endStrokAndFill();
			lastFill = new GraphicsGradientFill(type, colors, alphas, ratios, _bound, matrix, spreadMethod, interpolationMethod, focalPointRatio);
			graphicsData.push(lastFill);
		}
		
		public function beginBitmapFill(bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void
		{
			endStrokAndFill();
			lastFill = new GraphicsBitmapFill(bitmap, matrix, repeat, smooth);
			graphicsData.push(lastFill);
		}
		
		public function endStrokAndFill():void
		{
			if (lastPath)
			{
				if (lastFill)
				{
					var efill:GraphicsEndFill = new GraphicsEndFill;
					efill.fill = lastFill;
					graphicsData.push(efill);
					lastFill = null;
				}
				if (lastStroke && !isNaN(lastStroke.thickness))
				{
					lastStroke = new GraphicsStroke(NaN);
					graphicsData.push(lastStroke);
				}
				lastPath = null;
			}
		}
		
		// public function beginShaderFill(param1:Shader, param2:Matrix = null) : void;
		
		public function lineGradientStyle(type:String, colors:Array, alphas:Array, ratios:Array, matrix:* = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void
		{
			if (lastStroke)
			{
				endFill();
				var gs:GraphicsStroke = lastStroke;
				gs.fill = new GraphicsGradientFill(type, colors, alphas, ratios, _bound, matrix, spreadMethod, interpolationMethod, focalPointRatio);
			}
		}
		
		public function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):void
		{
			endStrokAndFill();
			if (!isNaN(thickness))
			{
				lastStroke = new GraphicsStroke(thickness === 0 ? 1 : thickness, pixelHinting, scaleMode, (caps) ? caps : "round", (joints) ? joints : "round", miterLimit, new GraphicsSolidFill(color, alpha));
				graphicsData.push(lastStroke);
			}
		}
		
		public function drawRect(x:Number, y:Number, width:Number, height:Number):void
		{
			lockBound = true;
			moveTo(x, y);
			lineTo(x + width, y);
			lineTo(x + width, y + height);
			lineTo(x, y + height);
			lastPath.closePath();
			//lineTo(x, y);
			lockBound = false;
			inflateBound(x, y);
			inflateBound(x + width, y + height);
		}
		
		public function drawRoundRect(x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number, ellipseHeight:Number = NaN):void
		{
			lockBound = true;
			if (isNaN(ellipseHeight))
				ellipseHeight = ellipseWidth;
			moveTo(x + ellipseWidth, y);
			lineTo(x + width - ellipseWidth, y);
			curveTo(x + width, y, x + width, y + ellipseHeight);
			lineTo(x + width, y + height - ellipseHeight);
			curveTo(x + width, y + height, x + width - ellipseWidth, y + height);
			lineTo(x + ellipseWidth, y + height);
			curveTo(x, y + height, x, y + height - ellipseHeight);
			lineTo(x, y + ellipseHeight);
			curveTo(x, y, x + ellipseWidth, y);
			lockBound = false;
			inflateBound(x, y);
			inflateBound(x + width, y + height);
		}
		
		public function drawRoundRectComplex(x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number):void
		{
			lockBound = true;
			moveTo(x + topLeftRadius, y);
			lineTo(x + width - topRightRadius, y);
			curveTo(x + width, y, x + width, y + topRightRadius);
			lineTo(x + width, y + height - bottomRightRadius);
			curveTo(x + width, y + height, x + width - bottomRightRadius, y + height);
			lineTo(x + bottomLeftRadius, y + height);
			curveTo(x, y + height, x, y + height - bottomLeftRadius);
			lineTo(x, y + topLeftRadius);
			curveTo(x, y, x + topLeftRadius, y);
			lockBound = false;
			inflateBound(x, y);
			inflateBound(x + width, y + height);
		}
		
		public function drawCircle(x:Number, y:Number, radius:Number):void
		{
			makePath();
			lastPath.moveTo(x+radius, y);
			lastPath.arc(x, y, radius, 0, Math.PI * 2);
			//this.drawRoundRect(x - radius, y - radius, radius * 2, radius * 2, radius, radius);
			inflateBound(x-radius, y-radius);
			inflateBound(x+radius, y+radius);
		}
		
		//http://stackoverflow.com/questions/2172798/how-to-draw-an-oval-in-html5-canvas
		public function drawEllipse(x:Number, y:Number, w:Number, h:Number):void
		{
			lockBound = true;
			var kappa:Number = .5522848,
			ox:Number = (w / 2) * kappa, // control point offset horizontal
			oy:Number = (h / 2) * kappa, // control point offset vertical
			xe:Number = x + w,           // x-end
			ye:Number = y + h,           // y-end
			xm:Number = x + w / 2,       // x-middle
			ym:Number = y + h / 2;       // y-middle

			moveTo(x, ym);
			cubicCurveTo(x, ym - oy, xm - ox, y, xm, y);
			cubicCurveTo(xm + ox, y, xe, ym - oy, xe, ym);
			cubicCurveTo(xe, ym + oy, xm + ox, ye, xm, ye);
			cubicCurveTo(xm - ox, ye, x, ym + oy, x, ym);
			//ctx.closePath(); // not used correctly, see comments (use to close off open path)
			lockBound = false;
			inflateBound(x, y);
			inflateBound(x+w, y+h);
		}
		
		public function moveTo(x:Number, y:Number):void
		{
			makePath();
			lastPath.moveTo(x, y);
			inflateBound(x, y);
		}
		
		public function lineTo(x:Number, y:Number):void
		{
			makePath();
			lastPath.lineTo(x, y);
			inflateBound(x, y);
		}
		
		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void
		{
			makePath();
			lastPath.curveTo(controlX, controlY, anchorX, anchorY);
			inflateBound(controlX, controlY);
			inflateBound(anchorX, anchorY);
		}
		
		public function cubicCurveTo(controlX1:Number, controlY1:Number, controlX2:Number, controlY2:Number, anchorX:Number, anchorY:Number):void
		{
			makePath();
			lastPath.cubicCurveTo(controlX1, controlY1, controlX2, controlY2, anchorX, anchorY);
			inflateBound(controlX1, controlY1);
			inflateBound(controlX2, controlY2);
			inflateBound(anchorX, anchorY);
		}
		
		private function inflateBound(x:Number, y:Number):void {
			if (lockBound) return;
			
			if (_bound == null)
			{
				_bound = new Rectangle(Number.MAX_VALUE, Number.MAX_VALUE, -Number.MAX_VALUE, -Number.MAX_VALUE);
				_rect = new Rectangle(Number.MAX_VALUE, Number.MAX_VALUE, -Number.MAX_VALUE, -Number.MAX_VALUE);
			}
			
			if (_bound.left>x) {
				_bound.left = x;
				_rect.left = x;
				if (lastStroke) _bound.left -= lastStroke.thickness / 2;
			}
			if (_bound.right<x) {
				_bound.right = x;
				_rect.right = x;
				if (lastStroke) _bound.right += lastStroke.thickness / 2;
			}
			if (_bound.top>y) {
				_bound.top = y;
				_rect.top = y;
				if (lastStroke) _bound.top -= lastStroke.thickness / 2;
			}
			if (_bound.bottom<y) {
				_bound.bottom = y;
				_rect.bottom = y;
				if (lastStroke) _bound.bottom += lastStroke.thickness / 2;
			}
			
			// update the bounds for gradient fills.
			if (lastFill && lastFill is GraphicsGradientFill) GraphicsGradientFill(lastFill).bounds = _bound;
			if (lastStroke && lastStroke.fill is GraphicsGradientFill) GraphicsGradientFill(lastStroke.fill).bounds = _bound;
		}
		
		private function makePath():void
		{
			if (lastPath == null)
			{
				lastPath = pathPool[pathPoolPos];
				if (lastPath==null){
					lastPath = pathPool[pathPoolPos] = SpriteFlexjs.renderer.createPath();
				}
				//lastPath.commands = null;
				//lastPath.data = null;
				lastPath.clear();
				lastPath.gpuPath2DDirty = true;
				pathPoolPos++;
				graphicsData.push(lastPath);
				SpriteFlexjs.dirtyGraphics = true;
			}
		}
		
		public function endFill():void
		{
			endStrokAndFill();
		}
		
		public function copyFrom(g:Graphics):void
		{
			this.graphicsData = g.graphicsData.slice();
		}
		
		public function lineBitmapStyle(bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void
		{
			if (lastStroke && lastStroke is GraphicsStroke)
			{
				var gs:GraphicsStroke = lastStroke as GraphicsStroke;
				gs.fill = new GraphicsBitmapFill(bitmap, matrix, repeat, smooth);
			}
		}
		
		// public function lineShaderStyle(param1:Shader, param2:Matrix = null) : void;
		
		public function drawPath(commands:Vector.<int>, data:Vector.<Number>, winding:String="evenOdd"):void
		{
			makePath();
			lastPath.commands.push.apply(null, commands);
			lastPath.data.push.apply(null, data);
		}
		
		public function drawTriangles(vertices:Vector.<Number>, indices:Vector.<int>=null, uvtData:Vector.<Number>=null, culling:String="none"):void
		{
			makePath();
			lastPath.drawTriangles(vertices, indices, uvtData);
		}
		
		private function drawPathObject(path:IGraphicsPath):void
		{
			var graphicsPath:GraphicsPath = null;
			var graphicsTrianglePath:GraphicsTrianglePath = null;
			if (path is GraphicsPath)
			{
				graphicsPath = GraphicsPath(path);
				this.drawPath(graphicsPath.commands, graphicsPath.data, graphicsPath.winding);
			}
			else if (path is GraphicsTrianglePath)
			{
				graphicsTrianglePath = GraphicsTrianglePath(path);
				this.drawTriangles(graphicsTrianglePath.vertices, graphicsTrianglePath.indices, graphicsTrianglePath.uvtData, graphicsTrianglePath.culling);
			}
		}
		
		private function beginFillObject(fill:IGraphicsFill):void
		{
			var solidFill:GraphicsSolidFill = null;
			var gradientFill:GraphicsGradientFill = null;
			var bitmapFill:GraphicsBitmapFill = null;
			// var shaderFill:GraphicsShaderFill = null;
			if (fill == null)
			{
				this.endFill();
			}
			else if (fill is GraphicsEndFill)
			{
				this.endFill();
			}
			else if (fill is GraphicsSolidFill)
			{
				solidFill = GraphicsSolidFill(fill);
				this.beginFill(solidFill.color, solidFill.alpha);
			}
			else if (fill is GraphicsGradientFill)
			{
				gradientFill = GraphicsGradientFill(fill);
				this.beginGradientFill(gradientFill.type, gradientFill.colors, gradientFill.alphas, gradientFill.ratios, gradientFill.matrix, gradientFill.spreadMethod, gradientFill.interpolationMethod, gradientFill.focalPointRatio);
			}
			else if (fill is GraphicsBitmapFill)
			{
				bitmapFill = GraphicsBitmapFill(fill);
				this.beginBitmapFill(bitmapFill.bitmapData, bitmapFill.matrix, bitmapFill.repeat, bitmapFill.smooth);
			}
		/* else if(fill is GraphicsShaderFill)
		   {
		   shaderFill = GraphicsShaderFill(fill);
		   this.beginShaderFill(shaderFill.shader,shaderFill.matrix);
		   }*/
		}
		
		private function beginStrokeObject(istroke:IGraphicsStroke):void
		{
			var solidFill:GraphicsSolidFill = null;
			var gradientFill:GraphicsGradientFill = null;
			var bitmapFill:GraphicsBitmapFill = null;
			// var shaderFill:GraphicsShaderFill = null;
			var stroke:GraphicsStroke = null;
			var fill:IGraphicsFill = null;
			if (istroke != null && istroke is GraphicsStroke)
			{
				stroke = istroke as GraphicsStroke;
			}
			if (stroke && stroke.fill && stroke.fill is IGraphicsFill)
			{
				fill = stroke.fill;
			}
			if (stroke == null || fill == null)
			{
				this.lineStyle();
			}
			else if (fill is GraphicsSolidFill)
			{
				solidFill = GraphicsSolidFill(fill);
				this.lineStyle(stroke.thickness, solidFill.color, solidFill.alpha, stroke.pixelHinting, stroke.scaleMode, stroke.caps, stroke.joints, stroke.miterLimit);
			}
			else if (fill is GraphicsGradientFill)
			{
				gradientFill = GraphicsGradientFill(fill);
				this.lineStyle(stroke.thickness, 0, 1, stroke.pixelHinting, stroke.scaleMode, stroke.caps, stroke.joints, stroke.miterLimit);
				this.lineGradientStyle(gradientFill.type, gradientFill.colors, gradientFill.alphas, gradientFill.ratios, gradientFill.matrix, gradientFill.spreadMethod, gradientFill.interpolationMethod, gradientFill.focalPointRatio);
			}
			else if (fill is GraphicsBitmapFill)
			{
				bitmapFill = GraphicsBitmapFill(fill);
				this.lineStyle(stroke.thickness, 0, 1, stroke.pixelHinting, stroke.scaleMode, stroke.caps, stroke.joints, stroke.miterLimit);
				this.lineBitmapStyle(bitmapFill.bitmapData, bitmapFill.matrix, bitmapFill.repeat, bitmapFill.smooth);
			}
		/*else if(fill is GraphicsShaderFill)
		   {
		   shaderFill = GraphicsShaderFill(fill);
		   this.lineStyle(stroke.thickness,0,1,stroke.pixelHinting,stroke.scaleMode,stroke.caps,stroke.joints,stroke.miterLimit);
		   this.lineShaderStyle(shaderFill.shader,shaderFill.matrix);
		   }*/
		}
		
		public function drawGraphicsData(graphicsData:Vector.<IGraphicsData>):void
		{
			var item:IGraphicsData = null;
			var path:IGraphicsPath = null;
			var fill:IGraphicsFill = null;
			var stroke:IGraphicsStroke = null;
			if (graphicsData == null)
			{
				return;
			}
			for (var i:int = 0; i < graphicsData.length; i++)
			{
				item = graphicsData[i];
				if (item is IGraphicsPath)
				{
					path = IGraphicsPath(item);
					this.drawPathObject(path);
				}
				else if (item is IGraphicsFill)
				{
					fill = IGraphicsFill(item);
					this.beginFillObject(fill);
				}
				else if (item is IGraphicsStroke)
				{
					stroke = IGraphicsStroke(item);
					this.beginStrokeObject(stroke);
				}
			}
		}
		
		/*private function GetGraphicsData(param1:Vector.<IGraphicsData>, recurse:Boolean):void
		   {
		
		   }*/
		
		public function readGraphicsData(recurse:Boolean = true):Vector.<IGraphicsData>
		{
			/* var vec:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
			   this.GetGraphicsData(vec,recurse);
			   return vec;*/
			return graphicsData.slice();
		}
		
		
		/**
		 * returns rectangle of drawn graphics not including strokes
		 */
		public function get rect():Rectangle 
		{
			return _rect;
		}
		
		/**
		 * returns rectangle of drawn graphics including strokes
		 */
		public function get bound():Rectangle 
		{
			return _bound
		}
		
		public function draw(ctx:CanvasRenderingContext2D, m:Matrix, blendMode:String, colorTransform:ColorTransform, useCache:Boolean = false, cacheImage:BitmapData = null):void
		{
			if (graphicsData.length || useCache)
			{
				if (useCache)
				{
					SpriteFlexjs.renderer.renderImage(ctx, cacheImage, m, blendMode, colorTransform);
				}
				else
				{
					SpriteFlexjs.renderer.renderGraphics(ctx, this, m, blendMode, colorTransform);
				}
				SpriteFlexjs.drawCounter++;
			}
		}
	}
}