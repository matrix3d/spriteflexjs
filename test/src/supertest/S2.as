package supertest 
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class S2 extends S1
	{
		
		public function S2() 
		{
			
		}
		
		override public function set test(value:Object):void 
		{
			//super.test = value;
		}
		override public function get test():Object 
		{
			//return super.test;
			return null;
		}
		
		override public function testfun():void 
		{
			//super.testfun();
		}
	}

}