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
		private var dirty:Boolean = true;
		private var data:Array;
		public function GLIndexBufferSet(data:Array) 
		{
			this.data = data;
			
		}
		
		public function getBuff(ctx:Context3D):IndexBuffer3D{
			if (dirty){
				buff = ctx.createIndexBuffer(data.length);
				buff.uploadFromVector(Vector.<uint>(data), 0, data.length);
				dirty = false;
			}
			return buff;
		}
	}

}