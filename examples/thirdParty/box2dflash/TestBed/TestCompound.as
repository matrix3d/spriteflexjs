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
	
	public class TestCompound extends Test{
		
		public function TestCompound(sp:Sprite,abouttf:TextField,input:Input){
			super(sp,abouttf,input);
			
			// Set Text field
			m_aboutText.text = "Compound Shapes";
			
			var bd:b2BodyDef;
			var body:b2Body;
			var i:int;
			var x:Number;
			
			{
				var cd1:b2CircleShape = new b2CircleShape();
				cd1.SetRadius(15.0/m_physScale);
				cd1.SetLocalPosition(new b2Vec2( -15.0 / m_physScale, 15.0 / m_physScale));
				
				var cd2:b2CircleShape = new b2CircleShape();
				cd2.SetRadius(15.0/m_physScale);
				cd2.SetLocalPosition(new b2Vec2(15.0 / m_physScale, 15.0 / m_physScale));
				
				bd = new b2BodyDef();
				bd.type = b2Body.b2_dynamicBody;
				
				for (i = 0; i < 5; ++i)
				{
					x = 320.0 + b2Math.RandomRange(-3.0, 3.0);
					bd.position.Set((x + 150.0)/m_physScale, (31.5 + 75.0 * -i + 300.0)/m_physScale);
					bd.angle = b2Math.RandomRange(-Math.PI, Math.PI);
					body = m_world.CreateBody(bd);
					body.CreateFixture2(cd1, 2.0);
					body.CreateFixture2(cd2, 0.0);
				}
			}
			
			{
				var pd1:b2PolygonShape = new b2PolygonShape();
				pd1.SetAsBox(7.5/m_physScale, 15.0/m_physScale);
				
				var pd2:b2PolygonShape = new b2PolygonShape();
				pd2.SetAsOrientedBox(7.5/m_physScale, 15.0/m_physScale, new b2Vec2(0.0, -15.0/m_physScale), 0.5 * Math.PI);
				
				bd = new b2BodyDef();
				bd.type = b2Body.b2_dynamicBody;
				
				for (i = 0; i < 5; ++i)
				{
					x = 320.0 + b2Math.RandomRange(-3.0, 3.0);
					bd.position.Set((x - 150.0)/m_physScale, (31.5 + 75.0 * -i + 300)/m_physScale);
					bd.angle = b2Math.RandomRange(-Math.PI, Math.PI);
					body = m_world.CreateBody(bd);
					body.CreateFixture2(pd1, 2.0);
					body.CreateFixture2(pd2, 2.0);
				}
			}
			
			{
				var xf1:b2Transform = new b2Transform();
				xf1.R.Set(0.3524 * Math.PI);
				xf1.position = b2Math.MulMV(xf1.R, new b2Vec2(1.0, 0.0));
				
				var sd1:b2PolygonShape = new b2PolygonShape();
				sd1.SetAsArray([
					b2Math.MulX(xf1, new b2Vec2(-30.0/m_physScale, 0.0)),
					b2Math.MulX(xf1, new b2Vec2(30.0/m_physScale, 0.0)),
					b2Math.MulX(xf1, new b2Vec2(0.0, 15.0 / m_physScale)),
					]);
				
				var xf2:b2Transform = new b2Transform();
				xf2.R.Set(-0.3524 * Math.PI);
				xf2.position = b2Math.MulMV(xf2.R, new b2Vec2(-30.0/m_physScale, 0.0));
				
				var sd2:b2PolygonShape = new b2PolygonShape();
				sd2.SetAsArray([
					b2Math.MulX(xf2, new b2Vec2(-30.0/m_physScale, 0.0)),
					b2Math.MulX(xf2, new b2Vec2(30.0/m_physScale, 0.0)),
					b2Math.MulX(xf2, new b2Vec2(0.0, 15.0 / m_physScale)),
					]);
				
				bd = new b2BodyDef();
				bd.type = b2Body.b2_dynamicBody;
				bd.fixedRotation = true;
				
				for (i = 0; i < 5; ++i)
				{
					x = 320.0 + b2Math.RandomRange(-3.0, 3.0);
					bd.position.Set(x/m_physScale, (-61.5 + 55.0 * -i + 300)/m_physScale);
					bd.angle = 0.0;
					body = m_world.CreateBody(bd);
					body.CreateFixture2(sd1, 2.0);
					body.CreateFixture2(sd2, 2.0);
				}
			}
			
			{
				var sd_bottom:b2PolygonShape = new b2PolygonShape();
				sd_bottom.SetAsBox( 45.0/m_physScale, 4.5/m_physScale );
				
				var sd_left:b2PolygonShape = new b2PolygonShape();
				sd_left.SetAsOrientedBox(4.5/m_physScale, 81.0/m_physScale, new b2Vec2(-43.5/m_physScale, -70.5/m_physScale), -0.2);
				
				var sd_right:b2PolygonShape = new b2PolygonShape();
				sd_right.SetAsOrientedBox(4.5/m_physScale, 81.0/m_physScale, new b2Vec2(43.5/m_physScale, -70.5/m_physScale), 0.2);
				
				bd = new b2BodyDef();
				bd.type = b2Body.b2_dynamicBody;
				bd.position.Set( 320.0/m_physScale, 300.0/m_physScale );
				body = m_world.CreateBody(bd);
				body.CreateFixture2(sd_bottom, 4.0);
				body.CreateFixture2(sd_left, 4.0);
				body.CreateFixture2(sd_right, 4.0);
			}
			
		}
		
		
		//======================
		// Member Data 
		//======================
	}
	
}