package 
{
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
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
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import spriteflexjs.Stats;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestStage3DGLSL extends Sprite
	{
		private var ctx:Context3D;
		private var vmatr:Matrix3D = new Matrix3D;
		private var pmatr:Matrix3D = new Matrix3D;
		private var bmd:BitmapData;
		private var vcode:String;
		private var fcode:String;
		private var meshs:Array = [];
		private var lightPos:Vector.<Number>=Vector.<Number>([0,20,-10,0])
		private var lightColor:Vector.<Number>=Vector.<Number>([1,1,1,1])
		public function TestStage3DGLSL() 
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, jpg_loader_complete);
			loader.load(new URLRequest("../../assets/wood.jpg"));
			addChild(new Stats);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		private function enterFrame(e:Event):void 
		{
			pmatr.copyRawDataFrom(perspectiveFieldOfViewLH(Math.PI/4, stage.stageWidth/ stage.stageHeight, .1,100000));
			vmatr.identity();
			vmatr.appendTranslation(0, 0, -30);
			vmatr.appendRotation(getTimer()/100, Vector3D.Y_AXIS);
			vmatr.invert();
			
			ctx.clear();
			//draw
			var first:Boolean = true;
			for each(var mesh:Mesh in meshs) {
				ctx.setProgram(mesh.program);
				var mmatr:Matrix3D = mesh.mmatr;
				CONFIG::as_only {
					if (first) {
						first = false;
						ctx.setTextureAt(0, mesh.texture);
						ctx.setVertexBufferAt(0, mesh.posBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
						ctx.setVertexBufferAt(1, mesh.normBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
						ctx.setVertexBufferAt(2, mesh.uvBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
						ctx.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, vmatr,true);
						ctx.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 8, pmatr,true);
						ctx.setProgramConstantsFromVector(Context3DProgramType.VERTEX,12,lightPos);//light pos
						ctx.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,mesh.specular);//specular
						ctx.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,1,lightColor);//light color
						ctx.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 2, mesh.ambient);//ambient
						ctx.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 3, Vector.<Number>([0.7, 2, 0, 0]));
					}
					ctx.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, mmatr,true);
				}
				CONFIG::js_only {
					if (first) {
						first = false;
						ctx.setTextureAtGL("uSampler", 0, mesh.texture);
						ctx.setVertexBufferAtGL("aVertexPosition", mesh.posBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
						ctx.setVertexBufferAtGL("aVertexNormal", mesh.normBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
						ctx.setVertexBufferAtGL("aTextureCoord", mesh.uvBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
						
						ctx.setProgramConstantsFromMatrixGL("uVMatrix", vmatr,false);
						ctx.setProgramConstantsFromMatrixGL("uPMatrix", pmatr, false);
						var gl:WebGLRenderingContext = mesh.program.gl;
						//draw
						gl.uniform1f(mesh.program.getUniformLocation("uMaterialShininess"), mesh.specular[0]);
						gl.uniform1i(mesh.program.getUniformLocation("uShowSpecularHighlights"), 1);
						gl.uniform1i(mesh.program.getUniformLocation("uUseTextures"), 1);
						gl.uniform1i(mesh.program.getUniformLocation("uUseLighting"), 1);
						gl.uniform3f(mesh.program.getUniformLocation("uAmbientColor"), mesh.ambient[0], mesh.ambient[1], mesh.ambient[2]);
						gl.uniform3f(mesh.program.getUniformLocation("uPointLightingLocation"), lightPos[0], lightPos[1], lightPos[2]);
						gl.uniform3f(mesh.program.getUniformLocation("uPointLightingSpecularColor"), 1, 1, 1);
						gl.uniform3f(mesh.program.getUniformLocation("uPointLightingDiffuseColor"), lightColor[0], lightColor[1], lightColor[2]);
					}
					ctx.setProgramConstantsFromMatrixGL("uMMatrix", mmatr,false);
				}
				ctx.drawTriangles(mesh.ibuffer,0);
			}
			ctx.present();
		}
		
		private function jpg_loader_complete(e:Event):void 
		{
			var target:LoaderInfo = e.currentTarget as LoaderInfo;
			bmd = (target.content as Bitmap).bitmapData;
			
			var loader:URLLoader = new URLLoader(new URLRequest("../../assets/glsl/per-fragment-lighting.vert"));
			loader.addEventListener(Event.COMPLETE, vert_loader_complete);
		}
		
		private function vert_loader_complete(e:Event):void 
		{
			var loader:URLLoader = e.currentTarget as URLLoader;
			vcode = loader.data + "";
			loader = new URLLoader(new URLRequest("../../assets/glsl/per-fragment-lighting.frag"));
			loader.addEventListener(Event.COMPLETE, frag_loader_complete);
		}
		
		private function frag_loader_complete(e:Event):void 
		{
			var loader:URLLoader = e.currentTarget as URLLoader;
			fcode = loader.data + "";
			
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
				var vb:ByteArray = new ByteArray;
				vb.writeUTFBytes( vcode);
				var fb:ByteArray = new ByteArray;
				fb.writeUTFBytes( fcode);
			}
			
			CONFIG::as_only{
				vcode = 
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
				fcode =<![CDATA[
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
			var ibuffer:IndexBuffer3D = ctx.createIndexBuffer(iData.length);
			ibuffer.uploadFromVector(Vector.<uint>(iData),0,iData.length);
			addEventListener(Event.ENTER_FRAME, enterFrame);
			for (var i:int = 0; i < 100;i++ ) {
				var mesh:Mesh = new Mesh;
				mesh.ibuffer = ibuffer;
				mesh.mmatr = new Matrix3D;
				mesh.normBuffer = normBuffer;
				mesh.posBuffer = posBuffer;
				mesh.program = program;
				mesh.texture = texture;
				mesh.uvBuffer = uvBuffer;
				mesh.mmatr.appendRotation(360 * Math.random(), Vector3D.X_AXIS);
				mesh.mmatr.appendRotation(360 * Math.random(), Vector3D.Y_AXIS);
				mesh.mmatr.appendRotation(360 * Math.random(), Vector3D.Z_AXIS);
				mesh.mmatr.prependTranslation((Math.random() - .5)*20, (Math.random() - .5)*20, (Math.random() - .5)*20 );
				meshs.push(mesh);
			}
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
import flash.display3D.IndexBuffer3D;
import flash.display3D.Program3D;
import flash.display3D.textures.Texture;
import flash.display3D.VertexBuffer3D;
import flash.geom.Matrix3D;
import flash.geom.Vector3D;

class Mesh {
	public var ibuffer:IndexBuffer3D;
	public var mmatr:Matrix3D = new Matrix3D;
	public var texture:Texture;
	public var program:Program3D;
	public var normBuffer:VertexBuffer3D;
	public var uvBuffer:VertexBuffer3D;
	public var posBuffer:VertexBuffer3D;
	public var specular:Vector.<Number> = Vector.<Number>([30,0,0,0]);
	public var ambient:Vector.<Number> = Vector.<Number>([.5, .5, .5, 1]);
	public function Mesh() 
	{
	}
}