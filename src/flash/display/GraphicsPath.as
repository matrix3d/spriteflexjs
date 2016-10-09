package flash.display
{
	import flash.__native.GLCanvasRenderingContext2D;
	import flash.__native.GLPath2D;
	import flash.geom.ColorTransform;
	
	public class GraphicsPath extends Object implements IGraphicsPath, IGraphicsData
	{
		public var gpuPath2DDirty:Boolean = true;
		
		public var commands:Vector.<int>=new Vector.<int>;
		
		public var data:Vector.<Number>=new Vector.<Number>;
		
		public var tris:Array = [];
		
		private var _winding:String;
		
		public function GraphicsPath(commands:Vector.<int> = null, data:Vector.<Number> = null, winding:String = "evenOdd")
		{
			super();
			this.commands = commands;
			this.data = data;
			if (this.commands == null){
				this.commands = new Vector.<int>;
			}
			if (this.data==null){
				this.data = new Vector.<Number>;
			}
			/*if(winding != GraphicsPathWinding.EVEN_ODD && winding != GraphicsPathWinding.NON_ZERO)
			   {
			   Error.throwError(null,2008,"winding");
			   }*/
			this._winding = winding;
		}
		
		public function clear():void{
			commands.length = 0;
			data.length = 0;
			tris.length = 0;
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
			//initData();
			this.commands.push(GraphicsPathCommand.MOVE_TO);
			this.data.push(x, y);
		}
		
		public function lineTo(x:Number, y:Number):void
		{
			//initData();
			this.commands.push(GraphicsPathCommand.LINE_TO);
			this.data.push(x, y);
		}
		
		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void
		{
			//initData();
			this.commands.push(GraphicsPathCommand.CURVE_TO);
			this.data.push(controlX, controlY, anchorX, anchorY);
		}
		
		public function cubicCurveTo(controlX1:Number, controlY1:Number, controlX2:Number, controlY2:Number, anchorX:Number, anchorY:Number):void
		{
			//initData();
			this.commands.push(GraphicsPathCommand.CUBIC_CURVE_TO);
			this.data.push(controlX1, controlY1, controlX2, controlY2, anchorX, anchorY);
		}
		
		public function wideLineTo(x:Number, y:Number):void
		{
			//initData();
			this.commands.push(GraphicsPathCommand.WIDE_LINE_TO);
			this.data.push(0.0, 0.0, x, y);
		}
		
		public function wideMoveTo(x:Number, y:Number):void
		{
			//initData();
			this.commands.push(GraphicsPathCommand.WIDE_MOVE_TO);
			this.data.push(0.0, 0.0, x, y);
		}
		
		public function arc(x:Number, y:Number,r:Number,a0:Number,a1:Number):void
		{
			//initData();
			this.commands.push(GraphicsPathCommand.ARC);
			this.data.push(x,y,r,a0,a1);
		}
		
		/*private function initData():void {
			if (this.commands == null)
			{
				this.commands = new Vector.<int>();
			}
			if (this.data == null)
			{
				this.data = new Vector.<Number>();
			}
		}*/
		
		public function draw(ctx:CanvasRenderingContext2D,colorTransform:ColorTransform):void
		{
			if (commands.length) {
				ctx.beginPath();
				var p:int = 0;
				var trip:int = 0;
				var len:int = commands.length as Number;
				for (var i:int = 0; i < len;i++ ){
					var cmd:int = commands[i] as Number;
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
						p += 2;
						ctx.moveTo(data[p++], data[p++]);
						break;
					case GraphicsPathCommand.WIDE_LINE_TO: 
						p += 2;
						ctx.lineTo(data[p++], data[p++]);
						break;
					case GraphicsPathCommand.ARC: 
						ctx.arc(data[p++], data[p++], data[p++], data[p++], data[p++]);
						break;
					case GraphicsPathCommand.DRAW_TRIANGLES: 
						doDrawTriangles( tris[trip++],ctx);
						break;
					case GraphicsPathCommand.CLOSE_PATH: 
						ctx.closePath();
						break;
					}
				}
			}
		}
		
		/**
		 * @flexjsignorecoercion flash.__native.GLCanvasRenderingContext2D
		 */
		public function gldraw(ctx:GLCanvasRenderingContext2D, colorTransform:ColorTransform):void{
			ctx.drawPath(this, colorTransform);
		}
		
		public function closePath():void 
		{
			//initData();
			this.commands.push(GraphicsPathCommand.CLOSE_PATH);
		}
		
		public function drawTriangles(vertices:Vector.<Number>, indices:Vector.<int>, uvtData:Vector.<Number>):void 
		{
			tris.push([vertices, indices, uvtData]);
			commands.push(GraphicsPathCommand.DRAW_TRIANGLES);
		}
		
		private function doDrawTriangles(tri:Array,ctx:CanvasRenderingContext2D):void {
			var vertices:Vector.<Number> = tri[0]
			var indices:Vector.<int> = tri[1];
			//, uvtData
			var len:int = indices.length as Number;
			for (var i:int = 0; i < len; ){
				var i0:int = indices[i++] as Number;
				var i1:int = indices[i++] as Number;
				var i2:int = indices[i++] as Number;
				var x0:Number = vertices[2*i0] as Number;
				var y0:Number = vertices[2*i0+1] as Number;
				var x1:Number = vertices[2*i1] as Number;
				var y1:Number = vertices[2*i1+1] as Number;
				var x2:Number = vertices[2*i2] as Number;
				var y2:Number = vertices[2 * i2 + 1] as Number;
				ctx.moveTo(x0, y0);
				ctx.lineTo(x1, y1);
				ctx.lineTo(x2, y2);
				ctx.lineTo(x0, y0);
			}
		}
	}
}
