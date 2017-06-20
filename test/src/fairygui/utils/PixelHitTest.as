package fairygui.utils
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class PixelHitTest
	{
		private var _data:PixelHitTestData;
		
		public var offsetX:int;
		public var offsetY:int;
		
		private var _shape:Shape;
		
		public function PixelHitTest(data:PixelHitTestData, offsetX:int=0, offsetY:int=0)
		{
			_data = data;
			this.offsetX = offsetX;
			this.offsetY = offsetY;
		}
		
		public function createHitAreaSprite():Sprite
		{
			if(_shape==null)
			{
				_shape = new Shape();
				var g:Graphics = _shape.graphics;
				g.beginFill(0,0);
				g.lineStyle(0,0,0);
				
				var arr:Vector.<int> = _data.pixels;
				var cnt:int = arr.length;
				var pw:int = _data.pixelWidth;
				for(var i:int=0;i<cnt;i++)
				{
					var pixel:int = arr[i];
					for(var j:int=0;j<8;j++)
					{
						if(((pixel>>j)&0x01)==1)
						{
							var pos:int = i*8+j;
							g.drawRect(pos%pw, int(pos/pw), 1, 1);
						}
					}
				}
				g.endFill();				
			}
			
			var sprite:Sprite = new Sprite();
			sprite.mouseEnabled = false;
			sprite.x = offsetX;
			sprite.y = offsetY;
			sprite.graphics.copyFrom(_shape.graphics);
			sprite.scaleX = sprite.scaleY = _data.scale;
			
			return sprite;
		}
	}
}