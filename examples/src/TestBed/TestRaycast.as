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


package TestBed{
	
	
	
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	import General.Input;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	
	
	public class TestRaycast extends Test{
		
		public var laser:b2Body;
		
		public function TestRaycast(sp:Sprite,abouttf:TextField,input:Input){
			super(sp,abouttf,input);
			// Set Text field
			m_aboutText.text = "Raycast";
			
			m_world.SetGravity(new b2Vec2(0,0));
			
			var ground:b2Body = m_world.GetGroundBody();
			
			var box:b2PolygonShape = new b2PolygonShape();
			box.SetAsBox(30 / m_physScale, 4 / m_physScale);
			var fd:b2FixtureDef = new b2FixtureDef();
			fd.shape = box;
			fd.density = 4;
			fd.friction = 0.4;
			fd.restitution = 0.3;
			fd.userData="laser";
			var bd:b2BodyDef = new b2BodyDef();
			bd.type = b2Body.b2_dynamicBody;
			bd.position.Set(320 / m_physScale, 150 / m_physScale);
			bd.position.Set(40 / m_physScale, 150 / m_physScale);
			laser = m_world.CreateBody(bd);
			laser.CreateFixture(fd);
			laser.SetAngle(0.5);
			laser.SetAngle(Math.PI);
			
			var circle:b2CircleShape = new b2CircleShape(30 / m_physScale);
			fd.shape = circle;
			fd.density = 4;
			fd.friction = 0.4;
			fd.restitution = 0.3;
			fd.userData="circle";
			bd.position.Set(100 / m_physScale, 100 / m_physScale);
			var body:b2Body = m_world.CreateBody(bd);
			body.CreateFixture(fd);
		}
		
		
		//======================
		// Member Data 
		//======================
		
		public override function Update():void{
			super.Update();
			
			var p1:b2Vec2 = laser.GetWorldPoint(new b2Vec2(30.1 / m_physScale, 0));
			var p2:b2Vec2 = laser.GetWorldPoint(new b2Vec2(130.1 / m_physScale, 0));
			
			var f:b2Fixture = m_world.RayCastOne(p1, p2);
			var lambda:Number = 1;
			if (f)
			{
				var input:b2RayCastInput = new b2RayCastInput(p1, p2);
				var output:b2RayCastOutput = new b2RayCastOutput();
				f.RayCast(output, input);
				lambda = output.fraction;
			}
			m_sprite.graphics.lineStyle(1,0xff0000,1);
			m_sprite.graphics.moveTo(p1.x * m_physScale, p1.y * m_physScale);
			m_sprite.graphics.lineTo( 	(p2.x * lambda + (1 - lambda) * p1.x) * m_physScale,
										(p2.y * lambda + (1 - lambda) * p1.y) * m_physScale);

		}
	}
	
}