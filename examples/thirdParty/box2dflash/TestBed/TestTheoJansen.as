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
	import flash.display.Sprite;
	import flash.text.TextField;
	// Input
	import General.Input;
	
	
	
	public class TestTheoJansen extends Test{
		
		public function TestTheoJansen(sp:Sprite,abouttf:TextField,input:Input){
			super(sp,abouttf,input);
			
			// Set Text field
			m_aboutText.text = "Theo Jansen Walker";
			
			// scale walker by variable to easily change size
			tScale = m_physScale * 2;
			
			// Set position in world space
			m_offset.Set(120.0/m_physScale, 250/m_physScale);
			m_motorSpeed = -2.0;
			m_motorOn = true;
			var pivot:b2Vec2 = new b2Vec2(0.0, -24.0/tScale);
			
			var pd:b2PolygonShape;
			var cd:b2CircleShape;
			var fd:b2FixtureDef;
			var bd:b2BodyDef;
			var body:b2Body;
			
			for (var i:int = 0; i < 40; ++i)
			{
				cd = new b2CircleShape(7.5/tScale);
				
				bd = new b2BodyDef();
				bd.type = b2Body.b2_dynamicBody;
				// Position in world space
				bd.position.Set((Math.random() * 620 + 10)/m_physScale, 350/m_physScale);
				
				body = m_world.CreateBody(bd);
				body.CreateFixture2(cd, 1.0);
			}
			
			{
				pd = new b2PolygonShape();
				pd.SetAsBox(75 / tScale, 30 / tScale);
				fd = new b2FixtureDef();
				fd.shape = pd;
				fd.density = 1.0;
				fd.filter.groupIndex = -1;
				bd = new b2BodyDef();
				bd.type = b2Body.b2_dynamicBody;
				//bd.position = pivot + m_offset;
				bd.position = b2Math.AddVV(pivot, m_offset);
				m_chassis = m_world.CreateBody(bd);
				m_chassis.CreateFixture(fd);
			}
			
			{
				cd = new b2CircleShape(48 / tScale);
				fd = new b2FixtureDef();
				fd.shape = cd;
				fd.density = 1.0;
				fd.filter.groupIndex = -1;
				bd = new b2BodyDef();
				bd.type = b2Body.b2_dynamicBody;
				//bd.position = pivot + m_offset;
				bd.position = b2Math.AddVV(pivot, m_offset);
				m_wheel = m_world.CreateBody(bd);
				m_wheel.CreateFixture(fd);
			}
			
			{
				var jd:b2RevoluteJointDef = new b2RevoluteJointDef();
				var po:b2Vec2 = pivot.Copy();
				po.Add(m_offset);
				jd.Initialize(m_wheel, m_chassis, po);
				jd.collideConnected = false;
				jd.motorSpeed = m_motorSpeed;
				jd.maxMotorTorque = 400.0;
				jd.enableMotor = m_motorOn;
				m_motorJoint = m_world.CreateJoint(jd) as b2RevoluteJoint;
			}
			
			var wheelAnchor:b2Vec2;
			
			//wheelAnchor = pivot + b2Vec2(0.0f, -0.8);
			wheelAnchor = new b2Vec2(0.0, 24.0/tScale);
			wheelAnchor.Add(pivot);
			
			CreateLeg(-1.0, wheelAnchor);
			CreateLeg(1.0, wheelAnchor);
			
			m_wheel.SetPositionAndAngle(m_wheel.GetPosition(), 120.0 * Math.PI / 180.0);
			CreateLeg(-1.0, wheelAnchor);
			CreateLeg(1.0, wheelAnchor);
			
			m_wheel.SetPositionAndAngle(m_wheel.GetPosition(), -120.0 * Math.PI / 180.0);
			CreateLeg(-1.0, wheelAnchor);
			CreateLeg(1.0, wheelAnchor);
			
		}
		
		
		
		private function CreateLeg(s:Number, wheelAnchor:b2Vec2):void{
			
			var p1:b2Vec2 = new b2Vec2(162 * s/tScale, 183/tScale);
			var p2:b2Vec2 = new b2Vec2(216 * s/tScale, 36 /tScale);
			var p3:b2Vec2 = new b2Vec2(129 * s/tScale, 57 /tScale);
			var p4:b2Vec2 = new b2Vec2( 93 * s/tScale, -24  /tScale);
			var p5:b2Vec2 = new b2Vec2(180 * s/tScale, -45  /tScale);
			var p6:b2Vec2 = new b2Vec2( 75 * s/tScale, -111 /tScale);
			
			//b2PolygonDef sd1, sd2;
			var sd1:b2PolygonShape = new b2PolygonShape();
			var sd2:b2PolygonShape = new b2PolygonShape();
			var fd1:b2FixtureDef = new b2FixtureDef();
			var fd2:b2FixtureDef = new b2FixtureDef();
			fd1.shape = sd1;
			fd2.shape = sd2;
			fd1.filter.groupIndex = -1;
			fd2.filter.groupIndex = -1;
			fd1.density = 1.0;
			fd2.density = 1.0;
			
			if (s > 0.0)
			{
				sd1.SetAsArray([p3, p2, p1]);
				sd2.SetAsArray([
					b2Math.SubtractVV(p6, p4),
					b2Math.SubtractVV(p5, p4),
					new b2Vec2()
					]);
			}
			else
			{
				sd1.SetAsArray([p2, p3, p1]);
				sd2.SetAsArray([
					b2Math.SubtractVV(p5, p4),
					b2Math.SubtractVV(p6, p4),
					new b2Vec2()
					]);
			}
			
			//b2BodyDef bd1, bd2;
			var bd1:b2BodyDef = new b2BodyDef();
			bd1.type = b2Body.b2_dynamicBody;
			var bd2:b2BodyDef = new b2BodyDef();
			bd2.type = b2Body.b2_dynamicBody;
			bd1.position.SetV(m_offset);
			bd2.position = b2Math.AddVV(p4, m_offset);
			
			bd1.angularDamping = 10.0;
			bd2.angularDamping = 10.0;
			
			var body1:b2Body = m_world.CreateBody(bd1);
			var body2:b2Body = m_world.CreateBody(bd2);
			
			body1.CreateFixture(fd1);
			body2.CreateFixture(fd2);
			
			var djd:b2DistanceJointDef = new b2DistanceJointDef();
			
			// Using a soft distance constraint can reduce some jitter.
			// It also makes the structure seem a bit more fluid by
			// acting like a suspension system.
			djd.dampingRatio = 0.5;
			djd.frequencyHz = 10.0;
			
			djd.Initialize(body1, body2, b2Math.AddVV(p2, m_offset), b2Math.AddVV(p5, m_offset));
			m_world.CreateJoint(djd);
			
			djd.Initialize(body1, body2, b2Math.AddVV(p3, m_offset), b2Math.AddVV(p4, m_offset));
			m_world.CreateJoint(djd);
			
			djd.Initialize(body1, m_wheel, b2Math.AddVV(p3, m_offset), b2Math.AddVV(wheelAnchor, m_offset));
			m_world.CreateJoint(djd);
			
			djd.Initialize(body2, m_wheel, b2Math.AddVV(p6, m_offset), b2Math.AddVV(wheelAnchor, m_offset));
			m_world.CreateJoint(djd);
			
			var rjd:b2RevoluteJointDef = new b2RevoluteJointDef();
			
			rjd.Initialize(body2, m_chassis, b2Math.AddVV(p4, m_offset));
			m_world.CreateJoint(rjd);
			
		}
		
		
		
		public override function Update():void{
			
			//case 'a':
			if (input.isKeyPressed(65)){ // A
				m_chassis.SetAwake(true);
				m_motorJoint.SetMotorSpeed(-m_motorSpeed);
			}
			//case 's':
			if (input.isKeyPressed(83)){ // S
				m_chassis.SetAwake(true);
				m_motorJoint.SetMotorSpeed(0.0);
			}
			//case 'd':
			if (input.isKeyPressed(68)){ // D
				m_chassis.SetAwake(true);
				m_motorJoint.SetMotorSpeed(m_motorSpeed);
			}
			//case 'm':
			if (input.isKeyPressed(77)){ // M
				m_chassis.SetAwake(true);
				m_motorJoint.EnableMotor(!m_motorJoint.IsMotorEnabled());
			}
			
			// Finally update super class
			super.Update();
		}
		
		
		//======================
		// Member Data 
		//======================
		private var tScale:Number;
		
		private var m_offset:b2Vec2 = new b2Vec2();
		private var m_chassis:b2Body;
		private var m_wheel:b2Body;
		private var m_motorJoint:b2RevoluteJoint;
		private var m_motorOn:Boolean = true;
		private var m_motorSpeed:Number;
		
	}
	
}