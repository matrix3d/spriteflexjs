package flash.events
{
   public class VideoTextureEvent extends Event
   {
      
      [API("706")]
      public static const RENDER_STATE:String = "renderState";
       
      private var m_status:String;
      
      private var m_colorSpace:String;
      
      [API("706")]
      public const codecInfo:String;
      
      public function VideoTextureEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, status:String = null, colorSpace:String = null)
      {
         super(type,bubbles,cancelable);
         this.m_status = status;
         this.m_colorSpace = colorSpace;
      }
      
      [API("706")]
      public function get status() : String
      {
         return this.m_status;
      }
      
      [API("706")]
      public function get colorSpace() : String
      {
         return this.m_colorSpace;
      }
   }
}
