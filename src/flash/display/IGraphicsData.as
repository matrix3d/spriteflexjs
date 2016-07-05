package flash.display
{
	import flash.__native.GLCanvasRenderingContext2D;
	import flash.geom.ColorTransform;
	
	public interface IGraphicsData
	{
		function draw(ctx:CanvasRenderingContext2D,colorTransform:ColorTransform):void;
		function gldraw(glctx:GLCanvasRenderingContext2D,colorTransform:ColorTransform):void;
	}

}
