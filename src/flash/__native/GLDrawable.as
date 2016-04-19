package flash.__native 
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class GLDrawable 
	{
		public var pos:GLVertexBufferSet;
		public var uv:GLVertexBufferSet;
		public var index:GLIndexBufferSet;
		public function GLDrawable(posData:Float32Array,uvData:Float32Array,iData:Uint16Array) 
		{
			pos = new GLVertexBufferSet(posData, 2,"pos");
			uv = new GLVertexBufferSet(uvData, 2,"uv");
			index = new GLIndexBufferSet(iData);
		}
	}

}