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
			poly.push(controlX);
			poly.push(controlY);
			poly.push(anchorX);
			poly.push(anchorY);
			//poly.push(controlX, controlY, anchorX, anchorY);
		}
		
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
			var da:Number = Math.PI / 4;
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