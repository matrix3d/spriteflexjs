package flash.__native 
{
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author lizhi
	 */
	public class WebGLRenderer extends IRenderer
	{
		
		public function WebGLRenderer() 
		{
			
		}
		
		override public function renderImage(ctx:CanvasRenderingContext2D, img:BitmapData, m:Matrix, alpha:Number, blendMode:String, colorTransform:ColorTransform):void 
		{
			var glctx:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			glctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
			glctx.drawImage(img.image, 0, 0);
		}
		
		override public function renderText(ctx:CanvasRenderingContext2D, txt:String, textFormat:TextFormat, m:Matrix, alpha:Number, blendMode:String, colorTransform:ColorTransform):void 
		{
			var glctx:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			glctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
			glctx.fillText(txt, 0, 0);
		}
	}

}