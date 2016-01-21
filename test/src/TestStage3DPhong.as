package 
{
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DTriangleFace;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.textures.Texture;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestStage3DPhong extends Sprite
	{
		private var ctx:Context3D;
		private var ibuffer:IndexBuffer3D;
		private var pmatr:Matrix3D = new Matrix3D;
		private var matr:Matrix3D = new Matrix3D();
		private var bmd:BitmapData;
		public function TestStage3DPhong() 
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
			loader.load(new URLRequest("../../wood.jpg"));
		}
		
		private function enterFrame(e:Event):void 
		{
			pmatr.copyRawDataFrom(perspectiveFieldOfViewLH(Math.PI/4, stage.stageWidth/ stage.stageHeight, .1,100000));
			//draw
			matr.identity();
			var time:Number = (new Date()).getTime();
			matr.appendRotation(time/100, Vector3D.X_AXIS);
			matr.appendRotation(time/130, Vector3D.Y_AXIS);
			matr.appendTranslation(0, 0, 5);
			matr.append(pmatr);
			ctx.clear();
			ctx.setCulling(Context3DTriangleFace.NONE);
			ctx.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, matr,true);
			ctx.drawTriangles(ibuffer);
			ctx.present();
		}
		
		private function loader_complete(e:Event):void 
		{
			var target:LoaderInfo = e.currentTarget as LoaderInfo;
			bmd = (target.content as Bitmap).bitmapData;
			//init gl
			stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, context3dCreate);
			stage.stage3Ds[0].requestContext3D();
			
		}
		
		private function context3dCreate(e:Event):void 
		{
			stage.addEventListener(Event.RESIZE, stage_resize);
			
			ctx = stage.stage3Ds[0].context3D;
			ctx.configureBackBuffer(stage.stageWidth, stage.stageHeight, 2);
			
			//init texture
			var texture:Texture = ctx.createTexture(bmd.width, bmd.height, Context3DTextureFormat.BGRA, false);
			texture.uploadFromBitmapData(bmd);
			
			//init shader
			CONFIG::js_only{
				var vcode:String = "attribute vec3 va0;" +
					"attribute vec2 va1;" +
					"varying vec2 uv;"+
					"uniform mat4 vc0;"+
					"void main(void) {" +
						"uv=va1;"+
						"gl_Position =vec4(va0, 1.0)*vc0;"+
					"}";
				var fcode:String = "precision mediump float;" +
					"varying vec2 uv;"+
					"uniform sampler2D fs0;"+
				   "void main(void) {" +
						"gl_FragColor = texture2D(fs0,uv.xy);"+
					"}";
				var vb:ByteArray = new ByteArray;
				vb.writeUTFBytes( vcode);
				var fb:ByteArray = new ByteArray;
				fb.writeUTFBytes( fcode);
			}
			
			CONFIG::as_only{
				var vcode:String = "mov v0 va1\n"+
					"m44 op va0 vc0"
				var fcode:String = "tex oc v0 fs0"
				var assembler:AGALMiniAssembler = new AGALMiniAssembler;
				var vb:ByteArray=assembler.assemble(Context3DProgramType.VERTEX, vcode);
				var fb:ByteArray=assembler.assemble(Context3DProgramType.FRAGMENT, fcode);
			}
			
			var program:Program3D = ctx.createProgram();
			program.upload(vb, fb);
			ctx.setProgram(program);
			
			//init buffer
			var posData:Array = // Front face
            [-1.0, -1.0,  1.0,
             1.0, -1.0,  1.0,
             1.0,  1.0,  1.0,
            -1.0,  1.0,  1.0,
            // Back face
            -1.0, -1.0, -1.0,
            -1.0,  1.0, -1.0,
             1.0,  1.0, -1.0,
             1.0, -1.0, -1.0,
            // Top face
            -1.0,  1.0, -1.0,
            -1.0,  1.0,  1.0,
             1.0,  1.0,  1.0,
             1.0,  1.0, -1.0,
            // Bottom face
            -1.0, -1.0, -1.0,
             1.0, -1.0, -1.0,
             1.0, -1.0,  1.0,
            -1.0, -1.0,  1.0,
            // Right face
             1.0, -1.0, -1.0,
             1.0,  1.0, -1.0,
             1.0,  1.0,  1.0,
             1.0, -1.0,  1.0,
            // Left face
            -1.0, -1.0, -1.0,
            -1.0, -1.0,  1.0,
            -1.0,  1.0,  1.0,
            -1.0,  1.0, -1.0];
			var posBuffer:VertexBuffer3D = ctx.createVertexBuffer(posData.length/3,3);
			posBuffer.uploadFromVector(Vector.<Number>(posData), 0, posData.length / 3);
			var uvData:Array = [ // Front face
            0.0, 0.0,
            1.0, 0.0,
            1.0, 1.0,
            0.0, 1.0,
            // Back face
            1.0, 0.0,
            1.0, 1.0,
            0.0, 1.0,
            0.0, 0.0,
            // Top face
            0.0, 1.0,
            0.0, 0.0,
            1.0, 0.0,
            1.0, 1.0,
            // Bottom face
            1.0, 1.0,
            0.0, 1.0,
            0.0, 0.0,
            1.0, 0.0,
            // Right face
            1.0, 0.0,
            1.0, 1.0,
            0.0, 1.0,
            0.0, 0.0,
            // Left face
            0.0, 0.0,
            1.0, 0.0,
            1.0, 1.0,
            0.0, 1.0];
			var uvBuffer:VertexBuffer3D = ctx.createVertexBuffer(uvData.length/2,2);
			uvBuffer.uploadFromVector(Vector.<Number>(uvData),0,uvData.length/2);
			var iData:Array = [0, 1, 2,      0, 2, 3,    // Front face
            4, 5, 6,      4, 6, 7,    // Back face
            8, 9, 10,     8, 10, 11,  // Top face
            12, 13, 14,   12, 14, 15, // Bottom face
            16, 17, 18,   16, 18, 19, // Right face
            20, 21, 22,   20, 22, 23]  // Left face;
			ibuffer = ctx.createIndexBuffer(iData.length);
			ibuffer.uploadFromVector(Vector.<uint>(iData),0,iData.length);
			ctx.setVertexBufferAt(0, posBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			ctx.setVertexBufferAt(1, uvBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
			ctx.setTextureAt(0, texture);
			
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function stage_resize(e:Event):void 
		{
			ctx.configureBackBuffer(stage.stageWidth, stage.stageHeight, 2);
		}
		
		public function perspectiveFieldOfViewLH(fieldOfViewY:Number, 
												 aspectRatio:Number, 
												 zNear:Number, 
												 zFar:Number):Vector.<Number> {
			var yScale:Number = 1.0/Math.tan(fieldOfViewY/2.0);
			var xScale:Number = yScale / aspectRatio; 
			return Vector.<Number>([
				xScale, 0.0, 0.0, 0.0,
				0.0, yScale, 0.0, 0.0,
				0.0, 0.0, zFar/(zFar-zNear), 1.0,
				0.0, 0.0, (zNear*zFar)/(zNear-zFar), 0.0
			]);
		}
		
	}

}