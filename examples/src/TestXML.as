package 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestXML extends Sprite
	{
		
		public function TestXML() 
		{
			var value:String = "<a a='1' b='2'>d<a>";
			var xmllist:DOMParser = new DOMParser();
			var xmlDoc:HTMLDocument = xmllist.parseFromString(value, "text/html") as HTMLDocument;
			
			function doxml(x:Node):void{
				console.log(x.nodeName+":" + x.nodeValue+":"+x.nodeType+":"+x.nodeTypeString);
				if(x.attributes){
					for (var i:int = 0; i < x.attributes.length;i++ ){
						console.log(x.attributes.item(i).nodeName,x.attributes.item(i).nodeValue);
					}
					console.log(x.attributes.getNamedItem("a"));
				}
				for(i=0;i<x.childNodes.length;i++){
					doxml(x.childNodes[i]);
				}
			}

			doxml(xmlDoc.body);
			
			var tf:TextField = new TextField;
			addChild(tf);
		}
		
	}
	
	

}