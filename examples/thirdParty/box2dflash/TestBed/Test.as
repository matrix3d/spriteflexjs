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
	import Main;
	import General.FpsCounter;
	import General.Input;
	import flash.text.TextField;
	
	import flash.utils.getTimer
	import flash.display.*;
	
	
	
	public class Test {
		public var m_aboutText:TextField;
		public var input:Input;
		public function Test(sp:Sprite,abouttf:TextField,input:Input){
			this.input = input;
			m_aboutText = abouttf;
			
			m_sprite = sp;//TestBedMain.m_sprite;
			
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(-1000.0, -1000.0);
			worldAABB.upperBound.Set(1000.0, 1000.0);
			
			// Define the gravity vector
			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
			
			// Allow bodies to sleep
			var doSleep:Boolean = true;
			
			// Construct a world object
			m_world = new b2World(gravity, doSleep);
			//m_world.SetBroadPhase(new b2BroadPhase(worldAABB));
			m_world.SetWarmStarting(true);
			// set debug draw
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			//var dbgSprite:Sprite = new Sprite();
			//m_sprite.addChild(dbgSprite);
			dbgDraw.SetSprite(m_sprite);
			dbgDraw.SetDrawScale(30.0);
			dbgDraw.SetFillAlpha(0.3);
			dbgDraw.SetLineThickness(1.0);
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			m_world.SetDebugDraw(dbgDraw);
			
			// Create border of boxes
			var wall:b2PolygonShape= new b2PolygonShape();
			var wallBd:b2BodyDef = new b2BodyDef();
			var wallB:b2Body;
			
			// Left
			wallBd.position.Set( -95 / m_physScale, 360 / m_physScale / 2);
			wall.SetAsBox(100/m_physScale, 400/m_physScale/2);
			wallB = m_world.CreateBody(wallBd);
			wallB.CreateFixture2(wall);
			// Right
			wallBd.position.Set((640 + 95) / m_physScale, 360 / m_physScale / 2);
			wallB = m_world.CreateBody(wallBd);
			wallB.CreateFixture2(wall);
			// Top
			wallBd.position.Set(640 / m_physScale / 2, -95 / m_physScale);
			wall.SetAsBox(680/m_physScale/2, 100/m_physScale);
			wallB = m_world.CreateBody(wallBd);
			wallB.CreateFixture2(wall);
			// Bottom
			wallBd.position.Set(640 / m_physScale / 2, (360 + 95) / m_physScale);
			wallB = m_world.CreateBody(wallBd);
			wallB.CreateFixture2(wall);
		}
		
		
		public function Update():void {
			// Update mouse joint
			UpdateMouseWorld()
			MouseDestroy();
			MouseDrag();
			
			// Update physics
			var physStart:uint = getTimer();
			m_world.Step(m_timeStep, m_velocityIterations, m_positionIterations);
			m_world.ClearForces();
			
			//fpsCounter.updatePhys(physStart);
			
			// Render
			m_world.DrawDebugData();
			// joints
			/*for (var jj:b2Joint = m_world.m_jointList; jj; jj = jj.m_next){
				//DrawJoint(jj);
			}
			// bodies
			for (var bb:b2Body = m_world.m_bodyList; bb; bb = bb.m_next){
				for (var s:b2Shape = bb.GetShapeList(); s != null; s = s.GetNext()){
					//DrawShape(s);
				}
			}*/
			
			//DrawPairs();
			//DrawBounds();
			
		}
		
		
		//======================
		// Member Data 
		//======================
		public var m_world:b2World;
		public var m_bomb:b2Body;
		public var m_mouseJoint:b2MouseJoint;
		public var m_velocityIterations:int = 10;
		public var m_positionIterations:int = 10;
		public var m_timeStep:Number = 1.0/30.0;
		public var m_physScale:Number = 30;
		// world mouse position
		static public var mouseXWorldPhys:Number;
		static public var mouseYWorldPhys:Number;
		static public var mouseXWorld:Number;
		static public var mouseYWorld:Number;
		// Sprite to draw in to
		public var m_sprite:Sprite;
		
		
		
		//======================
		// Update mouseWorld
		//======================
		public function UpdateMouseWorld():void{
			mouseXWorldPhys = (input.mouseX)/m_physScale; 
			mouseYWorldPhys = (input.mouseY)/m_physScale; 
			
			mouseXWorld = (input.mouseX); 
			mouseYWorld = (input.mouseY); 
		}
		
		
		
		//======================
		// Mouse Drag 
		//======================
		public function MouseDrag():void{
			// mouse press
			if (input.mouseDown && !m_mouseJoint){
				
				var body:b2Body = GetBodyAtMouse();
				//alert("mousedown"+body+input.mouseX+","+input.mouseY+","+mouseXWorldPhys+","+mouseYWorldPhys);
				trace("getbody",input.mouseX,input.mouseY,mouseXWorldPhys,mouseYWorldPhys, body);
				if (body)
				{
					var md:b2MouseJointDef = new b2MouseJointDef();
					md.bodyA = m_world.GetGroundBody();
					md.bodyB = body;
					md.target.Set(mouseXWorldPhys, mouseYWorldPhys);
					md.collideConnected = true;
					md.maxForce = 300.0 * body.GetMass();
					m_mouseJoint = m_world.CreateJoint(md) as b2MouseJoint;
					body.SetAwake(true);
				}
			}
			
			
			// mouse release
			if (!input.mouseDown){
				if (m_mouseJoint)
				{
					m_world.DestroyJoint(m_mouseJoint);
					m_mouseJoint = null;
				}
			}
			// mouse move
			if (m_mouseJoint)
			{
				var p2:b2Vec2 = new b2Vec2(mouseXWorldPhys, mouseYWorldPhys);
				m_mouseJoint.SetTarget(p2);
			}
		}
		
		
		
		//======================
		// Mouse Destroy
		//======================
		public function MouseDestroy():void{
			// mouse press
			if (!input.mouseDown && input.isKeyPressed(68/*D*/)){
				
				var body:b2Body = GetBodyAtMouse(true);
				
				if (body)
				{
					m_world.DestroyBody(body);
					return;
				}
			}
		}
		
		
		
		//======================
		// GetBodyAtMouse
		//======================
		private var mousePVec:b2Vec2 = new b2Vec2();
		public function GetBodyAtMouse(includeStatic:Boolean = false):b2Body {
			this.includeStatic = includeStatic;
			// Make a small box.
			mousePVec.Set(mouseXWorldPhys, mouseYWorldPhys);
			var aabb:b2AABB = new b2AABB();
			aabb.lowerBound.Set(mouseXWorldPhys - 0.001, mouseYWorldPhys - 0.001);
			aabb.upperBound.Set(mouseXWorldPhys + 0.001, mouseYWorldPhys + 0.001);
			var body:b2Body = null;
			var fixture:b2Fixture;
			
			tempBody = null;
			m_world.QueryAABB(GetBodyCallback, aabb);
			return tempBody;
		}
		
		private var tempBody:b2Body;
		private var includeStatic:Boolean = false
		// Query the world for overlapping shapes.
		private function GetBodyCallback(fixture:b2Fixture):Boolean
		{
			var shape:b2Shape = fixture.GetShape();
			if (fixture.GetBody().GetType() != b2Body.b2_staticBody || includeStatic)
			{
				var inside:Boolean = shape.TestPoint(fixture.GetBody().GetTransform(), mousePVec);
				if (inside)
				{
					tempBody = fixture.GetBody();
					return false;
				}
			}
			return true;
		}
		
		//======================
		// Draw Bounds
		//======================
		/*public function DrawBounds(){
			var b:b2AABB = new b2AABB();
			
			var bp:b2BroadPhase = m_world.m_broadPhase;
			var invQ:b2Vec2 = new b2Vec2();
			invQ.Set(1.0 / bp.m_quantizationFactor.x, 1.0 / bp.m_quantizationFactor.y);
			
			for (var i:int = 0; i < b2Settings.b2_maxProxies; ++i)
			{
				var p:b2Proxy = bp.m_proxyPool[ i ];
				if (p.IsValid() == false)
				{
					continue;
				}
				
				b.minVertex.x = bp.m_worldAABB.minVertex.x + invQ.x * bp.m_bounds[0][p.lowerBounds[0]].value;
				b.minVertex.y = bp.m_worldAABB.minVertex.y + invQ.y * bp.m_bounds[1][p.lowerBounds[1]].value;
				b.maxVertex.x = bp.m_worldAABB.minVertex.x + invQ.x * bp.m_bounds[0][p.upperBounds[0]].value;
				b.maxVertex.y = bp.m_worldAABB.minVertex.y + invQ.y * bp.m_bounds[1][p.upperBounds[1]].value;
				
				m_sprite.graphics.lineStyle(1,0xff22ff,1);
				m_sprite.graphics.moveTo(b.minVertex.x * m_physScale, b.minVertex.y * m_physScale);
				m_sprite.graphics.lineTo(b.maxVertex.x * m_physScale, b.minVertex.y * m_physScale);
				m_sprite.graphics.lineTo(b.maxVertex.x * m_physScale, b.maxVertex.y * m_physScale);
				m_sprite.graphics.lineTo(b.minVertex.x * m_physScale, b.maxVertex.y * m_physScale);
				m_sprite.graphics.lineTo(b.minVertex.x * m_physScale, b.minVertex.y * m_physScale);
			}
		}
		
		
		//======================
		// Draw Pairs
		//======================
		public function DrawPairs():void{
			
			var bp:b2BroadPhase = m_world.m_broadPhase;
			var invQ:b2Vec2 = new b2Vec2();
			invQ.Set(1.0 / bp.m_quantizationFactor.x, 1.0 / bp.m_quantizationFactor.y);
			
			for (var i:int = 0; i < b2Pair.b2_tableCapacity; ++i)
			{
				var index:uint = bp.m_pairManager.m_hashTable[i];
				while (index != b2Pair.b2_nullPair)
				{
					var pair:b2Pair = bp.m_pairManager.m_pairs[ index ];
					var p1:b2Proxy = bp.m_proxyPool[ pair.proxyId1 ];
					var p2:b2Proxy = bp.m_proxyPool[ pair.proxyId2 ];
					
					var b1:b2AABB = new b2AABB();
					var b2:b2AABB = new b2AABB();
					b1.minVertex.x = bp.m_worldAABB.minVertex.x + invQ.x * bp.m_bounds[0][p1.lowerBounds[0]].value;
					b1.minVertex.y = bp.m_worldAABB.minVertex.y + invQ.y * bp.m_bounds[1][p1.lowerBounds[1]].value;
					b1.maxVertex.x = bp.m_worldAABB.minVertex.x + invQ.x * bp.m_bounds[0][p1.upperBounds[0]].value;
					b1.maxVertex.y = bp.m_worldAABB.minVertex.y + invQ.y * bp.m_bounds[1][p1.upperBounds[1]].value;
					b2.minVertex.x = bp.m_worldAABB.minVertex.x + invQ.x * bp.m_bounds[0][p2.lowerBounds[0]].value;
					b2.minVertex.y = bp.m_worldAABB.minVertex.y + invQ.y * bp.m_bounds[1][p2.lowerBounds[1]].value;
					b2.maxVertex.x = bp.m_worldAABB.minVertex.x + invQ.x * bp.m_bounds[0][p2.upperBounds[0]].value;
					b2.maxVertex.y = bp.m_worldAABB.minVertex.y + invQ.y * bp.m_bounds[1][p2.upperBounds[1]].value;
					
					var x1:b2Vec2 = b2Math.MulFV(0.5, b2Math.AddVV(b1.minVertex, b1.maxVertex) );
					var x2:b2Vec2 = b2Math.MulFV(0.5, b2Math.AddVV(b2.minVertex, b2.maxVertex) );
					
					m_sprite.graphics.lineStyle(1,0xff2222,1);
					m_sprite.graphics.moveTo(x1.x * m_physScale, x1.y * m_physScale);
					m_sprite.graphics.lineTo(x2.x * m_physScale, x2.y * m_physScale);
					
					index = pair.next;
				}
			}
		}
		
		//======================
		// Draw Contacts
		//======================
		public function DrawContacts():void{
			for (var c:b2Contact = m_world.m_contactList; c; c = c.m_next)
			{
				var ms:Array = c.GetManifolds();
				for (var i:int = 0; i < c.GetManifoldCount(); ++i)
				{
					var m:b2Manifold = ms[ i ];
					//this.graphics.lineStyle(3,0x11CCff,0.7);
					
					for (var j:int = 0; j < m.pointCount; ++j)
					{	
						m_sprite.graphics.lineStyle(m.points[j].normalImpulse,0x11CCff,0.7);
						var v:b2Vec2 = m.points[j].position;
						m_sprite.graphics.moveTo(v.x * m_physScale, v.y * m_physScale);
						m_sprite.graphics.lineTo(v.x * m_physScale, v.y * m_physScale);
						
					}
				}
			}
		}
		
		
		//======================
		// Draw Shape 
		//======================
		public function DrawShape(shape:b2Shape):void{
			switch (shape.m_type)
			{
			case b2Shape.e_circleShape:
				{
					var circle:b2CircleShape = shape as b2CircleShape;
					var pos:b2Vec2 = circle.m_position;
					var r:Number = circle.m_radius;
					var k_segments:Number = 16.0;
					var k_increment:Number = 2.0 * Math.PI / k_segments;
					m_sprite.graphics.lineStyle(1,0xffffff,1);
					m_sprite.graphics.moveTo((pos.x + r) * m_physScale, (pos.y) * m_physScale);
					var theta:Number = 0.0;
					
					for (var i:int = 0; i < k_segments; ++i)
					{
						var d:b2Vec2 = new b2Vec2(r * Math.cos(theta), r * Math.sin(theta));
						var v:b2Vec2 = b2Math.AddVV(pos , d);
						m_sprite.graphics.lineTo((v.x) * m_physScale, (v.y) * m_physScale);
						theta += k_increment;
					}
					m_sprite.graphics.lineTo((pos.x + r) * m_physScale, (pos.y) * m_physScale);
					
					m_sprite.graphics.moveTo((pos.x) * m_physScale, (pos.y) * m_physScale);
					var ax:b2Vec2 = circle.m_R.col1;
					var pos2:b2Vec2 = new b2Vec2(pos.x + r * ax.x, pos.y + r * ax.y);
					m_sprite.graphics.lineTo((pos2.x) * m_physScale, (pos2.y) * m_physScale);
				}
				break;
			case b2Shape.e_polyShape:
				{
					var poly:b2PolyShape = shape as b2PolyShape;
					var tV:b2Vec2 = b2Math.AddVV(poly.m_position, b2Math.b2MulMV(poly.m_R, poly.m_vertices[i]));
					m_sprite.graphics.lineStyle(1,0xffffff,1);
					m_sprite.graphics.moveTo(tV.x * m_physScale, tV.y * m_physScale);
					
					for (i = 0; i < poly.m_vertexCount; ++i)
					{
						v = b2Math.AddVV(poly.m_position, b2Math.b2MulMV(poly.m_R, poly.m_vertices[i]));
						m_sprite.graphics.lineTo(v.x * m_physScale, v.y * m_physScale);
					}
					m_sprite.graphics.lineTo(tV.x * m_physScale, tV.y * m_physScale);
				}
				break;
			}
		}
		
		
		//======================
		// Draw Joint 
		//======================
		public function DrawJoint(joint:b2Joint):void
		{
			var b1:b2Body = joint.m_body1;
			var b2:b2Body = joint.m_body2;
			
			var x1:b2Vec2 = b1.m_position;
			var x2:b2Vec2 = b2.m_position;
			var p1:b2Vec2 = joint.GetAnchor1();
			var p2:b2Vec2 = joint.GetAnchor2();
			
			m_sprite.graphics.lineStyle(1,0x44aaff,1/1);
			
			switch (joint.m_type)
			{
			case b2Joint.e_distanceJoint:
			case b2Joint.e_mouseJoint:
				m_sprite.graphics.moveTo(p1.x * m_physScale, p1.y * m_physScale);
				m_sprite.graphics.lineTo(p2.x * m_physScale, p2.y * m_physScale);
				break;
				
			case b2Joint.e_pulleyJoint:
				var pulley:b2PulleyJoint = joint as b2PulleyJoint;
				var s1:b2Vec2 = pulley.GetGroundPoint1();
				var s2:b2Vec2 = pulley.GetGroundPoint2();
				m_sprite.graphics.moveTo(s1.x * m_physScale, s1.y * m_physScale);
				m_sprite.graphics.lineTo(p1.x * m_physScale, p1.y * m_physScale);
				m_sprite.graphics.moveTo(s2.x * m_physScale, s2.y * m_physScale);
				m_sprite.graphics.lineTo(p2.x * m_physScale, p2.y * m_physScale);
				break;
				
			default:
				if (b1 == m_world.m_groundBody){
					m_sprite.graphics.moveTo(p1.x * m_physScale, p1.y * m_physScale);
					m_sprite.graphics.lineTo(x2.x * m_physScale, x2.y * m_physScale);
				}
				else if (b2 == m_world.m_groundBody){
					m_sprite.graphics.moveTo(p1.x * m_physScale, p1.y * m_physScale);
					m_sprite.graphics.lineTo(x1.x * m_physScale, x1.y * m_physScale);
				}
				else{
					m_sprite.graphics.moveTo(x1.x * m_physScale, x1.y * m_physScale);
					m_sprite.graphics.lineTo(p1.x * m_physScale, p1.y * m_physScale);
					m_sprite.graphics.lineTo(x2.x * m_physScale, x2.y * m_physScale);
					m_sprite.graphics.lineTo(p2.x * m_physScale, p2.y * m_physScale);
				}
			}
		}*/
	}
	
}