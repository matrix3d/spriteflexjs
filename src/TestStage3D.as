package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.textures.Texture;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.net.URLRequest;
	import flash.events.Event;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestStage3D
	{
		
		public function TestStage3D() 
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
			loader.load(new URLRequest("../../wood.jpg"));
		}
		
		private function loader_complete(e:Event):void 
		{
			//init gl
			var ctx:Context3D = new Context3D;
			ctx.configureBackBuffer(400, 400, 2);
			
			//init texture
			var target:LoaderInfo = e.currentTarget as LoaderInfo;
			var bmd:BitmapData = (target.content as Bitmap).bitmapData;
			var texture:Texture = ctx.createTexture(bmd.width, bmd.height, Context3DTextureFormat.BGRA, false);
			texture.uploadFromBitmapData(bmd);
			
			//init shader
			var vcode:String = "attribute vec3 pos;" +
				"attribute vec3 color;" +
				"varying vec3 vColor;"+
				"uniform mat4 vc0;"+
				"void main(void) {" +
					"vColor=color;"+
					"gl_Position =vc0*vec4(pos, 1.0);"+
				"}";
			var fcode:String = "precision mediump float;" +
				"varying vec3 vColor;"+
				"uniform sampler2D fs0;"+
			   "void main(void) {" +
					"gl_FragColor = /*vec4(vColor,1)*/texture2D(fs0,vColor.xy);"+
				"}";
			var program:Program3D = ctx.createProgram();
			program.upload(vcode, fcode);
			ctx.setProgram(program);
			
			//init buffer
			var posData:Array = [0, .7, 0, -.7, -.7, 0, .7, -.7, 0];
			var posBuffer:VertexBuffer3D = ctx.createVertexBuffer(posData.length/3,3);
			posBuffer.uploadFromVector(Vector.<Number>(posData), 0, posData.length / 3);
			var colorData:Array = [1, 0, 0, 0, 1, 0, 0, 0, 1];
			var colorBuffer:VertexBuffer3D = ctx.createVertexBuffer(colorData.length/3,3);
			colorBuffer.uploadFromVector(Vector.<Number>(colorData),0,colorData.length/3);
			var iData:Array = [0,1,2];
			var ibuffer:IndexBuffer3D = ctx.createIndexBuffer(iData.length);
			ibuffer.uploadFromVector(Vector.<uint>(iData),0,iData.length);
			ctx.setVertexBufferAt(0, posBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			ctx.setVertexBufferAt(1, colorBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			ctx.setTextureAt(0, texture);
			
			//draw
			var matr:Matrix3D = new Matrix3D();
			setInterval(function():void { 
				matr.appendRotation(1, Vector3D.Z_AXIS);
				ctx.clear();
				ctx.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, matr);
				ctx.drawTriangles(ibuffer);
				ctx.present();
			}, 1000/60);
		}
			
		public function start():void
		{
			
		}
		
	}

}