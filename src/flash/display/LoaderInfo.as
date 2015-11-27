package flash.display
{
   import flash.system.ApplicationDomain;
   import flash.errors.*;
   import flash.utils.ByteArray;
   import flash.events.*;
   
   public class LoaderInfo extends EventDispatcher
   {
	   private var _content:Bitmap;
      public function LoaderInfo()
      {
         super();
      }
      
       public static function getLoaderInfoByDefinition(param1:Object) : LoaderInfo{return null;}
      
       public function get loaderURL() : String { return null; }
      
       public function get url() : String{return null}
      
       public function get isURLInaccessible() : Boolean{return false}
      
       public function get bytesLoaded() : uint { return 0; }
      
       public function get bytesTotal() : uint { return 0; }
      
       //public function get applicationDomain() : ApplicationDomain;
      
       public function get swfVersion() : uint { return 0; }
      
       public function get actionScriptVersion() : uint { return 0; }
      
       public function get frameRate() : Number { return 0; }
      
      public function get parameters() : Object
      {
         var k:String = null;
         var args:Object = this._getArgs();
         var rtn:Object = {};
         for(k in args)
         {
            rtn[k] = args[k];
         }
         return rtn;
      }
      
       public function get width() : int { return 0; }
      
       public function get height() : int { return 0; }
      
       public function get contentType() : String { return null; }
      
       public function get sharedEvents() : EventDispatcher { return null; }
      
       public function get parentSandboxBridge() : Object { return null; }
      
       public function set parentSandboxBridge(param1:Object) : void{}
      
       public function get childSandboxBridge() : Object { return null; }
      
       public function set childSandboxBridge(param1:Object) : void{}
      
      
       public function get sameDomain() : Boolean { return false; }
      
       public function get childAllowsParent() : Boolean { return false; }
      
       public function get parentAllowsChild() : Boolean{return false}
      
       public function get loader() : Loader{return null}
      
       public function set content(bmp:Bitmap) : void { _content = bmp; }
       public function get content() : Bitmap { return _content; }
      
       public function get bytes() : ByteArray{return null}
      
       private function _getArgs() : Object{return null}
      
      /*public function get uncaughtErrorEvents() : UncaughtErrorEvents
      {
         var _uncaughtErrorEvents:UncaughtErrorEvents = this._getUncaughtErrorEvents();
         if(!_uncaughtErrorEvents)
         {
            _uncaughtErrorEvents = new UncaughtErrorEvents();
            this._setUncaughtErrorEvents(_uncaughtErrorEvents);
         }
         return _uncaughtErrorEvents;
      }
      
      native private function _getUncaughtErrorEvents() : UncaughtErrorEvents;
      
      native private function _setUncaughtErrorEvents(param1:UncaughtErrorEvents) : void;*/
   }
}
