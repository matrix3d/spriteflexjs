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
		override public function getCssColor(color:uint, alpha:Number, ct:ColorTransform,toarr:Array):Object 
		{
			var r:uint = ((color >> 16 & 0xff)*ct.redMultiplier+ct.redOffset);
			var g:uint = ((color >> 8 & 0xff) * ct.greenMultiplier + ct.greenOffset);
			var b:uint = ((color & 0xff)*ct.greenMultiplier+ct.greenOffset);
			var a:uint = (alpha * ct.alphaMultiplier + ct.alphaOffset)*0xff;
			var c:uint = ((r << 0) | (g << 8) | (b << 16) | (a << 24))>>>0;
			return c;
		}
		
		/**
		 * @flexjsignorecoercion flash.__native.GLCanvasRenderingContext2D
		 */
		override public function renderImage(ctx:CanvasRenderingContext2D, img:BitmapData, m:Matrix, blendMode:String, colorTransform:ColorTransform):void 
		{
			var glctx:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			glctx.drawImageInternal(img.image,glctx.bitmapDrawable,m,null,true,colorTransform.tint,true,true);
		}
		
		/**
		 * @flexjsignorecoercion flash.display.GraphicsPath
		 * @flexjsignorecoercion flash.__native.GLCanvasRenderingContext2D
		 */
		override public function renderGraphics(ctx:CanvasRenderingContext2D, g:Graphics, m:Matrix, blendMode:String, colorTransform:ColorTransform):void{
			var glctx:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			glctx.setTransform2(m);
			ctx.globalCompositeOperation = blendMode;
			//ctx.globalAlpha = colorTransform.alphaMultiplier;
			//glctx.globalRed = colorTransform.redMultiplier;
			//glctx.globalGreen = colorTransform.greenMultiplier;
			//glctx.globalBlue = colorTransform.blueMultiplier;
			glctx.colorTransform = colorTransform;
			var len:int = g.graphicsData.length;
			for (var i:int = 0; i < len;i++ )
			{
				var igd:IGraphicsData = g.graphicsData[i];
				igd.gldraw(glctx, colorTransform);
			}
			if (g.lastFill)
			{
				endFillInstance.fill = g.lastFill;
				endFillInstance._worldMatrix = g._worldMatrix;
				endFillInstance.gldraw(glctx,colorTransform);
			}
			
			if (g.lastStroke)
			{
				ctx.stroke();
			}
			ctx.fillStyle = null;
			ctx.strokeStyle = null;
		}
		
		/**
		 * @flexjsignorecoercion flash.__native.GLCanvasRenderingContext2D
		 */
		override public function renderText(ctx:CanvasRenderingContext2D, txt:String, textFormat:TextFormat, m:Matrix, blendMode:String, colorTransform:ColorTransform, x:Number, y:Number):void{
			var glctx:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			glctx.colorTransform = colorTransform;
			ctx.globalCompositeOperation = blendMode;//BlendMode.getCompVal(blendMode);
			glctx.setTransform2(m);
			ctx.font = textFormat.css;
			ctx.fillStyle = textFormat.csscolor;
			ctx.textBaseline = "top";
			ctx.fillText(txt, x, y);
		}
		
		/**
		 * @flexjsignorecoercion flash.__native.GLCanvasRenderingContext2D
		 */
		override public function finish(ctx:CanvasRenderingContext2D):void{
			var glctx:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			glctx.drawImageInternal(null, null, null, null, true, null, true, true);
		}
	}

}