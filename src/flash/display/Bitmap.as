package flash.display
{
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Bitmap extends DisplayObject
	{
		private var _bitmapData:BitmapData;
		
		public function Bitmap(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
		{
			super();
			this.ctorbmp(bitmapData, pixelSnapping, smoothing);
		}
		
		private function ctorbmp(bitmapData:BitmapData, pixelSnapping:String, smoothing:Boolean):void
		{
			_bitmapData = bitmapData;
		}
		
		public function get pixelSnapping():String  { return null }
		
		public function set pixelSnapping(param1:String):void
		{
		
		}
		
		public function get smoothing():Boolean  { return false }
		
		public function set smoothing(param1:Boolean):void
		{
		
		}
		
		public function get bitmapData():BitmapData  { return _bitmapData }
		
		public function set bitmapData(param1:BitmapData):void
		{
			_bitmapData = param1;
		}
		
		override public function __getRect():Rectangle 
		{
			if (bitmapData) return bitmapData.rect;
			return null;
		}
		
		override public function __update():void
		{
			super.__update();
			if (stage && _bitmapData&&_bitmapData.image&&visible)
			{
				var m:Matrix = worldMatrix;
				var ctx:CanvasRenderingContext2D = stage.ctx;
				var ga:Number = ctx.globalAlpha;
				ctx.globalAlpha *= alpha;
				ctx.globalCompositeOperation = BlendMode.getCompVal(blendMode);
				ctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
				ctx.drawImage(_bitmapData.image, 0, 0);
				ctx.globalAlpha = ga;
			}
		}
		
		override protected function __doMouse(e:flash.events.MouseEvent):DisplayObject 
		{
			if (stage&&visible) {
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
