package flash.display
{
	import flash.geom.*;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author lizhi http://matrix3d.github.io/
	 */
	public class BitmapData  implements IBitmapDrawable
	{
		public var __data:Uint8ClampedArray;
		//private var data32:Uint32Array;
		private var imageData:ImageData;
		public var image:HTMLCanvasElement;
		private var _lock:Boolean = false;
		public var ctx:CanvasRenderingContext2D;
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
			__data = imageData.data;
			//data32 = new Uint32Array(imageData.data);
			fillRect(rect, fillColor);
		}
		
		public function fromImage(img:Object,dx:Number=0,dy:Number=0,opt_dw:Number=0,opt_dy:Number=0):void {
			ctx.drawImage(img, dx, dy);
			SpriteFlexjs.dirtyGraphics = true;
			imageData = ctx.getImageData(0, 0, width, height);
			this.__data = this.imageData.data;
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
			return (__data[p] << 16) | (__data[p + 1] << 8) | __data[p + 2];
			/*var p:int = y * width + x;
			return data32[p]&0xffffff;*/
		}
		
		public function getPixel32(x:int, y:int):uint  { 
			var p:int = (y * width + x) * 4;
			return (__data[p + 3] << 24) | (__data[p] << 16) | (__data[p + 1] << 8) | __data[p + 2];
			/*var p:int = y * width + x;
			return data32[p];*/
		}
		
		public function setPixel(x:int, y:int, color:uint):void  {
			var p:int = (y * width + x) * 4;
			__data[p] = (color>>16)&0xff;//r
			__data[p + 1] = (color>>8)&0xff;//g
			__data[p + 2] = color & 0xff;//b
			/*var p:int = y * width + x;
			data32[p] = 0xff000000 | color;*/
			if (!_lock) {
				ctx.putImageData(imageData, 0, 0);
				SpriteFlexjs.dirtyGraphics = true;
			}
		}
		
		public function setPixel32(x:int, y:int, color:uint):void  {
			var p:int = (y * width + x) * 4;
			__data[p] = (color>>16)&0xff;//r
			__data[p + 1] = (color>>8)&0xff;//g
			__data[p + 2] = color&0xff;//b
			__data[p + 3] = color >>> 24;//a
			/*var p:int = y * width + x;
			data32[p] = color;*/
			if (!_lock) {
				ctx.putImageData(imageData,0,0);
				SpriteFlexjs.dirtyGraphics = true;
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
		
		public function draw(source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false):void  {
			drawWithQuality(source, matrix, colorTransform, blendMode, clipRect, smoothing);
		}
		
		public function drawWithQuality(source:IBitmapDrawable, matrix:Matrix=null, colorTransform:ColorTransform=null, blendMode:String=null, clipRect:Rectangle=null, smoothing:Boolean=false, quality:String=null):void  {
			if (source is BitmapData){
				var bmd:BitmapData = source as BitmapData;
				fromImage(bmd.ctx);
			}/*else if(source is TextField){
				var tf:TextField = source as TextField;
				tf.__draw(ctx,matrix);
			}else if (source is Sprite){
				var sp:Sprite = source as Sprite;
				sp.graphics.draw(ctx, sp.worldMatrix, 1, sp.blendMode, sp.transform.colorTransform);
			}else if (source is Shape){
				var sha:Shape = source as Shape;
				sha.graphics.draw(ctx, sha.worldMatrix, 1, sha.blendMode, sha.transform.colorTransform);
			}*/
		}
		
		public function fillRect(rect:Rectangle, fillColor:uint):void  {
			lock();
			for (var y:int = 0; y < height; ++y) {
				for (var x:int = 0; x < width; ++x) {
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
			for (var y:int = 0; y < height; ++y) {
				for (var x:int = 0; x < width; ++x) {
					setPixel32(x, y, 0xff000000|0xffffff*Math.random());
				}
			}
			unlock();
		}
		
		public function paletteMap(param1:BitmapData, param2:Rectangle, param3:Point, param4:Array = null, param5:Array = null, param6:Array = null, param7:Array = null):void  {/**/ }
		
		private static var perm:Array = [151,160,137,91,90,15,
  131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
  190,6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
  88,237,149,56,87,174,20,125,136,171,168,68,175,74,165,71,134,139,48,27,166,
  77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
  102,143,54,65,25,63,161,1,216,80,73,209,76,132,187,208,89,18,169,200,196,
  135,130,116,188,159,86,164,100,109,198,173,186,3,64,52,217,226,250,124,123,
  5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
  223,183,170,213,119,248,152,2,44,154,163,70,221,153,101,155,167,43,172,9,
  129,22,39,253,19,98,108,110,79,113,224,232,178,185,112,104,218,246,97,228,
  251,34,242,193,238,210,144,12,191,179,162,241,81,51,145,235,249,14,239,107,
  49,192,214,31,181,199,106,157,184,84,204,176,115,121,50,45,127,4,150,254,
  138, 236, 205, 93, 222, 114, 67, 29, 24, 72, 243, 141, 128, 195, 78, 66, 215, 61, 156, 180];
		//https://zh.wikipedia.org/zh-hans/Perlin%E5%99%AA%E5%A3%B0
		public function perlinNoise(baseX:Number, baseY:Number, numOctaves:uint, randomSeed:int, stitch:Boolean, fractalNoise:Boolean, channelOptions:uint = 7, grayScale:Boolean = false, offsets:Array = null):void  {
			var bw:int = width;
			var bh:int = height;
			if(!_lock){
				var nowlock:Boolean = _lock;
				lock();
			}
			fillRect(rect, 0xff000000);
			var chs:Array = [];// [[0, 0], [1, grayScale?0:5], [2, grayScale?0:10]];
			if (channelOptions&BitmapDataChannel.RED){
				chs.push([0, randomSeed]);
			}
			if (channelOptions&BitmapDataChannel.GREEN){
				chs.push([1, randomSeed+(grayScale?0:5)]);
			}
			if (channelOptions&BitmapDataChannel.BLUE){
				chs.push([2, randomSeed+(grayScale?0:10)]);
			}
			var chlen:int = chs.length;
			var octaves:int = numOctaves;
			var totalAmplitude:Number = 0;
			var amplitude:Number = 1;
			var baseXB:Number = baseX;
			var baseYB:Number = baseY;
			var persistance:Number = 0.6;
			while (true){
				totalAmplitude+= amplitude;
				baseX = int(baseX);
				baseY = int(baseY);
				if (octaves<=0||baseX<=1||baseY<=1){
					break;
				}
				amplitude *= persistance;
				octaves--;
				baseX /= 2;
				baseY /= 2;
			}
			baseX = baseXB;
			baseY = baseYB;
			amplitude = 1;
			octaves = numOctaves;
			while (true){
				baseX = int(baseX);
				baseY = int(baseY);
				if (octaves<=0||baseX<=1||baseY<=1){
					break;
				}
				var offsetX:int = 0;
				var offsetY:int = 0;
				if (offsets){
					var offset:Point = offsets[numOctaves - octaves] as Point;
					if (offset){
						offsetX = int(offset.x/16);
						offsetY = int(offset.y/16);
					}
				}
				var nx:int = Math.ceil(bw/baseX);
				var ny:int = Math.ceil(bh / baseY);
				for (var y:int = 0; y <=ny; y++ ){
					for (var x:int = 0; x <= nx; x++ ){
						if (x != 0 && y != 0){
							for (var i:int = 0; i < chlen; i++ ){
								var chci:int = chs[i][0];
								var chpi:int = chs[i][1];
								var r00:Number = perm[((x-1+chpi+offsetX) % 16) + ((y-1+chpi+offsetY) % 16) * 16];
								var r10:Number = perm[((x+chpi+offsetX) % 16) + ((y-1+chpi+offsetY) % 16) * 16];
								var r01:Number = perm[((x-1+chpi+offsetX) % 16) + ((y+chpi+offsetY) % 16) * 16];
								var r11:Number = perm[((x+chpi+offsetX) % 16) + ((y+chpi+offsetY) % 16) * 16];
								var w:Number = x * baseX;
								if (w>bw){
									w = bw;
								}
								var h:Number = y * baseY;
								if (h>bh){
									h = bh;
								}
								var sx:int = (x - 1) * baseX;
								var sy:int = (y - 1) * baseY;
								for (var bx:int = sx; bx < w;bx++ ){
									var tx:Number = (bx - sx) / baseX;
									tx = tx * tx * (3   - 2 * tx);
									//tx = 6 * tx * tx * tx * tx * tx - 15 * tx * tx * tx * tx + 10 * tx * tx * tx;
									for (var by:int = sy; by < h; by++ ){
										var ty:Number = (by - sy) / baseY;
										ty = ty * ty * (3   - 2 * ty);
										//ty = 6 * ty * ty * ty * ty * ty - 15 * ty * ty * ty * ty + 10 * ty * ty * ty;
										var cx0:Number = r10 * tx + r00 * (1 - tx);
										var cx1:Number = r11 * tx + r01 * (1 - tx);
										var c:Number = cx1 * ty + cx0 * (1 - ty);
										__data[(bx + by * bw) * 4 + chci] += c * amplitude / totalAmplitude;
										//vec[bx + by * bw] += c/numOctaves;
									}
								}
							}
						}
					}
				}
				octaves--;
				baseX /= 2;
				baseY /= 2;
				amplitude *= persistance;
			}
			_lock = nowlock;
			if (!_lock) {
				ctx.putImageData(imageData,0,0);
				SpriteFlexjs.dirtyGraphics = true;
			}
			//setVector(rect, vec);
		}
		
		public function pixelDissolve(param1:BitmapData, param2:Rectangle, param3:Point, param4:int = 0, param5:int = 0, param6:uint = 0):int  { return 0 }
		
		public function scroll(param1:int, param2:int):void  {/**/ }
		
		public function setPixels(param1:Rectangle, param2:ByteArray):void  {/**/ }
		
		public function setVector(param1:Rectangle, param2:Vector.<uint>):void  {
			lock();
			for (var x:int = 0; x < width;x++ ){
				for (var y:int = 0; y < height; y++ ){
					setPixel(x, y, param2[x + y * width]);
				}
			}
			unlock();
		}
		
		public function threshold(param1:BitmapData, param2:Rectangle, param3:Point, param4:String, param5:uint, param6:uint = 0, param7:uint = 4.294967295E9, param8:Boolean = false):uint  { return 0 }
		
		public function lock():void  {
			_lock = true;
		}
		
		public function unlock(param1:Rectangle = null):void  {
			_lock = false;
			ctx.putImageData(imageData, 0, 0);
			SpriteFlexjs.dirtyGraphics = true;
		}
		
		public function histogram(param1:Rectangle = null):Vector.<Vector.<Number>>  { return null }
		
		public function encode(param1:Rectangle, param2:Object, param3:ByteArray = null):ByteArray  { return null }
	}
}
