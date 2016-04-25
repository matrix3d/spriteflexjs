package flash.__native 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsEndFill;
	import flash.display.IGraphicsData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author lizhi
	 */
	public class BaseRenderer extends IRenderer
	{
		
		private var endFillInstance:GraphicsEndFill = new GraphicsEndFill;
		public function BaseRenderer() 
		{
			
		}
		
		override public function renderGraphics(ctx:CanvasRenderingContext2D,g:Graphics,m:Matrix,alpha:Number,blendMode:String,colorTransform:ColorTransform):void{
			ctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
			ctx.globalAlpha = alpha;
			ctx.globalCompositeOperation = blendMode;//BlendMode.getCompVal(blendMode);
			for each (var igd:IGraphicsData in g.graphicsData)
			{
				igd.draw(ctx,colorTransform);
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
		
		override public function renderImage(ctx:CanvasRenderingContext2D,img:BitmapData,m:Matrix,alpha:Number,blendMode:String,colorTransform:ColorTransform):void{
			ctx.globalAlpha = alpha;
			ctx.globalCompositeOperation = blendMode;
			ctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
			ctx.drawImage(img.image, 0, 0);
		}
		
		override public function renderText(ctx:CanvasRenderingContext2D,txt:String,textFormat:TextFormat, m:Matrix, alpha:Number, blendMode:String, colorTransform:ColorTransform):void{
			ctx.globalAlpha = alpha;
			ctx.globalCompositeOperation = blendMode;//BlendMode.getCompVal(blendMode);
			ctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
			ctx.font = textFormat.css;
			ctx.fillStyle = textFormat.csscolor;
			ctx.textBaseline = "top";
			ctx.fillText(txt, 0, 0);
		}
	}

}