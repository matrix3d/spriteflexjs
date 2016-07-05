package flash.display
{
	import flash.__native.GLCanvasRenderingContext2D;
	import flash.geom.ColorTransform;
	
	public final class GraphicsTrianglePath extends Object implements IGraphicsPath, IGraphicsData
	{
		
		public var indices:Vector.<int>;
		
		public var vertices:Vector.<Number>;
		
		public var uvtData:Vector.<Number>;
		
		private var _culling:String;
		
		public function GraphicsTrianglePath(vertices:Vector.<Number> = null, indices:Vector.<int> = null, uvtData:Vector.<Number> = null, culling:String = "none")
		{
			super();
			this.vertices = vertices;
			this.indices = indices;
			this.uvtData = uvtData;
			this._culling = culling;
		/*if(culling != TriangleCulling.NONE && culling != TriangleCulling.POSITIVE && culling != TriangleCulling.NEGATIVE)
		   {
		   Error.throwError(null,2008,"culling");
		   }*/
		}
		
		public function get culling():String
		{
			return this._culling;
		}
		
		public function set culling(value:String):void
		{
			/* if(value != TriangleCulling.NONE && value != TriangleCulling.POSITIVE && value != TriangleCulling.NEGATIVE)
			   {
			   Error.throwError(null,2008,"culling");
			   }*/
			this._culling = value;
		}
		
		public function draw(ctx:CanvasRenderingContext2D,colorTransform:ColorTransform):void
		{
			trace("tripath");
		}
		public function gldraw(ctx:GLCanvasRenderingContext2D, colorTransform:ColorTransform):void{
			
		}
	}
}
