package 
{
	import org.apache.flex.reflection.describeType;
	import org.apache.flex.utils.Proxy;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestLib 
	{
		
		public function TestLib() 
		{
			
		}
		
		public function start():void{
			trace(describeType( new Proxy));
		}
		
	}

}