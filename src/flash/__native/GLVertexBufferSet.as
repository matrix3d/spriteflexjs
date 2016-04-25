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
		private var name:String;
		public var data:Float32Array;
		public var data32PerVertex:int;
		private var buff:VertexBuffer3D;
		//public var dirty:Boolean = true;
		public function GLVertexBufferSet(data:Float32Array,data32PerVertex:int,name:String) 
		{
			this.name = name;
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
			buff.gl.bindBuffer(buff.gl.ARRAY_BUFFER, buff.buff);
			buff.gl.bufferData(buff.gl.ARRAY_BUFFER, data, buff.gl.STATIC_DRAW);
			//buff.uploadFromVector(Vector.<Number>(data), 0, data.length / data32PerVertex);
			//}
			return buff;
		}
	}

}