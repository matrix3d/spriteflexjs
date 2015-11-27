package flash.display3D.textures
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   
   public final class Texture extends TextureBase
   {
	   public var gl:WebGLRenderingContext;
	   public var texture:WebGLTexture;
      public function Texture()
      {
         super();
      }
      
     public function uploadFromBitmapData(bitmapData:BitmapData, maplevel:uint = 0) : void {
		 gl.bindTexture(WebGLRenderingContext.TEXTURE_2D, texture);
		 gl.pixelStorei(WebGLRenderingContext.UNPACK_FLIP_Y_WEBGL,1);
		 gl.texImage2D(WebGLRenderingContext.TEXTURE_2D, 0, WebGLRenderingContext.RGBA, WebGLRenderingContext.RGBA, WebGLRenderingContext.UNSIGNED_BYTE, bitmapData.image);
		 gl.texParameteri(WebGLRenderingContext.TEXTURE_2D, WebGLRenderingContext.TEXTURE_MAG_FILTER, WebGLRenderingContext.NEAREST);
		 gl.texParameteri(WebGLRenderingContext.TEXTURE_2D, WebGLRenderingContext.TEXTURE_MIN_FILTER, WebGLRenderingContext.NEAREST);
		 gl.bindTexture(WebGLRenderingContext.TEXTURE_2D, null);
	 }
      
     public function uploadFromByteArray(param1:ByteArray, param2:uint, param3:uint = 0) : void{}
      
     public function uploadCompressedTextureFromByteArray(param1:ByteArray, param2:uint, param3:Boolean = false) : void{}
   }
}
