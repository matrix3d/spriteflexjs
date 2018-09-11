package flash.display3D
{
   import flash.utils.ByteArray;
   
   public class VertexBuffer3D extends Object
   {
       public var buff:WebGLBuffer;
	   public var gl:WebGLRenderingContext;
	   public var data32PerVertex:int;
      public function VertexBuffer3D()
      {
         super();
      }
      
	  /**
		 * @royaleignorecoercion Object
		 */
     public function uploadFromVector(data:Vector.<Number>, startVertex:int, numVertices:int) : void{
		 gl.bindBuffer(gl.ARRAY_BUFFER, buff);
		gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(data as Object), gl.STATIC_DRAW);
			
	 }
      
     public function uploadFromByteArray(data:ByteArray, byteArrayOffset:int, startVertex:int, numVertices:int) : void{}
      
     public function dispose() : void{
		 gl.deleteBuffer(buff);
		 buff = null;
	 }
   }
}
