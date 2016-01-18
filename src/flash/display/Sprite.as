package flash.display
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Sprite extends DisplayObjectContainer
	{
		private var _graphics:Graphics;
		private var tempPos:Point
		public function Sprite()
		{
		}
		
		public function get graphics():Graphics
		{
			if (_graphics == null)
			{
				_graphics = new Graphics;
			}
			return _graphics;
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
		
		override public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean 
		{
			return graphics.bound.containsPoint(invMatrix.transformPoint(new Point(x,y)));
		}
		
		override public function __update():void
		{
			super.__update();
			if (stage&&visible)
				graphics.draw(stage.ctx, worldMatrix,alpha,blendMode,transform._colorTransform);
		}
		
		override protected function __doMouse(e:flash.events.MouseEvent):DisplayObject 
		{
			if (stage && mouseEnabled) {
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
