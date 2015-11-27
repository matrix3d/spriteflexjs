package flash.display3D
{
   import flash.utils.ByteArray;
   
   public class VertexBuffer3D extends Object
   {
       public var buff:WebGLBuffer;
	   public var gl:WebGLRenderingContext;
      public function VertexBuffer3D()
      {
         super();
      }
      
     public function uploadFromVector(data:Vector.<Number>, startVertex:int, numVertices:int) : void{
		 gl.bindBuffer(WebGLRenderingContext.ARRAY_BUFFER, buff);
		gl.bufferData(WebGLRenderingContext.ARRAY_BUFFER, new Float32Array(data), WebGLRenderingContext.STATIC_DRAW);
			
	 }
      
     public function uploadFromByteArray(data:ByteArray, byteArrayOffset:int, startVertex:int, numVertices:int) : void{}
      
     public function dispose() : void{}
   }
}
