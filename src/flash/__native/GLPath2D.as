package flash.__native 
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class GLPath2D 
	{
		private var polys:Array = [];
		private var poly:Array;
		public function GLPath2D() 
		{
			
		}
		public function arc (x:Number, y:Number, radius:Number, startAngle:Number, endAngle:Number, opt_anticlockwise:Boolean=false) : Object{
			return null;
		}

		public function arcTo (x1:Number, y1:Number, x2:Number, y2:Number, radius:Number) : Object {
			return null;
		}
		public function bezierCurveTo (cp1x:Number, cp1y:Number, cp2x:Number, cp2y:Number, x:Number, y:Number) : Object {
			poly.push(cp1x, cp1y, cp2x, cp2y, x, y);
			return null;
		}
		public function quadraticCurveTo (cpx:Number, cpy:Number, x:Number, y:Number) : Object {
			poly.push(cpx, cpy, x, y);
			return null;
		}
		public function closePath () : Object {
			return null;
		}
		public function lineTo (x:Number, y:Number) : Object {
			poly.push(x, y);
			return null;
		}
		public function moveTo (x:Number, y:Number) : Object {
			polys.push(makePoly());
			poly.push(x, y);
			return null;
		}
		public function rect (x:Number, y:Number, w:Number, h:Number) : Object {
			moveTo(x, y);
			lineTo(x + w, y);
			lineTo(x + w, y + h);
			lineTo(x, y + h);
			lineTo(x, y);
			return null;
		}
		
		private function makePoly():Array {
			poly = [];
			return poly;
		}
	}

}