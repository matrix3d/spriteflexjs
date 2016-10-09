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
		private var uv:Float32Array;
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
				var len:int = path.polys.length as Number;
				for (var i:int = 0; i < len;i++ ){
					var plen:int = path.polys.array[i].length as Number;
					nump += plen;
					if(plen>=6){
						numi += (plen / 2 - 2) * 3;
					}
				}
				var tlen:int = path.tris.length;
				var diffuv:Boolean = false;
				for (i = 0; i < tlen;i++ ){
					var tri:Array = path.tris[i];
					nump += tri[0].length as Number;
					numi += tri[1].length as Number;
					if (tri[2]){
						diffuv = true;
					}
				}
				if(pos==null||pos.length!=nump){
					pos = new Float32Array(nump);
				}
				if(index==null||index.length!=numi){
					index = new Uint16Array(numi);
				}
				if(diffuv&&(uv==null||uv.length!=nump)){
					uv = new Float32Array(nump);
				}
				var offset:int = 0;
				var pi:int = 0;
				var ii:int = 0;
				for (i = 0; i < len; i++ ){
					var poly:MemArray = polys.array[i];
					plen = poly.length;
					var plendiv2:int = plen / 2;
					for (var j:int = 0; j < plendiv2; j++ ){
						var x:Number = poly.array[2 * j] as Number;
						var y:Number = poly.array[2 * j + 1] as Number;
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
				
				for (i = 0; i < tlen;i++ ){
					tri = path.tris[i];
					var vsdata:Vector.<Number> = tri[0];
					var idata:Vector.<int> = tri[1];
					var uvdata:Vector.<Number> = tri[2];
					var len2:int = vsdata.length as Number;
					for (j = 0; j < len2;j++ ){
						pos[pi] = vsdata[j];
						if(uvdata)
						uv[pi] = uvdata[j];
						pi++;
					}
					len2 = idata.length as Number;
					for (j = 0; j < len2;j++ ){
						index[ii++] = offset + idata[j];
					}
					offset += vsdata.length / 2;
				}
				if(_drawable==null){
					_drawable = new GLDrawable(pos, pos, index,WebGLRenderingContext.STATIC_DRAW);
				}else{
					_drawable.pos.data = pos;
					_drawable.uv.data = diffuv?uv:pos;
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