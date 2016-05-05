package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestXML extends Sprite
	{
		
		public function TestXML() 
		{
			var xml:XML = <a><b c="d"></b></a>;
			trace((xml.b.@c).toString());
		}
		
	}

}