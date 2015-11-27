package flash.net
{
   import flash.events.*;
   import flash.utils.*;
   
   public class URLLoader extends EventDispatcher
   {
       
      public var data:Object;
      
      public var dataFormat:String = "text";
      
      private var stream:URLStream;
      
      public var bytesLoaded:uint = 0;
      
      public var bytesTotal:uint = 0;
      
      public function URLLoader(request:URLRequest = null)
      {
         super();
         this.stream = new URLStream();
         this.stream.addEventListener(Event.OPEN,this.redirectEvent);
         this.stream.addEventListener(IOErrorEvent.IO_ERROR,this.onComplete);
         this.stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.redirectEvent);
         this.stream.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.redirectEvent);
         this.stream.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         this.stream.addEventListener(Event.COMPLETE,this.onComplete);
         if(request != null)
         {
            this.load(request);
         }
      }
      
      override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         super.addEventListener(type,listener,useCapture,priority,useWeakReference);
         if(type == HTTPStatusEvent.HTTP_RESPONSE_STATUS)
         {
            this.stream.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,this.redirectEvent);
         }
      }
      
      public function load(request:URLRequest) : void
      {
         this.stream.load(request);
      }
      
      public function close() : void
      {
         this.stream.close();
      }
      
      private function redirectEvent(event:Event) : void
      {
         dispatchEvent(event);
      }
      
      private function onComplete(event:Event) : void
      {
         var bytes:ByteArray = new ByteArray();
         this.stream.readBytes(bytes);
         switch(this.dataFormat)
         {
            case "binary":
               this.data = bytes.toString();
               break;
            case "variables":
               if(bytes.length > 0)
               {
                  this.data = new URLVariables(bytes.toString());
                  break;
               }
            case "text":
            case 3:
            default:
               this.data = bytes;
         }
         dispatchEvent(event);
      }
      
      private function onProgress(event:ProgressEvent) : void
      {
         this.bytesLoaded = event.bytesLoaded;
         this.bytesTotal = event.bytesTotal;
         dispatchEvent(event);
      }
   }
}
