package flash.__native 
{
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author lizhi http://matrix3d.github.io/
	 */
	public class GLPath2D 
	{
		private var polys:Array = [];
		private var poly:Array;
		public var matr:Matrix = new Matrix;
		private var dirty:Boolean = true;
		private var _drawable:GLDrawable;
		public function GLPath2D() 
		{
			
		}
		public function arc (x:Number, y:Number, radius:Number, startAngle:Number, endAngle:Number, opt_anticlockwise:Boolean=false) : Object{
			return rect(x - radius, y - radius, radius * 2, radius * 2);
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
			return null;
		}
		
		private function makePoly():Array {
			poly = [];
			return poly;
		}
		
		public function get drawable():GLDrawable{
			if (dirty){
				var nump:int = 0;
				var numi:int = 0;
				for each(var poly:Array in polys){
					nump += poly.length;
					numi += (poly.length / 2 - 2) * 3;
				}
				var pos:Float32Array = new Float32Array(nump);
				var index:Uint16Array = new Uint16Array(numi);
				var offset:int = 0;
				var pi:int = 0;
				var ii:int = 0;
				for each(poly in polys){
					for (var i:int = 0; i < poly.length / 2; i++ ){
						var x:Number = poly[2 * i];
						var y:Number = poly[2 * i + 1];
						pos[pi++] = x;
						pos[pi++] = y;
						if (i>=2){
							index[ii++] = offset;
							index[ii++] = offset+i-1;
							index[ii++] = offset+i;
						}
					}
					offset += i;
				}
				_drawable = new GLDrawable(pos,pos,index);
				dirty = false;
			}
			return _drawable;
		}
		
		public function clear():void{
			dirty = true;
			polys.length = 0;
		}
	}

}