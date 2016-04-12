package flash.__native 
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class GLDrawable 
	{
		public var pos:GLVertexBufferSet;
		public var index:GLIndexBufferSet;
		public function GLDrawable(posData:Array,iData:Array) 
		{
			pos = new GLVertexBufferSet(posData, 2);
			index = new GLIndexBufferSet(iData);
		}
	}

}