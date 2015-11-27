package flash.net
{
   public final class URLRequest extends Object
   {
      
      private static const kInvalidParamError:uint = 2004;
      private var _url:String;
      public function URLRequest(url:String = null)
      {
         super();
         if(url != null)
         {
            this.url = url;
         }
         this.requestHeaders = [];
      }
      
      public function get url() : String{
		  return _url;
	  }
      
      public function set url(param1:String) : void{
		  _url = param1;
	  }
      
      public function get data() : Object { return null; }
      
      public function set data(param1:Object) : void{}
      
      public function get method() : String { return null; }
      
      public function set method(value:String) :void
      {
         /*var re:RegExp = new RegExp("^(\\x21|[\\x23-\\x26]|\\x2A|\\x2B|\\x2D|\\x2E|[\\x30-\\x39]|[\\x41-\\x5A]|[\\x5E-\\x7A])+$");
         if(!re.test(value))
         {
            Error.throwError(ArgumentError,kInvalidParamError);
         }
         this.setMethod(value);*/
      }
      
      private function setMethod(param1:String) : void{}
      
      public function get contentType() : String { return null; }
      
      public function set contentType(param1:String) : void{}
      
      public function get requestHeaders() : Array { return null; };
      
      public function set requestHeaders(value:Array) : void
      {
         if(value != null)
         {
            //this.setRequestHeaders(value.filter(this.filterRequestHeaders));
         }
         else
         {
            //this.setRequestHeaders(value);
         }
      }
      
      private function setRequestHeaders(param1:Array) : void{}
      
      private function filterRequestHeaders(item:*, index:int, array:Array) : Boolean
      {
         return true;
      }
      
       public function get digest() : String { return null; }
      
       public function set digest(param1:String) : void{}
      
       public function useRedirectedURL(param1:URLRequest, param2:Boolean = false, param3:* = null, param4:String = null) : void{}
      
      private function shouldFilterHTTPHeader(header:String) : Boolean
      {
         return false;
      }
   }
}
