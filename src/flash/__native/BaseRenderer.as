package flash.__native 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsPath;
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
		
		protected var endFillInstance:GraphicsEndFill = new GraphicsEndFill;
		public function BaseRenderer() 
		{
			
		}
		
		override public function getCssColor(color:uint,alpha:Number, ct:ColorTransform,toarr:Array):Object 
		{
			return "rgba(" + int((color >> 16 & 0xff)*ct.redMultiplier+ct.redOffset) + "," + int((color >> 8 & 0xff)*ct.greenMultiplier+ct.greenOffset) + "," + int((color & 0xff)*ct.greenMultiplier+ct.greenOffset) + "," + (alpha*ct.alphaMultiplier+ct.alphaOffset) + ")";
		}
		
		override public function createPath():GraphicsPath 
		{
			return new GraphicsPath;
		}
		
		override public function renderGraphics(ctx:CanvasRenderingContext2D,g:Graphics,m:Matrix,blendMode:String,colorTransform:ColorTransform):void{
			ctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
			ctx.globalCompositeOperation = blendMode;//BlendMode.getCompVal(blendMode);
			var len:int = g.graphicsData.length;
			for (var i:int = 0; i < len;i++ )
			{
				var igd:IGraphicsData = g.graphicsData[i];
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
		
		override public function renderImage(ctx:CanvasRenderingContext2D,img:BitmapData,m:Matrix,blendMode:String,colorTransform:ColorTransform, offsetX:Number = 0, offsetY:Number = 0):void{
			ctx.globalAlpha = colorTransform.alphaMultiplier;
			ctx.globalCompositeOperation = blendMode;
			ctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
			ctx.drawImage(img.image, offsetX, offsetY);
		}
		
		override public function renderVideo(ctx:CanvasRenderingContext2D,video:HTMLVideoElement,m:Matrix, width:int, height:int, blendMode:String,colorTransform:ColorTransform):void{
			ctx.globalAlpha = colorTransform.alphaMultiplier;
			ctx.globalCompositeOperation = blendMode;
			ctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
			ctx.drawImage(video, 0, 0, width, height);
		}
		
		override public function renderText(ctx:CanvasRenderingContext2D,txt:String,textFormat:TextFormat, m:Matrix, blendMode:String, colorTransform:ColorTransform,x:Number,y:Number):void{
			ctx.globalAlpha = colorTransform.alphaMultiplier;
			ctx.globalCompositeOperation = blendMode;//BlendMode.getCompVal(blendMode);
			ctx.setTransform(m.a, m.b, m.c, m.d, m.tx, m.ty);
			ctx.font = textFormat.css;
			ctx.fillStyle = textFormat.csscolor;
			ctx.textBaseline = "top";
			ctx.fillText(txt, x, y);
		}
	}

}