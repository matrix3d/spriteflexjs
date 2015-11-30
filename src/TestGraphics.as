package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestGraphics extends Sprite
	{
		
		public function TestGraphics() 
		{
			trace("test graphics");
			graphics.lineStyle(0, 0xff00);
			graphics.beginFill(0xff0000);
			graphics.moveTo(0.5, 0.5);
			graphics.lineTo(1000.5, 1000.5);
			graphics.drawRect(100.5, 100.5, 100,100);
		}
		
		public function start():void {
			
		}
		
	}

}