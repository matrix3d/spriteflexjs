package flash.__native 
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.display3D.textures.TextureBase;
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
		private var bitmapPosBuf:VertexBuffer3D;
		private var bitmapUVBuf:VertexBuffer3D;
		private var bitmapIBuf:IndexBuffer3D;
		private var bitmapProg:Program3D;
		public function GLCanvasRenderingContext2D(stage:Stage) 
		{
			this.canvas = stage.canvas;
			context3D = new Context3D;
			context3D.canvas = canvas;
			context3D.gl = (canvas.getContext("webgl") || canvas.getContext("experimental-webgl")) as WebGLRenderingContext;
			context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, false);
			
			var posData:Array = [0, .7, 0, -.7, -.7, 0, .7, -.7, 0];
			bitmapPosBuf = context3D.createVertexBuffer(posData.length/3,3);
			bitmapPosBuf.uploadFromVector(Vector.<Number>(posData), 0, posData.length / 3);
			var uvData:Array = [1, 0, 0, 1, 0, 0];
			bitmapUVBuf = context3D.createVertexBuffer(uvData.length/2,2);
			bitmapUVBuf.uploadFromVector(Vector.<Number>(uvData),0,uvData.length/2);
			var iData:Array = [0,1,2];
			bitmapIBuf = context3D.createIndexBuffer(iData.length);
			bitmapIBuf.uploadFromVector(Vector.<uint>(iData), 0, iData.length);
			
			var vcode:String = "attribute vec3 va0;" +
				"attribute vec3 va1;" +
				"varying vec3 vColor;"+
				"uniform mat4 vc0;"+
				"void main(void) {" +
					"vColor=va1;"+
					"gl_Position =vc0*vec4(va0, 1.0);"+
				"}";
			var fcode:String = "precision mediump float;" +
				"varying vec3 vColor;"+
				"uniform sampler2D fs0;"+
			   "void main(void) {" +
					"gl_FragColor = /*vec4(vColor,1)*/texture2D(fs0,vColor.xy);"+
				"}";
			bitmapProg = context3D.createProgram();
			var vb:ByteArray = new ByteArray;
			vb.writeUTFBytes( vcode);
			var fb:ByteArray = new ByteArray;
			fb.writeUTFBytes( fcode);
			bitmapProg.upload(vb, fb);
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
			var texture:TextureBase = getTexture(image);
			context3D.setProgram(bitmapProg);
			context3D.setTextureAt(0, texture);
			context3D.setVertexBufferAt(0, bitmapPosBuf,0, Context3DVertexBufferFormat.FLOAT_3);
			context3D.setVertexBufferAt(1, bitmapUVBuf,0, Context3DVertexBufferFormat.FLOAT_2);
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, new Matrix3D);
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
			return null;
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
		
		private function getTexture(img:Object):TextureBase {
			var texture:TextureBase = bmd2texture.get(img) as TextureBase;
			if (texture==null) {
				texture = context3D.createTexture(128, 128, Context3DTextureFormat.BGRA, false);
				var bmd2:BitmapData = new BitmapData(128, 128, false, 0xffffff * Math.random());
				(texture as Texture).uploadFromBitmapData(bmd2);
				bmd2texture.set(img, texture);
			}
			return texture;
		}
	}

}