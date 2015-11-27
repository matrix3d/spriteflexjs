package flash.display
{
   import flash.geom.Rectangle;
   import flash.errors.*;
   import flash.geom.Transform;
   import flash.accessibility.AccessibilityProperties;
   import flash.accessibility.AccessibilityImplementation;
   import flash.events.Event;
   import flash.text.TextSnapshot;
   import flash.ui.ContextMenu;
   
   public class Stage extends DisplayObject
   {
      
      private static const kInvalidParamError:uint = 2004;
       
      public function Stage()
      {
         super();
      }
      
     public function get frameRate() : Number{return 0}
      
     public function set frameRate(param1:Number) : void{}
      
     public function invalidate() : void{}
      
     public function get scaleMode() : String{return null}
      
     public function set scaleMode(param1:String) : void{}
      
     public function get align() : String{return null}
      
     public function set align(param1:String) : void{}
      
     public function get stageWidth() : int{return 0}
      
     public function set stageWidth(param1:int) : void{}
      
     public function get stageHeight() : int{return 0}
      
     public function set stageHeight(param1:int) : void{}
      
     public function get showDefaultContextMenu() : Boolean{return false}
      
     public function set showDefaultContextMenu(param1:Boolean) : void{}
      
      
     public function get colorCorrection() : String{return null}
      
     public function set colorCorrection(param1:String) : void{}
      
     public function get colorCorrectionSupport() : String{return null}
      
     public function isFocusInaccessible() : Boolean{return false}
      
     public function get stageFocusRect() : Boolean{return false}
      
     public function set stageFocusRect(param1:Boolean) : void{}
      
     public function get quality() : String{return null}
      
     public function set quality(param1:String) : void{}
      
     public function get displayState() : String{return null}
      
     public function set displayState(param1:String) : void{}
      
     public function get fullScreenSourceRect() : Rectangle{return null}
      
     public function set fullScreenSourceRect(param1:Rectangle) : void{}
      
     public function get mouseLock() : Boolean{return false}
      
     public function set mouseLock(param1:Boolean) : void{}
      
    // public function get stageVideos() : Vector.<StageVideo>{return null}
      
     public function get stage3Ds() : Vector.<Stage3D>{return null}
      
     public function get color() : uint{return 0}
      
     public function set color(param1:uint) : void{}
      
     public function get fullScreenWidth() : uint{return 0}
      
     public function get fullScreenHeight() : uint{return 0}
      
     public function get wmodeGPU() : Boolean{return false}
      
     public function get softKeyboardRect() : Rectangle{return null}
      
      
     public function get allowsFullScreen() : Boolean{return false}
      
     public function get allowsFullScreenInteractive() : Boolean{return false}
      
      
     public function get contentsScaleFactor() : Number{return 0}
      
     public function get browserZoomFactor() : Number{return 0}
      
     private function requireOwnerPermissions() : void{}
      
     public function get displayContextInfo() : String{return null}
      
   }
}
