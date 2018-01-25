package flash.display
{
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Sprite extends DisplayObjectContainer
	{
		public var graphics:Graphics = new Graphics;
		private var tempPos:Point;
		
		private var _cacheCanvas:HTMLCanvasElement;
		private var _cacheCTX:CanvasRenderingContext2D;
		private var _cacheImage:BitmapData = new BitmapData(1, 1);
		private var _cacheMatrix:Matrix;
		private var _cacheOffsetX:Number = 0;
		private var _cacheOffsetY:Number = 0;
		
		public function Sprite()
		{
			super();
			
			DisplayObject.initStage = Stage.instance;
			initDisplayObjectStage();
		}
		
		public function get buttonMode():Boolean  { return false }
		
		public function set buttonMode(param1:Boolean):void  {/**/ }
		
		public function startDrag(param1:Boolean = false, param2:Rectangle = null):void  {/**/ }
		
		public function stopDrag():void  {/**/ }
		
		public function startTouchDrag(param1:int, param2:Boolean = false, param3:Rectangle = null):void  {/**/ }
		
		public function stopTouchDrag(param1:int):void  {/**/ }
		
		public function get dropTarget():DisplayObject  { return null }
		
		public function get hitArea():Sprite  { return null }
		
		public function set hitArea(param1:Sprite):void  {/**/ }
		
		public function get useHandCursor():Boolean  { return false }
		
		public function set useHandCursor(param1:Boolean):void  {/**/ }
		
		//public function get soundTransform() : SoundTransform;
		
		//public function set soundTransform(param1:SoundTransform) : void;
		
		override public function set cacheAsBitmap(value:Boolean):void 
		{
			super.cacheAsBitmap = value;
			
			if (cacheAsBitmap)
			{
				// do we have any graphics or is this an empty container?
				var hasGraphics:Boolean = (graphics && graphics.bound);
				var bounds:Rectangle = getFullBounds(this);
				if (!hasGraphics)
				{
					bounds.width += bounds.x;
					bounds.height += bounds.y;
					bounds.x = 0;
					bounds.y = 0;
				}
				
				bounds.inflate(filterOffsetX * 2, filterOffsetY * 2); // add space for filter effects
				
				_cacheCanvas = document.createElement("canvas") as HTMLCanvasElement;
				_cacheCanvas.width = bounds.width; // TODO add filter padding
				_cacheCanvas.height = bounds.height;
				_cacheCTX = _cacheCanvas.getContext('2d') as CanvasRenderingContext2D;
				//_cacheCTX.fillStyle = "blue";
				//_cacheCTX.fillRect(0, 0, _cacheCanvas.width, _cacheCanvas.height);
				_cacheOffsetX = (hasGraphics) ? bounds.width - bounds.right - x : -x;
				_cacheOffsetY = (hasGraphics) ? bounds.height - bounds.bottom - y : -y;
				
				if (parent)
				{
					_cacheOffsetX -= parent.x;
					_cacheOffsetY -= parent.y;
				}
				
				var mat:Matrix = transform.concatenatedMatrix.clone();
				mat.translate(_cacheOffsetX, _cacheOffsetY);
				graphics.draw(_cacheCTX, mat, blendMode, transform.concatenatedColorTransform);
				
				ApplyFilters(_cacheCTX);
				
				// draw children to cache canvas
				for (var i:int = 0; i < numChildren; i++) 
				{
					var child:DisplayObject = getChildAt(i);
					child.cacheAsBitmap = true;
					_cacheCTX.drawImage(Object(child).cacheImage.image, -(Object(child).cacheOffsetX + this.x), -(Object(child).cacheOffsetY + this.y));
				}
				
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
		
		override public function __getRect():Rectangle 
		{
			return graphics.bound;
		}
		
		override public function __update(ctx:CanvasRenderingContext2D):void
		{
			if (visible && (graphics.graphicsData.length || numChildren))
			{
				var mat:Matrix = transform.concatenatedMatrix.clone();
				if (cacheAsBitmap && !parent.cacheAsBitmap) 
				{
					SpriteFlexjs.renderer.renderImage(ctx, _cacheImage, mat, blendMode, transform.concatenatedColorTransform, -this.x - _cacheOffsetX, -this.y - _cacheOffsetY);
					//SpriteFlexjs.renderer.renderImage(ctx, _cacheImage, mat, blendMode, transform.concatenatedColorTransform);
				}
				else
				{
					graphics.draw(ctx, mat, blendMode, transform.concatenatedColorTransform, cacheAsBitmap, _cacheImage);
					ApplyFilters(ctx);
				}
			}
			
			if (hasEventListener(Event.ENTER_FRAME))
				dispatchEvent(new Event(Event.ENTER_FRAME));
			if (!cacheAsBitmap) super.__update(ctx);
		}
		
		override protected function __doMouse(e:flash.events.MouseEvent):DisplayObject 
		{
			if (mouseEnabled && visible) {
				var obj:DisplayObject = super.__doMouse(e);
				if (obj) {
					return obj;
				}
				if (hitTestPoint(stage.mouseX, stage.mouseY)) {
					return this;
				}
			}
			return null;
		}
	}
}
