package Box2D.Dynamics.Joints 
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class b2JointUtil 
	{
		// enum b2JointType
	static public const e_unknownJoint:int = 0;
	static public const e_revoluteJoint:int = 1;
	static public const e_prismaticJoint:int = 2;
	static public const e_distanceJoint:int = 3;
	static public const e_pulleyJoint:int = 4;
	static public const e_mouseJoint:int = 5;
	static public const e_gearJoint:int = 6;
	static public const e_lineJoint:int = 7;
	static public const e_weldJoint:int = 8;
	static public const e_frictionJoint:int = 9;
		public function b2JointUtil() 
		{
			
		}
		//--------------- Internals Below -------------------

	static public function Create(def:b2JointDef, allocator:*):b2Joint{
		var joint:b2Joint = null;
		
		switch (def.type)
		{
		case e_distanceJoint:
			{
				//void* mem = allocator->Allocate(sizeof(b2DistanceJoint));
				joint = new b2DistanceJoint(def as b2DistanceJointDef);
			}
			break;
		
		case e_mouseJoint:
			{
				//void* mem = allocator->Allocate(sizeof(b2MouseJoint));
				joint = new b2MouseJoint(def as b2MouseJointDef);
			}
			break;
		
		case e_prismaticJoint:
			{
				//void* mem = allocator->Allocate(sizeof(b2PrismaticJoint));
				joint = new b2PrismaticJoint(def as b2PrismaticJointDef);
			}
			break;
		
		case e_revoluteJoint:
			{
				//void* mem = allocator->Allocate(sizeof(b2RevoluteJoint));
				joint = new b2RevoluteJoint(def as b2RevoluteJointDef);
			}
			break;
		
		case e_pulleyJoint:
			{
				//void* mem = allocator->Allocate(sizeof(b2PulleyJoint));
				joint = new b2PulleyJoint(def as b2PulleyJointDef);
			}
			break;
		
		case e_gearJoint:
			{
				//void* mem = allocator->Allocate(sizeof(b2GearJoint));
				joint = new b2GearJoint(def as b2GearJointDef);
			}
			break;
		
		case e_lineJoint:
			{
				//void* mem = allocator->Allocate(sizeof(b2LineJoint));
				joint = new b2LineJoint(def as b2LineJointDef);
			}
			break;
			
		case e_weldJoint:
			{
				//void* mem = allocator->Allocate(sizeof(b2WeldJoint));
				joint = new b2WeldJoint(def as b2WeldJointDef);
			}
			break;
			
		case e_frictionJoint:
			{
				//void* mem = allocator->Allocate(sizeof(b2FrictionJoint));
				joint = new b2FrictionJoint(def as b2FrictionJointDef);
			}
			break;
			
		default:
			//b2Settings.b2Assert(false);
			break;
		}
		
		return joint;
	}
		
	}

}