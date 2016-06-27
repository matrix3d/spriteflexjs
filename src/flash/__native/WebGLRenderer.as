package flash.__native 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.display.IGraphicsData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author lizhi
	 */
	public class WebGLRenderer extends BaseRenderer
	{
		//private var path2glpath:ObjectMap = new ObjectMap;
		public function WebGLRenderer() 
		{
			
		}
		
		override public function createPath():GraphicsPath 
		{
			return new GLGraphicsPath;
		}
		
		/**
		 * @flexjsignorecoercion String
		 */
		override public function getCssColor(color:uint, alpha:Number, ct:ColorTransform):String 
		{
			return [ ((color >> 16 & 0xff)*ct.redMultiplier+ct.redOffset)/0xff , ((color >> 8 & 0xff)*ct.greenMultiplier+ct.greenOffset)/0xff, ((color & 0xff)*ct.greenMultiplier+ct.greenOffset)/0xff , (alpha*ct.alphaMultiplier+ct.alphaOffset)] as String;
		}
		
		/**
		 * @flexjsignorecoercion flash.__native.GLCanvasRenderingContext2D
		 */
		override public function renderImage(ctx:CanvasRenderingContext2D, img:BitmapData, m:Matrix, blendMode:String, colorTransform:ColorTransform):void 
		{
			var glctx:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			glctx.globalRed = colorTransform.redMultiplier;
			glctx.globalGreen = colorTransform.greenMultiplier;
			glctx.globalBlue = colorTransform.blueMultiplier;
			super.renderImage(ctx, img, m, blendMode, colorTransform);
		}
		
		/**
		 * @flexjsignorecoercion flash.display.GraphicsPath
		 * @flexjsignorecoercion flash.__native.GLCanvasRenderingContext2D
		 */
		override public function renderGraphics(ctx:CanvasRenderingContext2D, g:Graphics, m:Matrix, blendMode:String, colorTransform:ColorTransform):void{
			var glctx:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			ctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
			ctx.globalCompositeOperation = blendMode;
			ctx.globalAlpha = colorTransform.alphaMultiplier;
			glctx.globalRed = colorTransform.redMultiplier;
			glctx.globalGreen = colorTransform.greenMultiplier;
			glctx.globalBlue = colorTransform.blueMultiplier;
			var len:int = g.graphicsData.length;
			for (var i:int = 0; i < len;i++ )
			{
				var igd:IGraphicsData = g.graphicsData[i];
				if (igd is GraphicsPath){
					var path:GraphicsPath = igd as GraphicsPath;
					glctx.drawPath(path, colorTransform);
				}else{
					igd.draw(ctx, colorTransform);
				}
			}
			if (g.lastFill)
			{
				endFillInstance.fill = g.lastFill;
				endFillInstance.draw(ctx,colorTransform);
			}
			
			if (g.lastStroke)
			{
				ctx.stroke();
			}
			ctx.fillStyle = null;
			ctx.strokeStyle = null;
		}
	}

}