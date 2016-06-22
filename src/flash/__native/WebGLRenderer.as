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
		 * @flexjsignorecoercion flash.display.GraphicsPath
		 * @flexjsignorecoercion flash.__native.GLCanvasRenderingContext2D
		 */
		override public function renderGraphics(ctx:CanvasRenderingContext2D, g:Graphics, m:Matrix, alpha:Number, blendMode:String, colorTransform:ColorTransform):void{
			var glctx:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			ctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
			ctx.globalAlpha = alpha;
			ctx.globalCompositeOperation = blendMode;
			
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