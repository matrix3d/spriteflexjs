package{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	// Classes used in this example
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	public class TestBox2D extends Sprite{
		
		public function TestBox2D(){
			
			
			
			// Add event for main loop
			addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
			
			// Define the gravity vector
			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
			
			// Allow bodies to sleep
			var doSleep:Boolean = true;
			
			// Construct a world object
			m_world = new b2World( gravity, doSleep);
			
			// set debug draw
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite(this);
			debugDraw.SetDrawScale(30.0);
			debugDraw.SetFillAlpha(0.3);
			debugDraw.SetLineThickness(1.0);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			debugDraw.SetFlags(0xffffffff);
			m_world.SetDebugDraw(debugDraw);
			m_world.DrawDebugData();
			
			
			
			// Vars used to create bodies
			var body:b2Body;
			var bodyDef:b2BodyDef;
			var boxShape:b2PolygonShape;
			var circleShape:b2CircleShape;
			
			
			
			// Add ground body
			bodyDef = new b2BodyDef();
			//bodyDef.position.Set(15, 19);
			bodyDef.position.Set(10, 12);
			//bodyDef.angle = 0.1;
			boxShape = new b2PolygonShape();
			boxShape.SetAsBox(30, 3);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxShape;
			fixtureDef.friction = 0.3;
			fixtureDef.density = 0; // static bodies require zero density
			// Add sprite to body userData
			body = m_world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			// Add some objects
			for (var i:int = 1; i < 10; i++){
				bodyDef = new b2BodyDef();
				bodyDef.type = b2Body.b2_dynamicBody;
				bodyDef.position.x = Math.random() * 15 + 5;
				bodyDef.position.y = Math.random() * 10;
				var rX:Number = Math.random() + 0.5;
				var rY:Number = Math.random() + 0.5;
				body = m_world.CreateBody(bodyDef);
				// Box
				if (Math.random() < 0.5){
					boxShape = new b2PolygonShape();
					boxShape.SetAsBox(rX, rY);
					fixtureDef.shape = boxShape;
					fixtureDef.density = 1.0;
					fixtureDef.friction = 0.5;
					fixtureDef.restitution = 0.2;
					body.CreateFixture(fixtureDef);
				} 
				// Circle
				else {
					circleShape = new b2CircleShape(rX);
					fixtureDef.shape = circleShape;
					fixtureDef.density = 1.0;
					fixtureDef.friction = 0.5;
					fixtureDef.restitution = 0.2;
					body.CreateFixture(fixtureDef);
				}
			}
		}
		
		public function Update(e:Event):void{
			m_world.Step(m_timeStep, m_velocityIterations, m_positionIterations);
			m_world.DrawDebugData();
			
		}
		
		public var m_world:b2World;
		public var m_velocityIterations:int = 10;
		public var m_positionIterations:int = 10;
		public var m_timeStep:Number = 1.0/30.0;
		
	}

}