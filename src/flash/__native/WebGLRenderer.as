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
		/**
		 * @flexjsignorecoercion GLPath2D
		 * @flexjsignorecoercion GLCanvasRenderingContext2D
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
					var glpath:GLPath2D = igd["gpath"];//path2glpath.get(igd) as GLPath2D;
					var gversion:int = (igd as GraphicsPath).version;
					if (glpath == null){
						igd.draw(ctx, colorTransform);
						igd["gpath"] = glctx.currentPath;
						glctx.currentPath.version = gversion;
						//path2glpath.set(igd, glctx.currentPath);
					}else{
						if (glpath.version != gversion){
							glpath.poly = null;
							glpath.polys = [];
							glpath._drawable = null;
							
							glpath.version = gversion;
						}
						glctx.lastBeginPath = glpath;
						igd.draw(ctx, colorTransform);
						glctx.currentPath = glpath;
					}
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