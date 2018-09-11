package flash.display3D
{
	import flash.events.EventDispatcher;
	import flash.geom.Matrix3D;
	import flash.utils.ByteArray;
	import flash.display3D.textures.*;
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author lizhi http://matrix3d.github.io/
	 */
	public final class Context3D extends EventDispatcher
	{
		public var canvas:HTMLCanvasElement;
		public var gl:WebGLRenderingContext;
		private var currentProgram:Program3D;
		private var currentTextures:Object = { };
		private var currentVBufs:Object = { };
		public function Context3D()
		{
			super();
		}
		
		public static function get supportsVideoTexture():Boolean  { return false }
		
		public function get driverInfo():String  { return null }
		
		public function dispose(recreate:Boolean = true):void
		{
		}
		
		public function get enableErrorChecking():Boolean  { return false }
		
		public function set enableErrorChecking(toggle:Boolean):void
		{
		}
		
		public function configureBackBuffer(width:int, height:int, antiAlias:int, enableDepthAndStencil:Boolean = true, wantsBestResolution:Boolean = false):void
		{
			canvas.width = width;
			canvas.height = height;
			canvas.style.width = width + "px";
			canvas.style.height = height + "px";
			gl.viewport(0, 0, width, height);
			if (enableDepthAndStencil)
			{
				gl.enable(gl.DEPTH_TEST);
				gl.enable(gl.STENCIL_TEST);
			}
			else
			{
				gl.disable(gl.DEPTH_TEST);
				gl.disable(gl.STENCIL_TEST);
			}
		}
		
		public function clear(red:Number = 0, green:Number = 0, blue:Number = 0, alpha:Number = 1, depth:Number = 1, stencil:uint = 0, mask:uint = 4294967295):void
		{
			SpriteFlexjs.dirtyGraphics = true;
			gl.clearColor(red, green, blue, alpha);
			gl.clearDepth(depth);
			gl.clearStencil(stencil);
			gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
		}
		
		public function drawTriangles(indexBuffer:IndexBuffer3D, firstIndex:int = 0, numTriangles:int = -1):void
		{
			gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, indexBuffer.buff);
			gl.drawElements(gl.TRIANGLES, numTriangles < 0 ? indexBuffer.count : numTriangles * 3, gl.UNSIGNED_SHORT, firstIndex * 2);
		}
		
		public function present():void
		{
			SpriteFlexjs.dirtyGraphics = true;
		}
		
		public function setProgram(program:Program3D):void
		{
			if(currentProgram!=program){
				currentProgram = program;
				gl.useProgram(program.program);
			}
		}
		
		public function setProgramConstantsFromVector(programType:String, firstRegister:int, data:Vector.<Number>, numRegisters:int = -1):void
		{
			//var num:int =gl.getProgramParameter(currentProgram.program, gl.ACTIVE_UNIFORMS);
			//var count:int = 0;
			//for (var i:int = 0; i < num;i++ ) {
			//	var au:WebGLActiveInfo = gl(currentProgram.program, i);
			//}
			setProgramConstantsFromVectorGL(getUniformLocationName(programType, firstRegister), data, numRegisters);
		}
		
		public function setProgramConstantsFromMatrix(programType:String, firstRegister:int, matrix:Matrix3D, transposedMatrix:Boolean = false):void
		{
			setProgramConstantsFromMatrixGL(getUniformLocationName(programType, firstRegister), matrix, transposedMatrix);
		}
		
		public function setProgramConstantsFromByteArray(programType:String, firstRegister:int, numRegisters:int, data:ByteArray, byteArrayOffset:uint):void
		{
		}
		public function setProgramConstantsFromVectorGL(name:String, data:Vector.<Number>, numRegisters:int = -1):void
		{
			gl.uniform4fv(getUniformLocation(name), data as Object);
		}
		
		/**
		 * @royaleignorecoercion Object
		 */
		public function setProgramConstantsFromMatrixGL(name:String, matrix:Matrix3D, transposedMatrix:Boolean = false):void
		{
			if (transposedMatrix) {
				matrix.transpose();
			}
			gl.uniformMatrix4fv(getUniformLocation(name), false, matrix.rawData as Object);
			if (transposedMatrix) {
				matrix.transpose();
			}
		}
		
		public function setProgramConstantsFromByteArrayGL(name:String , numRegisters:int, data:ByteArray, byteArrayOffset:uint):void
		{
		}
		
		private function getUniformLocationName(programType:String, register:int):String
		{
			return (Context3DProgramType.VERTEX === programType) ? ("vc" + register) : ("fc" + register);
		}
		private function getUniformLocation(name:String):WebGLUniformLocation
		{
			return currentProgram.getUniformLocation(name);
		}
		
		public function setVertexBufferAt(index:int, buffer:VertexBuffer3D, bufferOffset:int = 0, format:String = "float4"):void
		{
			setVertexBufferAtGL("va" + index, buffer, bufferOffset, format);
		}
		
		public function setVertexBufferAtGL(name:String, buffer:VertexBuffer3D, bufferOffset:int = 0, format:String = "float4"):void {
			if (currentVBufs[name] != buffer) {
				currentVBufs[name] = buffer;
				var loc:Number= currentProgram.getAttribLocation(name);
				gl.bindBuffer(gl.ARRAY_BUFFER, buffer.buff);
				var type:int = gl.FLOAT;
				var size:int = 0;
				var mul:int=4;
				var normalized:Boolean = false;
				switch (format)
				{
				case Context3DVertexBufferFormat.FLOAT_1: 
					size = 1;
					break;
				case Context3DVertexBufferFormat.FLOAT_2: 
					size = 2;
					break;
				case Context3DVertexBufferFormat.FLOAT_3: 
					size = 3;
					break;
				case Context3DVertexBufferFormat.FLOAT_4: 
					size = 4;
					break;
				case Context3DVertexBufferFormat.BYTES_4: 
					size = 4;
					type = gl.UNSIGNED_BYTE;
					normalized = true;
					mul = 1;
					break;
				}
				gl.vertexAttribPointer(loc, size, type, normalized, buffer.data32PerVertex * mul, bufferOffset*mul);
			}
		}
		
		public function setBlendFactors(sourceFactor:String, destinationFactor:String):void
		{
			gl.enable(gl.BLEND);
			gl.blendEquation(gl.FUNC_ADD);
			gl.blendFunc(Context3DBlendFactor.getGLVal(gl,sourceFactor), Context3DBlendFactor.getGLVal(gl,destinationFactor));
		}
		
		public function setColorMask(red:Boolean, green:Boolean, blue:Boolean, alpha:Boolean):void
		{
			gl.colorMask(red, green, blue, alpha);
		}
		
		public function setDepthTest(depthMask:Boolean, passCompareMode:String):void
		{
			gl.depthFunc(Context3DCompareMode.getGLVal(gl,passCompareMode));
			gl.depthMask(depthMask);
		}
		
		public function setTextureAt(sampler:int, texture:TextureBase):void
		{
			if (texture == null)
			{
				this.setTextureInternal(sampler, null);
			}
			else if (texture is Texture)
			{
				this.setTextureInternal(sampler, texture as Texture);
			}
			else if (texture is CubeTexture)
			{
				this.setCubeTextureInternal(sampler, texture as CubeTexture);
			}
			else if (texture is RectangleTexture)
			{
				this.setRectangleTextureInternal(sampler, texture as RectangleTexture);
			}
			else if (texture is VideoTexture)
			{
				this.setVideoTextureInternal(sampler, texture as VideoTexture);
			}
		}
		
		public function setRenderToTexture(texture:TextureBase, enableDepthAndStencil:Boolean = false, antiAlias:int = 0, surfaceSelector:int = 0, colorOutputIndex:int = 0):void
		{
			var targetType:uint = 0;
			if (texture is Texture)
			{
				targetType = 1;
			}
			else if (texture is CubeTexture)
			{
				targetType = 2;
			}
			else if (texture is RectangleTexture)
			{
				targetType = 3;
			}
			else if (texture != null)
			{
				throw "texture argument not derived from TextureBase (can be Texture, CubeTexture, or if supported, RectangleTexture)";
			}
			this.setRenderToTextureInternal(texture, targetType, enableDepthAndStencil, antiAlias, surfaceSelector, colorOutputIndex);
		}
		
		public function setRenderToBackBuffer():void
		{
		}
		
		private function setRenderToTextureInternal(param1:TextureBase, param2:int, param3:Boolean, param4:int, param5:int, param6:int):void
		{
		}
		
		public function setCulling(triangleFaceToCull:String):void
		{
			if (triangleFaceToCull === Context3DTriangleFace.NONE)
			{
				gl.disable(gl.CULL_FACE);
			}
			else
			{
				gl.enable(gl.CULL_FACE);
				gl.cullFace(Context3DTriangleFace.getGLVal(gl,triangleFaceToCull));
			}
		}
		
		public function setStencilActions(triangleFace:String = "frontAndBack", compareMode:String = "always", actionOnBothPass:String = "keep", actionOnDepthFail:String = "keep", actionOnDepthPassStencilFail:String = "keep"):void
		{
		}
		
		public function setStencilReferenceValue(referenceValue:uint, readMask:uint = 255, writeMask:uint = 255):void
		{
		}
		
		public function setScissorRectangle(rectangle:Rectangle):void
		{
			if (rectangle == null)
			{
				gl.disable(gl.SCISSOR_TEST);
			}
			else
			{
				gl.enable(gl.SCISSOR_TEST);
				gl.scissor(rectangle.x, rectangle.y, rectangle.width, rectangle.height);
			}
		}
		
		public function createVertexBuffer(numVertices:int, data32PerVertex:int, bufferUsage:String = "staticDraw"):VertexBuffer3D
		{
			var buffer:VertexBuffer3D = new VertexBuffer3D;
			buffer.buff = gl.createBuffer();
			buffer.data32PerVertex = data32PerVertex;
			buffer.gl = gl;
			return buffer;
		}
		
		public function createIndexBuffer(numIndices:int, bufferUsage:String = "staticDraw"):IndexBuffer3D
		{
			var buffer:IndexBuffer3D = new IndexBuffer3D;
			buffer.buff = gl.createBuffer();
			buffer.gl = gl;
			buffer.count = numIndices;
			return buffer;
		}
		
		public function createTexture(width:int, height:int, format:String, optimizeForRenderToTexture:Boolean, streamingLevels:int = 0):Texture
		{
			var t:Texture = new Texture;
			t.gl = gl;
			t.texture = gl.createTexture();
			return t;
		}
		
		public function createCubeTexture(size:int, format:String, optimizeForRenderToTexture:Boolean, streamingLevels:int = 0):CubeTexture  { return null }
		
		public function createRectangleTexture(width:int, height:int, format:String, optimizeForRenderToTexture:Boolean):RectangleTexture  { return null }
		
		public function createProgram():Program3D
		{
			var p:Program3D = new Program3D;
			p.gl = gl;
			p.program = gl.createProgram();
			return p;
		}
		
		public function drawToBitmapData(destination:BitmapData):void
		{
		}
		
		public function setSamplerStateAt(sampler:int, wrap:String, filter:String, mipfilter:String):void
		{
		}
		
		public function get profile():String  { return null }
		
		private function setTextureInternal(sampler:int, texture:Texture):void
		{
			setTextureAtGL("fs" + sampler, sampler, texture);
		}
		
		public function setTextureAtGL(name:String, sampler:int, texture:Texture):void {
			if (currentTextures[name] != texture) {
				currentTextures[name] = texture;
				if (texture)
				{
					gl.activeTexture(WebGLRenderingContext["TEXTURE"+sampler]);
					gl.bindTexture(gl.TEXTURE_2D, texture.texture);
					gl.uniform1i(currentProgram.getUniformLocation(name), sampler);
				}
			}
		}
		
		private function setCubeTextureInternal(param1:int, param2:CubeTexture):void
		{
		}
		
		private function setRectangleTextureInternal(param1:int, param2:RectangleTexture):void
		{
		}
		
		private function setVideoTextureInternal(param1:int, param2:VideoTexture):void
		{
		}
		
		public function get backBufferWidth():int  { return 0 }
		
		public function get backBufferHeight():int  { return 0 }
		
		public function get maxBackBufferWidth():int  { return 0 }
		
		public function set maxBackBufferWidth(width:int):void
		{
		}
		
		public function get maxBackBufferHeight():int  { return 0 }
		
		public function set maxBackBufferHeight(height:int):void
		{
		}
		
		public function createVideoTexture():VideoTexture  { return null }
	}
}
