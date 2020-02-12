package flash.display
{
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class Shape extends DisplayObject
	{
		public var graphics:Graphics = new Graphics;
		
		private var _cacheCanvas:HTMLCanvasElement;
		private var _cacheCTX:CanvasRenderingContext2D;
		private var _cacheImage:BitmapData = new BitmapData(1, 1);
		private var _cacheMatrix:Matrix;
		private var _cacheOffsetX:Number = 0;
		private var _cacheOffsetY:Number = 0;
		
		public function Shape()
		{
			super();
		}
		
		override public function __update(ctx:CanvasRenderingContext2D):void
		{
			if (!_off && visible && graphics.graphicsData.length)
			{
				if (filters.length && !cacheAsBitmap && !parent.cacheAsBitmap) cacheAsBitmap = true;
				
				var mat:Matrix = transform.concatenatedMatrix.clone();
				if (cacheAsBitmap && !parent.cacheAsBitmap)
				{
					SpriteFlexjs.renderer.renderImage(ctx, _cacheImage, mat, blendMode, transform.concatenatedColorTransform, -this.x - _cacheOffsetX, -this.y - _cacheOffsetY);
				}
				else
				{
					graphics.draw(ctx, mat, blendMode, transform.concatenatedColorTransform);
					ApplyFilters(ctx);
				}
			}
		}
		
		override public function set cacheAsBitmap(value:Boolean):void 
		{
			super.cacheAsBitmap = value;
			
			if (cacheAsBitmap)
			{
				var bounds:Rectangle = getFullBounds(this);
				
				_cacheCanvas = document.createElement("canvas") as HTMLCanvasElement;
				_cacheCanvas.width = bounds.width; // TODO Add padding for Dropshadow
				_cacheCanvas.height = bounds.height;
				_cacheCTX = _cacheCanvas.getContext('2d') as CanvasRenderingContext2D;
				//_cacheCTX.fillStyle = "black";
				//_cacheCTX.fillRect(0, 0, _cacheCanvas.width, _cacheCanvas.height);
				
				// offsets to center drawing to larger cache canvas due to making space for filters.
				_cacheOffsetX = bounds.width - bounds.right - x;
				_cacheOffsetY = bounds.height - bounds.bottom - y;
				
				if (parent) 
				{
					_cacheOffsetX -= parent.x;
					_cacheOffsetY -= parent.y;
				}
				
				//trace("_cacheOffsetX: " + _cacheOffsetX + ", _cacheOffsetY: " + _cacheOffsetY + ", x: " + x + ", y: " + y);
				var mat:Matrix = transform.concatenatedMatrix.clone();
				mat.translate(_cacheOffsetX, _cacheOffsetY);
				graphics.draw(_cacheCTX, mat, blendMode, transform.concatenatedColorTransform);
				
				_cacheImage.image = _cacheCanvas;
				
				ApplyFilters(_cacheCTX);
				updateTransforms();
			}
			else
			{
				_cacheCanvas = null;
				_cacheCTX = null;
			}
		}
		
		public function get cacheImage():BitmapData 
		{
			return _cacheImage;
		}
		
		public function get cacheOffsetX():Number 
		{
			return _cacheOffsetX;
		}
		
		public function get cacheOffsetY():Number 
		{
			return _cacheOffsetY;
		}
		
		override public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean 
		{
			return false;
		}
		
		override public function __getRect():Rectangle 
		{
			return graphics.bound;
		}
	}
}
