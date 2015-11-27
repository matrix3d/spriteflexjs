package flash.display3D
{
   import flash.events.EventDispatcher;
   import flash.geom.Matrix3D;
   import flash.utils.ByteArray;
   import flash.display3D.textures.*;
   import flash.geom.Rectangle;
   import flash.display.BitmapData;
   
   public final class Context3D extends EventDispatcher
   {
	   private var canvas:HTMLCanvasElement;
	   private var gl:WebGLRenderingContext;
	   private var currentProgram:Program3D;
       
      public function Context3D()
      {
         super();
		 canvas = document.createElement("canvas") as HTMLCanvasElement;
		document.body.appendChild(canvas);
		gl = (canvas.getContext("webgl")||canvas.getContext("experimental-webgl")) as WebGLRenderingContext;
			
      }
      
     public static function get supportsVideoTexture() : Boolean{return false}
      
     public function get driverInfo() : String{return null}
      
     public function dispose(recreate:Boolean = true) : void{}
      
     public function get enableErrorChecking() : Boolean{return false}
      
     public function set enableErrorChecking(toggle:Boolean) : void{}
      
     public function configureBackBuffer(width:int, height:int, antiAlias:int, enableDepthAndStencil:Boolean=true, wantsBestResolution:Boolean=false) : void { 
		canvas.width = width;
		canvas.height = height;
		gl.viewport(0, 0, width, height);
		 if(enableDepthAndStencil){
			gl.enable(WebGLRenderingContext.DEPTH_TEST);
			gl.enable(WebGLRenderingContext.STENCIL_TEST);
		 }else{
			gl.disable(WebGLRenderingContext.DEPTH_TEST);
			gl.disable(WebGLRenderingContext.STENCIL_TEST);
		 }
	 }
      
     public function clear(red:Number = 0, green:Number = 0, blue:Number = 0, alpha:Number = 1, depth:Number = 1, stencil:uint = 0, mask:uint = 4294967295) : void {
		gl.clearColor(red, green, blue, alpha);
		gl.clearDepth(depth);
		gl.clearStencil(stencil);
		gl.clear(WebGLRenderingContext.COLOR_BUFFER_BIT | WebGLRenderingContext.DEPTH_BUFFER_BIT);
	 }
      
     public function drawTriangles(indexBuffer:IndexBuffer3D, firstIndex:int=0, numTriangles:int=-1) : void{
		gl.bindBuffer(WebGLRenderingContext.ELEMENT_ARRAY_BUFFER, indexBuffer.buff);
		gl.drawElements(WebGLRenderingContext.TRIANGLES, numTriangles<0?indexBuffer.count:numTriangles*3, WebGLRenderingContext.UNSIGNED_SHORT, firstIndex*2);
	 }
      
     public function present() : void{}
      
     public function setProgram(program:Program3D) : void {
		currentProgram = program; 
		 gl.useProgram(program.program);
	 }
      
     public function setProgramConstantsFromVector(programType:String, firstRegister:int, data:Vector.<Number>, numRegisters:int = -1) : void {
		//var num:int =gl.getProgramParameter(currentProgram.program, WebGLRenderingContext.ACTIVE_UNIFORMS);
		//var count:int = 0;
		//for (var i:int = 0; i < num;i++ ) {
		//	var au:WebGLActiveInfo = gl(currentProgram.program, i);
		//}
		gl.uniform4fv(getUniformLocation(programType,firstRegister), data);
	 }
      
     public function setProgramConstantsFromMatrix(programType:String, firstRegister:int, matrix:Matrix3D, transposedMatrix:Boolean=false) : void{
		gl.uniformMatrix4fv(getUniformLocation(programType,firstRegister), transposedMatrix, matrix.rawData);
	 }
	 
	 private function getUniformLocation(programType:String, register:int):WebGLUniformLocation {
		return gl.getUniformLocation(currentProgram.program, (Context3DProgramType.VERTEX==programType)?("vc" + register):("fc" + register));
	 }
      
     public function setProgramConstantsFromByteArray(programType:String, firstRegister:int, numRegisters:int, data:ByteArray, byteArrayOffset:uint) : void{}
      
     public function setVertexBufferAt(index:int, buffer:VertexBuffer3D, bufferOffset:int=0, format:String="float4") : void{
		gl.bindBuffer(WebGLRenderingContext.ARRAY_BUFFER, buffer.buff);
		var size:int = 0;
		switch(format) {
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
		}
		gl.vertexAttribPointer(index, size, WebGLRenderingContext.FLOAT, false, 0, bufferOffset);
		gl.enableVertexAttribArray(index);
	 }
      
     public function setBlendFactors(sourceFactor:int, destinationFactor:int) : void{
		 gl.enable(WebGLRenderingContext.BLEND);
		 gl.blendEquation(WebGLRenderingContext.FUNC_ADD);
		 gl.blendFunc(sourceFactor, destinationFactor);
	 }
      
     public function setColorMask(red:Boolean, green:Boolean, blue:Boolean, alpha:Boolean) : void{
		gl.colorMask(red, green, blue, alpha);
	 }
      
     public function setDepthTest(depthMask:Boolean, passCompareMode:int) : void {
		gl.depthFunc(passCompareMode);
		gl.depthMask(depthMask);
	 }
      
      public function setTextureAt(sampler:int, texture:TextureBase) : void
      {
         if(texture == null)
         {
            this.setTextureInternal(sampler,null);
         }
         else if(texture is Texture)
         {
            this.setTextureInternal(sampler,texture as Texture);
         }
         else if(texture is CubeTexture)
         {
            this.setCubeTextureInternal(sampler,texture as CubeTexture);
         }
         else if(texture is RectangleTexture)
         {
            this.setRectangleTextureInternal(sampler,texture as RectangleTexture);
         }
         else if(texture is VideoTexture)
         {
            this.setVideoTextureInternal(sampler,texture as VideoTexture);
         }
      }
      
      public function setRenderToTexture(texture:TextureBase, enableDepthAndStencil:Boolean = false, antiAlias:int = 0, surfaceSelector:int = 0, colorOutputIndex:int = 0) : void
      {
         var targetType:uint = 0;
         if(texture is Texture)
         {
            targetType = 1;
         }
         else if(texture is CubeTexture)
         {
            targetType = 2;
         }
         else if(texture is RectangleTexture)
         {
            targetType = 3;
         }
         else if(texture != null)
         {
            throw "texture argument not derived from TextureBase (can be Texture, CubeTexture, or if supported, RectangleTexture)";
         }
         this.setRenderToTextureInternal(texture,targetType,enableDepthAndStencil,antiAlias,surfaceSelector,colorOutputIndex);
      }
      
     public function setRenderToBackBuffer() : void{}
      
     private function setRenderToTextureInternal(param1:TextureBase, param2:int, param3:Boolean, param4:int, param5:int, param6:int) : void{}
      
	 public function setCulling(triangleFaceToCull:int) : void{
		 if (triangleFaceToCull==WebGLRenderingContext.NONE) {
			gl.disable(WebGLRenderingContext.CULL_FACE);
		 }else {
			gl.enable(WebGLRenderingContext.CULL_FACE);
			gl.cullFace(triangleFaceToCull);
		 }
	 }
      
     public function setStencilActions(triangleFace:String="frontAndBack", compareMode:String="always", actionOnBothPass:String="keep", actionOnDepthFail:String="keep", actionOnDepthPassStencilFail:String="keep") : void{}
      
     public function setStencilReferenceValue(referenceValue:uint, readMask:uint=255, writeMask:uint=255) : void{}
      
     public function setScissorRectangle(rectangle:Rectangle) : void{
		 if (rectangle==null) {
			 gl.disable(WebGLRenderingContext.SCISSOR_TEST);
		 }else {
			gl.enable(WebGLRenderingContext.SCISSOR_TEST);
			gl.scissor(rectangle.x, rectangle.y, rectangle.width, rectangle.height);
		 }
	 }
      
     public function createVertexBuffer(numVertices:int, data32PerVertex:int, bufferUsage:String = "staticDraw") : VertexBuffer3D {
		 var buffer:VertexBuffer3D = new VertexBuffer3D;
		 buffer.buff = gl.createBuffer();
		 buffer.gl = gl;
		 return buffer;
	}
      
     public function createIndexBuffer(numIndices:int, bufferUsage:String = "staticDraw") : IndexBuffer3D {
		 var buffer:IndexBuffer3D = new IndexBuffer3D;
		 buffer.buff = gl.createBuffer();
		 buffer.gl = gl;
		 buffer.count = numIndices;
		 return buffer;
	 }
      
     public function createTexture(width:int, height:int, format:String, optimizeForRenderToTexture:Boolean, streamingLevels:int=0) : Texture{
		 var t:Texture = new Texture;
		 t.gl = gl;
		 t.texture = gl.createTexture();
		 return t;
	 }
      
     public function createCubeTexture(size:int, format:String, optimizeForRenderToTexture:Boolean, streamingLevels:int=0) : CubeTexture{return null}
      
     public function createRectangleTexture(width:int, height:int, format:String, optimizeForRenderToTexture:Boolean) : RectangleTexture{return null}
      
     public function createProgram() : Program3D {
		 var p:Program3D = new Program3D;
		 p.gl = gl;
		 p.program = gl.createProgram();
		 return p;
	}
      
     public function drawToBitmapData(destination:BitmapData) : void{}
      
     public function setSamplerStateAt(sampler:int, wrap:String, filter:String, mipfilter:String) : void{}
      
     public function get profile() : String{return null}
      
     private function setTextureInternal(sampler:int, texture:Texture) : void{
		 if (texture) {
			gl.activeTexture(WebGLRenderingContext.TEXTURE0);
			gl.bindTexture(WebGLRenderingContext.TEXTURE_2D, texture.texture);
			gl.uniform1i(gl.getUniformLocation(currentProgram.program, "fs" + sampler),0);
		 }
	 }
      
     private function setCubeTextureInternal(param1:int, param2:CubeTexture) : void{}
      
     private function setRectangleTextureInternal(param1:int, param2:RectangleTexture) : void{}
      
     private function setVideoTextureInternal(param1:int, param2:VideoTexture) : void{}
      
     public function get backBufferWidth() : int{return 0}
      
     public function get backBufferHeight() : int{return 0}
      
     public function get maxBackBufferWidth() : int{return 0}
      
     public function set maxBackBufferWidth(width:int) : void{}
      
     public function get maxBackBufferHeight() : int{return 0}
      
     public function set maxBackBufferHeight(height:int) : void{}
      
     public function createVideoTexture() : VideoTexture{return null}
   }
}
