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
	import Box2D.Dynamics.Controllers.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	import General.Input;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	
	
	public class TestBuoyancy extends Test{
		
		private var m_bodies:Array = new Array();
		private var m_controller:b2Controller;
		
		public function TestBuoyancy(sp:Sprite,abouttf:TextField,input:Input){
			super(sp,abouttf,input);
			var bc:b2BuoyancyController = new b2BuoyancyController();
			m_controller = bc;
			
			bc.normal.Set(0,-1);
			bc.offset = -200 / m_physScale;
			bc.density = 2.0;
			bc.linearDrag = 5;
			bc.angularDrag = 2;
			
			var ground:b2Body = m_world.GetGroundBody();
			var i:int;
			var anchor:b2Vec2 = new b2Vec2();
			var body:b2Body;
			var fd:b2FixtureDef;
			
			// Spawn in a bunch of crap
			for (i = 0; i < 5; i++){
				var bodyDef:b2BodyDef = new b2BodyDef();
				bodyDef.type = b2Body.b2_dynamicBody;
				//bodyDef.isBullet = true;
				var boxDef:b2PolygonShape = new b2PolygonShape();
				fd = new b2FixtureDef();
				fd.shape = boxDef;
				fd.density = 1.0;
				// Override the default friction.
				fd.friction = 0.3;
				fd.restitution = 0.1;
				boxDef.SetAsBox((Math.random() * 5 + 10) / m_physScale, (Math.random() * 5 + 10) / m_physScale);
				bodyDef.position.Set((Math.random() * 400 + 120) / m_physScale, (Math.random() * 150 + 50) / m_physScale);
				bodyDef.angle = Math.random() * Math.PI;
				body = m_world.CreateBody(bodyDef);
				body.CreateFixture(fd);
				m_bodies.push(body);
				
			}
			for (i = 0; i < 5; i++){
				var bodyDefC:b2BodyDef = new b2BodyDef();
				bodyDefC.type = b2Body.b2_dynamicBody;
				//bodyDefC.isBullet = true;
				var circDef:b2CircleShape= new b2CircleShape((Math.random() * 5 + 10) / m_physScale);
				fd = new b2FixtureDef();
				fd.shape = circDef;
				fd.density = 1.0;
				// Override the default friction.
				fd.friction = 0.3;
				fd.restitution = 0.1;
				bodyDefC.position.Set((Math.random() * 400 + 120) / m_physScale, (Math.random() * 150 + 50) / m_physScale);
				bodyDefC.angle = Math.random() * Math.PI;
				body = m_world.CreateBody(bodyDefC);
				body.CreateFixture(fd);
				m_bodies.push(body);
			}
			for (i = 0; i < 15; i++){
				var bodyDefP:b2BodyDef = new b2BodyDef();
				bodyDefP.type = b2Body.b2_dynamicBody;
				//bodyDefP.isBullet = true;
				var polyDef:b2PolygonShape = new b2PolygonShape();
				if (Math.random() > 0.66) {
					polyDef.SetAsArray([
						new b2Vec2((-10 -Math.random()*10) / m_physScale, ( 10 +Math.random()*10) / m_physScale),
						new b2Vec2(( -5 -Math.random()*10) / m_physScale, (-10 -Math.random()*10) / m_physScale),
						new b2Vec2((  5 +Math.random()*10) / m_physScale, (-10 -Math.random()*10) / m_physScale),
						new b2Vec2(( 10 +Math.random() * 10) / m_physScale, ( 10 +Math.random() * 10) / m_physScale)
						]);
				}
				else if (Math.random() > 0.5) 
				{
					var array:Array = [];
					array[0] = new b2Vec2(0, (10 +Math.random()*10) / m_physScale);
					array[2] = new b2Vec2((-5 -Math.random()*10) / m_physScale, (-10 -Math.random()*10) / m_physScale);
					array[3] = new b2Vec2(( 5 +Math.random()*10) / m_physScale, (-10 -Math.random()*10) / m_physScale);
					array[1] = new b2Vec2((array[0].x + array[2].x), (array[0].y + array[2].y));
					array[1].Multiply(Math.random()/2+0.8);
					array[4] = new b2Vec2((array[3].x + array[0].x), (array[3].y + array[0].y));
					array[4].Multiply(Math.random() / 2 + 0.8);
					polyDef.SetAsArray(array);
				}
				else 
				{
					polyDef.SetAsArray([
						new b2Vec2(0, (10 +Math.random()*10) / m_physScale),
						new b2Vec2((-5 -Math.random()*10) / m_physScale, (-10 -Math.random()*10) / m_physScale),
						new b2Vec2(( 5 +Math.random() * 10) / m_physScale, ( -10 -Math.random() * 10) / m_physScale)
					]);
				}
				fd = new b2FixtureDef();
				fd.shape = polyDef;
				fd.density = 1.0;
				fd.friction = 0.3;
				fd.restitution = 0.1;
				bodyDefP.position.Set((Math.random() * 400 + 120) / m_physScale, (Math.random() * 150 + 50) / m_physScale);
				bodyDefP.angle = Math.random() * Math.PI;
				body = m_world.CreateBody(bodyDefP);
				body.CreateFixture(fd);
				m_bodies.push(body);
			}
			
			//Add some exciting bath toys
			boxDef.SetAsBox(40 / m_physScale, 10 / m_physScale);
			fd = new b2FixtureDef();
			fd.shape = boxDef;
			fd.density = 3.0;
			bodyDef.position.Set(50 / m_physScale, 300 / m_physScale);
			bodyDef.angle = 0;
			body = m_world.CreateBody(bodyDef);
			body.CreateFixture(fd);
			m_bodies.push(body);
			
			bodyDef.position.Set(300/ m_physScale, 300 / m_physScale);
			body = m_world.CreateBody(bodyDef);
			circDef = new b2CircleShape(7 / m_physScale);
			fd = new b2FixtureDef();
			fd.shape = circDef;
			fd.density =2;
			circDef.m_p.Set(30 / m_physScale, 0 / m_physScale);
			body.CreateFixture(fd);
			circDef.m_p.Set(-30 / m_physScale, 0 / m_physScale);
			body.CreateFixture(fd);
			circDef.m_p.Set(0 / m_physScale, 30 / m_physScale);
			body.CreateFixture(fd);
			circDef.m_p.Set(0 / m_physScale, -30 / m_physScale);
			body.CreateFixture(fd);
			
			fd = new b2FixtureDef();
			fd.shape = boxDef;
			fd.density = 2.0;
			boxDef.SetAsBox(30 / m_physScale, 2 / m_physScale);
			body.CreateFixture(fd);
			fd.density = 2.0;
			boxDef.SetAsBox(2 / m_physScale, 30 / m_physScale);
			body.CreateFixture(fd);
			m_bodies.push(body);
			
			for each(body in m_bodies)
				m_controller.AddBody(body);
			m_world.AddController(m_controller);
			
			// Set Text field
			m_aboutText.text = "Buoyancy";
			
		}
		
		
		
		//======================
		// Member Data 
		//======================
		
		public override function Update():void{
			
			super.Update();
			//Draw water line
			m_sprite.graphics.lineStyle(1,0x0000ff,1);
			m_sprite.graphics.moveTo(5,200);
			m_sprite.graphics.lineTo(635,200);
			//It's not water without transparency...
			m_sprite.graphics.lineStyle();
			m_sprite.graphics.beginFill(0x0000ff,0.2);
			m_sprite.graphics.moveTo(5,200);
			m_sprite.graphics.lineTo(635,200);
			m_sprite.graphics.lineTo(635,355);
			m_sprite.graphics.lineTo(5,355);
			m_sprite.graphics.endFill();

		}
	}
	
}