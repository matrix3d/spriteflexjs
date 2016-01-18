package flash.display
{
	import flash.geom.ColorTransform;
	
	public interface IGraphicsData
	{
		function draw(ctx:CanvasRenderingContext2D,colorTransform:ColorTransform):void;
	}

}
