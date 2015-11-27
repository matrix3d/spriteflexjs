package flash.events
{
	import flash.display.Sprite;
   
   public class MouseEvent extends Event
   {
      
      public static const CLICK:String = "click";
      
      public static const DOUBLE_CLICK:String = "doubleClick";
      
      public static const MOUSE_DOWN:String = "mouseDown";
      
      public static const MOUSE_MOVE:String = "mouseMove";
      
      public static const MOUSE_OUT:String = "mouseOut";
      
      public static const MOUSE_OVER:String = "mouseOver";
      
      public static const MOUSE_UP:String = "mouseUp";
      
      public static const RELEASE_OUTSIDE:String = "releaseOutside";
      
      public static const MOUSE_WHEEL:String = "mouseWheel";
      
      public static const ROLL_OUT:String = "rollOut";
      
      public static const ROLL_OVER:String = "rollOver";
      
      public static const MIDDLE_CLICK:String = "middleClick";
      
      public static const MIDDLE_MOUSE_DOWN:String = "middleMouseDown";
      
      public static const MIDDLE_MOUSE_UP:String = "middleMouseUp";
      
      public static const RIGHT_CLICK:String = "rightClick";
      
      public static const RIGHT_MOUSE_DOWN:String = "rightMouseDown";
      
      public static const RIGHT_MOUSE_UP:String = "rightMouseUp";
      
      public static const CONTEXT_MENU:String = "contextMenu";
       
      private var m_relatedObject:Sprite;
      
      private var m_ctrlKey:Boolean;
      
      private var m_altKey:Boolean;
      
      private var m_shiftKey:Boolean;
      
      private var m_buttonDown:Boolean;
      
      private var m_delta:int;
      
      private var m_isRelatedObjectInaccessible:Boolean;
      
      public function MouseEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, localX:Number = undefined, localY:Number = undefined, relatedObject:Sprite = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, delta:int = 0)
      {
         super(type,bubbles,cancelable);
         this.localX = localX;
         this.localY = localY;
         this.m_relatedObject = relatedObject;
         this.m_ctrlKey = ctrlKey;
         this.m_altKey = altKey;
         this.m_shiftKey = shiftKey;
         this.m_buttonDown = buttonDown;
         this.m_delta = delta;
      }
      
      override public function clone() : Event
      {
         return new MouseEvent(type,bubbles,cancelable,this.localX,this.localY,this.m_relatedObject,this.m_ctrlKey,this.m_altKey,this.m_shiftKey,this.m_buttonDown,this.m_delta);
      }
      
      override public function toString() : String
      {
         return formatToString("MouseEvent","type","bubbles","cancelable","eventPhase","localX","localY","stageX","stageY","relatedObject","ctrlKey","altKey","shiftKey","buttonDown","delta");
      }
      
     public function get localX() : Number{return 0}
      
     public function set localX(param1:Number) : void{}
      
     public function get localY() : Number{return 0}
      
     public function set localY(param1:Number) : void{}
      
      public function get relatedObject() : Sprite
      {
         return this.m_relatedObject;
      }
      
      public function set relatedObject(value:Sprite) : void
      {
         this.m_relatedObject = value;
      }
      
      public function get ctrlKey() : Boolean
      {
         return this.m_ctrlKey;
      }
      
      public function set ctrlKey(value:Boolean) : void
      {
         this.m_ctrlKey = value;
      }
      
      public function get altKey() : Boolean
      {
         return this.m_altKey;
      }
      
      public function set altKey(value:Boolean) : void
      {
         this.m_altKey = value;
      }
      
      public function get shiftKey() : Boolean
      {
         return this.m_shiftKey;
      }
      
      public function set shiftKey(value:Boolean) : void
      {
         this.m_shiftKey = value;
      }
      
      public function get buttonDown() : Boolean
      {
         return this.m_buttonDown;
      }
      
      public function set buttonDown(value:Boolean) : void
      {
         this.m_buttonDown = value;
      }
      
      public function get delta() : int
      {
         return this.m_delta;
      }
      
      public function set delta(value:int) : void
      {
         this.m_delta = value;
      }
      
      public function get stageX() : Number
      {
         if(isNaN(this.localX) || isNaN(this.localY))
         {
            return Number.NaN;
         }
         return this.getStageX();
      }
      
      public function get stageY() : Number
      {
         if(isNaN(this.localX) || isNaN(this.localY))
         {
            return Number.NaN;
         }
         return this.getStageY();
      }
      
     public function updateAfterEvent() : void{}
      
     private function getStageX() : Number{return 0}
      
     private function getStageY() : Number{return 0}
      
      public function get isRelatedObjectInaccessible() : Boolean
      {
         return this.m_isRelatedObjectInaccessible;
      }
      
      public function set isRelatedObjectInaccessible(value:Boolean) : void
      {
         this.m_isRelatedObjectInaccessible = value;
      }
      
     public function get movementX() : Number{return 0}
      
     public function set movementX(param1:Number) : void{}
      
     public function get movementY() : Number{return 0}
      
     public function set movementY(param1:Number) : void{}
   }
}
