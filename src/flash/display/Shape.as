package flash.display
{
	
	public class Shape extends DisplayObject
	{
		private var _graphics:Graphics;
		public function Shape()
		{
			super();
		}
		
		public function get graphics():Graphics
		{
			if (_graphics == null)
			{
				_graphics = new Graphics;
			}
			return _graphics;
		}
		
		override public function __update():void
		{
			super.__update();
			if (stage&&visible)
				graphics.draw(stage.ctx, worldMatrix,alpha);
		}
	}
}
