package flash.display
{
   import flash.geom.Point;
   
   public class DisplayObjectContainer extends InteractiveObject
   {
       private var children:Array = [];
      public function DisplayObjectContainer()
      {
         super();
      }
      
       public function addChild(child:DisplayObject) : DisplayObject {
		   children.push(child);
		   child.stage = stage;
		   child._parent = this;
		   return child;  
		 }
      
       public function addChildAt(child:DisplayObject, param2:int) : DisplayObject{return null}
      
       public function removeChild(child:DisplayObject) : DisplayObject{return null}
      
       public function removeChildAt(child:int) : DisplayObject{return null}
      
       public function getChildIndex(child:DisplayObject) : int{return 0}
      
       public function setChildIndex(child:DisplayObject, index:int) : void{}
      
       public function getChildAt(index:int) : DisplayObject{return null}
      
       public function getChildByName(name:String) : DisplayObject{return null}
      
       public function get numChildren() : int{return 0}
      
      // public function get textSnapshot() : TextSnapshot;
      
       public function getObjectsUnderPoint(p:Point) : Array{return null}
      
       public function areInaccessibleObjectsUnderPoint(p:Point) : Boolean{return false}
      
       public function get tabChildren() : Boolean{return false}
      
       public function set tabChildren(v:Boolean) : void{}
      
       public function get mouseChildren() : Boolean{return false}
      
       public function set mouseChildren(v:Boolean) : void{}
      
       public function contains(child:DisplayObject) : Boolean{return false}
      
       public function swapChildrenAt(param1:int, param2:int) : void{}
      
       public function swapChildren(param1:DisplayObject, param2:DisplayObject) : void{}
      
       public function removeChildren(param1:int = 0, param2:int = 2147483647) : void{}
      
       public function stopAllMovieClips() : void {}
	  
	   override public function innerUpdate():void 
	   {
		   super.innerUpdate();
			for each(var c:DisplayObject in children) {
				c.innerUpdate();
			}
	   }
	   
	   override public function updateTransforms():void 
	   {
		   super.updateTransforms();
		   for each(var c:DisplayObject in children) {
			   c.updateTransforms();
		   }
	   }
   }
}
