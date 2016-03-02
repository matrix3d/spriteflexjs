package flash.display
{
	import flash.geom.*;
	import flash.utils.ByteArray;
	
	public class BitmapData
	{
		private var data:Uint8ClampedArray;
		//private var data32:Uint32Array;
		private var imageData:ImageData;
		public var image:HTMLCanvasElement;
		private var _lock:Boolean = false;
		private var ctx:CanvasRenderingContext2D;
		private var _transparent:Boolean;
		private var _width:int;
		private var _height:int;
		public function BitmapData(width:int, height:int, transparent:Boolean = true, fillColor:uint = 0xffffffff)
		{
			super();
			this.ctor(width, height, transparent, fillColor);
		}
		
		private function ctor(width:int, height:int, transparent:Boolean = true, fillColor:uint = 0xffffffff):void
		{
			_transparent = transparent;
			image = document.createElement("canvas") as HTMLCanvasElement;
			image.width =_width= width;
			image.height = _height=height;
			ctx = image.getContext("2d") as CanvasRenderingContext2D;
			imageData = ctx.getImageData(0, 0, width, height);
			data = imageData.data;
			//data32 = new Uint32Array(imageData.data);
			fillRect(rect, fillColor);
		}
		
		public function fromImage(img:Object):void {
			ctx.drawImage(img, 0, 0);
			imageData = ctx.getImageData(0, 0, width, height);
			this.data = this.imageData.data;
		}
		
		public function clone():BitmapData  { return null }
		
		public function get width():int  { return _width }
		
		public function get height():int  { return _height }
		
		public function get transparent():Boolean  { return _transparent; }
		
		public function get rect():Rectangle
		{
			return new Rectangle(0, 0, this.width, this.height);
		}
		
		public function getPixel(x:int, y:int):uint  { 
			var p:int = (y * width + x) * 4;
			return (data[p] << 16) | (data[p + 1] << 8) | data[p + 2];
			/*var p:int = y * width + x;
			return data32[p]&0xffffff;*/
		}
		
		public function getPixel32(x:int, y:int):uint  { 
			var p:int = (y * width + x) * 4;
			return (data[p + 3] << 24) | (data[p] << 16) | (data[p + 1] << 8) | data[p + 2];
			/*var p:int = y * width + x;
			return data32[p];*/
		}
		
		public function setPixel(x:int, y:int, color:uint):void  {
			var p:int = (y * width + x) * 4;
			data[p] = (color>>16)&0xff;//r
			data[p + 1] = (color>>8)&0xff;//g
			data[p + 2] = color & 0xff;//b
			/*var p:int = y * width + x;
			data32[p] = 0xff000000 | color;*/
			if (!_lock) {
				ctx.putImageData(imageData,0,0);
			}
		}
		
		public function setPixel32(x:int, y:int, color:uint):void  {
			var p:int = (y * width + x) * 4;
			data[p] = (color>>16)&0xff;//r
			data[p + 1] = (color>>8)&0xff;//g
			data[p + 2] = color&0xff;//b
			data[p + 3] = color >>> 24;//a
			/*var p:int = y * width + x;
			data32[p] = color;*/
			if (!_lock) {
				ctx.putImageData(imageData,0,0);
			}
		}
		
		//native public function applyFilter(param1:BitmapData, param2:Rectangle, param3:Point, param4:BitmapFilter) : void;
		
		public function colorTransform(rect:Rectangle, ct:ColorTransform) : void {
			
		}
		
		public function compare(b:BitmapData):Object  { return null }
		
		public function copyChannel(b:BitmapData, r:Rectangle, p:Point, param4:uint, param5:uint):void  {/**/ }
		
		public function copyPixels(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, alphaBitmapData:BitmapData=null, alphaPoint:Point=null, mergeAlpha:Boolean=false):void  {
			lock();
			for (var x:int = 0; x < sourceRect.width;x++ ) {
				for (var y:int = 0; y < sourceRect.height; y++ ) {
					setPixel32(x+destPoint.x, y+destPoint.y, sourceBitmapData.getPixel32(x+sourceRect.x,y+sourceRect.y));
				}
			}
			unlock();
		}
		
		public function dispose():void  {/**/ }
		
		public function draw(param1:BitmapData, param2:Matrix = null, param3:Object/*ColorTransform*/ = null, param4:String = null, param5:Rectangle = null, param6:Boolean = false):void  {/**/ }
		
		public function drawWithQuality(param1:BitmapData, param2:Matrix = null, param3:Object/*ColorTransform*/ = null, param4:String = null, param5:Rectangle = null, param6:Boolean = false, param7:String = null):void  {/**/ }
		
		public function fillRect(rect:Rectangle, fillColor:uint):void  {
			lock();
			for (var y:int = 0; y < width; ++y) {
				for (var x:int = 0; x < height; ++x) {
					setPixel32(x, y,transparent?fillColor:(0xff000000|fillColor));
				}
			}
			unlock();
		}
		
		public function floodFill(param1:int, param2:int, param3:uint):void  {/**/ }
		
		//native public function generateFilterRect(param1:Rectangle, param2:BitmapFilter) : Rectangle;
		
		public function getColorBoundsRect(param1:uint, param2:uint, param3:Boolean = true):Rectangle  { return null }
		
		public function getPixels(param1:Rectangle):ByteArray  { return null }
		
		public function copyPixelsToByteArray(param1:Rectangle, param2:ByteArray):void  {/**/ }
		
		public function getVector(param1:Rectangle):Vector.<uint>  { return null }
		
		public function hitTest(param1:Point, param2:uint, param3:Object, param4:Point = null, param5:uint = 1):Boolean  { return false }
		
		public function merge(param1:BitmapData, param2:Rectangle, param3:Point, param4:uint, param5:uint, param6:uint, param7:uint):void  {/**/ }
		
		public function noise(randomSeed:int, low:uint=0, high:uint=255, channelOptions:uint=7, grayScale:Boolean=false):void  {
			lock();
			for (var y:int = 0; y < width; ++y) {
				for (var x:int = 0; x < height; ++x) {
					setPixel32(x, y, transparent? (0xffffffff * Math.random()):(0xff000000|0xffffff*Math.random()));
				}
			}
			unlock();
		}
		
		public function paletteMap(param1:BitmapData, param2:Rectangle, param3:Point, param4:Array = null, param5:Array = null, param6:Array = null, param7:Array = null):void  {/**/ }
		
		public function perlinNoise(param1:Number, param2:Number, param3:uint, param4:int, param5:Boolean, param6:Boolean, param7:uint = 7, param8:Boolean = false, param9:Array = null):void  {/**/ }
		
		public function pixelDissolve(param1:BitmapData, param2:Rectangle, param3:Point, param4:int = 0, param5:int = 0, param6:uint = 0):int  { return 0 }
		
		public function scroll(param1:int, param2:int):void  {/**/ }
		
		public function setPixels(param1:Rectangle, param2:ByteArray):void  {/**/ }
		
		public function setVector(param1:Rectangle, param2:Vector.<uint>):void  {/**/ }
		
		public function threshold(param1:BitmapData, param2:Rectangle, param3:Point, param4:String, param5:uint, param6:uint = 0, param7:uint = 4.294967295E9, param8:Boolean = false):uint  { return 0 }
		
		public function lock():void  {
			_lock = true;
		}
		
		public function unlock(param1:Rectangle = null):void  {
			_lock = false;
			ctx.putImageData(imageData, 0, 0);
		}
		
		public function histogram(param1:Rectangle = null):Vector.<Vector.<Number>>  { return null }
		
		public function encode(param1:Rectangle, param2:Object, param3:ByteArray = null):ByteArray  { return null }
	}
}
