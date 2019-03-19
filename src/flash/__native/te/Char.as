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
		
		
		private var _color:uint;
		public var indent:int;
		public var underline:int;
		public var leading:int;
		
		public var bgr:uint;
		
		public var x0:Number;
		public var x1:Number;
		public var y0:Number;
		public var y1:Number;
		public var charVersion:int = 0;
		public var lineInfo:LineInfo;
		public function Char(v:String,size:int,font:String) 
		{
			this.font = font;
			this.size = size;
			this.v = v;
			
		}
		
		public function get color():uint 
		{
			return _color;
		}
		
		public function set color(value:uint):void 
		{
			_color = value;
			bgr =/* 0xff000000 |*/ ((_color >> 16) & 0xff) | (((_color >> 8) & 0xff) << 8) | ((_color & 0xff) << 16);
		}
		
	}

}