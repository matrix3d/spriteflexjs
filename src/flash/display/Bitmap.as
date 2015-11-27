package flash.display
{
   public class Bitmap extends DisplayObject
   {
       private var _bitmapData:BitmapData;
      public function Bitmap(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
      {
         super();
         this.ctor(bitmapData,pixelSnapping,smoothing);
      }
      
       private function ctor(bitmapData:BitmapData, pixelSnapping:String, smoothing:Boolean) : void{
		   _bitmapData = bitmapData;
	   }
      
       public function get pixelSnapping() : String{return null}
      
       public function set pixelSnapping(param1:String) : void{}
      
       public function get smoothing() : Boolean{return false}
      
       public function set smoothing(param1:Boolean) : void{}
      
       public function get bitmapData() : BitmapData{return _bitmapData}
      
       public function set bitmapData(param1:BitmapData) : void{}
   }
}
