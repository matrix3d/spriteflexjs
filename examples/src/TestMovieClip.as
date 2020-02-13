package 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class TestMovieClip extends MovieClip
	{
		
		public function TestMovieClip() 
		{
			stage.frameRate = 60;
			
			var shape1:Shape = new Shape();
			shape1.name = "shape1";
			shape1.graphics.beginFill(0xFF8000);
			shape1.graphics.drawRect(0, 0, 100, 100);
			
			var shape2:Shape = new Shape();
			shape2.name = "shape2";
			shape2.graphics.beginFill(0xFF0000);
			shape2.graphics.drawCircle(0, 0, 50);
			
			shape1.x = shape1.y = 50;
			shape2.x = shape2.y = 200;
			
			addChild(shape1);
			addChild(shape2);
			
			shape1._off = true;
			shape2._off = true;
			addFrameObjects(0, [shape1]);
			addFrameObjects(29, [shape1, shape2]);
			addFrameObjects(15, [shape1]);
			addFrameObjects(59, [shape2]);
			
			addFrameTween(0, 0, shape1, {rotation:0, x:shape1.x, scaleX:shape1.scaleX, scaleY:shape1.scaleY, alpha:1});
			addFrameTween(0, 0, shape2, {scaleX:shape2.scaleX, scaleY:shape2.scaleY});
			addFrameTween(0, 15, shape1, {rotation:90, x:shape1.x + 400, scaleX:2, scaleY:2});
			addFrameTween(15, 29, shape1, {rotation:0, x:shape1.x, scaleX:1.25, scaleY:1.25, alpha:0});
			addFrameTween(29, 59, shape2, {scaleX:1.25, scaleY:1.25});
			
			gotoAndStop(1);
			gotoAndStop(2);
			
			gotoAndPlay(1);
		}
		
	}

}