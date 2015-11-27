package flash.events
{
   public class IOErrorEvent extends ErrorEvent
   {
      
      public static const IO_ERROR:String = "ioError";
      
      [Inspectable(environment="none")]
      public static const NETWORK_ERROR:String = "networkError";
      
      [Inspectable(environment="none")]
      public static const DISK_ERROR:String = "diskError";
      
      [Inspectable(environment="none")]
      public static const VERIFY_ERROR:String = "verifyError";
       
      public function IOErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0)
      {
         super(type,bubbles,cancelable,text,id);
      }
      
      override public function clone() : Event
      {
         return new IOErrorEvent(type,bubbles,cancelable,text,errorID);
      }
      
      override public function toString() : String
      {
         return formatToString("IOErrorEvent","type","bubbles","cancelable","eventPhase","text");
      }
   }
}
