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

package{

import Box2D.Dynamics.*
import Box2D.Collision.*
import Box2D.Collision.Shapes.*
import Box2D.Dynamics.Joints.*
import Box2D.Dynamics.Contacts.*
import Box2D.Common.Math.*
import flash.__native.WebGLRenderer;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.*;
import flash.text.*;
import General.*
import TestBed.*;

	[SWF(width='640', height='360', backgroundColor='#292C2C', frameRate='30')]
	public class TestBedMain extends Sprite{
		
		
		//======================
		// Member data
		//======================
		//public var m_fpsCounter:FpsCounter// = new FpsCounter();
		public var m_currId:int = 0;
		public var m_currTest:Test;
		public var m_sprite:Sprite;
		public var m_aboutText:TextField;
		// input
		public var m_input:Input;
		public function TestBedMain() {
			CONFIG::js_only{
			SpriteFlexjs.renderer = new WebGLRenderer;
			SpriteFlexjs.wmode = "gpu batch";
			}
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align=StageAlign.TOP_LEFT;
			//m_fpsCounter = new FpsCounter;
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			
			//m_fpsCounter.x = 7;
			//m_fpsCounter.y = 5;
			//addChildAt(m_fpsCounter, 0);
			
			m_sprite = new Sprite();
			addChild(m_sprite);
			// input
			m_input = new Input(m_sprite);
			
			
			//Instructions Text
			var instructions_text:TextField = new TextField();
			
			var instructions_text_format:TextFormat = new TextFormat("Arial", 16, 0xff00ff, false, false, false);
			instructions_text_format.align = TextFormatAlign.RIGHT;
			
			instructions_text.defaultTextFormat = instructions_text_format
			instructions_text.x = 140
			instructions_text.y = 4.5
			instructions_text.width = 495
			instructions_text.height = 61
			instructions_text.text = "Box2DFlashAS3 2.0.1\n'Left'/'Right' arrows to go to previous/next example. \n'R' to reset."
			addChild(instructions_text);
			
			// textfield pointer
			m_aboutText = new TextField();
			var m_aboutTextFormat:TextFormat = new TextFormat("Arial", 16, 0x00CCFF, true, false, false);
			m_aboutTextFormat.align = TextFormatAlign.RIGHT;
			m_aboutText.defaultTextFormat = m_aboutTextFormat
			m_aboutText.x = 334
			m_aboutText.y = 71
			m_aboutText.width = 300
			m_aboutText.height = 30
			addChild(m_aboutText);
			
			// Thanks to everyone who contacted me about this fix
			instructions_text.mouseEnabled = false;
			m_aboutText.mouseEnabled = false;
			
			var next:TextField = new TextField;
			next.defaultTextFormat = new TextFormat(null, 40, 0xff0000);
			next.autoSize = "left";
			next.text = "next";
			next.y = 100;
			addChild(next);
			next.addEventListener(MouseEvent.CLICK, next_click);
		}
		
		private function next_click(e:MouseEvent):void 
		{
			trace("lick");
			m_currId++;
			m_currTest = null;
		}
		
		public function update(e:Event):void{
			// clear for rendering
			m_sprite.graphics.clear()
			
			// toggle between tests
			if (m_input.isKeyPressed(39)){ // Right Arrow
				m_currId++;
				m_currTest = null;
			}
			else if (m_input.isKeyPressed(37)){ // Left Arrow
				m_currId--;
				m_currTest = null
			}
			// Reset
			else if (m_input.isKeyPressed(82)){ // R
				m_currTest = null
			}
			
			//var tests:Array = [
				//TestRagdoll,			// Ragdoll
				//TestCompound,			// Compound Shapes
				//TestCrankGearsPulley,	// Crank/Gears/Pulley
				//TestBridge,				// Bridge
				//TestStack,				// Stack
				//TestCCD,				// CCD
				//TestTheoJansen,			// Theo Jansen
				//TestEdges,				// Edges & Raycast
				//TestBuoyancy,			// Buoyancy
				//TestOneSidedPlatform,	// One Sided Platform
				//TestBreakable,			// Breakable
				//TestRaycast,			// Raycast
			//null
			//];
			//tests.length -= 1;
			
            var testCount:int = 12//tests.length;
			m_currId = (m_currId + testCount) % testCount;
			
			
			
			// if null, set new test
			if (!m_currTest){
				switch(m_currId) {
					case 0:
						m_currTest = new TestRagdoll(m_sprite, m_aboutText, m_input);
						break;
					case 1:
						m_currTest = new TestCompound(m_sprite, m_aboutText, m_input);
						break;
					case 2:
						m_currTest = new TestCrankGearsPulley(m_sprite, m_aboutText, m_input);
						break;
					case 3:
						m_currTest = new TestBridge(m_sprite, m_aboutText, m_input);
						break;
					case 4:
						m_currTest = new TestStack(m_sprite, m_aboutText, m_input);
						break;
					case 5:
						m_currTest = new TestCCD(m_sprite, m_aboutText, m_input);
						break;
					case 6:
						m_currTest = new TestTheoJansen(m_sprite, m_aboutText, m_input);
						break;
					case 7:
						m_currTest = new TestTheoJansen(m_sprite, m_aboutText, m_input);
						break;
					case 8:
						m_currTest = new TestBuoyancy(m_sprite, m_aboutText, m_input);
						break;
					case 9:
						m_currTest = new TestOneSidedPlatform(m_sprite, m_aboutText, m_input);
						break;
					case 10:
						m_currTest = new TestBreakable(m_sprite, m_aboutText, m_input);
						break;
					case 11:
						m_currTest = new TestRaycast(m_sprite, m_aboutText, m_input);
						break;
					//default:
					//	m_currTest = new  tests[m_currId](m_sprite,m_aboutText,m_input);
				}
			}
			
			// update current test
			m_currTest.Update();
			
			// Update input (last)
			m_input.update();
			
			// update counter and limit framerate
			//m_fpsCounter.update();
			//FRateLimiter.limitFrame(30);
			
		}
		
	}
}
