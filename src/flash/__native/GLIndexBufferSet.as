package flash.__native 
{
	import flash.display3D.Context3D;
	import flash.display3D.IndexBuffer3D;
	/**
	 * ...
	 * @author lizhi
	 */
	public class GLIndexBufferSet 
	{
		private var buff:IndexBuffer3D
		public var dirty:Boolean = true;
		public var data:Uint16Array;
		public function GLIndexBufferSet(data:Uint16Array) 
		{
			this.data = data;
			
		}
		
		public function getBuff(ctx:Context3D):IndexBuffer3D{
			//if (dirty){
			//var	buff:IndexBuffer3D = pool[data.length];
			if(buff==null){
				buff = ctx.createIndexBuffer(data.length);
				//dirty = false;
			}
			if(dirty){
				buff.gl.bindBuffer(buff.gl.ELEMENT_ARRAY_BUFFER, buff.buff);
				buff.gl.bufferData(buff.gl.ELEMENT_ARRAY_BUFFER, data, buff.gl.STATIC_DRAW);
				dirty = false;
			}
			//buff.uploadFromVector(Vector.<uint>(data), 0, data.length);
			
			return buff;
		}
	}

}