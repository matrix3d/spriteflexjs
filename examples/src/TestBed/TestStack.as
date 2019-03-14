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
	
	//TODO_BORIS: Remove
	
	public class TestStack extends Test{
		
		public function TestStack(sp:Sprite,abouttf:TextField,input:Input){
			super(sp,abouttf,input);
			
			// Set Text field
			m_aboutText.text = "Stacked Boxes";
			
			// Add bodies
			var fd:b2FixtureDef = new b2FixtureDef();
			var sd:b2PolygonShape = new b2PolygonShape();
			var bd:b2BodyDef = new b2BodyDef();
			bd.type = b2Body.b2_dynamicBody;
			//bd.isBullet = true;
			var b:b2Body;
			fd.density = 1.0;
			fd.friction = 0.5;
			fd.restitution = 0.1;
			fd.shape = sd;
			var i:int;
			// Create 3 stacks
			for (i = 0; i < 10; i++){
				sd.SetAsBox((10) / m_physScale, (10) / m_physScale);
				//bd.position.Set((640/2+100+Math.random()*0.02 - 0.01) / m_physScale, (360-5-i*25) / m_physScale);
				bd.position.Set((640/2+100) / m_physScale, (360-5-i*25) / m_physScale);
				b = m_world.CreateBody(bd);
				b.CreateFixture(fd);
			}
			for (i = 0; i < 10; i++){
				sd.SetAsBox((10) / m_physScale, (10) / m_physScale);
				bd.position.Set((640/2-0+Math.random()*0.02 - 0.01) / m_physScale, (360-5-i*25) / m_physScale);
				b = m_world.CreateBody(bd);
				b.CreateFixture(fd);
			}
			for (i = 0; i < 10; i++){
				sd.SetAsBox((10) / m_physScale, (10) / m_physScale);
				bd.position.Set((640/2+200+Math.random()*0.02 - 0.01) / m_physScale, (360-5-i*25) / m_physScale);
				b = m_world.CreateBody(bd);
				b.CreateFixture(fd);
			}
			// Create ramp
			var vxs:Array = [new b2Vec2(0, 0),
				new b2Vec2(0, -100 / m_physScale),
				new b2Vec2(200 / m_physScale, 0)];
			sd.SetAsArray(vxs, vxs.length);
			fd.density = 0;
			bd.type = b2Body.b2_staticBody;
			bd.userData = "ramp";
			bd.position.Set(0, 360 / m_physScale);
			b = m_world.CreateBody(bd);
			b.CreateFixture(fd);
			
			// Create ball
			var cd:b2CircleShape = new b2CircleShape();
			cd.m_radius = 40/m_physScale;
			fd.density = 2;
			fd.restitution = 0.2;
			fd.friction = 0.5;
			fd.shape = cd;
			bd.type = b2Body.b2_dynamicBody;
			bd.userData = "ball";
			bd.position.Set(50/m_physScale, 100 / m_physScale);
			b = m_world.CreateBody(bd);
			b.CreateFixture(fd);
			
		}
		
		
		//======================
		// Member Data 
		//======================
	}
	
}