package flash.display
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
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
				
				//trace("Name: " + name + ", bounds: " + bounds);
				
				_cacheCanvas = document.createElement("canvas") as HTMLCanvasElement;
				_cacheCanvas.width = bounds.width; // TODO add filter padding
				_cacheCanvas.height = bounds.height;
				//trace("cache width: " + getBounds(this).width + ", height: " + getBounds(this).height);
				_cacheCTX = _cacheCanvas.getContext('2d') as CanvasRenderingContext2D;
				//_cacheCTX.fillStyle = "blue";
				//_cacheCTX.fillRect(0, 0, _cacheCanvas.width, _cacheCanvas.height);
				
				var mat:Matrix = transform.concatenatedMatrix.clone();
				_cacheOffsetX = (hasGraphics) ? bounds.width - bounds.right - x : -x;
				_cacheOffsetY = (hasGraphics) ? bounds.height - bounds.bottom - y : -y;
				
				//trace("matX: " + mat.tx + ", matY: " + mat.ty);
				
				if (parent)
				{
					_cacheOffsetX -= parent.x;
					_cacheOffsetY -= parent.y;
				}
				
				mat.translate(_cacheOffsetX, _cacheOffsetY);
				
				
				//trace("Cache " + name + ": offsetX: " + _cacheOffsetX + ", offsetY: " + _cacheOffsetY);
				
				graphics.draw(_cacheCTX, mat, blendMode, transform.concatenatedColorTransform);
				
				// draw children to cache canvas
				for (var i:int = 0; i < numChildren; i++) 
				{
					var child:DisplayObject = getChildAt(i);
					if (child is Shape)
					{
						Shape(child).cacheAsBitmap = true;
						_cacheCTX.drawImage(Shape(child).cacheImage.image, -(Shape(child).cacheOffsetX + this.x), -(Shape(child).cacheOffsetY + this.y));
					}
					else if (child is Sprite) 
					{
						Sprite(child).cacheAsBitmap = true;
						_cacheCTX.drawImage(Sprite(child).cacheImage.image, -(Sprite(child).cacheOffsetX + this.x), -(Sprite(child).cacheOffsetY + this.y));
					}
				}
				
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
					//trace("Sprite: " + name + ", ParentX: " + parent.x + ", ParentY: " + parent.y);
					var bounds:Rectangle = getRect(this);
					mat.translate(parent.x, parent.y);
					//trace("Parent X: " + parent.x + ", Y: " + parent.y);
					//trace("This X: " + this.x + ", Y: " + this.y);
				}
				
				graphics.draw(ctx, mat, blendMode, transform.concatenatedColorTransform, cacheAsBitmap, _cacheImage);
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
