package 
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestJSON
	{
		
		public function TestJSON() 
		{
		}
		
		public function start():void {
			
			var json:Object = JSON.parse("{\"abcdefg\":1212121}");
			alert(json.abcdefg);
			alert(json["abcdefg"]);
			
		}
	}

}