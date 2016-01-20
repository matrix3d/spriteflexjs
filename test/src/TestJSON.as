package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestJSON extends Sprite
	{
		
		public function TestJSON() 
		{
			var json:Object = JSON.parse("{'a':1}");
			trace(json.a);
		}
		
	}

}