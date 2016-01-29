package flash.display3D
{
	import flash.utils.ByteArray;
	
	public final class Program3D extends Object
	{
		public var fshader:WebGLShader;
		public var vshader:WebGLShader;
		public var program:WebGLProgram;
		public var gl:WebGLRenderingContext;
		private var uniformLocations:Object = { };
		private var attribLocations:Object = { };
		public function Program3D()
		{
			super();
		}
		
		public function upload(vcode:ByteArray, fcode:ByteArray):void
		{
			fshader = gl.createShader(WebGLRenderingContext.FRAGMENT_SHADER);
			vshader = gl.createShader(WebGLRenderingContext.VERTEX_SHADER);
			vcode.position = fcode.position = 0;
			gl.shaderSource(vshader, vcode.readUTFBytes(vcode.length));
			gl.compileShader(vshader);
			if (!gl.getShaderParameter(vshader,WebGLRenderingContext.COMPILE_STATUS)) {
				throw vcode+"\n"+(gl.getShaderInfoLog(vshader))
			}
			gl.shaderSource(fshader, fcode.readUTFBytes(fcode.length));
			gl.compileShader(fshader);
			if (!gl.getShaderParameter(fshader,WebGLRenderingContext.COMPILE_STATUS)) {
				throw fcode+"\n"+(gl.getShaderInfoLog(fshader))
			}
			gl.attachShader(program, vshader);
			gl.attachShader(program, fshader);
			gl.linkProgram(program);
			if (!gl.getProgramParameter(program,WebGLRenderingContext.LINK_STATUS)) {
				throw (gl.getProgramInfoLog(program))
			}
		}
		
		public function dispose():void
		{
			gl.deleteShader(fshader);
			gl.deleteShader(vshader);
			gl.deleteProgram(program);
		}
		
		public function getUniformLocation(name:String):WebGLUniformLocation {
			var loc:WebGLUniformLocation = uniformLocations[name];
			if (loc==null) {
				loc = uniformLocations[name] = gl.getUniformLocation(program,name);
			}
			return loc;
		}
		public function getAttribLocation(name:String):Number {
			var loc:Object = attribLocations[name];
			if (loc==null) {
				loc = attribLocations[name] = gl.getAttribLocation(program,name);
			}
			var locnum:Number = Number(loc);
			gl.enableVertexAttribArray(locnum);
			return locnum;
		}
	}
}
