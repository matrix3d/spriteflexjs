package flash.__native 
{
	import flash.display.GraphicsPath;
	/**
	 * ...
	 * @author lizhi
	 */
	public class GLGraphicsPath extends GraphicsPath
	{
		public var polys:MemArray = new MemArray;
		private var poly:MemArray;
		public function GLGraphicsPath() 
		{
			
		}
		
		override public function clear():void{
			var len:int = polys.array.length;
			for (var i:int = 0; i < len;i++ ){
				polys.array[i].length = 0;
			}
			polys.length = 0;
			tris.length = 0;
		}
		
		override public function moveTo(x:Number, y:Number):void
		{
			makePoly();
			//polys.push(makePoly());
			poly.push(x);
			poly.push(y);
			//poly.push(x, y);
		}
		
		override public function lineTo(x:Number, y:Number):void
		{
			if (poly==null){
				makePoly();
			}
			//poly.push(x, y);
			poly.push(x);
			poly.push(y);
		}
		
		override public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void
		{
			if (poly==null){
				makePoly();
			}
			//poly.push(controlX);
			//poly.push(controlY);
			//poly.push(anchorX);
			//poly.push(anchorY);
			//poly.push(controlX, controlY, anchorX, anchorY);
			
			if (poly.length>=2){
				var x0:Number = poly.array[poly.length - 2];
				var y0:Number = poly.array[poly.length - 1];
				var d:Number = Math.abs(x0 - anchorX) + Math.abs(y0 - anchorY);
				var step:Number = 5 / d;
				for (var t1:Number = step; t1 <= 1; t1 += step ){
					var t0:Number = 1 - t1;
					var q0x:Number = t0 * x0 + t1 * controlX;
					var q0y:Number = t0 * y0 + t1 * controlY;
					var q1x:Number = t0 * controlX + t1 * anchorX;
					var q1y:Number = t0 * controlY + t1 * anchorY;
					poly.push(t0 * q0x + t1 * q1x);
					poly.push(t0 * q0y + t1 * q1y);
				}
			}
		}
		
		/*private function getCurvePoint(t1:Number, p0:Point, p1:Point, p2:Point):Vector3D
        {
            var t0:Number = 1 - t1;
            var q0x:Number = t0 * p0.x + t1 * p1.x;
            var q0y:Number = t0 * p0.y + t1 * p1.y;
            var q1x:Number = t0 * p1.x + t1 * p2.x;
            var q1y:Number = t0 * p1.y + t1 * p2.y;
            return new Vector3D(t0 * q0x + t1 * q1x, t0 * q0y + t1 * q1y, Math.atan2(q1y - q0y, q1x - q0x));
        }*/
		
		override public function cubicCurveTo(controlX1:Number, controlY1:Number, controlX2:Number, controlY2:Number, anchorX:Number, anchorY:Number):void
		{
			if (poly==null){
				makePoly();
			}
			poly.push(controlX1);
			poly.push(controlY1);
			poly.push(controlX2);
			poly.push(controlY2);
			poly.push(anchorX);
			poly.push(anchorY);
			//poly.push(controlX1, controlY1,controlX2, controlY2, anchorX, anchorY);
		}
		
		override public function wideLineTo(x:Number, y:Number):void
		{
			lineTo(x, y);
		}
		
		override public function wideMoveTo(x:Number, y:Number):void
		{
			moveTo(x, y);
		}
		
		override public function arc(x:Number, y:Number,r:Number,a0:Number,a1:Number):void
		{
			var da:Number = int(1 / r *180/Math.PI);// Math.PI * 3 / 4;
			if (da<1){
				da = 1;
			}
			if (da>90){
				da = 90;
			}
			da = da * Math.PI / 180;
			var x0:Number = r;
			var y0:Number = 0;
			var sin:Number = Math.sin(da);
			var cos:Number = Math.cos(da);
			moveTo(x0+x, y0+y);
			for (var a:Number = a0; a < a1;a+=da ){
				var x_:Number = x0;
				x0 = x0 * cos - y0 * sin;
				y0 = x_ * sin + y0 * cos;
				lineTo(x0 + x, y0 + y);
			}
		}
		
		private function rect (x:Number, y:Number, w:Number, h:Number) : void {
			moveTo(x, y);
			lineTo(x + w, y);
			lineTo(x + w, y + h);
			lineTo(x, y + h);
		}
		
		private function makePoly():void {
			poly = polys.array[polys.length];
			if (poly==null){
				poly = polys.array[polys.length] = new MemArray;
			}
			polys.length++;
		}
	}

}