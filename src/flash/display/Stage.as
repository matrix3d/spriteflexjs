package flash.display
{
	import flash.__native.GLCanvasRenderingContext2D;
	import flash.__native.WebGLRenderer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	public class Stage extends EventDispatcher
	{
		public var __rootHtmlElement:Element;
		public var __htmlWrapper:Element;
		private var _frameRate:int;
		private var _stage3Ds:Vector.<Stage3D>;
		private static const kInvalidParamError:uint = 2004;
		private var _canvas:HTMLCanvasElement;
		private var _ctx:CanvasRenderingContext2D
		private var _ctx2d:CanvasRenderingContext2D
		private var _mouseX:Number = 0;
		private var _mouseY:Number = 0;
		//private var intervalID:Number;
		private var needSendMouseMove:Boolean = false;
		private var needSendTouchMove:Boolean = false;
		private var lastUpdateTime:int = -1000;
		//private var requestAnimationFrameHander:Number;
		private var _loaderInfo:LoaderInfo;
		private var _stageWidth:Number=0;
		private var _stageHeight:Number=0;
		public function Stage()
		{
			trace("power by SpriteFlexJS");
			__rootHtmlElement = document.createElement("div");
			document.body.appendChild(__rootHtmlElement);
			
			__htmlWrapper = document.createElement("div");
			document.body.appendChild(__htmlWrapper);
			__htmlWrapper.style.position = "absolute";
			__htmlWrapper.style.left = "0px";
			__htmlWrapper.style.top = "0px";
			__htmlWrapper.style.zIndex =0;
			
			_loaderInfo = new LoaderInfo();
			if (SpriteFlexjs.startTime===0) {
				SpriteFlexjs.startTime = Date.now();
			}
			frameRate = 60;
			_stage3Ds = Vector.<Stage3D>([new Stage3D, new Stage3D, new Stage3D, new Stage3D]);
			_stage3Ds[0].__stage = this;
			_stage3Ds[1].__stage = this;
			_stage3Ds[2].__stage = this;
			_stage3Ds[3].__stage = this;
			window.addEventListener("resize", window_resize, false);
			window.addEventListener("orientationchange", window_resize, false);
			setTimeout(__update);
		}
		
		private function window_resize(e:Object):void
		{
			SpriteFlexjs.dirtyGraphics = true;
			if (SpriteFlexjs.autoSize){
				SpriteFlexjs.stageWidth = window.innerWidth;
				SpriteFlexjs.stageHeight = window.innerHeight;
			}
			_stageWidth = SpriteFlexjs.stageWidth;
			_stageHeight = SpriteFlexjs.stageHeight;
			canvas.width = _stageWidth;
			canvas.height = _stageHeight;
			canvas.style.width = _stageWidth + "px";
			canvas.style.height = _stageHeight + "px";
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		public function get frameRate():Number  { return _frameRate }
		
		public function set frameRate(v:Number):void
		{
			_frameRate = v;
			/*try{
				cancelRequestAnimationFrame(requestAnimationFrameHander);
			}catch(e:Object){}*/
			//__update();
		}
		
		private function __update():void {
			if(_stageWidth != SpriteFlexjs.stageWidth||
			_stageHeight != SpriteFlexjs.stageHeight){
				window_resize(null);
			}
			
			//http://codetheory.in/controlling-the-frame-rate-with-requestanimationframe/	
			/*requestAnimationFrameHander = */SpriteFlexjs.requestAnimationFrame.call(window,__update);
			//var now:Number = getTimer();
			//var interval:Number = Math.ceil(1000/frameRate);
			//var delta:Number = now - lastUpdateTime;
			//if (delta >= interval) {
			//	lastUpdateTime = now - (delta % interval);
				if (needSendMouseMove) {
					dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE, true, false, _mouseX, _mouseY));
					needSendMouseMove = false;
				}
				if (needSendTouchMove) {
					dispatchEvent(new TouchEvent(TouchEvent.TOUCH_MOVE, true, false, 0, true, _mouseX, _mouseY));
					needSendTouchMove = false;
				}
				dispatchEvent(new Event(Event.ENTER_FRAME));
			//}
		}
		
		public function invalidate():void  {/**/ }
		
		public function get loaderInfo():LoaderInfo  { return _loaderInfo; }
		
		public function get scaleMode():String  { return null }
		
		public function set scaleMode(param1:String):void  {/**/ }
		
		public function get align():String  { return null }
		
		public function set align(param1:String):void  {/**/ }
		
		public function get stageWidth():int  { return _stageWidth; }
		
		public function set stageWidth(param1:int):void  {/**/ }
		
		public function get stageHeight():int  { return _stageHeight; }
		
		public function set stageHeight(param1:int):void  {/**/ }
		
		public function get showDefaultContextMenu():Boolean  { return false }
		
		public function set showDefaultContextMenu(param1:Boolean):void  {/**/ }
		
		public function get colorCorrection():String  { return null }
		
		public function set colorCorrection(param1:String):void  {/**/ }
		
		public function get colorCorrectionSupport():String  { return null }
		
		public function isFocusInaccessible():Boolean  { return false }
		
		public function get stageFocusRect():Boolean  { return false }
		
		public function set stageFocusRect(param1:Boolean):void  {/**/ }
		
		public function get quality():String  { return null }
		
		public function set quality(param1:String):void  {/**/ }
		
		public function get displayState():String  {
			return (document["fullscreen"] || document["webkitIsFullScreen"] || document["mozFullScreen"]) ? "fullScreen" : "normal";
		}
		
		public function set displayState(param1:String):void  {
			if (param1.indexOf("fullScreen")!=-1) {
				var requestFunc:Function = (_canvas["requestFullscreen"] || _canvas["webkitRequestFullScreen"] || _canvas["mozRequestFullScreen"] || _canvas["msRequestFullscreen"]);
				requestFunc.call(_canvas);
			} else {
				var cancelFunc:Function = (document["exitFullscreen"] || document["webkitExitFullScreen"] || document["mozCancelFullScreen"] || document["msExitFullscreen"]);
				cancelFunc.call(document);
			}
		}
		
		public function get fullScreenSourceRect():Rectangle  { return null }
		
		public function set fullScreenSourceRect(param1:Rectangle):void  {/**/ }
		
		public function get mouseLock():Boolean  { return false }
		
		public function set mouseLock(param1:Boolean):void  {/**/ }
		
		// public function get stageVideos() : Vector.<StageVideo>{return null}
		
		public function get stage3Ds():Vector.<Stage3D>  { return _stage3Ds }
		
		public function get color():uint  { return 0 }
		
		public function set color(param1:uint):void  {/**/ }
		
		public function get fullScreenWidth():uint  { return 0 }
		
		public function get fullScreenHeight():uint  { return 0 }
		
		public function get wmodeGPU():Boolean  { return false }
		
		public function get softKeyboardRect():Rectangle  { return null }
		
		public function get allowsFullScreen():Boolean  { return false }
		
		public function get allowsFullScreenInteractive():Boolean  { return false }
		
		public function get contentsScaleFactor():Number  { return 0 }
		
		public function get browserZoomFactor():Number  { return 0 }
		
		private function requireOwnerPermissions():void  {/**/ }
		
		public function get canvas():HTMLCanvasElement
		{
			
			if (!_canvas)
			{
				//http://www.w3schools.com/jsref/dom_obj_event.asp
				_canvas = document.getElementById("spriteflexjsstage") as HTMLCanvasElement;
				if (_canvas == null){
					_canvas=document.createElement("canvas") as HTMLCanvasElement;
					_canvas.style.position = "absolute";
					_canvas.style.left = "0px";
					_canvas.style.top = "0px";
					_canvas.style.zIndex = -10;
					__rootHtmlElement.appendChild(_canvas as HTMLCanvasElement);
				}
				
				_canvas.addEventListener("click", canvas_mouseevent,false);
				_canvas.addEventListener("contextmenu", canvas_mouseevent,false);
				_canvas.addEventListener("dblclick", canvas_mouseevent,false);
				_canvas.addEventListener("mousedown", canvas_mouseevent,false);
				_canvas.addEventListener("mouseenter", canvas_mouseevent,false);
				_canvas.addEventListener("mouseleave", canvas_mouseevent,false);
				_canvas.addEventListener("mousemove", canvas_mouseevent,false);
				_canvas.addEventListener("mouseover", canvas_mouseevent,false);
				_canvas.addEventListener("mouseout", canvas_mouseevent,false);
				_canvas.addEventListener("mouseup", canvas_mouseevent,false);
				_canvas.addEventListener("mousewheel", canvas_mouseevent,false);
				_canvas.addEventListener("touchcancel", canvas_touchevent,false);
				_canvas.addEventListener("touchend", canvas_touchevent,false);
				_canvas.addEventListener("touchmove", canvas_touchevent,false);
				_canvas.addEventListener("touchstart", canvas_touchevent,false);
				document.addEventListener("keydown", canvas_keyevent,false);
				document.addEventListener("keyup", canvas_keyevent,false);
			}
			return _canvas;
		}
		
		
		private function canvas_touchevent(e:Object):void 
		{
			var jsType:String = e.type;
			var flashType:String;
			var flashType2:String;
			switch(jsType) {
				case "touchcancel":
					flashType = TouchEvent.TOUCH_END;
					flashType2 = MouseEvent.MOUSE_UP;
					break;
				case "touchend":
					flashType = TouchEvent.TOUCH_END;
					flashType2 = MouseEvent.MOUSE_UP;
					break;
				case "touchmove":
					flashType = TouchEvent.TOUCH_MOVE;
					flashType2 = MouseEvent.MOUSE_MOVE;
					break;
				case "touchstart":
					flashType = TouchEvent.TOUCH_BEGIN;
					flashType2 = MouseEvent.MOUSE_DOWN;
					e.preventDefault();
					break;
			}
			if (flashType) {
				if (e.targetTouches.length) {
					_mouseX = e.targetTouches[0].pageX - canvas.offsetLeft;
					_mouseY = e.targetTouches[0].pageY - canvas.offsetTop;
				}
				if (hasEventListener(flashType)) {
					if(flashType!=TouchEvent.TOUCH_MOVE){
						dispatchEvent(new TouchEvent(flashType, true, false, 0, true, _mouseX, _mouseY));
					}else {
						needSendTouchMove = true;
					}
				}
				if (hasEventListener(flashType2)) {
					if(flashType2!=MouseEvent.MOUSE_MOVE){
						dispatchEvent(new MouseEvent(flashType2, true, false, _mouseX, _mouseY));
					}else {
						needSendMouseMove = true;
					}
				}
				if (flashType===TouchEvent.TOUCH_END&&hasEventListener(MouseEvent.CLICK)) {
					dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, false, _mouseX, _mouseY));
				}
			}
		}
		private function canvas_keyevent(e:Object):void {
			var jsType:String = e.type;
			var flashType:String;
			switch(jsType) {
				case "keydown":
					flashType = KeyboardEvent.KEY_DOWN;
					break;
				case "keyup":
					flashType = KeyboardEvent.KEY_UP;
					break;
			}
			if (hasEventListener(flashType)) {
				dispatchEvent(new KeyboardEvent(flashType, true, false, e.charCode, e.keyCode, e.location, e.ctrlKey, e.altKey, e.shiftKey));
			}
		}
		private function canvas_mouseevent(e:Object):void
		{
			var jsType:String = e.type;
			var flashType:String;
			switch(jsType) {
				case "click":
					flashType = MouseEvent.CLICK;
					break;
				case "contextmenu":
					flashType = MouseEvent.CONTEXT_MENU;
					break;
				case "dblclick":
					flashType = MouseEvent.DOUBLE_CLICK;
					break;
				case "mousedown":
					flashType = MouseEvent.MOUSE_DOWN;
					break;
				case "mouseenter":
					flashType = MouseEvent.ROLL_OVER;
					break;
				case "mouseleave":
					flashType = MouseEvent.MOUSE_OUT;
					break;
				case "mousemove":
					flashType = MouseEvent.MOUSE_MOVE;
					break;
				case "mouseover":
					flashType = MouseEvent.MOUSE_OVER;
					break;
				case "mouseout":
					flashType = MouseEvent.MOUSE_OUT;
					break;
				case "mouseup":
					flashType = MouseEvent.MOUSE_UP;
					break;
				case "mousewheel":
					flashType = MouseEvent.MOUSE_WHEEL;
					break;
					
			}
			if(flashType){
				_mouseX = e.pageX - canvas.offsetLeft;
				_mouseY = e.pageY - canvas.offsetTop;
				if (hasEventListener(flashType)) {
					if(flashType!=MouseEvent.MOUSE_MOVE){
						dispatchEvent(new MouseEvent(flashType,true,false,_mouseX,_mouseY,null,e.ctrlKey,e.altKey,e.shiftKey,e.button>0,e.wheelDelta));
					}else {
						needSendMouseMove = true;
					}
				}
			}
		}
		/**
		 * @flexjsignorecoercion CanvasRenderingContext2D
		 */
		public function get ctx():CanvasRenderingContext2D
		{
			if (!_ctx)
			{
				if (SpriteFlexjs.wmode==="gpu") {
					_ctx = new GLCanvasRenderingContext2D(this) as CanvasRenderingContext2D;
					SpriteFlexjs.renderer = new WebGLRenderer;
				}else if (SpriteFlexjs.wmode==="gpu batch"){
					_ctx = new GLCanvasRenderingContext2D(this, true) as CanvasRenderingContext2D;
					SpriteFlexjs.renderer = new WebGLRenderer;
				}else{
					_ctx = canvas.getContext("2d") as CanvasRenderingContext2D;
				}
			}
			return _ctx;
		}
		
		public function get ctx2d():CanvasRenderingContext2D{
			if (!_ctx2d)
			{
				var can:HTMLCanvasElement = document.createElement("canvas") as HTMLCanvasElement;
				_ctx2d = can.getContext("2d") as CanvasRenderingContext2D;
			}
			return _ctx2d;
		}
		
		public function get displayContextInfo():String  { return null }
		
		public function get mouseX():Number 
		{
			return _mouseX;
		}
		
		public function get mouseY():Number 
		{
			return _mouseY;
		}
	
	}
}
