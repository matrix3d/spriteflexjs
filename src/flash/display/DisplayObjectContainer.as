package flash.display
{
   import flash.geom.Point;
   
   public class DisplayObjectContainer extends InteractiveObject
   {
       
      public function DisplayObjectContainer()
      {
         super();
      }
      
       public function addChild(param1:DisplayObject) : DisplayObject{return null}
      
       public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject{return null}
      
       public function removeChild(param1:DisplayObject) : DisplayObject{return null}
      
       public function removeChildAt(param1:int) : DisplayObject{return null}
      
       public function getChildIndex(param1:DisplayObject) : int{return 0}
      
       public function setChildIndex(param1:DisplayObject, param2:int) : void{}
      
       public function getChildAt(param1:int) : DisplayObject{return null}
      
       public function getChildByName(param1:String) : DisplayObject{return null}
      
       public function get numChildren() : int{return 0}
      
      // public function get textSnapshot() : TextSnapshot;
      
       public function getObjectsUnderPoint(param1:Point) : Array{return null}
      
       public function areInaccessibleObjectsUnderPoint(param1:Point) : Boolean{return false}
      
       public function get tabChildren() : Boolean{return false}
      
       public function set tabChildren(param1:Boolean) : void{}
      
       public function get mouseChildren() : Boolean{return false}
      
       public function set mouseChildren(param1:Boolean) : void{}
      
       public function contains(param1:DisplayObject) : Boolean{return false}
      
       public function swapChildrenAt(param1:int, param2:int) : void{}
      
       public function swapChildren(param1:DisplayObject, param2:DisplayObject) : void{}
      
       public function removeChildren(param1:int = 0, param2:int = 2147483647) : void{}
      
       public function stopAllMovieClips() : void{}
   }
}
