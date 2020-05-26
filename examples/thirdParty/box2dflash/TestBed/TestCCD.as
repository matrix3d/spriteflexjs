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
	
	
	
	public class TestCCD extends Test{
		
		public function TestCCD(sp:Sprite,abouttf:TextField,input:Input){
			super(sp,abouttf,input);
			
			// Set Text field
			m_aboutText.text = "Continuous Collision Detection";
			
			var bd:b2BodyDef;
			var body:b2Body;
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			// These values are used for all the parts of the 'basket'
			fixtureDef.density = 4.0; 
			fixtureDef.restitution = 1.4;
			
			// Create 'basket'
			{
				bd = new b2BodyDef();
				bd.type = b2Body.b2_dynamicBody;
				bd.bullet = true;
				bd.position.Set( 150.0/m_physScale, 100.0/m_physScale );
				body = m_world.CreateBody(bd);
				var sd_bottom:b2PolygonShape = new b2PolygonShape();
				sd_bottom.SetAsBox( 45.0 / m_physScale, 4.5 / m_physScale );
				fixtureDef.shape = sd_bottom;
				body.CreateFixture( fixtureDef );
				
				var sd_left:b2PolygonShape = new b2PolygonShape();
				sd_left.SetAsOrientedBox(4.5/m_physScale, 81.0/m_physScale, new b2Vec2(-43.5/m_physScale, -70.5/m_physScale), -0.2);
				fixtureDef.shape = sd_left;
				body.CreateFixture( fixtureDef );
				
				var sd_right:b2PolygonShape = new b2PolygonShape();
				sd_right.SetAsOrientedBox(4.5/m_physScale, 81.0/m_physScale, new b2Vec2(43.5/m_physScale, -70.5/m_physScale), 0.2);
				fixtureDef.shape = sd_right;
				body.CreateFixture( fixtureDef );
			}
			
			// add some small circles for effect
			for (var i:int = 0; i < 5; i++){
				var cd:b2CircleShape = new b2CircleShape((Math.random() * 10 + 5) / m_physScale);
				fixtureDef.shape = cd;
				fixtureDef.friction = 0.3;
				fixtureDef.density = 1.0;
				fixtureDef.restitution = 1.1;
				bd = new b2BodyDef();
				bd.type = b2Body.b2_dynamicBody;
				bd.bullet = true;
				bd.position.Set( (Math.random()*300 + 250)/m_physScale, (Math.random()*320 + 20)/m_physScale );
				body = m_world.CreateBody(bd);
				body.CreateFixture(fixtureDef);
			}
			
		}
		
		
		//======================
		// Member Data 
		//======================
		
	}
	
}