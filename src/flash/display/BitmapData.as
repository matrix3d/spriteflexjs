package flash.display
{
   import flash.geom.*;
   import flash.utils.ByteArray;
   
   public class BitmapData
   {
	   public var image:Image;
       private var _width:int;
	   private var _height:int;
      public function BitmapData(width:int, height:int, transparent:Boolean = true, fillColor:uint = 4.294967295E9)
      {
         super();
         this.ctor(width,height,transparent,fillColor);
      }
      
     private function ctor(width:int, height:int, transparent:Boolean = true, fillColor:uint = 4.294967295E9) : void{
		 _width = width;
		 _height = height;
	 }
      
     public function clone() : BitmapData{return null}
      
     public function get width() : int{return _width}
      
     public function get height() : int{return _height}
      
     public function get transparent() : Boolean{return true}
      
      public function get rect() : Rectangle
      {
         return new Rectangle(0,0,this.width,this.height);
      }
      
     public function getPixel(param1:int, param2:int) : uint{return 0}
      
     public function getPixel32(param1:int, param2:int) : uint{return 0}
      
     public function setPixel(param1:int, param2:int, param3:uint) : void{}
      
     public function setPixel32(param1:int, param2:int, param3:uint) : void{}
      
      //native public function applyFilter(param1:BitmapData, param2:Rectangle, param3:Point, param4:BitmapFilter) : void;
      
      //native public function colorTransform(param1:Rectangle, param2:ColorTransform) : void;
      
     public function compare(param1:BitmapData) : Object{return null}
      
     public function copyChannel(param1:BitmapData, param2:Rectangle, param3:Point, param4:uint, param5:uint) : void{}
      
     public function copyPixels(param1:BitmapData, param2:Rectangle, param3:Point, param4:BitmapData = null, param5:Point = null, param6:Boolean = false) : void{}
      
     public function dispose() : void{}
      
     public function draw(param1:BitmapData, param2:Matrix = null, param3:Object/*ColorTransform*/ = null, param4:String = null, param5:Rectangle = null, param6:Boolean = false) : void{}
      
     public function drawWithQuality(param1:BitmapData, param2:Matrix = null, param3:Object/*ColorTransform*/ = null, param4:String = null, param5:Rectangle = null, param6:Boolean = false, param7:String = null) : void{}
      
     public function fillRect(param1:Rectangle, param2:uint) : void{}
      
     public function floodFill(param1:int, param2:int, param3:uint) : void{}
      
      //native public function generateFilterRect(param1:Rectangle, param2:BitmapFilter) : Rectangle;
      
     public function getColorBoundsRect(param1:uint, param2:uint, param3:Boolean = true) : Rectangle{return null}
      
     public function getPixels(param1:Rectangle) : ByteArray{return null}
      
     public function copyPixelsToByteArray(param1:Rectangle, param2:ByteArray) : void{}
      
     public function getVector(param1:Rectangle) : Vector.<uint>{return null}
      
     public function hitTest(param1:Point, param2:uint, param3:Object, param4:Point = null, param5:uint = 1) : Boolean{return false}
      
     public function merge(param1:BitmapData, param2:Rectangle, param3:Point, param4:uint, param5:uint, param6:uint, param7:uint) : void{}
      
     public function noise(param1:int, param2:uint = 0, param3:uint = 255, param4:uint = 7, param5:Boolean = false) : void{}
      
     public function paletteMap(param1:BitmapData, param2:Rectangle, param3:Point, param4:Array = null, param5:Array = null, param6:Array = null, param7:Array = null) : void{}
      
     public function perlinNoise(param1:Number, param2:Number, param3:uint, param4:int, param5:Boolean, param6:Boolean, param7:uint = 7, param8:Boolean = false, param9:Array = null) : void{}
      
     public function pixelDissolve(param1:BitmapData, param2:Rectangle, param3:Point, param4:int = 0, param5:int = 0, param6:uint = 0) : int{return 0}
      
     public function scroll(param1:int, param2:int) : void{}
      
     public function setPixels(param1:Rectangle, param2:ByteArray) : void{}
      
     public function setVector(param1:Rectangle, param2:Vector.<uint>) : void{}
      
     public function threshold(param1:BitmapData, param2:Rectangle, param3:Point, param4:String, param5:uint, param6:uint = 0, param7:uint = 4.294967295E9, param8:Boolean = false) : uint{return 0}
      
     public function lock() : void{}
      
     public function unlock(param1:Rectangle = null) : void{}
      
     public function histogram(param1:Rectangle = null) : Vector.<Vector.<Number>>{return null}
      
     public function encode(param1:Rectangle, param2:Object, param3:ByteArray = null) : ByteArray{return null}
   }
}
