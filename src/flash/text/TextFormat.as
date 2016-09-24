package flash.text
{
	
	public class TextFormat extends Object
	{
		private var _css:String;
		private var dirty:Boolean = true;
		private var _font:String;
		private var _size:Object=12;
		private var _color:Object;
		public function TextFormat(font:String = null, size:Object = null, color:Object = null, bold:Object = null, italic:Object = null, underline:Object = null, url:String = null, target:String = null, align:String = null, leftMargin:Object = null, rightMargin:Object = null, indent:Object = null, leading:Object = null)
		{
			super();
			if (font != null)
			{
				this.font = font;
			}
			if (size != null)
			{
				this.size = size;
			}
			if (color != null)
			{
				this.color = color;
			}
			if (bold != null)
			{
				this.bold = bold;
			}
			if (italic != null)
			{
				this.italic = italic;
			}
			if (underline != null)
			{
				this.underline = underline;
			}
			if (url != null)
			{
				this.url = url;
			}
			if (target != null)
			{
				this.target = target;
			}
			if (align != null)
			{
				this.align = align;
			}
			if (leftMargin != null)
			{
				this.leftMargin = leftMargin;
			}
			if (rightMargin != null)
			{
				this.rightMargin = rightMargin;
			}
			if (indent != null)
			{
				this.indent = indent;
			}
			if (leading != null)
			{
				this.leading = leading;
			}
		}
		
		public function get align():String  { return null; }
		
		public function set align(param1:String):void  {/**/ }
		
		public function get blockIndent():Object  { return null; }
		
		public function set blockIndent(param1:Object):void  {/**/ }
		
		public function get bold():Object  { return null; }
		
		public function set bold(param1:Object):void  {/**/ }
		
		public function get bullet():Object  { return null; }
		
		public function set bullet(param1:Object):void  {/**/ }
		
		public function get color():Object  { return _color; }
		
		public function set color(param1:Object):void  { _color = param1; }
		
		public function get display():String  { return null; }
		
		public function set display(param1:String):void  {/**/ }
		
		public function get font():String  { return _font; }
		
		public function set font(param1:String):void  { _font = param1; }
		
		public function get indent():Object  { return null; }
		
		public function set indent(param1:Object):void  {/**/ }
		
		public function get italic():Object  { return null; }
		
		public function set italic(param1:Object):void  {/**/ }
		
		public function get kerning():Object  { return null; }
		
		public function set kerning(param1:Object):void  {/**/ }
		
		public function get leading():Object  { return null; }
		
		public function set leading(param1:Object):void  {/**/ }
		
		public function get leftMargin():Object  { return null; }
		
		public function set leftMargin(param1:Object):void  {/**/ }
		
		public function get letterSpacing():Object  { return null; }
		
		public function set letterSpacing(param1:Object):void  {/**/ }
		
		public function get rightMargin():Object  { return null; }
		
		public function set rightMargin(param1:Object):void  {/**/ }
		
		public function get size():Object  { return _size; }
		
		public function set size(param1:Object):void  { _size = param1; }
		
		public function get tabStops():Array  { return null; }
		
		public function set tabStops(param1:Array):void  {/**/ }
		
		public function get target():String  { return null; }
		
		public function set target(param1:String):void  {/**/ }
		
		public function get underline():Object  { return null; }
		
		public function set underline(param1:Object):void  {/**/ }
		
		public function get url():String  { return null; }
		
		public function set url(param1:String):void  {/**/ }
		
		public function get css():String
		{
			_css = size+"px " +font;
			return _css;
		}
		
		public function get csscolor():String {
			return "rgb(" + (int(color) >> 16 & 0xff) + "," + (int(color) >> 8 & 0xff) + "," + (int(color) & 0xff) + ")";
		}
	}
}
