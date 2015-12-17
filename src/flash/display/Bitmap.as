package flash.display
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	
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
		
		override public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean 
		{
			if(bitmapData)return bitmapData.rect.containsPoint(invMatrix.transformPoint(new Point(x,y)));
			return false;
		}
		
		override public function innerUpdate():void
		{
			super.innerUpdate();
			if (stage && _bitmapData&&_bitmapData.image)
			{
				var m:Matrix = worldMatrix;
				var ctx:CanvasRenderingContext2D = stage.ctx;
				ctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
				ctx.drawImage(_bitmapData.image, 0, 0);
			}
		}
	}
}
