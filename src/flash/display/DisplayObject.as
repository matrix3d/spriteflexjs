package flash.display
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author lizhi
	 */
	public class DisplayObject extends EventDispatcher
	{
		private static var ID:int = 0;
		public var innerID:int;
		private var _name:String;
		private var _stage:Stage;
		private var _rotation:Number = 0;
		private var rsin:Number = 0;
		private var rcos:Number = 1;
		private var _transform:Transform;
		private var dirty:Boolean = true;
		private var _worldMatrix:Matrix;
		private var invDirty:Boolean = true;
		private var _invMatrix:Matrix;
		public var _parent:DisplayObject;
		private var _alpha:Number = 1;
		private var _visible:Boolean = true;
		private var lastMouseOverObj:DisplayObject;
		public function DisplayObject()
		{
			_transform = new Transform(this);
			_worldMatrix = new Matrix;
			_invMatrix = new Matrix;
			innerID = ID++;
			name = "instance" + innerID;
			if (innerID == 0)
			{
				_stage = new Stage;
				_stage.addEventListener(Event.ENTER_FRAME, __enterFrame);
				_stage.addEventListener(MouseEvent.CLICK, __mouseevent);
				_stage.addEventListener(MouseEvent.CONTEXT_MENU, __mouseevent);
				_stage.addEventListener(MouseEvent.DOUBLE_CLICK, __mouseevent);
				_stage.addEventListener(MouseEvent.MOUSE_DOWN, __mouseevent);
				_stage.addEventListener(MouseEvent.MOUSE_MOVE, __mouseevent);
				_stage.addEventListener(MouseEvent.MOUSE_UP, __mouseevent);
			}
		}
		
		public function get stage():Stage  { return _stage; }
		
		public function set stage(v:Stage):void  { _stage = v; }
		
		public function get root():DisplayObject  { return null }
		
		public function get name():String  { return _name; }
		
		public function set name(v:String):void  {
			_name = v;
		}
		
		public function get parent():DisplayObject/*DisplayObjectContainer*/  { return _parent; }
		
		public function get mask():DisplayObject  { return null }
		
		public function set mask(param1:DisplayObject):void  {/**/ }
		
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
			if (m.b == 0) return m.a;
			return Math.sqrt(m.a * m.a + m.b * m.b);
		}
		
		public function set scaleX(v:Number):void
		{
			var m:Matrix = transform.matrix;
			if (m.c == 0)
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
			if (m.c == 0)
			{
				return m.d;
			}
			return Math.sqrt(m.c * m.c + m.d * m.d);
		}
		
		public function set scaleY(v:Number):void
		{
			var m:Matrix = transform.matrix;
			if (m.c == 0)
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
			return invMatrix.transformPoint(new Point(stage.mouseX, stage.mouseY)).x;
			return 0;
		}
		
		public function get mouseY():Number  { 
			if(stage)
			return invMatrix.transformPoint(new Point(stage.mouseX, stage.mouseY)).y;
			return 0;
		}
		
		public function get rotation():Number  { return _rotation }
		
		public function set rotation(v:Number):void
		{
			_rotation = v;
			var m:Matrix = transform.matrix;
			var r:Number = v * Math.PI / 180;
			rsin = Math.sin(r);
			rcos = Math.cos(r);
			var sx:Number = scaleX;
			var sy:Number = scaleY;
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
		
		public function get alpha():Number  { return _alpha; }
		
		public function set alpha(v:Number):void  { _alpha = v; }
		
		public function get width():Number  { return 0 }
		
		public function set width(v:Number):void  {/**/ }
		
		public function get height():Number  { return 0 }
		
		public function set height(v:Number):void  {/**/ }
		
		public function get cacheAsBitmap():Boolean  { return false }
		
		public function set cacheAsBitmap(v:Boolean):void  {/**/ }
		
		public function get opaqueBackground():Object  { return null }
		
		public function set opaqueBackground(v:Object):void  {/**/ }
		
		public function get scrollRect():Rectangle  { return null }
		
		public function set scrollRect(v:Rectangle):void  {/**/ }
		
		public function get filters():Array  { return null }
		
		public function set filters(v:Array):void  {/**/ }
		
		public function get blendMode():String  { return null }
		
		public function set blendMode(v:String):void  {/**/ }
		
		public function get transform():Transform  { return _transform }
		
		public function set transform(v:Transform):void
		{
			_transform = v;
			updateTransforms();
		}
		
		public function get worldMatrix():Matrix
		{
			if (dirty)
			{
				_worldMatrix.copyFrom(transform.matrix);
				if (parent)
				{
					_worldMatrix.concat(parent.worldMatrix);
				}
				dirty = false;
			}
			return _worldMatrix;
		}
		
		public function get invMatrix():Matrix
		{
			if (invDirty)
			{
				_invMatrix.copyFrom(worldMatrix);
				_invMatrix.invert();
				invDirty = false;
			}
			return _invMatrix;
		}
		
		public function updateTransforms():void
		{
			dirty = true;
			invDirty = true;
		}
		
		public function get scale9Grid():Rectangle  { return null }
		
		public function set scale9Grid(v:Rectangle):void  {/**/ }
		
		public function globalToLocal(v:Point):Point  { return null }
		
		public function localToGlobal(v:Point):Point  { return null }
		
		public function getBounds(v:DisplayObject):Rectangle  { return null }
		
		public function getRect(param1:DisplayObject):Rectangle  { return null }
		
		//public function get loaderInfo() : LoaderInfo{return null}
		
		public function hitTestObject(obj:DisplayObject):Boolean
		{
			return false;// this._hitTest(false, 0, 0, false, obj);
		}
		
		public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean
		{
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
		
		public function __update():void
		{
			if (hasEventListener(Event.ENTER_FRAME))
				dispatchEvent(new Event(Event.ENTER_FRAME));
		}
		
		private function __enterFrame(e:Event):void
		{
			var ctx:CanvasRenderingContext2D = stage.ctx;
			ctx.globalAlpha = 1;
			ctx.setTransform(1, 0, 0, 1, 0, 0);
			ctx.clearRect(0, 0, stage.stageWidth, stage.stageHeight);
			__update();
		}
		
		private function __mouseevent(e:flash.events.MouseEvent):void 
		{
			//从叶子遍历 找到鼠标经过node
			//如果找到向上遍历父级，抛出事件
			var obj:DisplayObject = __doMouse(e);
			if (e.type==MouseEvent.MOUSE_MOVE) {
				//如果类型是mousemove 处理mouseover 和 mouseout事件
				//如果上次鼠标经过obj不在obj上层节点
				//递归抛出mouseout事件直到为null或当前节点
				if (lastMouseOverObj) {
					var isSendMouseOut:Boolean = false;
					var t:DisplayObject = obj;
					while (t) {
						if (t==lastMouseOverObj) {
							isSendMouseOut = true;
							break;
						}
						t = t.parent;
					}
					if (!isSendMouseOut) {
						var out:MouseEvent = new MouseEvent(MouseEvent.MOUSE_OUT);
						t = lastMouseOverObj;
						while (t) {
							t.dispatchEvent(out);
							t = t.parent;
						}
					}
				}
				
				//mouse over
				var t2:DisplayObject = obj;
				var over:MouseEvent = new MouseEvent(MouseEvent.MOUSE_OVER);
				while (t2 && t2 != t) {
					t2.dispatchEvent(over);
					t2 = t2.parent;
				}
				lastMouseOverObj = obj;
			}
			while (obj) {
				obj.dispatchEvent(e);
				obj = obj.parent;
			}
		}
		
		protected function __doMouse(e:flash.events.MouseEvent):DisplayObject {
			return null;
		}
	}

}