package flash.events
{
   public class SecurityErrorEvent extends ErrorEvent
   {
      
      public static const SECURITY_ERROR:String = "securityError";
       
      public function SecurityErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0)
      {
         super(type,bubbles,cancelable,text,id);
      }
      
      override public function clone() : Event
      {
         return new SecurityErrorEvent(type,bubbles,cancelable,text,errorID);
      }
      
      override public function toString() : String
      {
         return formatToString("SecurityErrorEvent","type","bubbles","cancelable","eventPhase","text");
      }
   }
}
