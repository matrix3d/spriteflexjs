package flash.display
{
	import flash.geom.*;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author lizhi http://matrix3d.github.io/
	 */
	public class BitmapData
	{
		private var data:Uint8ClampedArray;
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
			data = imageData.data;
			//data32 = new Uint32Array(imageData.data);
			fillRect(rect, fillColor);
		}
		
		public function fromImage(img:Object,dx:Number=0,dy:Number=0,opt_dw:Number=0,opt_dy:Number=0):void {
			ctx.drawImage(img,dx,dy);
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
					setPixel32(x, y, 0xff000000|0xffffff*Math.random());
				}
			}
			unlock();
		}
		
		public function paletteMap(param1:BitmapData, param2:Rectangle, param3:Point, param4:Array = null, param5:Array = null, param6:Array = null, param7:Array = null):void  {/**/ }
		
		//https://chengkehan.github.io/PerlinNoise.html
		public function perlinNoise(baseX:Number, baseY:Number, numOctaves:uint, randomSeed:int, stitch:Boolean, fractalNoise:Boolean, channelOptions:uint=7, grayScale:Boolean=false, offsets:Array=null):void  {
			lock();
			
			var width:int = this.width;
			var height:int = this.height;
			
			var smoothNoises:Array = [];

			// 不同采样级别的 Noise 的叠加系数
			var persistance:Number = 0.8;

			// 生成不同采样级别的 Noise
			for (var k:int = 0; k < numOctaves; k++)
			{
				var whiteNoise:Array = [];
				for (var i:int = 0; i < width;i++ ){
					whiteNoise[i] = [];
					for (var j:int = 0; j < height; j++ ){
						whiteNoise[i][j] = Math.random();// int(Math.random() * 0xffffffff);
					}
				}

				var smoothNoise:Array = [];
				smoothNoises[k] = smoothNoise;
				// 采样步长
				var samplePeriod:int = Math.pow(2, k);
				// 采样频率
				var sampleFrequency:Number = 1 / samplePeriod;

				for (i = 0; i < width; i++)
				{
					smoothNoise[i] = [];
					// 最左点位置
					var sampler_l:int =  int(i / samplePeriod) * samplePeriod;
					// 最右点位置
					var sampler_r:int = (sampler_l + samplePeriod) % width;
					// 根据实际点与最左最右的距离，计算水平混合系数
					var horizontal_blend:Number = (i - sampler_l) * sampleFrequency;

					for (j = 0; j < height; j++)
					{
						// 最上点位置
						var sampler_t:int = int(j / samplePeriod) * samplePeriod;
						// 最下点位置
						var sampler_d:int = (sampler_t + samplePeriod) % height;
						// 根据实际点与最上最下的距离，计算垂直混合系数
						var vertical_blend:Number = (j - sampler_t) * sampleFrequency;

						// 左上和右上根据水平混合系数进行插值
						var top:Number = interpolate(whiteNoise[sampler_l][ sampler_t], whiteNoise[sampler_r][sampler_t], horizontal_blend);
						// 左下和右下根据水平混合系数进行插值
						var bottom:Number = interpolate(whiteNoise[sampler_l][ sampler_d], whiteNoise[sampler_r][sampler_d], horizontal_blend);
						// 最总数值为 top down 根据垂直混合系数进行插值
						smoothNoise[i][j] = interpolate(top, bottom, vertical_blend);
						//var c:int = 0xff * (interpolate(top, bottom, vertical_blend));
						//setPixel32(i,j, 0xff000000|(c<<16)|(c<<8)|c);                    
					}
				}
			}
			
			// 最终生成的 Perlin Noise
			var perlinNoise:Array = [];

			// 不同采样级别的 Noise 的叠加比重
			var amplitude:Number = 1;
			// 所有采样级别的 Noise 的叠加总比重
			var totalAmplitude:Number = 0;

			// 开始混合所有采样级别的 Noise
			for (var octave:int = numOctaves - 1; octave >= 0; octave--)
			{
				amplitude *= persistance;
				totalAmplitude += amplitude;

				for ( i = 0; i < width; i++)
				{
					if(octave==numOctaves-1){
						perlinNoise[i] = [];
					}
					for (j = 0; j < height; j++)
					{
						if(octave==numOctaves-1){
							perlinNoise[i][j] = smoothNoises[octave][i][j] * amplitude;
						}else{
							perlinNoise[i][j] += smoothNoises[octave][i][j] * amplitude;
						}
					}
				}
			}

			// 归一化最终的 Perlin Noise
			for ( i = 0; i < width; i++)
			{
				for (j = 0; j < height; j++)
				{
					var c:int=0xff*(perlinNoise[i][j] / totalAmplitude);
					setPixel32(i, j, 0xff000000 | (c << 16) | (c << 8) | c);
				}
			}
			unlock();
		}

		// 在两个数值间进行插值
		private function interpolate(x0:Number,x1:Number,alpha:Number):Number
		{
			return x0 * (1 - alpha) + alpha * x1;
		}
		
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
