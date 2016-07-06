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
		public var data:Float32Array;
		public var data32PerVertex:int;
		private var buff:VertexBuffer3D;
		private var usage:Number;
		public var dirty:Boolean = true;
		//public var dirty:Boolean = true;
		public function GLVertexBufferSet(data:Float32Array,data32PerVertex:int,usage:Number) 
		{
			this.usage = usage;
			this.data32PerVertex = data32PerVertex;
			this.data = data;
		}
		
		public function getBuff(ctx:Context3D):VertexBuffer3D{
			//if (dirty){
			//var key:String = data.length + "," + data32PerVertex+name;
			//var buff:VertexBuffer3D = pool[key];
			if (buff==null){
				buff/* = pool[key]*/= ctx.createVertexBuffer(data.length / data32PerVertex, data32PerVertex);
				//dirty = false;
			}
			if(dirty){
				buff.gl.bindBuffer(buff.gl.ARRAY_BUFFER, buff.buff);
				buff.gl.bufferData(buff.gl.ARRAY_BUFFER, data, usage);
				dirty = false;
			}
			//buff.uploadFromVector(Vector.<Number>(data), 0, data.length / data32PerVertex);
			//}
			return buff;
		}
	}

}