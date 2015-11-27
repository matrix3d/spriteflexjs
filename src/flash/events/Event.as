package flash.events
{
   public class Event extends Object
   {
      
      public static const ACTIVATE:String = "activate";
      
      public static const ADDED:String = "added";
      
      public static const ADDED_TO_STAGE:String = "addedToStage";
      
      public static const BROWSER_ZOOM_CHANGE:String = "browserZoomChange";
      
      public static const CANCEL:String = "cancel";
      
      public static const CHANGE:String = "change";
      
      public static const CLEAR:String = "clear";
      
      public static const CLOSE:String = "close";
      
      public static const COMPLETE:String = "complete";
      
      public static const CONNECT:String = "connect";
      
      public static const COPY:String = "copy";
      
      public static const CUT:String = "cut";
      
      public static const DEACTIVATE:String = "deactivate";
      
      public static const ENTER_FRAME:String = "enterFrame";
      
      public static const FRAME_CONSTRUCTED:String = "frameConstructed";
      
      public static const EXIT_FRAME:String = "exitFrame";
      
      public static const FRAME_LABEL:String = "frameLabel";
      
      public static const ID3:String = "id3";
      
      public static const INIT:String = "init";
      
      public static const MOUSE_LEAVE:String = "mouseLeave";
      
      public static const OPEN:String = "open";
      
      public static const PASTE:String = "paste";
      
      public static const REMOVED:String = "removed";
      
      public static const REMOVED_FROM_STAGE:String = "removedFromStage";
      
      public static const RENDER:String = "render";
      
      public static const RESIZE:String = "resize";
      
      public static const SCROLL:String = "scroll";
      
      public static const TEXT_INTERACTION_MODE_CHANGE:String = "textInteractionModeChange";
      
      public static const SELECT:String = "select";
      
      public static const SELECT_ALL:String = "selectAll";
      
      public static const SOUND_COMPLETE:String = "soundComplete";
      
      public static const TAB_CHILDREN_CHANGE:String = "tabChildrenChange";
      
      public static const TAB_ENABLED_CHANGE:String = "tabEnabledChange";
      
      public static const TAB_INDEX_CHANGE:String = "tabIndexChange";
      
      public static const UNLOAD:String = "unload";
      
      public static const FULLSCREEN:String = "fullScreen";
      
      public static const CONTEXT3D_CREATE:String = "context3DCreate";
      
      public static const TEXTURE_READY:String = "textureReady";
      
      public static const VIDEO_FRAME:String = "videoFrame";
      
      public static const SUSPEND:String = "suspend";
      
      public static const CHANNEL_MESSAGE:String = "channelMessage";
      
      public static const CHANNEL_STATE:String = "channelState";
      
      public static const WORKER_STATE:String = "workerState";
       
	  private var _type:String;
      public function Event(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super();
         this.ctor(type,bubbles,cancelable);
      }
      
      public function formatToString(className:String, ... args) : String
      {
         return null
      }
      
     private function ctor(type:String, bubbles:Boolean, cancelable:Boolean) : void{
		 _type = type;
	 }
      
      public function clone() : Event
      {
         return new Event(this.type,this.bubbles,this.cancelable);
      }
      
      public function toString() : String
      {
         return this.formatToString("Event","type","bubbles","cancelable","eventPhase");
      }
      
     public function get type() : String{return _type}
      
     public function get bubbles() : Boolean{return false}
      
     public function get cancelable() : Boolean{return false}
      
     public var target : Object;
      
     public var currentTarget : Object;
      
     public function get eventPhase() : uint{return 0}
      
     public function stopPropagation() : void{}
      
     public function stopImmediatePropagation() : void{}
      
     public function preventDefault() : void{}
      
     public function isDefaultPrevented() : Boolean{return false}
   }
}
