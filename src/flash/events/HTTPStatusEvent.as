package flash.events
{
   public class HTTPStatusEvent extends Event
   {
      
      public static const HTTP_STATUS:String = "httpStatus";
      
      public static const HTTP_RESPONSE_STATUS:String = "httpResponseStatus";
       
      private var m_status:int;
      
      private var m_responseHeaders:Array;
      
      private var m_responseUrl:String;
      
      private var m_redirected:Boolean;
      
      public function HTTPStatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, status:int = 0, redirected:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this.m_status = status;
         this.m_redirected = redirected;
         this.m_responseHeaders = [];
      }
      
      override public function clone() : Event
      {
         var result:HTTPStatusEvent = new HTTPStatusEvent(type,bubbles,cancelable,this.status,this.redirected);
         result.responseURL = this.responseURL;
         result.responseHeaders = this.responseHeaders;
         return result;
      }
      
      override public function toString() : String
      {
         return formatToString("HTTPStatusEvent","type","bubbles","cancelable","eventPhase","status","redirected","responseURL");
      }
      
      public function get status() : int
      {
         return this.m_status;
      }
      
      public function get responseURL() : String
      {
         return this.m_responseUrl;
      }
      
      public function set responseURL(value:String) : void
      {
         this.m_responseUrl = value;
      }
      
      public function get responseHeaders() : Array
      {
         return this.m_responseHeaders;
      }
      
      public function set responseHeaders(value:Array) : void
      {
         this.m_responseHeaders = value;
      }
      
      public function get redirected() : Boolean
      {
         return this.m_redirected;
      }
      
      public function set redirected(value:Boolean) : void
      {
         this.m_redirected = value;
      }
   }
}
