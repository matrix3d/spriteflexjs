package fairygui.text
{
	import flash.text.TextFormat;

	internal class HtmlElement
	{
		public var type:int; //0-none, 1-link, 2-image
		
		public var start:int;
		public var end:int;
		public var textformat:TextFormat;
		public var id:String;
		public var width:int;
		public var height:int;
		
		//link
		public var href:String;
		public var target:String;
		
		//image
		public var src:String;
		public var realWidth:int;
		public var realHeight:int;
		
		public static const LINK:int = 1;
		public static const IMAGE:int = 2;
		
		public function HtmlElement()
		{
		}
	}
}