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
		private var usage:Number;
		public var dirty:Boolean = true;
		public var data:Uint16Array;
		public function GLIndexBufferSet(data:Uint16Array,usage:Number) 
		{
			this.usage = usage;
			this.data = data;
			
		}
		
		public function getBuff(ctx:Context3D):IndexBuffer3D{
			//if (dirty){
			//var	buff:IndexBuffer3D = pool[data.length];
			if(buff==null){
				buff = ctx.createIndexBuffer(data.length);
				buff.gl.bindBuffer(buff.gl.ELEMENT_ARRAY_BUFFER, buff.buff);
				buff.gl.bufferData(buff.gl.ELEMENT_ARRAY_BUFFER, data, usage);
				dirty = false;
			}
			if(dirty){
				buff.gl.bindBuffer(buff.gl.ELEMENT_ARRAY_BUFFER, buff.buff);
				buff.gl.bufferSubData(buff.gl.ELEMENT_ARRAY_BUFFER,0, data);
				dirty = false;
			}
			//buff.uploadFromVector(Vector.<uint>(data), 0, data.length);
			
			return buff;
		}
	}

}