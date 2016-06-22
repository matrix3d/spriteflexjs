package flash.__native 
{
	import flash.display.BitmapData;
	import flash.display.GraphicsPath;
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
	import flash.geom.ColorTransform;
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
		public var ctx:Context3D;
		public var currentPath:GLPath2D;
		private var text2img:Object = { };
		private var bitmapDrawable:GLDrawable;
		private var bitmapProg:Program3D;
		private var colorProg:Program3D;
		private var matr3d:Matrix3D = new Matrix3D;
		private var uvmatr3d:Matrix3D = new Matrix3D;
		private var matr:Matrix = new Matrix;
		private var matrhelp:Matrix = new Matrix;
		private var stage:Stage;
		private var isBatch:Boolean;
		private var batchs:Array = [];
		private var states:Array = [];
		private var statesPos:int = -1;
		private var posPool:Object = {};
		private var uvPool:Object = {};
		private var colorPool:Object = {};
		private var indexPool:Object = {};
		private var newDrawable:GLDrawable = new GLDrawable(null, null, null);
		//public var lastBeginPath:GLPath2D;
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
			
			vcode = 
				"attribute vec2 va0;" +
				"attribute vec4 va1;" +
				"varying vec4 vColor;"+
				"uniform mat4 vc0;"+
				"void main(void) {" +
					"vColor=va1;"+
					"gl_Position =vc0*vec4(va0, 1.0,1.0);"+
				"}";
			fcode = "precision mediump float;" +
				"varying vec4 vColor;"+
			   "void main(void) {" +
					"gl_FragColor = vColor;"+
				"}";
			colorProg = ctx.createProgram();
			vb = new ByteArray;
			vb.writeUTFBytes( vcode);
			fb = new ByteArray;
			fb.writeUTFBytes(fcode);
			colorProg.upload(vb, fb);
			
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
			currentPath.path.arc(x, y, radius, startAngle, endAngle);
			return null;
		}

		public function arcTo (x1:Number, y1:Number, x2:Number, y2:Number, radius:Number) : Object {
			//currentPath.path.arc(x1, y1, x2, y2, radius);
			return null;
		}

		public function beginPath () : Object {
			currentPath = new GLPath2D;
			currentPath.path = SpriteFlexjs.renderer.createPath() as GLGraphicsPath;
			currentPath.matr.copyFrom(matr);
			return null;
		}

		public function bezierCurveTo (cp1x:Number, cp1y:Number, cp2x:Number, cp2y:Number, x:Number, y:Number) : Object {
			currentPath.path.cubicCurveTo(cp1x, cp1y, cp2x, cp2y, x, y);
			return null;
		}

		public function clearRect (x:Number, y:Number, w:Number, h:Number) : Object {
			ctx.clear(1,1,1);
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
		
		/**
		 * @flexjsignorecoercion CanvasRenderingContext2D
		 */
		public function drawPath (path:GraphicsPath, colorTransform:ColorTransform) : Object {
			currentPath = path["glpath2d"];
			if (path["glpath2d"]==null){
				currentPath = path["glpath2d"] = new GLPath2D;
			}
			currentPath.path = path as GLGraphicsPath;
			currentPath.matr.copyFrom(matr);
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
			SpriteFlexjs.batDrawCounter++;
			if (image is String){
				ctx.setProgram(colorProg);
				ctx.setVertexBufferAt(1, drawable.color.getBuff(ctx), 0, Context3DVertexBufferFormat.FLOAT_4);
			}else{
				var texture:BitmapTexture = getTexture(image);
				ctx.setProgram(bitmapProg);
				ctx.setTextureAt(0, texture.texture);
				ctx.setVertexBufferAt(1, drawable.uv.getBuff(ctx), 0, Context3DVertexBufferFormat.FLOAT_2);
			}
			ctx.setVertexBufferAt(0, drawable.pos.getBuff(ctx),0, Context3DVertexBufferFormat.FLOAT_2);
			if(posmatr){
				matr3d.rawData[0] = posmatr.a*2  / stage.stageWidth;
				matr3d.rawData[1] = -posmatr.b*2 / stage.stageHeight;
				matr3d.rawData[4] = posmatr.c*2 / stage.stageWidth;
				matr3d.rawData[5] = -posmatr.d*2 / stage.stageHeight;
				matr3d.rawData[12] = posmatr.tx * 2 / stage.stageWidth-1;
				matr3d.rawData[13] = 1 - posmatr.ty * 2 / stage.stageHeight;
			}else{
				matr3d.rawData[0] = 2  / stage.stageWidth;
				matr3d.rawData[1] = 0;
				matr3d.rawData[4] = 0;
				matr3d.rawData[5] = -2 / stage.stageHeight;
				matr3d.rawData[12] = -1;
				matr3d.rawData[13] = 1;
			}
			if (scaleWithImage){
				matr3d.rawData[0] *= image.width;
				matr3d.rawData[1] *= image.width;
				matr3d.rawData[4] *= image.height;
				matr3d.rawData[5] *= image.height;
			}
			
			ctx.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, matr3d);
			if(!(image is String)){
				if (uvmatr){
					if(posmatr){
						matrhelp.copyFrom(posmatr);
						matrhelp.invert();
						matrhelp.concat(uvmatr);
					}else{
						matrhelp.copyFrom(uvmatr);
					}
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
			}
			ctx.drawTriangles(drawable.index.getBuff(ctx),0,drawable.numTriangles);
		}
		
		
		
		private function stage_enterFrame(e:Event):void 
		{
			SpriteFlexjs.batDrawCounter = 0;
			var len:int = batchs.length;
			var renderbatchs:Array = [];
			var renderbatch:Array;
			var lastImage:Object;
			for (var i:int = 0; i <= len;i++ ){
				var batch:Array = batchs[i]||[];
				var image:Object = batch[0];
				var drawable:GLDrawable = batch[1];
				if ((lastImage is String)&&(image is String)){
					
				}else if (lastImage != image){
					if (renderbatch){
						renderbatch[1] = i - 1;
					}
					if(image){
						renderbatch = [i,-1,0,0,image];
						renderbatchs.push(renderbatch);
						lastImage = image;
					}
				}
				if (drawable){
					renderbatch[2] += drawable.pos.data.length / 2;
					renderbatch[3] += drawable.index.data.length / 3;
				}
			}
			len = renderbatchs.length;
			for (i = 0; i < len;i++ ){
				renderbatch = renderbatchs[i];
				image = renderbatch[4];
				var isImage:Boolean = !(image is String);
				var numPos:int = renderbatch[2];
				var numIndex:int = renderbatch[3];
				var posKey:int = getNextPow2(numPos);
				var indexKey:int = getNextPow2(numIndex);
				var newpos:GLVertexBufferSet = posPool[posKey];
				var newuv:GLVertexBufferSet = uvPool[posKey];
				var newcolor:GLVertexBufferSet = colorPool[posKey];
				var newi:GLIndexBufferSet = indexPool[indexKey];
				if (newpos==null){
					newpos = posPool[posKey] = new GLVertexBufferSet(new Float32Array(posKey * 2), 2, "pos");
					trace("bat new pos",posKey);
				}
				if (newuv==null&&isImage){
					newuv = uvPool[posKey] = new GLVertexBufferSet(new Float32Array(posKey * 2), 2, "uv");
				}
				if (newcolor==null&&!isImage){
					newcolor = colorPool[posKey] = new GLVertexBufferSet(new Float32Array(posKey * 4), 4, "color");
				}
				if (newi==null){
					newi = indexPool[indexKey] = new GLIndexBufferSet(new Uint16Array(indexKey * 3));
					trace("bat new index",indexKey);
				}
				var newposdata:Float32Array = newpos.data;
				if(isImage){
					var newuvdata:Float32Array = newuv.data;
				}else{
					var newcolordata:Float32Array = newcolor.data;
				}
				var newidata:Uint16Array = newi.data;
				newDrawable.index = newi;
				newDrawable.pos = newpos;
				newDrawable.uv = newuv;
				newDrawable.color = newcolor;
				newDrawable.numTriangles = numIndex;
				var si:int = 0;
				var il:int = 0;
				if (isImage){
					var iw:int = image.width;
					var ih:int = image.height;
				}
				for (var j:int = renderbatch[0]; j <= renderbatch[1]; j++ ){
					batch = batchs[j];
					drawable = batch[1]; 
					var posmatr:Matrix = batch[2];
					var scaleWithImage:Boolean = batch[4];
					if(isImage){
						var uvmatr:Matrix = batch[3];
						if(uvmatr){
							matrhelp.copyFrom(posmatr);
							matrhelp.invert();
							matrhelp.concat(uvmatr);
							matrhelp.b *=-1;
							matrhelp.c *=-1;
							matrhelp.tx *=-1;
							matrhelp.ty *=-1;
						}
					}
					var data:Float32Array = drawable.pos.data;
					if(isImage){
						var uvdata:Float32Array = drawable.uv.data;
					}else{
						var colordata:Float32Array = drawable.color.data;
					}
					var len2:int = data.length/2 ;
					for (var k:int = 0; k < len2; k++ ){
						var x:Number = data[k*2];
						var y:Number = data[k*2 + 1];
						if (scaleWithImage){
							x *= iw;
							y *= ih;
						}
						var x2:Number = posmatr.a * x + posmatr.c * y + posmatr.tx;
						var y2:Number = posmatr.d * y + posmatr.b * x + posmatr.ty;
						newposdata[(si + k)*2] = x2;
						newposdata[(si + k)*2 + 1] = y2;
						if(isImage){
							x = uvdata[k*2];
							y = uvdata[k*2 + 1];
							if (scaleWithImage){
								x *=iw;
								y *= ih;
							}
							if(uvmatr){
								x2 = matrhelp.a * x + matrhelp.c * y + matrhelp.tx;
								y2 = matrhelp.d * y + matrhelp.b * x + matrhelp.ty;
								newuvdata[(si + k)*2] = x2;
								newuvdata[(si + k)*2 + 1] = y2;
							}else{
								newuvdata[(si + k)*2] = x;
								newuvdata[(si + k)*2 + 1] = y;
							}
						}else{
							newcolordata[(si + k)*4] = colordata[k*4];
							newcolordata[(si + k)*4+1] = colordata[k*4+1];
							newcolordata[(si + k)*4+2] = colordata[k*4+2];
							newcolordata[(si + k)*4+3] = colordata[k*4+3];
						}
					}
					var did:Uint16Array = drawable.index.data;
					var didl:int = did.length;
					for (k = 0; k < didl;k++){
						var vi:int = did[k];
						newidata[il + k] = vi + si;
					}
					si += len2;
					il += didl;
				}
				newDrawable.index.dirty = true;
				newDrawable.pos.dirty = true;
				if(isImage){
					newDrawable.uv.dirty = true;
				}else{
					newDrawable.color.dirty = true;
				}
				renderImage(image, newDrawable, null, null, false);
			}
		}

		public function fill (opt_fillRule:String = "") : Object {
			if (fillStyle is GLCanvasPattern) {
				var glcp:GLCanvasPattern = fillStyle as GLCanvasPattern;
				drawImageInternal(glcp.image, currentPath.drawable,currentPath.matr,matr,false);
			}else{
				var color:GLVertexBufferSet = currentPath.drawable.color;
				color.dirty = true;
				var data:Float32Array = color.data;
				var c:String = fillStyle.substring(fillStyle.indexOf("(") + 1, fillStyle.indexOf(")"));
				var carr:Array = c.split(",");
				var carrn:Array = [parseFloat(carr[0])/0xff,parseFloat(carr[1])/0xff,parseFloat(carr[2])/0xff,parseFloat(carr[3])];
				var len:int = data.length;
				for (var i:int = 0; i < len;i+=4 ){
					data[i] = carrn[0];
					data[i+1] = carrn[1];
					data[i+2] = carrn[2];
					data[i+3] = carrn[3];
				}
				drawImageInternal(fillStyle, currentPath.drawable,currentPath.matr,null,false);
			}
			return null;
		}

		public function fillRect (x:Number, y:Number, w:Number, h:Number) : Object {
			return null;
		}

		public function fillText (text:String, x:Number, y:Number, opt_maxWidth:Number = 0) : Object {
			return null;
			var image:HTMLCanvasElement = text2img[text];
			if (image==null) {
				image = text2img[text]=document.createElement("canvas") as HTMLCanvasElement;
				var ctx:CanvasRenderingContext2D = image.getContext("2d") as CanvasRenderingContext2D;
				ctx.font = font;
				var measure:TextMetrics = ctx.measureText(text);
				image.width = measure.width;
				image.height = int(font.substr(0, font.indexOf("px")));
				ctx.font = font;
				ctx.textBaseline = "top";
				ctx.fillStyle = fillStyle;
				ctx.fillText(text, 0, 0);
			}
			matrhelp.copyFrom(matr);
			matrhelp.translate(x, y);
			drawImageInternal(image, bitmapDrawable,matrhelp,null,true);
			return null;
		}

		public function getImageData (sx:Number, sy:Number, sw:Number, sh:Number) : ImageData {
			return null;
		}

		public function isPointInPath (x:Number, y:Number, opt_fillRule:String = "") : Boolean {
			return false;
		}

		public function lineTo (x:Number, y:Number) : Object {
			currentPath.path.lineTo(x, y);
			return null;
		}

		public function measureText (text:String) : TextMetrics {
			return null;
		}

		public function moveTo (x:Number, y:Number) : Object {
			currentPath.path.moveTo(x, y);
			return null;
		}

		public function putImageData (imagedata:ImageData, dx:Number, dy:Number, opt_dirtyX:Number = 0, opt_dirtyY:Number = 0, opt_dirtyWidth:Number = 0, opt_dirtyHeight:Number = 0) : Object {
			return null;
		}

		public function quadraticCurveTo (cpx:Number, cpy:Number, x:Number, y:Number) : Object {
			currentPath.path.curveTo(cpx, cpy, x, y);
			return null;
		}

		public function rect (x:Number, y:Number, w:Number, h:Number) : Object {
			currentPath.path.moveTo(x, y);
			currentPath.path.lineTo(x + w, y);
			currentPath.path.lineTo(x + w, y + h);
			currentPath.path.lineTo(x, y + h);
			currentPath.path.closePath();
			return null;
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
			var btexture:BitmapTexture = img._texture;
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
				img._texture = btexture;
				//bmd2texture.set(img, btexture);
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