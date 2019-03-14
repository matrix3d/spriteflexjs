package Box2D.Collision.Shapes 
{
	import Box2D.Collision.b2Distance;
	import Box2D.Collision.b2DistanceInput;
	import Box2D.Collision.b2DistanceOutput;
	import Box2D.Collision.b2DistanceProxy;
	import Box2D.Collision.b2SimplexCache;
	import Box2D.Common.Math.b2Transform;
	/**
	 * ...
	 * @author lizhi
	 */
	public class b2ShapeUtil 
	{
		
		public function b2ShapeUtil() 
		{
			
		}
		
		public static function TestOverlap(shape1:b2Shape, transform1:b2Transform, shape2:b2Shape, transform2:b2Transform):Boolean
	{
		var input:b2DistanceInput = new b2DistanceInput();
		input.proxyA = new b2DistanceProxy();
		input.proxyA.Set(shape1);
		input.proxyB = new b2DistanceProxy();
		input.proxyB.Set(shape2);
		input.transformA = transform1;
		input.transformB = transform2;
		input.useRadii = true;
		var simplexCache:b2SimplexCache = new b2SimplexCache();
		simplexCache.count = 0;
		var output:b2DistanceOutput = new b2DistanceOutput();
		b2Distance.Distance(output, simplexCache, input);
		return output.distance  < 10.0 * Number.MIN_VALUE;
	}
		
	}

}