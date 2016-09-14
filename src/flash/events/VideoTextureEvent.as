package flash.events
{
   public class VideoTextureEvent extends Event
   {
      
      public static const RENDER_STATE:String = "renderState";
       
      private var m_status:String;
      
      private var m_colorSpace:String;
      
      public var codecInfo:String;
      
      public function VideoTextureEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, status:String = null, colorSpace:String = null)
      {
         super(type,bubbles,cancelable);
         this.m_status = status;
         this.m_colorSpace = colorSpace;
      }
      public function get status() : String
      {
         return this.m_status;
      }
      public function get colorSpace() : String
      {
         return this.m_colorSpace;
      }
   }
}
