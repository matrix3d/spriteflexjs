package flash.__native 
{
	import flash.display.Stage;
	import flash.display3D.Context3D;
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
		public function GLCanvasRenderingContext2D(stage:Stage) 
		{
			this.canvas = stage.canvas;
			context3D = new Context3D;
			context3D.canvas = canvas;
			context3D.gl = (canvas.getContext("webgl") || canvas.getContext("experimental-webgl")) as WebGLRenderingContext;
			context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight,0);
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
	}

}