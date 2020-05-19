package flash.__native 
{
	import flash.__native.te.CharSet;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.display.IGraphicsData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author lizhi
	 */
	public class WebGLRenderer extends BaseRenderer
	{
		//private var path2glpath:ObjectMap = new ObjectMap;
		public static var textCharSet:CharSet = new CharSet;
		public function WebGLRenderer() 
		{
			
		}
		
		override public function createPath():GraphicsPath 
		{
			return new GLGraphicsPath;
		}
		
		/**
		 * @royaleignorecoercion String
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
		 * @royaleignorecoercion flash.__native.GLCanvasRenderingContext2D
		 */
		override public function renderImage(ctx:CanvasRenderingContext2D, img:BitmapData, m:Matrix, blendMode:String, colorTransform:ColorTransform, offsetX:Number = 0, offsetY:Number = 0):void 
		{
			var glctx:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			if (!glctx.isBatch){
				ctx.globalCompositeOperation = blendMode;
			}
			glctx.drawImageInternal(img.image, glctx.bitmapDrawable, m, null, true, colorTransform.tint, true, true);
			if (glctx.isBatch){
				ctx.globalCompositeOperation = blendMode;
			}
		}
		
		/**
		 * @royaleignorecoercion flash.display.GraphicsPath
		 * @royaleignorecoercion flash.__native.GLCanvasRenderingContext2D
		 */
		override public function renderGraphics(ctx:CanvasRenderingContext2D, g:Graphics, m:Matrix, blendMode:String, colorTransform:ColorTransform):void{
			var glctx:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			//glctx.setTransform2(m);
			//inline
			/*if(g.lastStroke){
				glctx.flush();
			}*/
			
			glctx.matr = m;
			if (!glctx.isBatch){
				ctx.globalCompositeOperation = blendMode;
			}
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
			
			if (g.lastStroke)//draw fill and line
			{
				ctx.stroke();
			}
			ctx.fillStyle = null;
			ctx.strokeStyle = null;
			if (glctx.isBatch){
				ctx.globalCompositeOperation = blendMode;
			}
		}
		
		/**
		 * @royaleignorecoercion flash.__native.GLCanvasRenderingContext2D
		 */
		override public function renderText(ctx:CanvasRenderingContext2D, txt:String, textFormat:TextFormat, m:Matrix, blendMode:String, colorTransform:ColorTransform, x:Number, y:Number):void{
			var glctx:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			glctx.colorTransform = colorTransform;
			//ctx.globalCompositeOperation = blendMode;//BlendMode.getCompVal(blendMode);
			if (!glctx.isBatch){
				ctx.globalCompositeOperation = blendMode;
			}
			glctx.setTransform2(m);
			ctx.font = textFormat.css;
			ctx.fillStyle = textFormat.csscolor;
			ctx.textBaseline = "top";
			ctx.fillText(txt, x, y);
			if (glctx.isBatch){
				ctx.globalCompositeOperation = blendMode;
			}
		}
		
		/**
		 * @royaleignorecoercion flash.__native.GLCanvasRenderingContext2D
		 */
		override public function finish(ctx:CanvasRenderingContext2D):void{
			var glctx:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			glctx.drawImageInternal(null, null, null, null, true, null, true, true);
		}
		
		/**
		 * @royaleignorecoercion flash.__native.GLCanvasRenderingContext2D
		 */
		override public function renderRichText(ctx:CanvasRenderingContext2D, t:TextField):void 
		{
			var ctx2:GLCanvasRenderingContext2D = ctx as GLCanvasRenderingContext2D;
			ctx2.flush();
			//t.__updateCanvas(ctx);
			t.__updateGL(ctx as GLCanvasRenderingContext2D);
		}
		
		override public function start(ctx:CanvasRenderingContext2D):void 
		{
			textCharSet.rebuild();
		}
	}

}