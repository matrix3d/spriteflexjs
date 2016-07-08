package flash.__native 
{
	import flash.display3D.Context3D;
	import flash.display3D.VertexBuffer3D;
	/**
	 * ...
	 * @author lizhi
	 */
	public class GLVertexBufferSet 
	{
		public var data:Object;
		public var data32PerVertex:int;
		private var buff:VertexBuffer3D;
		private var usage:Number;
		public var dirty:Boolean = true;
		public function GLVertexBufferSet(data:Object,data32PerVertex:int,usage:Number) 
		{
			this.usage = usage;
			this.data32PerVertex = data32PerVertex;
			this.data = data;
		}
		
		public function getBuff(ctx:Context3D):VertexBuffer3D{
			if (buff==null){
				buff= ctx.createVertexBuffer(data.length / data32PerVertex, data32PerVertex);
				buff.gl.bindBuffer(buff.gl.ARRAY_BUFFER, buff.buff);
				buff.gl.bufferData(buff.gl.ARRAY_BUFFER, data, usage);
				dirty = false;
			}
			if (dirty){
				buff.gl.bindBuffer(buff.gl.ARRAY_BUFFER, buff.buff);
				buff.gl.bufferSubData(buff.gl.ARRAY_BUFFER, 0, data);
				dirty = false;
			}
			return buff;
		}
	}

}