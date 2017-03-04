package flash.__native 
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
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
		public var fillStyleIsImage:Boolean;
		public var font : String;
		public var getLineDash : Object;
		public var globalAlpha : Number=1;
		//public var globalRed : Number=1;
		//public var globalGreen : Number=1;
		//public var globalBlue : Number=1;
		public var colorTransform:ColorTransform;
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
		public var bitmapDrawable:GLDrawable;
		private var bitmapProg:Program3D;
		private var colorProg:Program3D;
		private var matr3d:Matrix3D = new Matrix3D;
		private var uvmatr3d:Matrix3D = new Matrix3D;
		public var matr:Matrix = new Matrix;
		private var matrhelp:Matrix = new Matrix;
		private var stage:Stage;
		private var isBatch:Boolean;
		private var batchs:Array = [];
		private var batchsLen:int = 0;
		private var states:Array = [];
		private var statesPos:int = -1;
		private var posPool:Object = {};
		private var uvPool:Object = {};
		private var colorPool:Object = {};
		private var indexPool:Object = {};
		private var newDrawable:GLDrawable = new GLDrawable(null, null, null,WebGLRenderingContext.DYNAMIC_DRAW);
		
		private var lastImage:Object;
		private var lastImageIsImage:Object;
		private var numPos:int = 0;
		private var numIndex:int = 0;
		private var updateColor:Boolean = true;
		public function GLCanvasRenderingContext2D(stage:Stage,isBatch:Boolean=false) 
		{
			this.isBatch = isBatch;
			this.stage = stage;
			this.canvas = stage.canvas;
			ctx = new Context3D;
			ctx.canvas = canvas;
			ctx.gl = (canvas.getContext("webgl", {alpha:false,antialias:false}) || canvas.getContext("experimental-webgl", {alpha:false,antialias:false})) as WebGLRenderingContext;
			stage_resize(null);
			ctx.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
			ctx.setCulling(Context3DTriangleFace.NONE);
			
			var posData:Float32Array = new Float32Array([0, 0, 1, 0, 0, 1, 1, 1]);
			var iData:Uint16Array = new Uint16Array([0, 2, 1, 2, 1, 3]);
			bitmapDrawable = new GLDrawable(posData, posData,iData,ctx.gl.STATIC_DRAW);
			
			var vcode:String = 
				"attribute vec2 va0;" +
				"attribute vec4 va1;" +
				"attribute vec2 va2;" +
				"varying vec4 vColor;"+
				"varying vec2 vUV;" +
				"uniform mat4 vc0;"+
				"uniform mat4 vc4;"+
				"void main(void) {" +
					"vColor=va1;"+
					"vUV=(vc4*vec4(va2,0.0,1.0)).xy;"+
					"gl_Position =vc0*vec4(va0, 0.0,1.0);"+
				"}";
			var fcode:String = "precision lowp float;" +
				"varying vec4 vColor;"+
				"varying vec2 vUV;"+
				"uniform sampler2D fs0;"+
			   "void main(void) {" +
					"gl_FragColor = texture2D(fs0,vUV)*vColor;"+
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
					"gl_Position =vc0*vec4(va0, 0.0,1.0);"+
				"}";
			fcode = "precision lowp float;" +
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
		}
		
		private function stage_resize(e:Event):void 
		{
			ctx.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, false);
		}
		
		public function arc (x:Number, y:Number, radius:Number, startAngle:Number, endAngle:Number/*, opt_anticlockwise:Boolean=false*/) : Object{
			currentPath.path.arc(x, y, radius, startAngle, endAngle);
			return null;
		}

		public function arcTo (x1:Number, y1:Number, x2:Number, y2:Number, radius:Number) : Object {
			//currentPath.path.arc(x1, y1, x2, y2, radius);
			return null;
		}

		/**
		 * @flexjsignorecoercion flash.__native.GLGraphicsPath
		 */
		public function beginPath () : Object {
			currentPath = new GLPath2D;
			currentPath.path = SpriteFlexjs.renderer.createPath() as GLGraphicsPath;
			currentPath.matr = matr;
			return null;
		}

		public function bezierCurveTo (cp1x:Number, cp1y:Number, cp2x:Number, cp2y:Number, x:Number, y:Number) : Object {
			currentPath.path.cubicCurveTo(cp1x, cp1y, cp2x, cp2y, x, y);
			return null;
		}

		public function clearRect (x:Number, y:Number, w:Number, h:Number) : Object {
			ctx.clear(0,0,0);
			batchsLen = 0;
			SpriteFlexjs.batDrawCounter = 0;
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

		public function drawImage (image:Object, dx:Number, dy:Number/*, opt_dw:Number = 0, opt_dh:Number = 0, opt_sx:Number = 0, opt_sy:Number = 0, opt_sw:Number = 0, opt_sh:Number = 0*/) : Object {
			drawImageInternal(image,bitmapDrawable, matr,null,true,colorTransform.tint,true,true);
			return null;
		}
		
		/**
		 * @flexjsignorecoercion flash.__native.GLGraphicsPath
		 */
		public function drawPath (path:GraphicsPath, colorTransform:ColorTransform) : Object {
			currentPath = path["glpath2d"];
			if (path["glpath2d"]==null){
				currentPath = path["glpath2d"] = new GLPath2D;
			}
			currentPath.path = path as GLGraphicsPath;
			currentPath.matr = matr;
			return null;
		}
		
		/**
		 * @flexjsignorecoercion Uint32Array
		 */
		public function drawImageInternal(image:Object, drawable:GLDrawable, posmatr:Matrix, uvmatr:Matrix, scaleWithImage:Boolean,color:uint,scaleWithImageUV:Boolean,isImage:Boolean):void{
			if (!isBatch){
				if(image){
					var colorb:GLVertexBufferSet = drawable.color;
					colorb.dirty = true;
					var data:Uint32Array = colorb.data as Uint32Array;
					var len:int = data.length;
					for (var i:int = 0; i < len;i++ ){
						data[i] = color;//color[0];
						//data[i + 1] = color[1];
						//data[i + 2] = color[2];
						//data[i + 3] = color[3];
					}
					renderImage(image, drawable, posmatr, uvmatr, scaleWithImage, scaleWithImageUV, isImage);
				}
			}else{
				if (!isImage&&!lastImageIsImage){
					
				}else if (image==null||lastImage != image){
					if (numPos > 0){
						batchFinish();
					}
					numPos = 0;
					numIndex = 0;
					lastImage = image;
					lastImageIsImage = isImage;
				}
				if (drawable){
					numPos += drawable.pos.data.length / 2;
					numIndex += drawable.index.data.length / 3;
				}
				var batch:Array = batchs[batchsLen];
				if (batch == null){
					batch = batchs[batchsLen] = [];
				}
				batchsLen++;
				batch[0] = image;
				batch[1] = drawable;
				batch[2] = posmatr;
				batch[3] = uvmatr;
				batch[4] = scaleWithImage;
				batch[5] = color;
				batch[6] = scaleWithImageUV;
				batch[7] = isImage;
			}
		}
		
		private function renderImage(image:Object, drawable:GLDrawable, posmatr:Matrix, uvmatr:Matrix, scaleWithImage:Boolean,scaleWithImageUV:Boolean,isImage:Boolean):void{
			SpriteFlexjs.batDrawCounter++;
			if (!isImage){
				ctx.setProgram(colorProg);
			}else{
				var texture:BitmapTexture = getTexture(image);
				ctx.setProgram(bitmapProg);
				ctx.setTextureAt(0, texture.texture);
				ctx.setVertexBufferAt(2, drawable.uv.getBuff(ctx), 0, Context3DVertexBufferFormat.FLOAT_2);
			}
			ctx.setVertexBufferAt(0, drawable.pos.getBuff(ctx),0, Context3DVertexBufferFormat.FLOAT_2);
			ctx.setVertexBufferAt(1, drawable.color.getBuff(ctx), 0, Context3DVertexBufferFormat.BYTES_4);
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
			if(isImage){
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
					if (scaleWithImageUV){
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
					if (scaleWithImageUV){
						uvmatr3d.rawData[0] *= image.width;
						uvmatr3d.rawData[5] *= image.height;
					}
				}
				ctx.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, uvmatr3d);
			}
			
			switch (globalCompositeOperation) {
				/*case BlendMode.NORMAL:
					var sourceFactor:String = Context3DBlendFactor.ONE;
					var destinationFactor:String = Context3DBlendFactor.ZERO;
					break;*/
				/*case BlendMode.LAYER:
					sourceFactor = Context3DBlendFactor.SOURCE_ALPHA;
					destinationFactor = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
					break;*/
				case BlendMode.MULTIPLY:
					var sourceFactor:String = Context3DBlendFactor.ZERO;
					var destinationFactor:String = Context3DBlendFactor.SOURCE_COLOR;
					break;
				case BlendMode.ADD:
					sourceFactor = Context3DBlendFactor.SOURCE_ALPHA;
					destinationFactor = Context3DBlendFactor.ONE;
					break;
				case BlendMode.ALPHA:
					sourceFactor = Context3DBlendFactor.ZERO;
					destinationFactor = Context3DBlendFactor.SOURCE_ALPHA;
					break;
				default:
					sourceFactor = Context3DBlendFactor.SOURCE_ALPHA;
					destinationFactor = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
					break;
					
			}
			ctx.setBlendFactors(sourceFactor, destinationFactor);
			ctx.drawTriangles(drawable.index.getBuff(ctx),0,drawable.numTriangles);
		}
		
		/**
		 * @flexjsignorecoercion Float32Array
		 * @flexjsignorecoercion Uint32Array
		 * @flexjsignorecoercion Number
		 */
		private function batchFinish():void{
			var posKey:int = getNextPow2(numPos);
			var indexKey:int = getNextPow2(numIndex);
			var newpos:GLVertexBufferSet = posPool[posKey];
			var newuv:GLVertexBufferSet = uvPool[posKey];
			var newcolor:GLVertexBufferSet = colorPool[posKey];
			var newi:GLIndexBufferSet = indexPool[indexKey];
			if (newpos==null){
				newpos = posPool[posKey] = new GLVertexBufferSet(new Float32Array(posKey * 2), 2,ctx.gl.DYNAMIC_DRAW);
				trace("bat new pos",posKey,numPos);
			}
			if (newuv==null&&lastImageIsImage){
				newuv = uvPool[posKey] = new GLVertexBufferSet(new Float32Array(posKey * 2), 2, ctx.gl.DYNAMIC_DRAW);
			}
			if (newcolor==null&&updateColor){
				newcolor = colorPool[posKey] = new GLVertexBufferSet(new Uint32Array(posKey), 4,ctx.gl.DYNAMIC_DRAW);
			}
			if (newi==null){
				newi = indexPool[indexKey] = new GLIndexBufferSet(new Uint16Array(indexKey * 3),ctx.gl.DYNAMIC_DRAW);
				trace("bat new index",indexKey,numIndex);
			}
			var newposdata:Float32Array = newpos.data as Float32Array;
			if(lastImageIsImage){
				var newuvdata:Float32Array = newuv.data as Float32Array;
			}
			if(updateColor){
				var newcolordata:Uint32Array = newcolor.data as Uint32Array;
			}
			var newidata:Uint16Array = newi.data;
			newDrawable.index = newi;
			newDrawable.pos = newpos;
			newDrawable.uv = newuv;
			newDrawable.color = newcolor;
			newDrawable.numTriangles = numIndex;
			var si:int = 0;
			var il:int = 0;
			if (lastImageIsImage){
				var iw:int = lastImage.width as Number;
				var ih:int = lastImage.height as Number;
			}
			var len:int = batchsLen;
			for (var i:int = 0; i < len; i++ ){
				var batch:Array = batchs[i];
				var drawable2:GLDrawable = batch[1]; 
				var posmatr:Matrix = batch[2];
				var scaleWithImage:Boolean = batch[4];
				var scaleWithImageUV:Boolean = batch[6];
				var color:uint = batch[5] as Number;
				if(lastImageIsImage){
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
				var data:Float32Array = drawable2.pos.data as Float32Array;
				if(lastImageIsImage){
					var uvdata:Float32Array = drawable2.uv.data as Float32Array;
				}
				var len2:int = data.length/2 ;
				for (var j:int = 0; j < len2; j++ ){
					var x:Number = data[j*2] as Number;
					var y:Number = data[j*2 + 1] as Number;
					if (scaleWithImage){
						x *= iw;
						y *= ih;
					}
					var x2:Number = posmatr.a * x + posmatr.c * y + posmatr.tx;
					var y2:Number = posmatr.d * y + posmatr.b * x + posmatr.ty;
					newposdata[(si + j)*2] = x2;
					newposdata[(si + j)*2 + 1] = y2;
					if(lastImageIsImage){
						x = uvdata[j*2] as Number;
						y = uvdata[j*2 + 1] as Number;
						if (scaleWithImageUV){
							x *=iw;
							y *= ih;
						}
						if(uvmatr){
							x2 = matrhelp.a * x + matrhelp.c * y + matrhelp.tx;
							y2 = matrhelp.d * y + matrhelp.b * x + matrhelp.ty;
							newuvdata[(si + j)*2] = x2;
							newuvdata[(si + j)*2 + 1] = y2;
						}else{
							newuvdata[(si + j)*2] = x;
							newuvdata[(si + j)*2 + 1] = y;
						}
					}
					if(updateColor){
						newcolordata[(si + j)] = color;//0xff0000ff// color[0];
						//newcolordata[(si + j)*4+1] = color[1];
						//newcolordata[(si + j)*4+2] = color[2];
						//newcolordata[(si + j)*4+3] = color[3];
					}
				}
				var did:Uint16Array = drawable2.index.data;
				var didl:int = did.length;
				for (j = 0; j < didl;j++){
					var vi:int = did[j] as Number;
					newidata[il + j] = vi + si;
				}
				si += len2;
				il += didl;
			}
			newDrawable.index.dirty = true;
			newDrawable.pos.dirty = true;
			if(lastImageIsImage){
				newDrawable.uv.dirty = true;
			}
			if(updateColor){
				newDrawable.color.dirty = true;
			}
			renderImage(lastImage, newDrawable, null, null, false, false, lastImageIsImage);
			batchsLen = 0;
		}

		/**
		 * @flexjsignorecoercion flash.__native.GLCanvasPattern
		 * @flexjsignorecoercion uint
		 */
		public function fill (/*opt_fillRule:String = ""*/) : Object {
			if (fillStyleIsImage) {
				var glcp:GLCanvasPattern = fillStyle as GLCanvasPattern;
				drawImageInternal(glcp.image, currentPath.drawable,currentPath.matr,matr,false,colorTransform.tint,currentPath.path.tris.length>0,true);
			}else if(currentPath){
				drawImageInternal(fillStyle, currentPath.drawable,currentPath.matr,null,false,fillStyle as uint,false,false);
			}
			return null;
		}

		public function fillRect (x:Number, y:Number, w:Number, h:Number) : Object {
			return null;
		}

		public function fillText (text:String, x:Number, y:Number/*, opt_maxWidth:Number = 0*/) : Object {
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
			drawImageInternal(image, bitmapDrawable,matrhelp.clone(),null,true,colorTransform.tint,true,true);
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

		/*public function restore () : Object {
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
		
		public function translate (x:Number, y:Number) : Object {
			matr.translate(x, y);
			return null;
		}*/

		public function setTransform (m11:Number, m12:Number, m21:Number, m22:Number, dx:Number, dy:Number) : Object {
			//matr.setTo(m11, m12, m21, m22, dx, dy);
			return null;
		}
		public function setTransform2 (m:Matrix) : Object {
			matr = m;// r.copyFrom(m);
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

		/*public function transform (m11:Number, m12:Number, m21:Number, m22:Number, dx:Number, dy:Number) : Object {
			matrhelp.setTo(m11, m12, m21, m22, dx, dy);
			matr.concat(matrhelp);
			return null;
		}*/
		public function transform2 (m:Matrix) : Object {
			var result_a:Number = matr.a / m.a;
			var result_b:Number = 0.0;
			var result_c:Number = 0.0;
			var result_d:Number = matr.d / m.d;
			var result_tx:Number = matr.tx / m.a + m.tx / m.a;
			var result_ty:Number = matr.ty / m.d + m.ty / m.d;
			if (matr.b != 0.0 || matr.c != 0.0 || m.b != 0.0 || m.c != 0.0)
			{
				result_a = result_a + matr.b * m.c;
				result_d = result_d + matr.c * m.b;
				result_b = result_b + (matr.a * m.b + matr.b * m.d);
				result_c = result_c + (matr.c * m.a + matr.d * m.c);
				result_tx = result_tx + matr.ty * m.c;
				result_ty = result_ty + matr.tx * m.b;
			}
			m.a = result_a;
			m.b = result_b;
			m.c = result_c;
			m.d = result_d;
			m.tx = result_tx;
			m.ty = result_ty;
			matr = m;
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
