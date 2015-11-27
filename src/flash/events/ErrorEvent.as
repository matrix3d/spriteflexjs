package flash.events
{
   public class ErrorEvent extends TextEvent
   {
      
      public static const ERROR:String = "error";
       
      private var m_errorID:int;
      
      public function ErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0)
      {
         super(type,bubbles,cancelable,text);
         this.m_errorID = id;
      }
      
      [API("667")]
      public function get errorID() : int
      {
         return this.m_errorID;
      }
      
      override public function clone() : Event
      {
         return new ErrorEvent(type,bubbles,cancelable,text,this.m_errorID);
      }
      
      override public function toString() : String
      {
         return formatToString("ErrorEvent","type","bubbles","cancelable","eventPhase","text");
      }
   }
}
