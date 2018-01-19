package flash.display
{
	import flash.events.Event;
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
				graphics.draw(ctx, transform.concatenatedMatrix, blendMode, transform.concatenatedColorTransform, cacheAsBitmap, _cacheImage);
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
				//_cacheCTX.fillStyle = "blue";
				//_cacheCTX.fillRect(0, 0, _cacheCanvas.width, _cacheCanvas.height);
				var mat:Matrix = transform.concatenatedMatrix.clone();
				_cacheOffsetX = bounds.width - bounds.right - x;
				_cacheOffsetY = bounds.height - bounds.bottom - y;
				
				//trace("offsetX: " + offsetX + ", offsetY: " + offsetY + ", x: " + x + ", y: " + y);
				
				if (parent) 
				{
					_cacheOffsetX -= parent.x;
					_cacheOffsetY -= parent.y;
				}
				mat.translate(_cacheOffsetX, _cacheOffsetY);
				//mat.translate(0, -250);
				graphics.draw(_cacheCTX, mat, blendMode, transform.concatenatedColorTransform);
				
				//trace("offsetX: " + offsetX + ", offsetY: " + offsetY + ", x: " + x + ", y: " + y);
				
				/*// shadow test
				_cacheCTX.shadowColor = 'rgba(0,0,0, 0.50)';
				_cacheCTX.shadowBlur = 10;
				_cacheCTX.shadowOffsetX = 10;
				_cacheCTX.shadowOffsetY = 10;
				_cacheCTX.stroke();
				_cacheCTX.fill();
				// clear the shadow
				_cacheCTX.shadowColor = "0";
				_cacheCTX.shadowOffsetX = 0; 
				_cacheCTX.shadowOffsetY = 0;
				
				// restroke w/o the shadow
				_cacheCTX.stroke();*/
				
				_cacheImage.image = _cacheCanvas;
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
