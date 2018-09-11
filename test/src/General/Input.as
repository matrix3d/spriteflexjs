//===========================================================
//=========================================================//
//						-=ANTHEM=-
//	file: .as
//
//	copyright: Matthew Bush 2007
//
//	notes:
//
//=========================================================//
//===========================================================


//===========================================================
// Input class
//===========================================================
package General{
	
	
	
	import flash.display.*;
	import flash.events.*;
	
	
	public class Input{
		
		
		//======================
		// constructor
		//======================
		public function Input(stageMc:Sprite){
			
			m_stageMc = stageMc;
			
			// init ascii array
			ascii = new Array(222)
			fillAscii();
			
			// init key state array
			keyState = new Array(222);
			keyArr = new Array();
			for (var i:int = 0; i < 222; i++){
				keyState[i] = 0;
				if (ascii[i] != undefined){
					keyArr.push(i);
				}
			}
			
			// buffer
			bufferSize = 5;
			keyBuffer = new Array(bufferSize);
			for (var j:int = 0; j < bufferSize; j++){
				keyBuffer[j] = new Array(0,0);
			}
			
			// add key listeners
			stageMc.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress, false, 0, true);
			stageMc.stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease, false, 0, true);		
			
			// mouse listeners
			stageMc.stage.addEventListener(MouseEvent.MOUSE_DOWN, mousePress, false, 0, true);
			stageMc.stage.addEventListener(MouseEvent.CLICK, mouseRelease, false, 0, true);
			stageMc.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove, false, 0, true);
			stageMc.stage.addEventListener(Event.MOUSE_LEAVE, mouseLeave, false, 0, true);
			
			mouse.graphics.lineStyle(0.1, 0, 100);
			mouse.graphics.moveTo(0,0);
			mouse.graphics.lineTo(0,0.1);
			
		}
		
		
		
		//======================
		// update
		//======================
		 public function update():void{
			
			// array of used keys
			/*var kArr:Array = new Array(
				Globals.keyP1Up,
				Globals.keyP1Down,
				Globals.keyP1Left,
				Globals.keyP1Right,
				Globals.keyP1Attack1,
				Globals.keyP1Attack2,
				Globals.keyP1Jump,
				Globals.keyP1Defend,
				Globals.keyResetGame,
				Globals.keyInvertBg,
				Globals.keyChangeBg,
				Globals.keyPauseGame);*/
				
			// update used keys
			for (var i:int = 0; i < keyArr.length; i++){
				if (keyState[keyArr[i]] != 0){
					keyState[keyArr[i]]++;
				}
			}
			
			// update buffer
			for (var j:int = 0; j < bufferSize; j++){
				keyBuffer[j][1]++;
			}
			
			// end mouse release
			mouseReleased = false;
			mousePressed = false;
			mouseOver = false;
			
		}
		
		
		
		//======================
		// mousePress listener
		//======================
		public function mousePress(e:MouseEvent):void{
			mousePressed = true;
			mouseDown = true;
			mouseDragX = 0;
			mouseDragY = 0;
		}
		
		
		
		//======================
		// mousePress listener
		//======================
		public function mouseRelease(e:MouseEvent):void{
			mouseDown = false;
			mouseReleased = true;
		}
		
		
		
		//======================
		// mousePress listener
		//======================
		public function mouseLeave(e:Event):void{
			mouseReleased = mouseDown;
			mouseDown = false;
		}
		
		
		
		//======================
		// mouseMove listener
		//======================
		public function mouseMove(e:MouseEvent):void{
			// Fix mouse release not being registered from mouse going off stage
			if (mouseDown != e.buttonDown){
				mouseDown = e.buttonDown;
				mouseReleased = !e.buttonDown;
				mousePressed = e.buttonDown;
				mouseDragX = 0;
				mouseDragY = 0;
			}
			mouseX = e.stageX - m_stageMc.x;
			mouseY = e.stageY - m_stageMc.y;
			//alert(e.stageX + ","+m_stageMc.x+","+mouseX);
			// Store offset
			mouseOffsetX = mouseX - mouse.x;
			mouseOffsetY = mouseY - mouse.y;
			// Update drag
			if (mouseDown){
				mouseDragX += mouseOffsetX;
				mouseDragY += mouseOffsetY;
			}
			mouse.x = mouseX;
			mouse.y = mouseY;
		}
		
		
		
		//======================
		// getKeyHold
		//======================
		 public function getKeyHold(k:int):int{
			return Math.max(0, keyState[k]);
		}
		
		
		//======================
		// isKeyDown
		//======================
		 public function isKeyDown(k:int):Boolean{
			return (keyState[k] > 0);
		}
		
		
		
		//======================
		//  isKeyPressed
		//======================
		 public function isKeyPressed(k:int):Boolean{
			timeSinceLastKey = 0;
			return (keyState[k] == 1);
		}
		
		
		
		//======================
		//  isKeyReleased
		//======================
		 public function isKeyReleased(k:int):Boolean{
			return (keyState[k] == -1);
		}
		
		
		
		//======================
		// isKeyInBuffer
		//======================
		 public function isKeyInBuffer(k:int, i:int, t:int):Boolean{
			return (keyBuffer[i][0] == k && keyBuffer[i][1] <= t);
		}
		
		
		
		//======================
		// keyPress function
		//======================
		public function keyPress(e:KeyboardEvent):void{
			
			//strace ( e.keyCode + " : " + ascii[e.keyCode] );
			
			// set keyState
			keyState[e.keyCode] = Math.max(keyState[e.keyCode], 1);
			
			// last key (for key config)
			lastKey = e.keyCode;
			
		}
		
		//======================
		// keyRelease function
		//======================
		public function keyRelease(e:KeyboardEvent):void{
			keyState[e.keyCode] = -1;
			
			// add to key buffer
			for (var i:int = bufferSize-1; i > 0 ; i--){
				keyBuffer[i] = keyBuffer[i - 1];
			}
			keyBuffer[0] = [e.keyCode, 0];
		}
		
		
		
		//======================
		// get key string
		//======================
		 public function getKeyString(k:uint):String{
			return ascii[k];
		}
		
		
		//======================
		// set up ascii text
		//======================
		private function fillAscii():void{
			ascii[65] = "A";
			ascii[66] = "B";
			ascii[67] = "C";
			ascii[68] = "D";
			ascii[69] = "E";
			ascii[70] = "F";
			ascii[71] = "G";
			ascii[72] = "H";
			ascii[73] = "I";
			ascii[74] = "J";
			ascii[75] = "K";
			ascii[76] = "L";
			ascii[77] = "M";
			ascii[78] = "N";
			ascii[79] = "O";
			ascii[80] = "P";
			ascii[81] = "Q";
			ascii[82] = "R";
			ascii[83] = "S";
			ascii[84] = "T";
			ascii[85] = "U";
			ascii[86] = "V";
			ascii[87] = "W";
			ascii[88] = "X";
			ascii[89] = "Y";
			ascii[90] = "Z";
			ascii[48] = "0";
			ascii[49] = "1";
			ascii[50] = "2";
			ascii[51] = "3";
			ascii[52] = "4";
			ascii[53] = "5";
			ascii[54] = "6";
			ascii[55] = "7";
			ascii[56] = "8";
			ascii[57] = "9";
			ascii[32] = "Spacebar";
			ascii[17] = "Ctrl";
			ascii[16] = "Shift";
			ascii[192] = "~";
			ascii[38] = "up";
			ascii[40] = "down";
			ascii[37] = "left";
			ascii[39] = "right";
			ascii[96] = "Numpad 0";
			ascii[97] = "Numpad 1";
			ascii[98] = "Numpad 2";
			ascii[99] = "Numpad 3";
			ascii[100] = "Numpad 4";
			ascii[101] = "Numpad 5";
			ascii[102] = "Numpad 6";
			ascii[103] = "Numpad 7";
			ascii[104] = "Numpad 8";
			ascii[105] = "Numpad 9";
			ascii[111] = "Numpad /";
			ascii[106] = "Numpad *";
			ascii[109] = "Numpad -";
			ascii[107] = "Numpad +";
			ascii[110] = "Numpad .";
			ascii[45] = "Insert";
			ascii[46] = "Delete";
			ascii[33] = "Page Up";
			ascii[34] = "Page Down";
			ascii[35] = "End";
			ascii[36] = "Home";
			ascii[112] = "F1";
			ascii[113] = "F2";
			ascii[114] = "F3";
			ascii[115] = "F4";
			ascii[116] = "F5";
			ascii[117] = "F6";
			ascii[118] = "F7";
			ascii[119] = "F8";
			ascii[188] = ",";
			ascii[190] = ".";
			ascii[186] = ";";
			ascii[222] = "'";
			ascii[219] = "[";
			ascii[221] = "]";
			ascii[189] = "-";
			ascii[187] = "+";
			ascii[220] = "\\";
			ascii[191] = "/";
			ascii[9] = "TAB";
			ascii[8] = "Backspace";
			//ascii[27] = "ESC";
		}
		
		//======================
		// member data
		//======================
		// key text array
		 public var ascii:Array;
		 private var keyState:Array;
		 private var keyArr:Array;
		
		 private var keyBuffer:Array;
		 private var bufferSize:int;
		
		// last key pressed
		 public var lastKey:int = 0;
		 public var timeSinceLastKey:Number = 0;
		
		// mouse states
		 public var mouseDown:Boolean = false;
		 public var mouseReleased:Boolean = false;
		 public var mousePressed:Boolean = false;
		 public var mouseOver:Boolean = false;
		 public var mouseX:Number = 0;
		 public var mouseY:Number = 0;
		 public var mouseOffsetX:Number = 0;
		 public var mouseOffsetY:Number = 0;
		 public var mouseDragX:Number = 0;
		 public var mouseDragY:Number = 0;
		 public var mouse:Sprite = new Sprite();
		
		// stage
		 public var m_stageMc:Sprite;
	}
	
	
}



// End of file
//===========================================================
//===========================================================

