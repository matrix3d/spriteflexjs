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
		private var data:Array;
		private var data32PerVertex:int;
		private var buff:VertexBuffer3D;
		public var dirty:Boolean = true;
		public function GLVertexBufferSet(data:Array,data32PerVertex:int) 
		{
			this.data32PerVertex = data32PerVertex;
			this.data = data;
		}
		
		public function getBuff(ctx:Context3D):VertexBuffer3D{
			if (dirty){
				buff = ctx.createVertexBuffer(data.length/data32PerVertex,data32PerVertex);
				buff.uploadFromVector(Vector.<Number>(data), 0, data.length / data32PerVertex);
				dirty = false;
			}
			return buff;
		}
	}

}