package flash.display
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class DisplayObjectContainer extends InteractiveObject
	{
		private var children:Array = [];
		private var _mouseChildren:Boolean = true;
		public function DisplayObjectContainer()
		{
			super();
		}
		
		public function addChild(child:DisplayObject):DisplayObject
		{
			return addChildAt(child,children.length);
		}
		
		public function addChildAt(child:DisplayObject, index:int):DisplayObject  {
			children.splice(index,0,child);
			child.stage = stage;
			child._parent = this;
			return child;
		}
		
		public function removeChild(child:DisplayObject):DisplayObject  { return null }
		
		public function removeChildAt(child:int):DisplayObject  { return null }
		
		public function getChildIndex(child:DisplayObject):int  { return 0 }
		
		public function setChildIndex(child:DisplayObject, index:int):void  {/**/ }
		
		public function getChildAt(index:int):DisplayObject  { return children[index]; }
		
		public function getChildByName(name:String):DisplayObject  { return null }
		
		public function get numChildren():int  { return children.length; }
		
		// public function get textSnapshot() : TextSnapshot;
		
		public function getObjectsUnderPoint(p:Point):Array  { return null }
		
		public function areInaccessibleObjectsUnderPoint(p:Point):Boolean  { return false }
		
		public function get tabChildren():Boolean  { return false }
		
		public function set tabChildren(v:Boolean):void  {/**/ }
		
		public function get mouseChildren():Boolean  { return _mouseChildren; }
		
		public function set mouseChildren(v:Boolean):void  { _mouseChildren = v; }
		
		public function contains(child:DisplayObject):Boolean  { 
			return children.indexOf(child) != -1;
		}
		
		public function swapChildrenAt(param1:int, param2:int):void  {/**/ }
		
		public function swapChildren(param1:DisplayObject, param2:DisplayObject):void  {/**/ }
		
		public function removeChildren(param1:int = 0, param2:int = 2147483647):void  {/**/ }
		
		public function stopAllMovieClips():void
		{
		
		}
		
		override public function __update():void
		{
			super.__update();
			for each (var c:DisplayObject in children)
			{
				c.__update();
			}
		}
		
		override public function updateTransforms():void
		{
			super.updateTransforms();
			for each (var c:DisplayObject in children)
			{
				c.updateTransforms();
			}
		}
		
		override protected function __doMouse(e:flash.events.MouseEvent):DisplayObject 
		{
			if (mouseEnabled&&mouseChildren) {
				for (var i:int = children.length - 1; i >= 0; i-- ) {
					var obj:DisplayObject = children[i].__doMouse(e);
					if (obj) {
						return obj;
					}
				}
			}
			return null;
		}
	}
}
