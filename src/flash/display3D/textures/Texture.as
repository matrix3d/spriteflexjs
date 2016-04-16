package flash.display3D.textures
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	public final class Texture extends TextureBase
	{
		public var gl:WebGLRenderingContext;
		public var texture:WebGLTexture;
		public var repeat:Boolean = true;
		public function Texture()
		{
			super();
		}
		
		public function uploadFromBitmapData(bitmapData:BitmapData, maplevel:uint = 0):void
		{
			uploadFromImg(bitmapData.image,maplevel);
		}
		
		public function uploadFromImg(img:Object, maplevel:uint = 0):void
		{
			gl.bindTexture(gl.TEXTURE_2D, texture);
			gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, img);
			if (repeat){
				gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT);
				gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT);
			}else{
				gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
				gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
			}
			if(maplevel>0){
				gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
				gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST);
				gl.generateMipmap(gl.TEXTURE_2D);
			}else {
				gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
				gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
			}
			gl.bindTexture(gl.TEXTURE_2D, null);
		}
		
		public function uploadFromByteArray(param1:ByteArray, param2:uint, param3:uint = 0):void
		{
		}
		
		public function uploadCompressedTextureFromByteArray(param1:ByteArray, param2:uint, param3:Boolean = false):void
		{
		}
	}
}
