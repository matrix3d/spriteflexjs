/*
* Copyright (c) 2006-2007 Erin Catto http://www.gphysics.com
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
*/

package Box2D.Collision.Shapes{




import Box2D.Common.Math.*;
import Box2D.Common.*;
import Box2D.Dynamics.*;
import Box2D.Collision.*;






/**
* A shape is used for collision detection. Shapes are created in b2Body.
* You can use shape for collision detection before they are attached to the world.
* warning you cannot reuse shapes.
*/
public class b2Shape
{
	
	/**
	 * Clone the shape
	 */
	 public function Copy():b2Shape
	{
		//var s:b2Shape = new b2Shape();
		//s.Set(this);
		//return s;
		return null; // Abstract type
	}
	
	/**
	 * Assign the properties of anther shape to this
	 */
	 public function Set(other:b2Shape):void
	{
		//Don't copy m_type?
		//m_type = other.m_type;
		m_radius = other.m_radius;
	}
	
	/**
	* Get the type of this shape. You can use this to down cast to the concrete shape.
	* @return the shape type.
	*/
	public function GetType() : int
	{
		return m_type;
	}

	/**
	* Test a point for containment in this shape. This only works for convex shapes.
	* @param xf the shape world transform.
	* @param p a point in world coordinates.
	*/
	public  function TestPoint(xf:b2Transform, p:b2Vec2) : Boolean {return false};

	/**
	 * Cast a ray against this shape.
	 * @param output the ray-cast results.
	 * @param input the ray-cast input parameters.
	 * @param transform the transform to be applied to the shape.
	 */
	public  function RayCast(output:b2RayCastOutput, input:b2RayCastInput, transform:b2Transform):Boolean
	{
		return false;
	}

	/**
	* Given a transform, compute the associated axis aligned bounding box for this shape.
	* @param aabb returns the axis aligned box.
	* @param xf the world transform of the shape.
	*/
	public  function  ComputeAABB(aabb:b2AABB, xf:b2Transform) : void {};

	/**
	* Compute the mass properties of this shape using its dimensions and density.
	* The inertia tensor is computed about the local origin, not the centroid.
	* @param massData returns the mass data for this shape.
	*/
	public  function ComputeMass(massData:b2MassData, density:Number) : void { };
	
	/**
	 * Compute the volume and centroid of this shape intersected with a half plane
	 * @param normal the surface normal
	 * @param offset the surface offset along normal
	 * @param xf the shape transform
	 * @param c returns the centroid
	 * @return the total volume less than offset along normal
	 */
	public  function ComputeSubmergedArea(
				normal:b2Vec2,
				offset:Number,
				xf:b2Transform,
				c:b2Vec2):Number { return 0; };
				
	
	
	//--------------- Internals Below -------------------
	/**
	 * @private
	 */
	public function b2Shape()
	{
		m_type = e_unknownShape;
		m_radius = b2Settings.b2_linearSlop;
	}
	
	// ~b2Shape();
	
	public var m_type:int;
	public var m_radius:Number;
	
	/**
	* The various collision shape types supported by Box2D.
	*/
	//enum b2ShapeType
	//{
		static public const e_unknownShape:int = 	-1;
		static public const e_circleShape:int = 	0;
		static public const e_polygonShape:int = 	1;
		static public const e_edgeShape:int =       2;
		static public const e_shapeTypeCount:int = 	3;
	//};
	
	/**
	 * Possible return values for TestSegment
	 */
		/** Return value for TestSegment indicating a hit. */
		static public const e_hitCollide:int = 1;
		/** Return value for TestSegment indicating a miss. */
		static public const e_missCollide:int = 0;
		/** Return value for TestSegment indicating that the segment starting point, p1, is already inside the shape. */
		static public const e_startsInsideCollide:int = -1;
};

	
}
