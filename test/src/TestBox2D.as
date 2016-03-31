package 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestBox2D extends Sprite
	{
		
		public function TestBox2D() 
		{
			new b2World(new b2Vec2,true);
		}
		
	}

}