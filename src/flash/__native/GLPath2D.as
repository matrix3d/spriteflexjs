package flash.__native 
{
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author lizhi http://matrix3d.github.io/
	 */
	public class GLPath2D 
	{
		public var matr:Matrix = new Matrix;
		public var _drawable:GLDrawable;
		private var pos:Float32Array;
		private var index:Uint16Array;
		public var path:GLGraphicsPath;
		public function GLPath2D() 
		{
			
		}
		
		public function get drawable():GLDrawable{
			if (path.gpuPath2DDirty){
				path.gpuPath2DDirty = false;
				
				var polys:MemArray = path.polys;
				
				var nump:int = 0;
				var numi:int = 0;
				var len:int = path.polys.length;
				for (var i:int = 0; i < len;i++ ){
					var plen:int = path.polys.array[i].length;
					nump += plen;
					if(plen>=6){
						numi += (plen / 2 - 2) * 3;
					}
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
					var poly:MemArray = polys.array[i];
					plen = poly.length;
					var plendiv2:int = plen / 2;
					for (var j:int = 0; j < plendiv2; j++ ){
						var x:Number = poly.array[2 * j];
						var y:Number = poly.array[2 * j + 1];
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
				if(_drawable==null){
					_drawable = new GLDrawable(pos, pos, index);
				}else{
					_drawable.pos.data = pos;
					_drawable.uv.data = pos;
					_drawable.index.data = index;
					_drawable.pos.dirty = true;
					_drawable.uv.dirty = true;
					_drawable.index.dirty = true;
				}
			}
			return _drawable;
		}
	}

}