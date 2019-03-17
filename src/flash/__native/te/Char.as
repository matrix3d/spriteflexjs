package flash.__native.te 
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class Char 
	{
		public var size:int;
		public var font:String;
		public var v:String;
		public var texture:UVTexture;
		public function Char(v:String,size:int,font:String) 
		{
			this.font = font;
			this.size = size;
			this.v = v;
			
		}
		
	}

}