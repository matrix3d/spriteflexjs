package
{
	import flash.geom.Matrix3D_ARRAY;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestWebgl 
	{
		
		public function start():void
		{
			//init gl
			var canvas:HTMLCanvasElement = document.createElement("canvas") as HTMLCanvasElement;
			document.body.appendChild(canvas);
			canvas.width = 400;
			canvas.height = 400;
			var gl:WebGLRenderingContext = (canvas.getContext("webgl")||canvas.getContext("experimental-webgl")) as WebGLRenderingContext;
			gl.clearColor(0, 0, 0, 1);
			gl.enable(WebGLRenderingContext.DEPTH_TEST);
			gl.depthFunc(WebGLRenderingContext.LEQUAL);
			gl.clear(WebGLRenderingContext.COLOR_BUFFER_BIT|WebGLRenderingContext.DEPTH_BUFFER_BIT);
			
			//init shader
			var vcode:String = "attribute vec3 pos;" +
				"attribute vec3 color;" +
				"varying vec3 vColor;"+
				"uniform mat4 mvp;"+
				"void main(void) {" +
					"vColor=color;"+
					"gl_Position =mvp*vec4(pos, 1.0);"+
				"}";
			var fcode:String = "precision mediump float;" +
				"varying vec3 vColor;"+
			   "void main(void) {" +
					"gl_FragColor = vec4(vColor,1);"+
				"}";
			var fshader:WebGLShader = gl.createShader(WebGLRenderingContext.FRAGMENT_SHADER);
			var vshader:WebGLShader = gl.createShader(WebGLRenderingContext.VERTEX_SHADER);
			gl.shaderSource(fshader,fcode);
			gl.compileShader(fshader);
			gl.shaderSource(vshader,vcode);
			gl.compileShader(vshader);

			var program:WebGLProgram = gl.createProgram();
			gl.attachShader(program,vshader);
			gl.attachShader(program,fshader);
			gl.linkProgram(program);
			gl.useProgram(program);
			gl.enableVertexAttribArray(0);
			gl.enableVertexAttribArray(1);
			
			//init buffer
			var buffer:WebGLBuffer = gl.createBuffer();
			gl.bindBuffer(WebGLRenderingContext.ARRAY_BUFFER, buffer);
			gl.bufferData(WebGLRenderingContext.ARRAY_BUFFER, new Float32Array(/*drawable.pos.data/**/[0, .7, 0, -.7, -.7, 0, .7, -.7, 0]), WebGLRenderingContext.STATIC_DRAW);
			gl.vertexAttribPointer(0, 3, WebGLRenderingContext.FLOAT, false, 0, 0);
			
			buffer = gl.createBuffer();
			gl.bindBuffer(WebGLRenderingContext.ARRAY_BUFFER, buffer);
			gl.bufferData(WebGLRenderingContext.ARRAY_BUFFER, new Float32Array([1,0,0,0,1,0,0,0,1]), WebGLRenderingContext.STATIC_DRAW);
			gl.vertexAttribPointer(1, 3, WebGLRenderingContext.FLOAT, false, 0, 0);
			
			var ibuffer:WebGLBuffer = gl.createBuffer();
			gl.bindBuffer(WebGLRenderingContext.ELEMENT_ARRAY_BUFFER, ibuffer);
			gl.bufferData(WebGLRenderingContext.ELEMENT_ARRAY_BUFFER, new Uint16Array([0,1,2]), WebGLRenderingContext.STATIC_DRAW);
			
			gl.clearColor(0, 0, 0, 1);
			gl.clear(WebGLRenderingContext.COLOR_BUFFER_BIT);
			//gl.drawArrays(WebGLRenderingContext.TRIANGLE_STRIP, 0, drawable.pos.data.length/3);
			gl.bindBuffer(WebGLRenderingContext.ELEMENT_ARRAY_BUFFER, ibuffer);
			
			
			//draw
			var matr:Matrix3D_ARRAY = new Matrix3D_ARRAY();
			setInterval(function():void { 
				var mvpLoction:WebGLUniformLocation = gl.getUniformLocation(program, "mvp");
				
				matr.appendRotation(1, Vector3D.Z_AXIS);
				gl.uniformMatrix4fv(mvpLoction, false,matr.rawData);
				
				gl.drawElements(WebGLRenderingContext.TRIANGLES, 3, WebGLRenderingContext.UNSIGNED_SHORT, 0);
				
			}, 1000/60);
			/*var xhr:XMLHttpRequest = new XMLHttpRequest;
			xhr.open("get", "1.txt");
			xhr.onreadystatechange=function():void{
				trace(xhr.status,xhr.statusText,xhr.readyState);
			}
			xhr.send();*/
			
		}
		
	}
	
}