package flash.__native 
{
	import flash.__native.util.Earcut;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import flash.display3D.Context3D;
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
		private var color:Uint32Array;
		private var index:Uint16Array;
		private var ctx:Context3D;
		public var path:GLGraphicsPath;
		public function GLPath2D(ctx:Context3D) 
		{
			this.ctx = ctx;
			
		}
		
		/**
		 * @royaleignorecoercion uint
		 */
		public function getDrawable(gl:GLCanvasRenderingContext2D):GLDrawable{
			if (path.gpuPath2DDirty){
				path.gpuPath2DDirty = false;
				
				var isDrawline:Boolean = gl.strokeStyle != null;
				
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
					var isClosePath:Boolean = path.closePathIndex[i];
					//isClosePath = false;
					var pathplen:int = plen / 2;
					//line
					if (isDrawline&&pathplen>=2){
						if (isClosePath){
							nump += pathplen * 8;
							numi += pathplen * 6;
						}else{
							nump += (pathplen-1) * 8;
							numi += (pathplen-1) * 6;
						}
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
				if(color==null||color.length!=nump/2){
					color = new Uint32Array(nump/2);
				}
				var colorv:Object = gl.fillStyle;
				var offset:int = 0;
				var pi:int = 0;
				var ii:int = 0;
				for (i = 0; i < len; i++ ){
					var poly:MemArray = polys.array[i];
					if (SpriteFlexjs.useEarcut){// todo : earcut
						var ear:Earcut = new Earcut;
						var ins:Array = ear.earcut(poly);
					}else{
						plen = poly.length;
						var plendiv2:int = plen / 2;
						for (var j:int = 0; j < plendiv2; j++ ){
							var x:Number = poly.array[2 * j] as Number;
							var y:Number = poly.array[2 * j + 1] as Number;
							color[pi/2] = colorv;
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
						if (j%2==0){
							color[pi / 2] = colorv;
						}
						pi++;
					}
					len2 = idata.length as Number;
					for (j = 0; j < len2;j++ ){
						index[ii++] = offset + idata[j];
					}
					offset += vsdata.length / 2;
				}
				
				if (isDrawline){
					var hw:Number = gl.lineWidth / 2;
					if (hw<=0){
						hw = .5;
					}
					// todo : 1pixel width line no need JointStyle
					var lcolorv = gl.strokeStyle;
					for (i = 0; i < len; i++ ){
						var poly:MemArray = polys.array[i];
						var isClosePath:Boolean = path.closePathIndex[i];
						//isClosePath = false;
						plen = poly.length;
						var plendiv2:int = plen / 2;
						if(plendiv2>=2){
							for (var j:int = 0; j < plendiv2; j++ ){
								if (j != 0 || isClosePath){
									var x0:Number = poly.array[2 * j] as Number;
									var y0:Number = poly.array[2 * j + 1] as Number;
									if (j==0){
										var x1:Number = poly.array[plen - 2];
										var y1:Number = poly.array[plen - 1];
									}else{
										x1 = poly.array[2 * j - 2];
										y1 = poly.array[2 * j - 1];
									}
									
									/////////////////////
									var dy:Number = x1 - x0;
									var dx:Number = y1 - y0;
									var distance:Number = Math.sqrt(dx * dx + dy * dy);
									dx *= hw/distance;
									dy *= -hw/distance;
									
									/////////////////////
									
									color[pi/2] = lcolorv;
									pos[pi++] = x0+dx;
									pos[pi++] = y0+dy;
									color[pi/2] = lcolorv;
									pos[pi++] = x0-dx;
									pos[pi++] = y0 - dy;
									color[pi/2] = lcolorv;
									pos[pi++] = x1+dx;
									pos[pi++] = y1+dy;
									color[pi/2] = lcolorv;
									pos[pi++] = x1-dx;
									pos[pi++] = y1 - dy;
									
									var a:int = offset;
									var b:int = offset + 1;
									//if (j==0){
									//	var c:int = offset + plen - 2;
									//	var d:int = offset + plen - 1;
									//}else{
										var c:int = offset + 2;
										var d:int = offset+ 3;
									//}
									
									
									index[ii++] = a;
									index[ii++] = b;
									index[ii++] = c;
									index[ii++] = b;
									index[ii++] = d;
									index[ii++] = c;
									offset += 4;
								}
							}
							//offset += j * 8;
						}
					}
					
					
					/*color[pi / 2] = 0xffffffff;
					pos[pi++] = x;
					pos[pi++] = y;
					color[pi / 2] = 0xffffffff;
					pos[pi++] = x+20;
					pos[pi++] = y;
					color[pi / 2] = 0xffffffff;
					pos[pi++] = x;
					pos[pi++] = y + 20;
					index[ii++] = offset++;
					index[ii++] = offset++;
					index[ii++] = offset++;*/
					
				}
				
				if(_drawable==null){
					_drawable = new GLDrawable(pos, pos, index, ctx.gl.STATIC_DRAW);
				}else{
					_drawable.pos.data = pos;
					_drawable.uv.data = diffuv?uv:pos;
					_drawable.index.data = index;
					_drawable.pos.dirty = true;
					_drawable.uv.dirty = true;
					_drawable.index.dirty = true;
				}
				_drawable.color.data = color;
				_drawable.color.dirty = true;
			}
			return _drawable;
		}
	}

}