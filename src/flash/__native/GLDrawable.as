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
		private var _color:GLVertexBufferSet;
		public var index:GLIndexBufferSet;
		public var numTriangles:int = -1
		public function GLDrawable(posData:Float32Array,uvData:Float32Array,iData:Uint16Array) 
		{
			pos = new GLVertexBufferSet(posData, 2,"pos");
			uv = new GLVertexBufferSet(uvData, 2,"uv");
			index = new GLIndexBufferSet(iData);
		}
		
		public function get color():GLVertexBufferSet 
		{
			if (_color==null||_color.data.length/4!=pos.data.length/2){
				_color = new GLVertexBufferSet(new Float32Array(pos.data.length * 2), 4, "color");
			}
			return _color;
		}
		
		public function set color(v:GLVertexBufferSet):void{
			_color = v;
		}
	}

}