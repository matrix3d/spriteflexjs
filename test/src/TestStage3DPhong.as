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
		private var mmatr:Matrix3D = new Matrix3D;
		private var vmatr:Matrix3D = new Matrix3D;
		private var pmatr:Matrix3D = new Matrix3D;
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
			mmatr.identity();
			var time:Number = (new Date()).getTime();
			mmatr.appendRotation(time/100, Vector3D.X_AXIS);
			mmatr.appendRotation(time/130, Vector3D.Y_AXIS);
			vmatr.identity();
			vmatr.appendTranslation(0, 0, -10);
			vmatr.invert();
			ctx.clear();
			ctx.setCulling(Context3DTriangleFace.NONE);
			ctx.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, mmatr,true);
			ctx.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, vmatr,true);
			ctx.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 8, pmatr,true);
			ctx.setProgramConstantsFromVector(Context3DProgramType.VERTEX,12,Vector.<Number>([0,20,-10,0]));//light pos
			ctx.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,Vector.<Number>([10,0,0,0]));//specular
			ctx.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,1,Vector.<Number>([.7,.4,.2,1]));//light color
			ctx.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 2, Vector.<Number>([.5, .5, .5, 1]));//ambient
			
			CONFIG::as_only {
				ctx.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 3, Vector.<Number>([0.7,2,0,0]));
			}
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
				var vcode:String = 
					"uniform mat4 vc0;"+
					"uniform mat4 vc4;"+
					"uniform mat4 vc8;"+
					"uniform vec4 vc12;"+
					"varying vec4 v0;"+
					"varying vec4 v1;"+
					"varying vec4 v2;"+
					"varying vec4 v3;"+
					"attribute vec4 va0;"+
					"attribute vec4 va1;"+
					"attribute vec4 va2;"+
					"void main(){"+
					"	vec4 vt0 = va0 * vc0;"+
					"	vec4 vt1 = vt0 * vc4;"+
					"	vt0 = vt1 * vc8;"+
					"	gl_Position = vt0;"+
					"	vt0.xyz = va1 * vc0;"+
					"	vec4 vt2"+
					"	vt2.xyz = normalize(vt3.xyz);"+
					"	vt0 = -vt1;"+
					"	vec4 vt3"+
					"	vt3.xyz = normalize(vt0.xyz);"+
					"	v0 = vt6;"+
					"	vt0 = vc12;"+
					"	vt3 = vt0 * vc4;"+
					"	vt0 = vt3 - vt1;"+
					"	vt1.xyz = normalize(vt0.xyz);"+
					"	v1 = vt10;"+
					"	vt0.xyz = vt4 * vc4;"+
					"	vt1.xyz = normalize(vt11);"+
					"	v2 = vt12;"+
					"	v3 = va2;"+
					"}"
				var fcode:String = 
					"uniform sampler2D fs0;"+
					"uniform vec4 fc3;"+
					"uniform vec4 fc0;"+
					"uniform vec4 fc1;"+
					"uniform vec4 fc2;"+
					"varying vec4 v3;"+
					"varying vec4 v2;"+
					"varying vec4 v1;"+
					"varying vec4 v0;"+
					"void main(){"+
					"	vec4 ft0 = texture2D(v3,fs0);"+
					"	vec4 ft1 = ft0 - fc3;"+
					"	ft1 = dot(v2,v1);"+
					"	vec4 ft2 = clamp(ft1,0,1);"+
					"	ft1.xyz = dot(v1.xyz,v2.xyz);"+
					"	vec4 ft3 = fc3 * ft1;"+
					"	ft1 = ft3 * v2;"+
					"	ft3 = ft1 - v1;"+
					"	ft1.xyz = normalize(ft3);"+
					"	ft3.xyz = dot(v0.xyz,ft8.xyz);"+
					"	ft1 = clamp(ft3,0,1);"+
					"	ft3 = pow(ft1,fc0);"+
					"	ft1 = ft2 + ft3;"+
					"	ft2 = fc1 * ft1;"+
					"	ft1 = ft2 * fc1;"+
					"	ft2 = fc2 + ft1;"+
					"	ft2.w = ft0.x;"+
					"	ft0 = ft2 * ft0;"+
					"	gl_FragColor = ft0;"+
					"}"
					var vb:ByteArray = new ByteArray;
					vb.writeUTFBytes( vcode);
					var fb:ByteArray = new ByteArray;
					fb.writeUTFBytes( fcode);
				}
			
			CONFIG::as_only{
				var vcode:String = 
				<![CDATA[
					m44 vt0 va0 vc0
					m44 vt1 vt0 vc4
					m44 vt0 vt1 vc8
					mov op vt0
					m33 vt0.xyz va1 vc0
					nrm vt2.xyz vt0.xyz
					neg vt0 vt1
					nrm vt3.xyz vt0
					mov v0 vt3.xyz
					mov vt0 vc12
					m44 vt3 vt0 vc4
					sub vt0 vt3 vt1
					nrm vt1.xyz vt0
					mov v1 vt1.xyz
					m33 vt0.xyz vt2.xyz vc4
					nrm vt1.xyz vt0.xyz
					mov v2 vt1.xyz
					mov v3 va2
				]]>
				var fcode:String =<![CDATA[
					tex ft0 v3 fs0
					sub ft1 ft0.w fc3.x
					kil ft1.x
					dp3 ft1 v2 v1
					sat ft2 ft1
					dp3 ft1 v1 v2
					mul ft3 fc3.y ft1
					mul ft1 ft3 v2
					sub ft3 ft1 v1
					nrm ft1.xyz ft3
					dp3 ft3 v0 ft1.xyz
					sat ft1 ft3
					pow ft3 ft1 fc0.x
					add ft1 ft2 ft3
					mul ft2 fc1 ft1
					mul ft1 ft2 fc1.w
					add ft2 fc2 ft1
					mov ft2.w ft0.w
					mul ft0 ft2 ft0
					mov oc ft0
				]]>
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
			
			var normData:Array = 
            [// Front face
             0.0,  0.0,  1.0,
             0.0,  0.0,  1.0,
             0.0,  0.0,  1.0,
             0.0,  0.0,  1.0,

            // Back face
             0.0,  0.0, -1.0,
             0.0,  0.0, -1.0,
             0.0,  0.0, -1.0,
             0.0,  0.0, -1.0,

            // Top face
             0.0,  1.0,  0.0,
             0.0,  1.0,  0.0,
             0.0,  1.0,  0.0,
             0.0,  1.0,  0.0,

            // Bottom face
             0.0, -1.0,  0.0,
             0.0, -1.0,  0.0,
             0.0, -1.0,  0.0,
             0.0, -1.0,  0.0,

            // Right face
             1.0,  0.0,  0.0,
             1.0,  0.0,  0.0,
             1.0,  0.0,  0.0,
             1.0,  0.0,  0.0,

            // Left face
            -1.0,  0.0,  0.0,
            -1.0,  0.0,  0.0,
            -1.0,  0.0,  0.0,
            -1.0,  0.0,  0.0];
			var normBuffer:VertexBuffer3D = ctx.createVertexBuffer(normData.length/3,3);
			normBuffer.uploadFromVector(Vector.<Number>(normData), 0, normData.length / 3);
			
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
			ctx.setVertexBufferAt(1, normBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			ctx.setVertexBufferAt(2, uvBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
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