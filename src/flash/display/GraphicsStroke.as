package flash.display
{
	import flash.__native.GLCanvasRenderingContext2D;
	import flash.geom.ColorTransform;
	
	public final class GraphicsStroke extends Object implements IGraphicsStroke, IGraphicsData
	{
		
		public var thickness:Number;
		
		public var pixelHinting:Boolean;
		
		private var _caps:String;
		
		private var _joints:String;
		
		public var miterLimit:Number;
		
		private var _scaleMode:String;
		
		public var fill:IGraphicsFill;
		
		public function GraphicsStroke(thickness:Number = NaN, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = "none", joints:String = "round", miterLimit:Number = 3.0, fill:IGraphicsFill = null)
		{
			super();
			this.thickness = thickness;
			this.pixelHinting = pixelHinting;
			this._caps = (caps == "none") ? "butt" : caps;
			this._joints = joints;
			this.miterLimit = miterLimit;
			this._scaleMode = scaleMode;  // TODO implement scaleMode
			this.fill = fill;
			
		/*if(this._scaleMode != LineScaleMode.NORMAL && this._scaleMode != LineScaleMode.NONE && this._scaleMode != LineScaleMode.VERTICAL && this._scaleMode != LineScaleMode.HORIZONTAL)
		   {
		   Error.throwError(null,2008,"scaleMode");
		   }
		   if(this._caps != CapsStyle.NONE && this._caps != CapsStyle.ROUND && this._caps != CapsStyle.SQUARE)
		   {
		   Error.throwError(null,2008,"caps");
		   }
		   if(this._joints != JointStyle.BEVEL && this._joints != JointStyle.MITER && this._joints != JointStyle.ROUND)
		   {
		   Error.throwError(null,2008,"joints");
		   }*/
		}
		
		public function get caps():String
		{
			return this._caps;
		}
		
		public function set caps(value:String):void
		{
			/*if(value != CapsStyle.NONE && value != CapsStyle.ROUND && value != CapsStyle.SQUARE)
			   {
			   Error.throwError(null,2008,"caps");
			   }*/
			this._caps = value;
		}
		
		public function get joints():String
		{
			return this._joints;
		}
		
		public function set joints(value:String):*
		{
			/*if(value != JointStyle.BEVEL && value != JointStyle.MITER && value != JointStyle.ROUND)
			   {
			   Error.throwError(null,2008,"joints");
			   }*/
			this._joints = value;
		}
		
		public function get scaleMode():String
		{
			return this._scaleMode;
		}
		
		public function set scaleMode(value:String):void
		{
			/*if(value != LineScaleMode.NORMAL && value != LineScaleMode.NONE && value != LineScaleMode.VERTICAL && value != LineScaleMode.HORIZONTAL)
			   {
			   Error.throwError(null,2008,"scaleMode");
			   }*/
			this._scaleMode = value;
		}
		
		/**
		 * @royaleignorecoercion String
		 */
		public function draw(ctx:CanvasRenderingContext2D,colorTransform:ColorTransform):void
		{
			if (isNaN(thickness))
			{
				ctx.lineJoin = _joints;
				ctx.stroke();
			}
			else
			{
				ctx.lineWidth = thickness;
				if (fill is GraphicsSolidFill)
				{
					var sf:GraphicsSolidFill = fill as GraphicsSolidFill;
					ctx.lineCap = _caps
					ctx.lineJoin = _joints;
					ctx.miterLimit = miterLimit;
					ctx.strokeStyle = SpriteFlexjs.renderer.getCssColor(sf.color, sf.alpha,colorTransform,null) as String;//sf.getCssColor(colorTransform);
				}
				else if (fill is GraphicsGradientFill)
				{
					var gf:GraphicsGradientFill = fill as GraphicsGradientFill;
					gf.draw(ctx, colorTransform);
					ctx.lineCap = _caps;
					ctx.lineJoin = _joints;
					ctx.miterLimit = miterLimit;
					ctx.strokeStyle = gf.gradient as String;
				}
			}
		}
		
		/**
		 * @royaleignorecoercion String
		 * @royaleignorecoercion flash.display.GraphicsSolidFill
		 */
		public function gldraw(ctx:GLCanvasRenderingContext2D, colorTransform:ColorTransform):void{
			//if (isNaN(thickness))
			//{
				//ctx.stroke();
			//}
			//else
			//{
				ctx.lineWidth = thickness;
				if (fill is GraphicsSolidFill)
				{
					var sf:GraphicsSolidFill = fill as GraphicsSolidFill;
					ctx.strokeStyle=SpriteFlexjs.renderer.getCssColor(sf.color, sf.alpha,colorTransform,null) as String;
					//ctx.strokeStyle = sf._glcolor as String; //sf.getCssColor(colorTransform);
				}
			//}
		}
	}
}
