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
	
	
	
	public class TestBreakable extends Test{
		
		public function TestBreakable(sp:Sprite,abouttf:TextField,input:Input){
			super(sp,abouttf,input);
			
			// Set Text field
			m_aboutText.text = "Breakable";
			
			m_world.SetContactListener(new ContactListener(this));
			
			var ground:b2Body = m_world.GetGroundBody();
			
			// Breakable Dynamic Body
			{
				var bd:b2BodyDef = new b2BodyDef();
				bd.type = b2Body.b2_dynamicBody;
				bd.position.Set(5.0, 5.0);
				bd.angle = 0.25 * Math.PI;
				m_body1 = m_world.CreateBody(bd);
				
				m_shape1.SetAsOrientedBox(0.5, 0.5, new b2Vec2( -0.5, 0.0));
				m_piece1 = m_body1.CreateFixture2(m_shape1, 1.0);
				
				m_shape2.SetAsOrientedBox(0.5, 0.5, new b2Vec2( 0.5, 0.0));
				m_piece2 = m_body1.CreateFixture2(m_shape2, 1.0);
			}
			
			m_break = false;
			m_broke = false;
		}
		
		public function Break():void
		{
			// Apply cached velocity for more realistic break
			m_body1.SetLinearVelocity(m_velocity);
			m_body1.SetAngularVelocity(m_angularVelocity);
			
			// Split body into two pieces
			m_body1.Split(function(fixture:b2Fixture):Boolean {
				return fixture != m_piece1;
			});
		}
		
		override public function Update():void 
		{
			super.Update();
			if (m_break)
			{
				Break();
				m_broke = true;
				m_break = false;
			}
			
			// Cache velocities to improve movement on breakage
			if (m_broke == false)
			{
				m_velocity = m_body1.GetLinearVelocity();
				m_angularVelocity = m_body1.GetAngularVelocity();
			}
		}
		
		//======================
		// Member Data 
		//======================
		
		public var m_body1:b2Body;
		public var m_velocity:b2Vec2 = new b2Vec2();
		public var m_angularVelocity:Number;
		public var m_shape1:b2PolygonShape = new b2PolygonShape();
		public var m_shape2:b2PolygonShape = new b2PolygonShape();;
		public var m_piece1:b2Fixture;
		public var m_piece2:b2Fixture;
		public var m_broke:Boolean;
		public var m_break:Boolean;
	}
	
}

import Box2D.Dynamics.*;
import Box2D.Collision.*;
import Box2D.Collision.Shapes.*;
import Box2D.Dynamics.Joints.*;
import Box2D.Dynamics.Contacts.*;
import Box2D.Common.*;
import Box2D.Common.Math.*;
import TestBed.TestBreakable;

class ContactListener extends b2ContactListener
{
	private var test:TestBreakable;
	public function ContactListener(test:TestBreakable)
	{
		this.test = test;
	}
	
	override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void 
	{
		if (test.m_broke)
		{
			// The body already broke
			return;
		}
		
		// Should the body break?
		var count:int = contact.GetManifold().m_pointCount;
		
		var maxImpulse:Number = 0.0;
		for (var i:int = 0; i < count; i++)
		{
			maxImpulse = b2Math.Max(maxImpulse, impulse.normalImpulses[i]);
		}
		
		if (maxImpulse > 50)
		{
			test.m_break = true;
		}
	}
}