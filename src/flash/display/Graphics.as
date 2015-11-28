package flash.display
{
   import flash.display.cmds.Cmd;
   import flash.display.cmds.SetAttribCmd;
   import flash.display.cmds.SetBitmapAttribCmd;
   import flash.display.cmds.SetColorAttribCmd;
   import flash.geom.Matrix;
   
   public final class Graphics extends Object
   {
       private var filling:Boolean;
	private var fillingBmdCmd:SetBitmapAttribCmd;
	private var lineing:Boolean;
    private var cmds: Array = [];
	public var sprite:Object;
      public function Graphics()
      {
         super();
      }
      
	  public function getCanvas():CanvasRenderingContext2D
	{
		return Stage.getCanvas();
	}
       public function clear() : void{
		  this.filling=false;
		this.lineing=false;
		this.cmds=[];
	   }
      
       public function beginFill(color:uint, alpha:Number = 1.0):void 
		{
			this.cmds.push(
				new SetColorAttribCmd(getCanvas(),"fillStyle", color,alpha,this.sprite),
				new Cmd(getCanvas().beginPath, null),
				new SetAttribCmd(this,"filling", true),
				new SetAttribCmd(this,"fillingBmdCmd", null)
			);
		}
      
       public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:* = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void 
		{
			
		}
      
       public function beginBitmapFill(bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void 
		{
			var cmd:SetBitmapAttribCmd=new SetBitmapAttribCmd(getCanvas(),"fillStyle", bitmap,matrix,repeat,this.sprite);
			this.cmds.push(
				cmd,
				new Cmd(getCanvas().beginPath, null),
				new SetAttribCmd(this,"filling", true),
				new SetAttribCmd(this,"fillingBmdCmd", cmd)
			);
		}
      // public function beginShaderFill(param1:Shader, param2:Matrix = null) : void;
      
       public function lineGradientStyle(param1:String, param2:Array, param3:Array, param4:Array, param5:Matrix = null, param6:String = "pad", param7:String = "rgb", param8:Number = 0) : void{}
      
      public function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):void
		{
			if(this.lineing)this.cmds.push(new Cmd(getCanvas().stroke,null));
			this.cmds.push(
				new SetAttribCmd(getCanvas(),"lineWidth", thickness),
				new SetColorAttribCmd(getCanvas(),"strokeStyle", color,alpha,this.sprite),
				new SetAttribCmd(this,"lineing", !isNaN(thickness))
			);
		}
       public function drawRect(x:Number, y:Number, width:Number, height:Number):void 
		{
			moveTo(x, y);
			lineTo(x + width,y);
			lineTo(x + width,y+height);
			lineTo(x,y+height);
			lineTo(x,y);
		}
      
       public function drawRoundRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = undefined) : void{}
      
       public function drawRoundRectComplex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void{}
      
      public function drawCircle(x:Number, y:Number, radius:Number) : void
      {
         this.drawRoundRect(x - radius,y - radius,radius * 2,radius * 2,radius * 2,radius * 2);
      }
      
      public function drawEllipse(x:Number, y:Number, width:Number, height:Number) : void
      {
         this.drawRoundRect(x,y,width,height,width,height);
      }
      
       public function moveTo(x:Number, y:Number) : void{
		   this.cmds.push(
            new Cmd(getCanvas().moveTo, [x, y])
            );
	   }
      
       public function lineTo(x:Number, y:Number) : void{
		   this.cmds.push(
            new Cmd(getCanvas().lineTo, [x, y])
        );
	   }
      
       public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number): void {
			this.cmds.push(
				new Cmd(getCanvas().quadraticCurveTo, [controlX,controlY, anchorX,anchorY])
			);
		}
		public function cubicCurveTo(controlX1: Number, controlY1: Number, controlX2: Number, controlY2: Number, anchorX: Number, anchorY: Number): void {
			this.cmds.push(
				new Cmd(getCanvas().bezierCurveTo, [controlX1, controlY1,controlX2,controlY2,anchorX,anchorY])
			);
		}
       public function endFill() : void{
		   this.cmds.push(
				new Cmd(getCanvas().closePath, null),
				new SetAttribCmd(this,"filling", false)
			)
			if(this.filling){
				this.cmds.push(new Cmd(getCanvas().fill, null));
			}
	   }
      
       public function copyFrom(g:Graphics) : void{
		   this.cmds = g.cmds.concat(); 
	   }
      
       public function lineBitmapStyle(param1:BitmapData, param2:Matrix = null, param3:Boolean = true, param4:Boolean = false) : void{}
      
      // public function lineShaderStyle(param1:Shader, param2:Matrix = null) : void;
      
       public function drawPath(param1:Vector.<int>, param2:Vector.<Number>, param3:String = "evenOdd") : void{}
      
       public function drawTriangles(param1:Vector.<Number>, param2:Vector.<int> = null, param3:Vector.<Number> = null, param4:String = "none") : void{}
      
      /*private function drawPathObject(path:IGraphicsPath) : void
      {
         var graphicsPath:GraphicsPath = null;
         var graphicsTrianglePath:GraphicsTrianglePath = null;
         if(path is GraphicsPath)
         {
            graphicsPath = GraphicsPath(path);
            this.drawPath(graphicsPath.commands,graphicsPath.data,graphicsPath.winding);
         }
         else if(path is GraphicsTrianglePath)
         {
            graphicsTrianglePath = GraphicsTrianglePath(path);
            this.drawTriangles(graphicsTrianglePath.vertices,graphicsTrianglePath.indices,graphicsTrianglePath.uvtData,graphicsTrianglePath.culling);
         }
      }
      
      private function beginFillObject(fill:IGraphicsFill) : void
      {
         var solidFill:GraphicsSolidFill = null;
         var gradientFill:GraphicsGradientFill = null;
         var bitmapFill:GraphicsBitmapFill = null;
         var shaderFill:GraphicsShaderFill = null;
         if(fill == null)
         {
            this.endFill();
         }
         else if(fill is GraphicsEndFill)
         {
            this.endFill();
         }
         else if(fill is GraphicsSolidFill)
         {
            solidFill = GraphicsSolidFill(fill);
            this.beginFill(solidFill.color,solidFill.alpha);
         }
         else if(fill is GraphicsGradientFill)
         {
            gradientFill = GraphicsGradientFill(fill);
            this.beginGradientFill(gradientFill.type,gradientFill.colors,gradientFill.alphas,gradientFill.ratios,gradientFill.matrix,gradientFill.spreadMethod,gradientFill.interpolationMethod,gradientFill.focalPointRatio);
         }
         else if(fill is GraphicsBitmapFill)
         {
            bitmapFill = GraphicsBitmapFill(fill);
            this.beginBitmapFill(bitmapFill.bitmapData,bitmapFill.matrix,bitmapFill.repeat,bitmapFill.smooth);
         }
         else if(fill is GraphicsShaderFill)
         {
            shaderFill = GraphicsShaderFill(fill);
            this.beginShaderFill(shaderFill.shader,shaderFill.matrix);
         }
      }
      
      private function beginStrokeObject(istroke:IGraphicsStroke) : void
      {
         var solidFill:GraphicsSolidFill = null;
         var gradientFill:GraphicsGradientFill = null;
         var bitmapFill:GraphicsBitmapFill = null;
         var shaderFill:GraphicsShaderFill = null;
         var stroke:GraphicsStroke = null;
         var fill:IGraphicsFill = null;
         if(istroke != null && istroke is GraphicsStroke)
         {
            stroke = istroke as GraphicsStroke;
         }
         if(stroke && stroke.fill && stroke.fill is IGraphicsFill)
         {
            fill = stroke.fill;
         }
         if(stroke == null || fill == null)
         {
            this.lineStyle();
         }
         else if(fill is GraphicsSolidFill)
         {
            solidFill = GraphicsSolidFill(fill);
            this.lineStyle(stroke.thickness,solidFill.color,solidFill.alpha,stroke.pixelHinting,stroke.scaleMode,stroke.caps,stroke.joints,stroke.miterLimit);
         }
         else if(fill is GraphicsGradientFill)
         {
            gradientFill = GraphicsGradientFill(fill);
            this.lineStyle(stroke.thickness,0,1,stroke.pixelHinting,stroke.scaleMode,stroke.caps,stroke.joints,stroke.miterLimit);
            this.lineGradientStyle(gradientFill.type,gradientFill.colors,gradientFill.alphas,gradientFill.ratios,gradientFill.matrix,gradientFill.spreadMethod,gradientFill.interpolationMethod,gradientFill.focalPointRatio);
         }
         else if(fill is GraphicsBitmapFill)
         {
            bitmapFill = GraphicsBitmapFill(fill);
            this.lineStyle(stroke.thickness,0,1,stroke.pixelHinting,stroke.scaleMode,stroke.caps,stroke.joints,stroke.miterLimit);
            this.lineBitmapStyle(bitmapFill.bitmapData,bitmapFill.matrix,bitmapFill.repeat,bitmapFill.smooth);
         }
         else if(fill is GraphicsShaderFill)
         {
            shaderFill = GraphicsShaderFill(fill);
            this.lineStyle(stroke.thickness,0,1,stroke.pixelHinting,stroke.scaleMode,stroke.caps,stroke.joints,stroke.miterLimit);
            this.lineShaderStyle(shaderFill.shader,shaderFill.matrix);
         }
      }
      
      public function drawGraphicsData(graphicsData:Vector.<IGraphicsData>) : void
      {
         var item:IGraphicsData = null;
         var path:IGraphicsPath = null;
         var fill:IGraphicsFill = null;
         var stroke:IGraphicsStroke = null;
         if(graphicsData == null)
         {
            return;
         }
         for(var i:int = 0; i < graphicsData.length; i++)
         {
            item = graphicsData[i];
            if(item is IGraphicsPath)
            {
               path = IGraphicsPath(item);
               this.drawPathObject(path);
            }
            else if(item is IGraphicsFill)
            {
               fill = IGraphicsFill(item);
               this.beginFillObject(fill);
            }
            else if(item is IGraphicsStroke)
            {
               stroke = IGraphicsStroke(item);
               this.beginStrokeObject(stroke);
            }
         }
      }
      
       private function GetGraphicsData(param1:Vector.<IGraphicsData>, param2:Boolean) : void;
      
      public function readGraphicsData(recurse:Boolean = true) : Vector.<IGraphicsData>
      {
         var vec:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
         this.GetGraphicsData(vec,recurse);
         return vec;
      }*/
   }
}
