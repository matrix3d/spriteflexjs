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
			if (visible && graphics.graphicsData.length)
			{
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
				
				bounds.inflate(filterOffsetX * 2, filterOffsetY * 2); // add space for filter effects
				
				_cacheCanvas = document.createElement("canvas") as HTMLCanvasElement;
				_cacheCanvas.width = bounds.width; // TODO Add padding for Dropshadow
				_cacheCanvas.height = bounds.height;
				_cacheCTX = _cacheCanvas.getContext('2d') as CanvasRenderingContext2D;
				//_cacheCTX.fillStyle = "blue";
				//_cacheCTX.fillRect(0, 0, _cacheCanvas.width, _cacheCanvas.height);
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
				
				ApplyFilters(_cacheCTX);
				
				_cacheImage.image = _cacheCanvas;
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
