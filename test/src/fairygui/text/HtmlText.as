package fairygui.text
{	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class HtmlText 
	{
		public var parsedText:String;
		public var elements:Vector.<HtmlElement>;
		
		public function HtmlText(val:String):void 
		{
			elements = new Vector.<HtmlElement>();
			try {
				val = val.replace(/\r\n/g, "\n");
				val = val.replace(/\r/g, "\n");
				var ignoreWhitespace:Boolean = XML.ignoreWhitespace;
				XML.ignoreWhitespace = false;
				var xml:XML = new XML("<dummy>"+val+"</dummy>");
				XML.ignoreWhitespace = ignoreWhitespace;
				var list:XMLList = xml.children();
				parsedText = "";
				parseXML(list);
			}
			catch(e:*) {
				parsedText = val;
				elements.length = 0;
				trace(e);
			}
		}
		
		public function appendTo(textField:TextField):void 
		{
			var pos:int = textField.text.length;
			textField.replaceText(pos, pos, parsedText);
			for(var i:int=elements.length-1;i>=0;i--) {
				var e:HtmlElement = elements[i];
				textField.setTextFormat(e.textformat, pos+e.start, pos+e.end+1);
			}
		}
		
		private function parseXML(list:XMLList):void 
		{
			var cnt:int = list.length();
			var tag:String;
			var attr:XMLList;
			var node:XML;
			var tf:TextFormat;
			var start:int;
			var element:HtmlElement;
			for(var i:int=0;i<cnt;i++) {
				node = list[i];
				tag = node.name();
				if(tag=="font") {
					tf = new TextFormat();
					attr = node.attribute("size");
					if(attr.length())
						tf.size = int(attr[0]);
					attr = node.attribute("color");
					if(attr.length())
						tf.color = parseInt(attr[0].substr(1), 16);
					attr =node.attribute("italic");
					if(attr.length())
						tf.italic = attr[0]=="true";
					attr =node.attribute("underline");
					if(attr.length())
						tf.underline = attr[0]=="true";
					attr =node.attribute("face");
					if(attr.length())
						tf.font = attr[0];
					
					start = parsedText.length;
					if(node.hasSimpleContent())
						parsedText += node.text();
					else
						parseXML(node.children());
					if(parsedText.length>start)
					{
						element = new HtmlElement();
						element.start = start;
						element.end = parsedText.length-1;
						element.textformat = tf;
						elements.push(element);
					}
				}
				else if(tag=="a") {	
					tf = new TextFormat();
					tf.underline = true;
					tf.url = "#";
					
					start = parsedText.length;
					if(node.hasSimpleContent())
						parsedText += node.text();
					else
						parseXML(node.children());
					if(parsedText.length>start)
					{
						element = new HtmlElement();
						element.type = 1;
						element.start = start;
						element.end = parsedText.length-1;
						element.textformat = tf;
						element.id = node.attribute("id").toString();
						element.href = node.attribute("href").toString();
						element.target = node.attribute("target").toString();
						elements.push(element);
					}
				}
				else if(tag=="img") {
					start = parsedText.length;
					tf = new TextFormat();
					parsedText += "　";
					
					element = new HtmlElement();
					element.type = 2;
					element.id = node.attribute("id").toString();
					element.src = node.attribute("src").toString();
					element.width = int(node.attribute("width").toString());
					element.height = int(node.attribute("height").toString());
					element.start = start;
					element.end = parsedText.length-1;
					element.textformat = tf;
					elements.push(element);
				}			
				else if(tag=="b") {
					tf = new TextFormat();
					tf.bold = true;
					start = parsedText.length;
					if(node.hasSimpleContent())
						parsedText += node.text();
					else
						parseXML(node.children());
					if(parsedText.length>start)
					{
						element = new HtmlElement();
						element.start = start;
						element.end = parsedText.length-1;
						element.textformat = tf;
						elements.push(element);
					}
				}
				else if(tag=="i") {
					tf = new TextFormat();
					tf.italic = true;
					start = parsedText.length;
					if(node.hasSimpleContent())
						parsedText += node.text();
					else
						parseXML(node.children());
					if(parsedText.length>start)
					{
						element = new HtmlElement();
						element.start = start;
						element.end = parsedText.length-1;
						element.textformat = tf;
						elements.push(element);
					}
				}
				else if(tag=="u") {
					tf = new TextFormat();
					tf.underline = true;
					start = parsedText.length;
					if(node.hasSimpleContent())
						parsedText += node.text();
					else
						parseXML(node.children());
					if(parsedText.length>start) 
					{
						element = new HtmlElement();
						element.start = start;
						element.end = parsedText.length-1;
						element.textformat = tf;
						elements.push(element);
					}
				}
				else if(tag=="br") {
					parsedText += "\n";
				}
				else if(node.nodeKind()=="text") {
					var str:String = node.toString();
					
					parsedText += str;
				}
				else {
					parseXML(node.children());
				}
			}
		}	
	}
	
}
