package flash.display
{
	import flash.__native.GLCanvasRenderingContext2D;
	import flash.geom.ColorTransform;
	
	public final class GraphicsSolidFill extends Object implements IGraphicsFill, IGraphicsData
	{
		
		public var color:uint = 0;
		
		public var alpha:Number = 1.0;
		private var cssColor:String;
		public var _glcolor:Array = [];
		public function GraphicsSolidFill(color:uint = 0, alpha:Number = 1.0)
		{
			super();
			this.color = color;
			this.alpha = alpha;
			cssColor = "rgba(" + (color >> 16 & 0xff) + "," + (color >> 8 & 0xff) + "," + (color & 0xff) + "," + this.alpha + ")";
		}
		
		/**
		 * @royaleignorecoercion String
		 */
		public function draw(ctx:CanvasRenderingContext2D,colorTransform:ColorTransform):void
		{
			ctx.fillStyle = SpriteFlexjs.renderer.getCssColor(color,alpha, colorTransform,null) as String;//getCssColor(colorTransform);
		}
		
		/*public function getCssColor(ct:ColorTransform):String 
		{
			return "rgba(" + ((color >> 16 & 0xff)*ct.redMultiplier+ct.redOffset) + "," + ((color >> 8 & 0xff)*ct.greenMultiplier+ct.greenOffset) + "," + ((color & 0xff)*ct.greenMultiplier+ct.greenOffset) + "," + (this.alpha*ct.alphaMultiplier+ct.alphaOffset) + ")";
		}*/
		/**
		 * @royaleignorecoercion String
		 */
		public function gldraw(ctx:GLCanvasRenderingContext2D, colorTransform:ColorTransform):void{
			//SpriteFlexjs.renderer.getCssColor(color, alpha, colorTransform, _glcolor);
			ctx.fillStyle = SpriteFlexjs.renderer.getCssColor(color, alpha, colorTransform, _glcolor) as String//_glcolor as String; 
			ctx.fillStyleIsImage = false;
		}
	}
}
