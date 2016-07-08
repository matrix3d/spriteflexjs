package 
{
	import flash.__native.GLCanvasRenderingContext2D;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.utils.getTimer;
	import spriteflexjs.Stats;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestWebgl2D 
	{
		private var renderer:GLCanvasRenderingContext2D;
		private var bmd:BitmapData;
		private var num:int = 30;
		private var poss:Array = [];
		public function TestWebgl2D() 
		{
			renderer = new GLCanvasRenderingContext2D(new Stage,true);
			renderer.colorTransform = new ColorTransform;
			bmd = new BitmapData(10, 10, false, 0xffffff * Math.random());
			for (var i:int = 0; i < num;i++ ){
				poss.push([0xff0000ff,new Matrix(1,0,0,1,400*Math.random(),400*Math.random())]);
			}
			
			
			animation();
		}
		
		public function animation():void{
			requestAnimationFrame(animation);
			renderer.clearRect(0, 0, 0, 0);
			for (var i:int = 0; i < num;i++ ){
				renderer.drawImageInternal(bmd.image, renderer.bitmapDrawable, poss[i][1], null, true, poss[i][0], false, true);
			}
			renderer.drawImageInternal(null,null,null,null,false,null,true,true);
		}
		
	}

}