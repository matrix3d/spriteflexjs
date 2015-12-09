package flash.display
{
	
	public final class GraphicsPath extends Object implements IGraphicsPath, IGraphicsData
	{
		
		public var commands:Vector.<int>;
		
		public var data:Vector.<Number>;
		
		private var _winding:String;
		
		public function GraphicsPath(commands:Vector.<int> = null, data:Vector.<Number> = null, winding:String = "evenOdd")
		{
			super();
			this.commands = commands;
			this.data = data;
			/*if(winding != GraphicsPathWinding.EVEN_ODD && winding != GraphicsPathWinding.NON_ZERO)
			   {
			   Error.throwError(null,2008,"winding");
			   }*/
			this._winding = winding;
		}
		
		public function get winding():String
		{
			return this._winding;
		}
		
		public function set winding(value:String):*
		{
			/*if(value != GraphicsPathWinding.EVEN_ODD && value != GraphicsPathWinding.NON_ZERO)
			   {
			   Error.throwError(null,2008,"winding");
			   }*/
			this._winding = value;
		}
		
		public function moveTo(x:Number, y:Number):void
		{
			initData();
			this.commands.push(GraphicsPathCommand.MOVE_TO);
			this.data.push(x, y);
		}
		
		public function lineTo(x:Number, y:Number):void
		{
			initData();
			this.commands.push(GraphicsPathCommand.LINE_TO);
			this.data.push(x, y);
		}
		
		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void
		{
			initData();
			this.commands.push(GraphicsPathCommand.CURVE_TO);
			this.data.push(controlX, controlY, anchorX, anchorY);
		}
		
		public function cubicCurveTo(controlX1:Number, controlY1:Number, controlX2:Number, controlY2:Number, anchorX:Number, anchorY:Number):void
		{
			initData();
			this.commands.push(GraphicsPathCommand.CUBIC_CURVE_TO);
			this.data.push(controlX1, controlY1, controlX2, controlY2, anchorX, anchorY);
		}
		
		public function wideLineTo(x:Number, y:Number):void
		{
			initData();
			this.commands.push(GraphicsPathCommand.WIDE_LINE_TO);
			this.data.push(0.0, 0.0, x, y);
		}
		
		public function wideMoveTo(x:Number, y:Number):void
		{
			initData();
			this.commands.push(GraphicsPathCommand.WIDE_MOVE_TO);
			this.data.push(0.0, 0.0, x, y);
		}
		
		public function arc(x:Number, y:Number,r:Number,r0:Number,r1:Number):void
		{
			initData();
			this.commands.push(GraphicsPathCommand.ARC);
			this.data.push(x,y,r,r0,r1);
		}
		
		private function initData():void {
			if (this.commands == null)
			{
				this.commands = new Vector.<int>();
			}
			if (this.data == null)
			{
				this.data = new Vector.<Number>();
			}
		}
		
		public function draw(ctx:CanvasRenderingContext2D):void
		{
			if (commands.length) {
				ctx.beginPath();
				var p:int = 0;
				for each (var cmd:int in commands)
				{
					switch (cmd)
					{
					case GraphicsPathCommand.MOVE_TO: 
						ctx.moveTo(data[p++], data[p++]);
						break;
					case GraphicsPathCommand.LINE_TO: 
						ctx.lineTo(data[p++], data[p++]);
						break;
					case GraphicsPathCommand.CURVE_TO: 
						ctx.quadraticCurveTo(data[p++], data[p++], data[p++], data[p++]);
						break;
					case GraphicsPathCommand.CUBIC_CURVE_TO: 
						ctx.bezierCurveTo(data[p++], data[p++], data[p++], data[p++], data[p++], data[p++]);
						break;
					case GraphicsPathCommand.WIDE_MOVE_TO: 
						ctx.moveTo(data[p++], data[p++]);
						break;
					case GraphicsPathCommand.WIDE_LINE_TO: 
						ctx.lineTo(data[p++], data[p++]);
						break;
					case GraphicsPathCommand.ARC: 
						ctx.arc(data[p++], data[p++], data[p++], data[p++], data[p++]);
						break;
					}
				}
				ctx.closePath();
			}
		}
	}
}
