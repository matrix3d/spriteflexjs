package flash.__native 
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.display3D.textures.TextureBase;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author lizhi
	 */
	public class GLCanvasRenderingContext2D
	{
		public var canvas : HTMLCanvasElement;
		public var fillColor : String;
		public var fillStyle : String;
		public var font : String;
		public var getLineDash : Object;
		public var globalAlpha : Number;
		public var globalCompositeOperation : String;
		public var lineCap : String;
		public var lineJoin : String;
		public var lineWidth : Number;
		public var miterLimit : Number;
		public var setFillColor : Object;
		public var setLineDash : Object;
		public var setStrokeColor : Object;
		public var shadowBlur : Number;
		public var shadowColor : String;
		public var shadowOffsetX : Number;
		public var shadowOffsetY : Number;
		public var strokeColor : String;
		public var strokeStyle : String;
		public var textAlign : String;
		public var textBaseline : String;
		public var context3D:Context3D;
		
		private var bmd2texture:ObjectMap = new ObjectMap;
		private var text2img:Object = { };
		private var bitmapPosBuf:VertexBuffer3D;
		private var bitmapUVBuf:VertexBuffer3D;
		private var bitmapIBuf:IndexBuffer3D;
		private var bitmapProg:Program3D;
		private var matr3d:Matrix3D = new Matrix3D;
		private var matr:Matrix = new Matrix;
		private var bitmapUVScale:Vector.<Number> = Vector.<Number>([1,1,0,0]);
		private var stage:Stage;
		private var isBatch:Boolean;
		public function GLCanvasRenderingContext2D(stage:Stage,isBatch:Boolean=false) 
		{
			this.isBatch = isBatch;
			this.stage = stage;
			this.canvas = stage.canvas;
			context3D = new Context3D;
			context3D.canvas = canvas;
			context3D.gl = (canvas.getContext("webgl") || canvas.getContext("experimental-webgl")) as WebGLRenderingContext;
			stage_resize(null);
			context3D.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
			
			var posData:Array = [0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0];
			bitmapPosBuf = context3D.createVertexBuffer(posData.length/3,3);
			bitmapPosBuf.uploadFromVector(Vector.<Number>(posData), 0, posData.length / 3);
			var uvData:Array = [0, 0, 1, 0, 0, 1, 1, 1];
			bitmapUVBuf = context3D.createVertexBuffer(uvData.length/2,2);
			bitmapUVBuf.uploadFromVector(Vector.<Number>(uvData),0,uvData.length/2);
			var iData:Array = [0, 2, 1, 2, 1, 3];
			bitmapIBuf = context3D.createIndexBuffer(iData.length);
			bitmapIBuf.uploadFromVector(Vector.<uint>(iData), 0, iData.length);
			
			var vcode:String = "attribute vec3 va0;" +
				"attribute vec2 va1;" +
				"varying vec2 vUV;" +
				"uniform mat4 vc0;"+
				"uniform vec4 vc4;"+
				"void main(void) {" +
					"vUV=va1*vc4.xy;"+
					"gl_Position =vc0*vec4(va0, 1.0);"+
				"}";
			var fcode:String = "precision mediump float;" +
				"varying vec2 vUV;"+
				"uniform sampler2D fs0;"+
			   "void main(void) {" +
					"gl_FragColor = texture2D(fs0,vUV);"+
				"}";
			bitmapProg = context3D.createProgram();
			var vb:ByteArray = new ByteArray;
			vb.writeUTFBytes( vcode);
			var fb:ByteArray = new ByteArray;
			fb.writeUTFBytes( fcode);
			bitmapProg.upload(vb, fb);
			
			stage.addEventListener(Event.RESIZE, stage_resize);
		}
		
		private function stage_resize(e:Event):void 
		{
			context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, false);
		}
		public function arc (x:Number, y:Number, radius:Number, startAngle:Number, endAngle:Number, opt_anticlockwise:Boolean=false) : Object{
			return null;
		}

		public function arcTo (x1:Number, y1:Number, x2:Number, y2:Number, radius:Number) : Object {
			return null;
		}

		public function beginPath () : Object {
			return null;
		}

		public function bezierCurveTo (cp1x:Number, cp1y:Number, cp2x:Number, cp2y:Number, x:Number, y:Number) : Object {
			return null;
		}

		public function clearRect (x:Number, y:Number, w:Number, h:Number) : Object {
			context3D.clear();
			return null;
		}

		public function clip (opt_fillRule:String = "") : Object {
			return null;
		}

		public function closePath () : Object {
			return null;
		}

		public function createImageData (sw:Number, sh:Number) : ImageData {
			return null;
		}

		public function createLinearGradient (x0:Number, y0:Number, x1:Number, y1:Number) : CanvasGradient {
			return null;
		}

		public function createPattern (image:Object, repetition:String) : CanvasPattern {
			return null;
		}

		public function createRadialGradient (x0:Number, y0:Number, r0:Number, x1:Number, y1:Number, r1:Number) : CanvasGradient {
			return null;
		}

		public function drawImage (image:Object, dx:Number, dy:Number, opt_dw:Number = 0, opt_dh:Number = 0, opt_sx:Number = 0, opt_sy:Number = 0, opt_sw:Number = 0, opt_sh:Number = 0) : Object {
			var texture:BitmapTexture = getTexture(image);
			context3D.setProgram(bitmapProg);
			context3D.setTextureAt(0, texture.texture);
			context3D.setVertexBufferAt(0, bitmapPosBuf,0, Context3DVertexBufferFormat.FLOAT_3);
			context3D.setVertexBufferAt(1, bitmapUVBuf, 0, Context3DVertexBufferFormat.FLOAT_2);
			
			/*matr3d.identity();
			matr3d.appendScale(2 * texture.img.width / stage.stageWidth, 2 * texture.img.height / stage.stageHeight, 1);
			matr3d.appendTranslation(matr.tx * 2 / stage.stageWidth - 1, 1 - matr.ty * 2 / stage.stageHeight, 0);*/
			
			//a + ", " + b + ", " + "0, 0, " + c + ", " + d + ", " + "0, 0, 0, 0, 1, 0, " + tx + ", " + ty + ", 0, 1)";
			matr3d.rawData[0] = matr.a*2 * texture.img.width / stage.stageWidth;
			matr3d.rawData[1] = -matr.b*2 * texture.img.height / stage.stageHeight;
			//matr3d.rawData[2] = 0;
			//matr3d.rawData[3] = 0;
			matr3d.rawData[4] = matr.c*2 * texture.img.width / stage.stageWidth;
			matr3d.rawData[5] = -matr.d*2 * texture.img.height / stage.stageHeight;
			//matr3d.rawData[6] = 0;
			//matr3d.rawData[7] = 0;
			//matr3d.rawData[8] = 0;
			//matr3d.rawData[9] = 0;
			//matr3d.rawData[10] = 1;
			//matr3d.rawData[11] = 0;
			matr3d.rawData[12] = matr.tx * 2 / stage.stageWidth-1;
			matr3d.rawData[13] = 1-matr.ty * 2 / stage.stageHeight;
			//matr3d.rawData[14] = 0;
			//matr3d.rawData[15] = 1;
			
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, matr3d);
			bitmapUVScale[0] = texture.img.width / texture.width;
			bitmapUVScale[1] = texture.img.height / texture.height;
			context3D.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, bitmapUVScale);
			context3D.drawTriangles(bitmapIBuf);
			return null;
		}

		public function fill (opt_fillRule:String = "") : Object {
			return null;
		}

		public function fillRect (x:Number, y:Number, w:Number, h:Number) : Object {
			return null;
		}

		public function fillText (text:String, x:Number, y:Number, opt_maxWidth:Number = 0) : Object {
			var image:HTMLCanvasElement = text2img[text];
			if (image==null) {
				image = text2img[text]=document.createElement("canvas") as HTMLCanvasElement;
				var ctx:CanvasRenderingContext2D = image.getContext("2d") as CanvasRenderingContext2D;
				var measure:TextMetrics = ctx.measureText(text);
				image.width = measure.width;
				image.height = 20;
				ctx.fillStyle = "#ff0000";
				ctx.fillText(text, 0, 20);
			}
			return drawImage(image,0,0);
		}

		public function getImageData (sx:Number, sy:Number, sw:Number, sh:Number) : ImageData {
			return null;
		}

		public function isPointInPath (x:Number, y:Number, opt_fillRule:String = "") : Boolean {
			return null;
		}

		public function lineTo (x:Number, y:Number) : Object {
			return null;
		}

		public function measureText (text:String) : TextMetrics {
			return null;
		}

		public function moveTo (x:Number, y:Number) : Object {
			return null;
		}

		public function putImageData (imagedata:ImageData, dx:Number, dy:Number, opt_dirtyX:Number = 0, opt_dirtyY:Number = 0, opt_dirtyWidth:Number = 0, opt_dirtyHeight:Number = 0) : Object {
			return null;
		}

		public function quadraticCurveTo (cpx:Number, cpy:Number, x:Number, y:Number) : Object {
			return null;
		}

		public function rect (x:Number, y:Number, w:Number, h:Number) : Object {
			return null;
		}

		public function restore () : Object {
			return null;
		}

		public function rotate (angle:Number) : Object {
			return null;
		}

		public function save () : Object {
			return null;
		}

		public function scale (x:Number, y:Number) : Object {
			return null;
		}

		public function setTransform (m11:Number, m12:Number, m21:Number, m22:Number, dx:Number, dy:Number) : Object {
			matr.setTo(m11, m12, m21, m22, dx, dy);
			return null;
		}

		public function stroke () : Object {
			return null;
		}

		public function strokeRect (x:Number, y:Number, w:Number, h:Number) : Object {
			return null;
		}

		public function strokeText (text:String, x:Number, y:Number, opt_maxWidth:Number = 0) : Object {
			return null;
		}

		public function transform (m11:Number, m12:Number, m21:Number, m22:Number, dx:Number, dy:Number) : Object {
			return null;
		}

		public function translate (x:Number, y:Number) : Object {
			return null;
		}
		
		private function getTexture(img:Object):BitmapTexture {
			var btexture:BitmapTexture = bmd2texture.get(img) as BitmapTexture;
			if (btexture == null) {
				var w:int = getNextPow2(img.width);
				var h:int = getNextPow2(img.height);
				var bmd:BitmapData = new BitmapData(w, h, true, 0);
				bmd.fromImage(img);
				var texture:Texture = context3D.createTexture(w, h, Context3DTextureFormat.BGRA, false);
				texture.uploadFromBitmapData(bmd);
				btexture = new BitmapTexture;
				btexture.img = img;
				btexture.texture = texture;
				btexture.width = w;
				btexture.height = h;
				bmd2texture.set(img, btexture);
			}
			return btexture;
		}
		
		private function getNextPow2(v:int):int {
			var r:int = 1;
			while (r < v) {
				r *= 2;
			}
			return r;
		}
	}
}