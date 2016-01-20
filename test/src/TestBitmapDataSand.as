package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author lizhi https://twitter.com/lizhi525
	 */
	[SWF(frameRate = 60)]
	public class TestBitmapDataSand extends Sprite
	{
		private var fp:P;
		private var bmd:BitmapData;
		private var w:int = 200;
		private var h:int = 200;
		
		public function TestBitmapDataSand()
		{
			bmd = new BitmapData(w, h, false, 0);
			bmd.noise(0);
			image = new Bitmap(bmd);
			addChild(image);
			image.scaleX = image.scaleY = 2;
			var cp:P;
			for (var x:int = 0; x < bmd.width; x++)
			{
				for (var y:int = 0; y < bmd.height; y++)
				{
					var p:P = new P;
					p.x = x;
					p.y = y;
					p.c = bmd.getPixel(x, y);
					//ps.push(p);
					if (fp == null) fp = p;
					if (cp) cp.next = p;
					cp = p;
				}
			}
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private const r:Number = 10;
		private const help:Number = r * Math.PI / 2;
		private var image:Bitmap;
		
		private function enterFrame(e:Event):void
		{
			bmd.fillRect(bmd.rect, 0);
			var mx:Number = image.mouseX;
			var my:Number = image.mouseY;
			var p:P = fp;
			bmd.lock();
			while (p)
			{
				var dx:Number = p.x - mx;
				var dy:Number = p.y - my;
				if (dx < -r || dx > r || dy < -r || dy > r)
				{
					
				}
				else
				{
					var d:Number = Math.sqrt(dx * dx + dy * dy);
					if (d < r)
					{
						var f:Number = Math.cos(d / help);
						var a:Number = Math.atan2(dy, dx);
						p.vx += Math.cos(a) * f;
						p.vy += Math.sin(a) * f;
					}
				}
				
				if (p.vx < -.3 || p.vx > .3)
				{
					p.vx *= .9;
					if (p.vx > 5)
					{
						p.vx = 5;
					}
					else if (p.vx < -5)
					{
						p.vx = -5;
					}
					p.x += p.vx;
					if (p.x < 0)
					{
						p.x = 0;
						p.vx *= -1;
					}
					else if (p.x >= w)
					{
						p.x = w - 1;
						p.vx *= -1;
					}
				}
				if (p.vy < -.3 || p.vy > .3)
				{
					p.vy *= .9;
					if (p.vy > 5)
					{
						p.vy = 5;
					}
					else if (p.vy < -5)
					{
						p.vy = -5;
					}
					p.y += p.vy;
					if (p.y < 0)
					{
						p.y = 0;
						p.vy *= -1;
					}
					else if (p.y >= h)
					{
						p.y = h - 1;
						p.vy *= -1;
					}
				}
				bmd.setPixel(int(p.x), int(p.y), p.c);
				p = p.next;
			}
			bmd.unlock();
		}
	
	}

}

class P
{
	public var x:Number;
	public var y:Number;
	public var c:uint;
	public var vx:Number = 0;
	public var vy:Number = 0;
	public var next:P;
}