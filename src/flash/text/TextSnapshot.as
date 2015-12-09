package flash.text
{
   [native(instance="TextSnapshotObject",methods="auto",cls="TextSnapshotClass",construct="native")]
   public class TextSnapshot extends Object
   {
       
      public function TextSnapshot()
      {
         super();
      }
      
      native public function findText(param1:int, param2:String, param3:Boolean) : int;
      
      native public function get charCount() : int;
      
      native public function getSelected(param1:int, param2:int) : Boolean;
      
      native public function getSelectedText(param1:Boolean = false) : String;
      
      native public function getText(param1:int, param2:int, param3:Boolean = false) : String;
      
      native public function getTextRunInfo(param1:int, param2:int) : Array;
      
      native public function hitTestTextNearPos(param1:Number, param2:Number, param3:Number = 0) : Number;
      
      native public function setSelectColor(param1:uint = 16776960) : void;
      
      native public function setSelected(param1:int, param2:int, param3:Boolean) : void;
   }
}
