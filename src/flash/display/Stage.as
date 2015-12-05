package flash.display
{
   import flash.errors.*;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   
   public class Stage extends EventDispatcher
   {
	   private var _frameRate:int;
	   private var _stage3Ds:Vector.<Stage3D>;
      private static const kInvalidParamError:uint = 2004;
	  private var _canvas:HTMLCanvasElement;
	  private var intervalID:Number;
      public function Stage()
      {
         super();
		 frameRate = 60;
		 _stage3Ds = Vector.<Stage3D>([new Stage3D,new Stage3D,new Stage3D,new Stage3D]);
      }
	  
      
     public function get frameRate() : Number{return _frameRate}
      
     public function set frameRate(v:Number) : void{
		 _frameRate = v;
		 clearInterval(intervalID);
		intervalID= setInterval(update, 1000/v);
	 }
	 
	 private function update():void {
		dispatchEvent(new Event(Event.ENTER_FRAME));
	 }
      
     public function invalidate() : void{}
      
     public function get scaleMode() : String{return null}
      
     public function set scaleMode(param1:String) : void{}
      
     public function get align() : String{return null}
      
     public function set align(param1:String) : void{}
      
     public function get stageWidth() : int{return canvas.width}
      
     public function set stageWidth(param1:int) : void{}
      
     public function get stageHeight() : int{return canvas.height}
      
     public function set stageHeight(param1:int) : void{}
      
     public function get showDefaultContextMenu() : Boolean{return false}
      
     public function set showDefaultContextMenu(param1:Boolean) : void{}
      
      
     public function get colorCorrection() : String{return null}
      
     public function set colorCorrection(param1:String) : void{}
      
     public function get colorCorrectionSupport() : String{return null}
      
     public function isFocusInaccessible() : Boolean{return false}
      
     public function get stageFocusRect() : Boolean{return false}
      
     public function set stageFocusRect(param1:Boolean) : void{}
      
     public function get quality() : String{return null}
      
     public function set quality(param1:String) : void{}
      
     public function get displayState() : String{return null}
      
     public function set displayState(param1:String) : void{}
      
     public function get fullScreenSourceRect() : Rectangle{return null}
      
     public function set fullScreenSourceRect(param1:Rectangle) : void{}
      
     public function get mouseLock() : Boolean{return false}
      
     public function set mouseLock(param1:Boolean) : void{}
      
    // public function get stageVideos() : Vector.<StageVideo>{return null}
      
     public function get stage3Ds() : Vector.<Stage3D>{return _stage3Ds}
      
     public function get color() : uint{return 0}
      
     public function set color(param1:uint) : void{}
      
     public function get fullScreenWidth() : uint{return 0}
      
     public function get fullScreenHeight() : uint{return 0}
      
     public function get wmodeGPU() : Boolean{return false}
      
     public function get softKeyboardRect() : Rectangle{return null}
      
      
     public function get allowsFullScreen() : Boolean{return false}
      
     public function get allowsFullScreenInteractive() : Boolean{return false}
      
      
     public function get contentsScaleFactor() : Number{return 0}
      
     public function get browserZoomFactor() : Number{return 0}
      
     private function requireOwnerPermissions() : void{}
	 
	 public function get canvas():HTMLCanvasElement 
	 {
		 
		if (!_canvas)
		{
			_canvas = document.createElement("canvas") as HTMLCanvasElement;
			_canvas.width = 400;
			_canvas.height = 400;
			_canvas.style.position = "absolute";
			_canvas.style.left = 0;
			_canvas.style.top = 0;
			_canvas.style.zIndex = 1;
			document.body.appendChild(_canvas as HTMLCanvasElement);
		}
		return _canvas;
	 }
	 public function get ctx():CanvasRenderingContext2D 
	 {
		return canvas.getContext("2d") as CanvasRenderingContext2D;
	 }
      
     public function get displayContextInfo() : String{return null}
      
   }
}
