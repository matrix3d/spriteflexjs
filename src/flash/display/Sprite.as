package flash.display
{
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   
   public class Sprite extends DisplayObjectContainer
   {
	   private var _graphics:Graphics;
      public function Sprite()
      {
      }
	  
	    public function get graphics() : Graphics {
			if (_graphics == null) {
				_graphics = new Graphics;
				//_graphics.sprite = this;
			}
			return _graphics;
		}
      
       public function get buttonMode() : Boolean{return false}
      
       public function set buttonMode(param1:Boolean) : void{}
      
       public function startDrag(param1:Boolean = false, param2:Rectangle = null) : void{}
      
       public function stopDrag() : void{}
      
       public function startTouchDrag(param1:int, param2:Boolean = false, param3:Rectangle = null) : void{}
      
       public function stopTouchDrag(param1:int) : void{}
      
       public function get dropTarget() : DisplayObject{return null}
      
       public function get hitArea() : Sprite{return null}
      
       public function set hitArea(param1:Sprite) : void{}
      
       public function get useHandCursor() : Boolean{return false}
      
       public function set useHandCursor(param1:Boolean) : void{}
      
       //public function get soundTransform() : SoundTransform;
      
       //public function set soundTransform(param1:SoundTransform) : void;
	   
	   override public function updateJS():void 
	   {
		   super.updateJS();
		   graphics.draw(stage.ctx);
	   }
   }
}
