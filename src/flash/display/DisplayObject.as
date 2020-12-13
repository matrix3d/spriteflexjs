package flash.display
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author lizhi
	 */
	public class DisplayObject extends EventDispatcher implements IBitmapDrawable
	{
		private static var _globalStage:Stage;
		private var _stage:Stage;
		private var _inited:Boolean = false;
		protected var _root:DisplayObject;
		public var _off:Boolean = false;
		
		private static var ID:int = 0;
		public var innerID:int;
		private var _name:String;
		private var _rotation:Number = 0;
		private var rsin:Number = 0;
		private var rcos:Number = 1;
		public var transform:Transform;
		public var _parent:DisplayObjectContainer;
		private var _mask:DisplayObject;
		private var _visible:Boolean = true;
		private var lastMouseOverObj:DisplayObject;
		private var _blendMode:String;
		private var _cacheAsBitmap:Boolean = false;
		private var _loaderInfo:LoaderInfo;
		private var _filters:Array = [];
		private var _filterOffsetX:Number = 0;
		private var _filterOffsetY:Number = 0;
		
		public function DisplayObject()
		{
			_loaderInfo = new LoaderInfo();
			_stage = _globalStage;
			
			if (_stage) initDisplayObjectStage();
		}
		
		public function initDisplayObjectStage():void
		{
			if (!_inited)
			{
				_blendMode = BlendMode.NORMAL;
				transform = new Transform(this);
				innerID = ID++;
				_name = "instance" + innerID;
				
				if (innerID === 0)
				{
					//_globalStage.addChild(this);
					_globalStage.setRoot(this); 
					_stage = _globalStage;
					_stage.addEventListener(Event.ENTER_FRAME, __enterFrame);
					_stage.addEventListener(MouseEvent.CLICK, __mouseevent);
					_stage.addEventListener(MouseEvent.CONTEXT_MENU, __mouseevent);
					_stage.addEventListener(MouseEvent.DOUBLE_CLICK, __mouseevent);
					_stage.addEventListener(MouseEvent.MOUSE_DOWN, __mouseevent);
					_stage.addEventListener(MouseEvent.MOUSE_MOVE, __mouseevent);
					_stage.addEventListener(MouseEvent.MOUSE_UP, __mouseevent);
				}
				_inited = true;
			}
		}
		
		public static function set initStage(value:Stage):void 
		{
			_globalStage = value;
		}
		
		public function get stage():Stage  { return _stage; }
		
		public function set stage(v:Stage):void  { 
			_stage = v;
			if (_stage) {
				dispatchEvent(new Event(Event.ADDED_TO_STAGE));
			}else {
				SpriteFlexjs.dirtyGraphics = true;
				dispatchEvent(new Event(Event.REMOVED_FROM_STAGE));
			}
		}
		
		
		/************************ <Non Flash API Helper Methods> *****************************************/
		public function get loaderInfo():LoaderInfo  { return _loaderInfo; }
		
		public function get root():DisplayObject  { return _root }
		
		public function get name():String  { return _name; }
		
		public function set name(v:String):void  {
			_name = v;
		}
		
		public function get parent():DisplayObjectContainer  { return _parent; }
		
		public function get mask():DisplayObject  { return _mask; }
		
		public function set mask(param1:DisplayObject):void  { _mask = param1; }
		
		public function get visible():Boolean  { return _visible }
		
		public function set visible(v:Boolean):void  {
			_visible = v;
		}
		
		public function get x():Number  { return transform.matrix.tx }
		
		public function set x(v:Number):void
		{
			transform.matrix.tx = v;
			updateTransforms();
		}
		
		public function get y():Number  { return transform.matrix.ty }
		
		public function set y(v:Number):void
		{
			transform.matrix.ty = v;
			updateTransforms();
		}
		
		public function get z():Number  { return 0 }
		
		public function set z(v:Number):void  {/**/ }
		
		public function get scaleX():Number
		{
			var m:Matrix = transform.matrix;
			if (m.b === 0) return m.a;
			return Math.sqrt(m.a * m.a + m.b * m.b);
		}
		
		public function set scaleX(v:Number):void
		{
			var m:Matrix = transform.matrix;
			if (m.c === 0)
			{
				m.a = v;
			}
			else
			{
				m.a = rcos * v;
				m.b = rsin * v;
			}
			updateTransforms();
		}
		
		public function get scaleY():Number
		{
			var m:Matrix = transform.matrix;
			if (m.c === 0)
			{
				return m.d;
			}
			return Math.sqrt(m.c * m.c + m.d * m.d);
		}
		
		public function set scaleY(v:Number):void
		{
			var m:Matrix = transform.matrix;
			if (m.c === 0)
			{
				m.d = v;
			}
			else
			{
				m.c = -rsin * v;
				m.d = rcos * v;
			}
			updateTransforms();
		}
		
		public function get scaleZ():Number  { return 1 }
		
		public function set scaleZ(v:Number):void  {/**/ }
		
		public function get mouseX():Number  {
			if(stage)
			return transform.invMatrix.transformPoint(new Point(stage.mouseX, stage.mouseY)).x;
			return 0;
		}
		
		public function get mouseY():Number  { 
			if(stage)
			return transform.invMatrix.transformPoint(new Point(stage.mouseX, stage.mouseY)).y;
			return 0;
		}
		
		public function get rotation():Number  { return _rotation }
		
		public function set rotation(v:Number):void
		{
			// TODO change to -180 to 180 instead of the (0 - 360) to match Flash API.
			_rotation = (v >= 360) ? v - 360 : v;
			var m:Matrix = transform.matrix;
			var r:Number = v * Math.PI / 180;
			rsin = Math.sin(r);
			rcos = Math.cos(r);
			var sx:Number = m.b === 0?m.a:Math.sqrt(m.a * m.a + m.b * m.b);
			var sy:Number = m.c === 0?m.d:Math.sqrt(m.c * m.c + m.d * m.d);
			m.a = rcos * sx;
			m.b = rsin * sx;
			m.c = -rsin * sy;
			m.d = rcos * sy;
			updateTransforms();
		}
		
		public function get rotationX():Number  { return 0 }
		
		public function set rotationX(v:Number):void  {/**/ }
		
		public function get rotationY():Number  { return 0 }
		
		public function set rotationY(v:Number):void  {/**/ }
		
		public function get rotationZ():Number  { return 0 }
		
		public function set rotationZ(v:Number):void  {/**/ }
		
		public function updateTransforms():void
		{
			transform.updateTransforms();
			SpriteFlexjs.dirtyGraphics = true;
		}
		
		public function get alpha():Number  {
			return transform.colorTransform.alphaMultiplier;
		}
		
		public function set alpha(v:Number):void  {
			transform.colorTransform.alphaMultiplier = v;
			transform.updateColorTransforms();
		}
		
		public function get width():Number  { 
			var rect:Rectangle = getRect(this);
			
			var radians:Number = _rotation * (Math.PI / 180);
			rect.width = Math.round((rect.height * Math.abs(Math.sin(radians)) + rect.width * Math.abs(Math.cos(radians))) * 10) / 10;
			
			if (rect) return rect.width;
			return 0;
		}
		
		public function set width(v:Number):void  {/**/ }
		
		public function get height():Number  { 
			var rect:Rectangle = getRect(this);
			
			var radians:Number = _rotation * (Math.PI / 180);
			rect.height = Math.round((rect.height * Math.abs(Math.cos(radians)) + rect.width * Math.abs(Math.sin(radians))) * 10) / 10;
			
			if (rect) return rect.height;
			return 0;
		}
		
		public function set height(v:Number):void  {/**/ }
		
		public function get cacheAsBitmap():Boolean  { return _cacheAsBitmap }
		
		public function set cacheAsBitmap(v:Boolean):void 
		{ 
			_cacheAsBitmap = v;
			if (SpriteFlexjs.wmode.indexOf("gpu") != -1) _cacheAsBitmap = false;
		}
		
		public function get opaqueBackground():Object  { return null }
		
		public function set opaqueBackground(v:Object):void  {/**/ }
		
		public function get scrollRect():Rectangle  { return null }
		
		public function set scrollRect(v:Rectangle):void  {/**/ }
		
		public function get filters():Array  { return _filters; }
		
		public function set filters(v:Array):void
		{
			_filters = v;
			_filterOffsetX = _filterOffsetY = 0;
			for each (var f:BitmapFilter in _filters) 
			{
				_filterOffsetX = Math.max(f.offsetX, _filterOffsetX);
				_filterOffsetY = Math.max(f.offsetY, _filterOffsetY);
			}
		}
		
		public function get blendMode():String  { return _blendMode }
		
		public function set blendMode(v:String):void  { _blendMode = v; }
		
		/*public function get transform():Transform  { return _transform }
		
		public function set transform(v:Transform):void
		{
			_transform = v;
			updateTransforms();
		}*/
		
		public function get scale9Grid():Rectangle  { return null }
		
		public function set scale9Grid(v:Rectangle):void  {/**/ }
		
		public function globalToLocal(v:Point):Point  { 
			return transform.invMatrix.transformPoint(v);
		}
		
		public function localToGlobal(v:Point):Point  { 
			return transform.concatenatedMatrix.transformPoint(v);
		}
		
		public function getBounds(v:DisplayObject):Rectangle
		{ 
			var gfx:Graphics = Object(v).graphics;
			return (gfx && gfx.bound) ? gfx.bound.clone() : new Rectangle();
		}
		
		/**
		 * Use to provide proper bounds when object is rotated, scaled, or has filters applied.  Mainly used for cacheAsBitmap.
		 * @param	v	DisplayObject to get bounds from.
		 * @return		Rectangle of bounds
		 */
		public function getFullBounds(v:DisplayObject):Rectangle 
		{
			var gfx:Graphics = Object(v).graphics;
			var bounds:Rectangle = (gfx && gfx.bound) ? gfx.bound.clone() : new Rectangle();
			
			//trace("Width: " + v.width);
			
			// adjust bounds for rotation
			var rot:Number = (_rotation >= 180) ? _rotation - 180 : _rotation;
			var radians:Number = rot * (Math.PI / 180);
			
			var w:Number = Math.round((bounds.height * Math.abs(Math.sin(radians)) + bounds.width * Math.abs(Math.cos(radians))) * 10) / 10;
			var h:Number = Math.round((bounds.height * Math.abs(Math.cos(radians)) + bounds.width * Math.abs(Math.sin(radians))) * 10) / 10;
			//trace("w: " + w + ", h: " + h);
			// adjust rectangle bigger if needed
			w = (w > bounds.width) ? w - bounds.width : 0;
			h = (h > bounds.height) ? h - bounds.width : 0;
			bounds.inflate(w/2, h/2);
			
			bounds.inflate(filterOffsetX, filterOffsetY);
			
			return bounds;
		}
		
		public function getRect(v:DisplayObject):Rectangle 
		{
			var gfx:Graphics = Object(v).graphics;
			return (gfx && gfx.rect) ? gfx.rect.clone() : new Rectangle();
		}
		
		public function __getRect():Rectangle {
			return null;
		}
		//public function get loaderInfo() : LoaderInfo{return null}
		
		public function hitTestObject(obj:DisplayObject):Boolean
		{
			return false;// this._hitTest(false, 0, 0, false, obj);
		}
		
		public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean
		{
			//var rect:Rectangle = __getRect();
			//if (rect) return rect.containsPoint(globalToLocal(new Point(x,y)));
			return false;
		}
		
		//private function _hitTest(param1:Boolean, param2:Number, param3:Number, param4:Boolean, param5:DisplayObject):Boolean  { return false }
		
		// public function get accessibilityProperties() : AccessibilityProperties;
		
		//  public function set accessibilityProperties(param1:AccessibilityProperties) : void;
		
		public function globalToLocal3D(param1:Point):Vector3D  { return null }
		
		public function local3DToGlobal(param1:Vector3D):Point  { return null }
		
		//public function set blendShader(param1:Shader) : void;
		
		public function get metaData():Object  { return null }
		
		public function set metaData(param1:Object):void  {/**/ }
		
		public function get filterOffsetX():Number { return _filterOffsetX; }
		public function get filterOffsetY():Number { return _filterOffsetY; }
		
		protected function ApplyFilters(ctx:CanvasRenderingContext2D, isText:Boolean = false, shadowsOnly:Boolean = false, noShadows:Boolean = false):void 
		{
			for each (var filter:BitmapFilter in _filters) 
			{
				if (filter is DropShadowFilter && !noShadows)
				{
					var ds:DropShadowFilter = filter as DropShadowFilter;
					ctx.shadowOffsetX = ds.offsetX;
					ctx.shadowOffsetY = ds.offsetY;
					ctx.shadowColor = ds.rgba;
					ctx.shadowBlur = ds.blur;
					
					if (!isText)
					{
						//ctx.stroke();
						ctx.fill();
						// clear the shadow
						ctx.shadowColor = "0";
						ctx.shadowOffsetX = 0; 
						ctx.shadowOffsetY = 0;
						ctx.shadowBlur = 0;
						// restroke w/o the shadow
						ctx.stroke();
					}
				}
				else if (filter is GlowFilter && !shadowsOnly)
				{
					GlowFilter(filter).applyFilter(ctx, this, isText);
				}
			}
		}
		
		public function __update(ctx:CanvasRenderingContext2D):void
		{
			/*if (hasEventListener(Event.ENTER_FRAME))
				dispatchEvent(new Event(Event.ENTER_FRAME));*/
		}
		
		private function __enterFrame(e:Event):void
		{
			if(SpriteFlexjs.dirtyGraphics){
				SpriteFlexjs.dirtyGraphics = false;
				var ctx:CanvasRenderingContext2D = stage.ctx;
				ctx.setTransform(1, 0, 0, 1, 0, 0);
				ctx.clearRect(0, 0, stage.stageWidth, stage.stageHeight);
				SpriteFlexjs.drawCounter = 0;
				SpriteFlexjs.renderer.start(ctx);
				__update(ctx);
				SpriteFlexjs.renderer.finish(ctx);
			}
		}
		
		private function __mouseevent(e:flash.events.MouseEvent):void 
		{
			//从叶子遍历 找到鼠标经过node
			//如果找到向上遍历父级，抛出事件
			var time:Number = getTimer();
			var obj:DisplayObject = __doMouse(e);
			
			time = getTimer();
			if (e.type === MouseEvent.MOUSE_MOVE)
			{
				//如果类型是mousemove 处理mouseover 和 mouseout事件
				//如果上次鼠标经过obj不在obj上层节点
				//递归抛出mouseout事件直到为null或当前节点
				var t:DisplayObject = lastMouseOverObj;
				while (t) {
					if (t == obj) {
						break;
					}else{
						//trace("Mouse Out: " + t.name + ", New Mouse Obj: " + obj.name);
						t.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT,false,false,e.localX,e.localY,null,e.ctrlKey,e.altKey,e.shiftKey,e.buttonDown));
						t.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT,false,false,e.localX,e.localY,null,e.ctrlKey,e.altKey,e.shiftKey,e.buttonDown));
					}
					t = t.parent;
				}
				
				//mouse over
				if(obj && obj != t) {
					var over:MouseEvent = new MouseEvent(MouseEvent.MOUSE_OVER,true,false,e.localX,e.localY,null,e.ctrlKey,e.altKey,e.shiftKey,e.buttonDown);
					var rollover:MouseEvent = new MouseEvent(MouseEvent.ROLL_OVER,true,false,e.localX,e.localY,null,e.ctrlKey,e.altKey,e.shiftKey,e.buttonDown);
					obj.dispatchEvent(over);
					obj.dispatchEvent(rollover);
				}
				
				lastMouseOverObj = obj;
			}
			
			if (obj) obj.dispatchEvent(e);
			
			if (SpriteFlexjs.debug) trace("__dispatchmouseevent", getTimer() - time);
		}
		
		protected function __doMouse(e:flash.events.MouseEvent):DisplayObject {
			return null;
		}
		
		override public function dispatchEvent(event:Event):Boolean 
		{
			var b:Boolean = super.dispatchEvent(event);
			if (event.bubbles && parent) {
				parent.dispatchEvent(event);
			}
			return b;
		}
	}

}