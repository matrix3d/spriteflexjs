package flash.__native 
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DTriangleFace;
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
	 * @author lizhi http://matrix3d.github.io/
	 */
	public class GLCanvasRenderingContext2D
	{
		public var canvas : HTMLCanvasElement;
		public var fillColor : String;
		public var fillStyle : Object;
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
		public var ctx:Context3D;
		public var currentPath:GLPath2D;
		
		private var bmd2texture:ObjectMap = new ObjectMap;
		private var text2img:Object = { };
		
		private var bitmapDrawable:GLDrawable;
		
		private var bitmapProg:Program3D;
		private var matr3d:Matrix3D = new Matrix3D;
		private var uvmatr3d:Matrix3D = new Matrix3D;
		private var matr:Matrix = new Matrix;
		private var matrhelp:Matrix = new Matrix;
		private var stage:Stage;
		private var isBatch:Boolean;
		private var batchs:Array = [];
		private var states:Array = [];
		private var statesPos:int = -1;
		private var pathPool:Array = [];
		private var pathPoolPos:int = 0;
		public function GLCanvasRenderingContext2D(stage:Stage,isBatch:Boolean=false) 
		{
			this.isBatch = isBatch;
			this.stage = stage;
			this.canvas = stage.canvas;
			ctx = new Context3D;
			ctx.canvas = canvas;
			ctx.gl = (canvas.getContext("webgl",{alpha:false}) || canvas.getContext("experimental-webgl",{alpha:false})) as WebGLRenderingContext;
			stage_resize(null);
			ctx.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
			ctx.setCulling(Context3DTriangleFace.NONE);
			
			var posData:Float32Array = new Float32Array([0, 0, 1, 0, 0, 1, 1, 1]);
			var iData:Uint16Array = new Uint16Array([0, 2, 1, 2, 1, 3]);
			bitmapDrawable = new GLDrawable(posData, posData,iData);
			
			var vcode:String = 
				"attribute vec2 va0;" +
				"attribute vec2 va1;" +
				"varying vec2 vUV;" +
				"uniform mat4 vc0;"+
				"uniform mat4 vc4;"+
				"void main(void) {" +
					"vUV=(vc4*vec4(va1,1.0,1.0)).xy;"+
					"gl_Position =vc0*vec4(va0, 1.0,1.0);"+
				"}";
			var fcode:String = "precision mediump float;" +
				"varying vec2 vUV;"+
				"uniform sampler2D fs0;"+
			   "void main(void) {" +
					"gl_FragColor = texture2D(fs0,vUV);"+
				"}";
			bitmapProg = ctx.createProgram();
			var vb:ByteArray = new ByteArray;
			vb.writeUTFBytes( vcode);
			var fb:ByteArray = new ByteArray;
			fb.writeUTFBytes( fcode);
			bitmapProg.upload(vb, fb);
			
			stage.addEventListener(Event.RESIZE, stage_resize);
			if (isBatch){
				stage.addEventListener(Event.ENTER_FRAME, stage_enterFrame);
			}
		}
		
		private function stage_resize(e:Event):void 
		{
			ctx.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, false);
		}
		public function arc (x:Number, y:Number, radius:Number, startAngle:Number, endAngle:Number, opt_anticlockwise:Boolean=false) : Object{
			return currentPath.arc(x,y,radius,startAngle,endAngle,opt_anticlockwise);
		}

		public function arcTo (x1:Number, y1:Number, x2:Number, y2:Number, radius:Number) : Object {
			return currentPath.arcTo(x1, y1, x2, y2, radius);
		}

		public function beginPath () : Object {
			currentPath = pathPool[pathPoolPos];
			if (currentPath==null){
				currentPath = pathPool[pathPoolPos] = new GLPath2D;
			}else{
				currentPath.clear();
			}
			pathPoolPos++;
			currentPath.matr.copyFrom(matr);
			return null;
		}

		public function bezierCurveTo (cp1x:Number, cp1y:Number, cp2x:Number, cp2y:Number, x:Number, y:Number) : Object {
			return currentPath.bezierCurveTo(cp1x,cp1y,cp2x,cp2y,x,y);
		}

		public function clearRect (x:Number, y:Number, w:Number, h:Number) : Object {
			pathPoolPos = 0;
			ctx.clear();
			batchs.length = 0;
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

		/**
		 * @flexjsignorecoercion CanvasPattern
		 */
		public function createPattern (image:Object, repetition:String) : CanvasPattern {
			return new GLCanvasPattern(image,repetition) as CanvasPattern;
		}

		public function createRadialGradient (x0:Number, y0:Number, r0:Number, x1:Number, y1:Number, r1:Number) : CanvasGradient {
			return null;
		}

		public function drawImage (image:Object, dx:Number, dy:Number, opt_dw:Number = 0, opt_dh:Number = 0, opt_sx:Number = 0, opt_sy:Number = 0, opt_sw:Number = 0, opt_sh:Number = 0) : Object {
			drawImageInternal(image,bitmapDrawable, matr,null,true);
			return null;
		}
		
		public function drawImageInternal(image:Object, drawable:GLDrawable, posmatr:Matrix, uvmatr:Matrix, scaleWithImage:Boolean):void{
			if(!isBatch){
				renderImage(image, drawable, posmatr, uvmatr, scaleWithImage);
			}else{
				batchs.push([image,drawable,posmatr?posmatr.clone():null,uvmatr?uvmatr.clone():null,scaleWithImage]);
			}
		}
		
		private function renderImage(image:Object, drawable:GLDrawable, posmatr:Matrix, uvmatr:Matrix, scaleWithImage:Boolean):void{
			var texture:BitmapTexture = getTexture(image);
			ctx.setProgram(bitmapProg);
			ctx.setTextureAt(0, texture.texture);
			ctx.setVertexBufferAt(0, drawable.pos.getBuff(ctx),0, Context3DVertexBufferFormat.FLOAT_2);
			ctx.setVertexBufferAt(1, drawable.uv.getBuff(ctx),0, Context3DVertexBufferFormat.FLOAT_2);
			matr3d.rawData[0] = posmatr.a*2  / stage.stageWidth;
			matr3d.rawData[1] = -posmatr.b*2 / stage.stageHeight;
			matr3d.rawData[4] = posmatr.c*2 / stage.stageWidth;
			matr3d.rawData[5] = -posmatr.d*2 / stage.stageHeight;
			matr3d.rawData[12] = posmatr.tx * 2 / stage.stageWidth-1;
			matr3d.rawData[13] = 1 - posmatr.ty * 2 / stage.stageHeight;
			if (scaleWithImage){
				matr3d.rawData[0] *= image.width;
				matr3d.rawData[1] *= image.width;
				matr3d.rawData[4] *= image.height;
				matr3d.rawData[5] *= image.height;
			}
			
			ctx.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, matr3d);
			if (uvmatr){
				matrhelp.copyFrom(posmatr);
				matrhelp.invert();
				matrhelp.concat(uvmatr);
				uvmatr3d.rawData[0] = matrhelp.a / texture.width;
				uvmatr3d.rawData[1] = -matrhelp.b / texture.width;
				uvmatr3d.rawData[4] = -matrhelp.c / texture.height;
				uvmatr3d.rawData[5] = matrhelp.d / texture.height;
				uvmatr3d.rawData[12] = -matrhelp.tx/texture.width;
				uvmatr3d.rawData[13] = -matrhelp.ty/texture.height;
				if (scaleWithImage){
					uvmatr3d.rawData[0] *= image.width;
					uvmatr3d.rawData[1] *= image.width;
					uvmatr3d.rawData[4] *= image.height;
					uvmatr3d.rawData[5] *= image.height;
				}
			}else{
				uvmatr3d.rawData[0] = 1 / texture.width;
				uvmatr3d.rawData[1] = 0;
				uvmatr3d.rawData[4] = 0;
				uvmatr3d.rawData[5] = 1/ texture.height;
				uvmatr3d.rawData[12] = 0;
				uvmatr3d.rawData[13] = 0;
				if (scaleWithImage){
					uvmatr3d.rawData[0] *= image.width;
					uvmatr3d.rawData[5] *= image.height;
				}
			}
			ctx.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, uvmatr3d);
			ctx.drawTriangles(drawable.index.getBuff(ctx));
		}
		
		private var newdata:Float32Array = new Float32Array(20000);
		private var newuvdata:Float32Array = new Float32Array(20000);
		private var newidata:Uint16Array = new Uint16Array(30000);
		private function stage_enterFrame(e:Event):void 
		{
			//render batch
			var lastImage:Object;
			var lastDrawable:GLDrawable;
			SpriteFlexjs.batDrawCounter = 0;
			var len:int = batchs.length;
			for (var i:int = 0; i <= len;i++ ){
				var batch:Array = batchs[i] || [];
				var image:Object = batch[0];
				var drawable:GLDrawable = batch[1]; 
				var posmatr:Matrix = batch[2];
				var uvmatr:Matrix = batch[3];
				var scaleWithImage:Boolean = batch[4];
				if (lastImage != image){//如果图像和上次图像不一样，设置新的，并渲染
					if (lastDrawable){//render
						SpriteFlexjs.batDrawCounter++;
						renderImage(lastImage, lastDrawable, new Matrix, new Matrix, false);
					}
					lastImage = image;
					lastDrawable = new GLDrawable(newdata,newuvdata,newidata);
				}
				if (drawable){
					if(uvmatr){
						matrhelp.copyFrom(posmatr);
						matrhelp.invert();
						matrhelp.concat(uvmatr);
						matrhelp.b *=-1;
						matrhelp.c *=-1;
						matrhelp.tx *=-1;
						matrhelp.ty *=-1;
					}
					var data:Float32Array = drawable.pos.data;
					var uvdata:Float32Array = drawable.uv.data;
					var si:int = newdata.length / 2;
					var len2:int = data.length / 2;
					for (var j:int = 0; j < len2; j++ ){
						var x:Number = data[2 * j];
						var y:Number = data[2 * j + 1];
						if (scaleWithImage){
							x *= image.width;
							y *=image.height;
						}
						var x2:Number = posmatr.a * x + posmatr.c * y + posmatr.tx;
						var y2:Number = posmatr.d * y + posmatr.b * x + posmatr.ty;
						newdata[si + j * 2] = x2;
						newdata[si + j * 2 + 1] = y2;
						
						x = uvdata[2 * j];
						y = uvdata[2 * j + 1];
						if (scaleWithImage){
							x *=image.width;
							y *= image.height;
						}
						if(uvmatr){
							x2 = matrhelp.a * x + matrhelp.c * y + matrhelp.tx;
							y2 = matrhelp.d * y + matrhelp.b * x + matrhelp.ty;
							newuvdata[si + j * 2] = x2;
							newuvdata[si + j * 2 + 1] = y2;
						}else{
							newuvdata[si + j * 2] = x;
							newuvdata[si + j * 2 + 1] = y;
						}
					}
					var il:int = newidata.length;
					var did:Uint16Array = drawable.index.data;
					var didl:int = did.length;
					for (j = 0; j < didl;j++){
						var vi:int = didl[j];
						newidata[il + j] = vi + si;
					}
				}
			}
		}

		public function fill (opt_fillRule:String = "") : Object {
			if (fillStyle is GLCanvasPattern) {
				var glcp:GLCanvasPattern = fillStyle as GLCanvasPattern;
				drawImageInternal(glcp.image, currentPath.drawable,currentPath.matr,matr,false);
			}
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
			drawImageInternal(image, bitmapDrawable,matr,null,true);
			return null;
		}

		public function getImageData (sx:Number, sy:Number, sw:Number, sh:Number) : ImageData {
			return null;
		}

		public function isPointInPath (x:Number, y:Number, opt_fillRule:String = "") : Boolean {
			return false;
		}

		public function lineTo (x:Number, y:Number) : Object {
			return currentPath.lineTo(x,y);
		}

		public function measureText (text:String) : TextMetrics {
			return null;
		}

		public function moveTo (x:Number, y:Number) : Object {
			return currentPath.moveTo(x,y);
		}

		public function putImageData (imagedata:ImageData, dx:Number, dy:Number, opt_dirtyX:Number = 0, opt_dirtyY:Number = 0, opt_dirtyWidth:Number = 0, opt_dirtyHeight:Number = 0) : Object {
			return null;
		}

		public function quadraticCurveTo (cpx:Number, cpy:Number, x:Number, y:Number) : Object {
			currentPath.quadraticCurveTo(cpx, cpy, x, y);
			return null;
		}

		public function rect (x:Number, y:Number, w:Number, h:Number) : Object {
			return currentPath.rect(x,y,w,h);
		}

		public function restore () : Object {
			var state:GLCanvasState = states[statesPos--];
			matr.copyFrom(state.matr);
			return null;
		}

		public function rotate (angle:Number) : Object {
			matr.rotate(angle);
			return null;
		}

		public function save () : Object {
			var state:GLCanvasState = states[++statesPos];
			if (state==null){
				state = states[statesPos] = new GLCanvasState;
			}
			state.matr.copyFrom(matr);
			return null;
		}

		public function scale (x:Number, y:Number) : Object {
			matr.scale(x, y);
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
			matrhelp.setTo(m11, m12, m21, m22, dx, dy);
			matr.concat(matrhelp);
			return null;
		}

		public function translate (x:Number, y:Number) : Object {
			matr.translate(x, y);
			return null;
		}
		
		private function getTexture(img:Object):BitmapTexture {
			var btexture:BitmapTexture = bmd2texture.get(img) as BitmapTexture;
			if (btexture == null) {
				var w:int = getNextPow2(img.width);
				var h:int = getNextPow2(img.height);
				var bmd:BitmapData = new BitmapData(w, h, true, 0);
				bmd.fromImage(img);
				var texture:Texture = ctx.createTexture(w, h, Context3DTextureFormat.BGRA, false);
				texture.uploadFromBitmapData(bmd,1);
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