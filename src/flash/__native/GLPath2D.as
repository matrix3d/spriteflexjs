package flash.__native 
{
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author lizhi http://matrix3d.github.io/
	 */
	public class GLPath2D 
	{
		public var polys:Array = [];
		public var poly:Array;
		public var matr:Matrix = new Matrix;
		public var _drawable:GLDrawable;
		public var version:int = 0;
		private var pos:Float32Array;
		private var index:Uint16Array;
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
			if(_drawable==null){
				var nump:int = 0;
				var numi:int = 0;
				var len:int = polys.length;
				for (var i:int = 0; i < len;i++ ){
					var poly:Array = polys[i];
					nump += poly.length;
					numi += (poly.length / 2 - 2) * 3;
				}
				if(pos==null||pos.length!=nump){
					pos = new Float32Array(nump);
				}
				if(index==null||index.length!=numi){
					index = new Uint16Array(numi);
				}
				var offset:int = 0;
				var pi:int = 0;
				var ii:int = 0;
				for (i = 0; i < len; i++ ){
					poly = polys[i];
					for (var j:int = 0; j < poly.length / 2; j++ ){
						var x:Number = poly[2 * j];
						var y:Number = poly[2 * j + 1];
						pos[pi++] = x;
						pos[pi++] = y;
						if (j>=2){
							index[ii++] = offset;
							index[ii++] = offset+j-1;
							index[ii++] = offset+j;
						}
					}
					offset += j;
				}
				_drawable = new GLDrawable(pos, pos, index);
			}
			return _drawable;
		}
	}

}