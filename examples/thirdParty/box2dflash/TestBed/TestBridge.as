﻿/*
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
	
	
	
	public class TestBridge extends Test{
		
		public function TestBridge(sp:Sprite,abouttf:TextField,input:Input){
			super(sp,abouttf,input);
			
			// Set Text field
			m_aboutText.text = "Bridge";
			
			var ground:b2Body = m_world.GetGroundBody();
			var i:int;
			var anchor:b2Vec2 = new b2Vec2();
			var body:b2Body;
			
			// Bridge
			{
				var sd:b2PolygonShape = new b2PolygonShape();
				var fixtureDef:b2FixtureDef = new b2FixtureDef();
				sd.SetAsBox(24 / m_physScale, 5 / m_physScale);
				fixtureDef.shape = sd;
				fixtureDef.density = 20.0;
				fixtureDef.friction = 0.2;
				
				var bd:b2BodyDef = new b2BodyDef();
				bd.type = b2Body.b2_dynamicBody;
				
				var jd:b2RevoluteJointDef = new b2RevoluteJointDef();
				const numPlanks:int = 10;
				jd.lowerAngle = -15 / (180/Math.PI);
				jd.upperAngle = 15 / (180/Math.PI);
				jd.enableLimit = true;
				
				var prevBody:b2Body = ground;
				for (i = 0; i < numPlanks; ++i)
				{
					bd.position.Set((100 + 22 + 44 * i) / m_physScale, 250 / m_physScale);
					body = m_world.CreateBody(bd);
					body.CreateFixture(fixtureDef);
					
					anchor.Set((100 + 44 * i) / m_physScale, 250 / m_physScale);
					jd.Initialize(prevBody, body, anchor);
					m_world.CreateJoint(jd);
					
					prevBody = body;
				}
				
				anchor.Set((100 + 44 * numPlanks) / m_physScale, 250 / m_physScale);
				jd.Initialize(prevBody, ground, anchor);
				m_world.CreateJoint(jd);
			}
			
			
			
			
			
			
			
			
			// Spawn in a bunch of crap
			for (i = 0; i < 5; i++){
				var bodyDef:b2BodyDef = new b2BodyDef();
				bodyDef.type = b2Body.b2_dynamicBody;
				var boxShape:b2PolygonShape = new b2PolygonShape();
				fixtureDef.shape = boxShape
				fixtureDef.density = 1.0;
				// Override the default friction.
				fixtureDef.friction = 0.3;
				fixtureDef.restitution = 0.1;
				boxShape.SetAsBox((Math.random() * 5 + 10) / m_physScale, (Math.random() * 5 + 10) / m_physScale);
				bodyDef.position.Set((Math.random() * 400 + 120) / m_physScale, (Math.random() * 150 + 50) / m_physScale);
				bodyDef.angle = Math.random() * Math.PI;
				body = m_world.CreateBody(bodyDef);
				body.CreateFixture(fixtureDef);
				
			}
			for (i = 0; i < 5; i++){
				var bodyDefC:b2BodyDef = new b2BodyDef();
				bodyDefC.type = b2Body.b2_dynamicBody;
				var circShape:b2CircleShape = new b2CircleShape((Math.random() * 5 + 10) / m_physScale);
				fixtureDef.shape = circShape
				fixtureDef.density = 1.0;
				// Override the default friction.
				fixtureDef.friction = 0.3;
				fixtureDef.restitution = 0.1;
				bodyDefC.position.Set((Math.random() * 400 + 120) / m_physScale, (Math.random() * 150 + 50) / m_physScale);
				bodyDefC.angle = Math.random() * Math.PI;
				body = m_world.CreateBody(bodyDefC);
				body.CreateFixture(fixtureDef);
				
			}
			var j:int;
			for (i = 0; i < 15; i++){
				var bodyDefP:b2BodyDef = new b2BodyDef();
				bodyDefP.type = b2Body.b2_dynamicBody;
				var polyShape:b2PolygonShape = new b2PolygonShape();
				var vertices:Array = new Array();
				var vertexCount:int;
				if (Math.random() > 0.66){
					vertexCount = 4;
					for ( j = 0; j < vertexCount; ++j )
					{
						vertices[j] = new b2Vec2();
					}
					vertices[0].Set((-10 -Math.random()*10) / m_physScale, ( 10 +Math.random()*10) / m_physScale);
					vertices[1].Set(( -5 -Math.random()*10) / m_physScale, (-10 -Math.random()*10) / m_physScale);
					vertices[2].Set((  5 +Math.random()*10) / m_physScale, (-10 -Math.random()*10) / m_physScale);
					vertices[3].Set(( 10 +Math.random()*10) / m_physScale, ( 10 +Math.random()*10) / m_physScale);
				}
				else if (Math.random() > 0.5){
					vertexCount = 5;
					for ( j = 0; j < vertexCount; ++j )
					{
						vertices[j] = new b2Vec2();
					}
					vertices[0].Set(0, (10 +Math.random()*10) / m_physScale);
					vertices[2].Set((-5 -Math.random()*10) / m_physScale, (-10 -Math.random()*10) / m_physScale);
					vertices[3].Set(( 5 +Math.random()*10) / m_physScale, (-10 -Math.random()*10) / m_physScale);
					vertices[1].Set((vertices[0].x + vertices[2].x), (vertices[0].y + vertices[2].y));
					vertices[1].Multiply(Math.random()/2+0.8);
					vertices[4].Set((vertices[3].x + vertices[0].x), (vertices[3].y + vertices[0].y));
					vertices[4].Multiply(Math.random()/2+0.8);
				}
				else{
					vertexCount = 3;
					for ( j = 0; j < vertexCount; ++j )
					{
						vertices[j] = new b2Vec2();
					}
					vertices[0].Set(0, (10 +Math.random()*10) / m_physScale);
					vertices[1].Set((-5 -Math.random()*10) / m_physScale, (-10 -Math.random()*10) / m_physScale);
					vertices[2].Set(( 5 +Math.random()*10) / m_physScale, (-10 -Math.random()*10) / m_physScale);
				}
				polyShape.SetAsArray( vertices, vertexCount );
				fixtureDef.shape = polyShape;
				fixtureDef.density = 1.0;
				fixtureDef.friction = 0.3;
				fixtureDef.restitution = 0.1;
				bodyDefP.position.Set((Math.random() * 400 + 120) / m_physScale, (Math.random() * 150 + 50) / m_physScale);
				bodyDefP.angle = Math.random() * Math.PI;
				body = m_world.CreateBody(bodyDefP);
				body.CreateFixture(fixtureDef);
			}
			
		}
		
		
		//======================
		// Member Data 
		//======================
	}
	
}