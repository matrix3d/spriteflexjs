package flash.__native 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author lizhi
	 */
	public class IRenderer 
	{
		
		public function IRenderer() 
		{
			
		}
		
		public function createPath():GraphicsPath{
			return null;
		}
		
		public function getCssColor(color:uint,alpha:Number,ct:ColorTransform,toarr:Array):Object{
			return null;
		}
		
		public function renderGraphics(ctx:CanvasRenderingContext2D,g:Graphics,m:Matrix,blendMode:String,colorTransform:ColorTransform):void{
			
		}
		
		public function renderImage(ctx:CanvasRenderingContext2D,img:BitmapData,m:Matrix,blendMode:String,colorTransform:ColorTransform, offsetX:Number = 0, offsetY:Number = 0):void{
			
		}
		
		public function renderVideo(ctx:CanvasRenderingContext2D,video:HTMLVideoElement,m:Matrix, width:int, height:int, blendMode:String,colorTransform:ColorTransform):void{
			
		}
		
		public function renderText(ctx:CanvasRenderingContext2D,txt:String,textFormat:TextFormat, m:Matrix, blendMode:String, colorTransform:ColorTransform,x:Number,y:Number):void{
			
		}
		
		public function finish(ctx:CanvasRenderingContext2D):void{
			
		}
		public function start(ctx:CanvasRenderingContext2D):void{
			
		}
	}

}