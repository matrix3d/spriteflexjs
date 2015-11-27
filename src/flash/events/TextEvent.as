package flash.events
{
   public class TextEvent extends Event
   {
      
      public static const LINK:String = "link";
      
      public static const TEXT_INPUT:String = "textInput";
       
      private var m_text:String;
      
      public function TextEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "")
      {
         super(type,bubbles,cancelable);
         this.m_text = text;
      }
      
      public function get text() : String
      {
         return this.m_text;
      }
      
      public function set text(value:String) : void
      {
         this.m_text = value;
      }
      
      override public function clone() : Event
      {
         var te:TextEvent = new TextEvent(type,bubbles,cancelable,this.m_text);
         te.copyNativeData(this);
         return te;
      }
      
      override public function toString() : String
      {
         return formatToString("TextEvent","type","bubbles","cancelable","eventPhase","text");
      }
      
     private function copyNativeData(param1:TextEvent) : void{}
   }
}
