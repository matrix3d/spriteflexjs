package com.hsharma.hungryHero 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author lizhi
	 */
	public class Button extends Sprite
	{
		public var fontColor:int;
		public function Button(bmd:BitmapData) 
		{
			graphics.beginFill(0,.5);
			graphics.drawRect(0, 0, bmd.width, bmd.height);
			addChild(new Bitmap(bmd));
			buttonMode = true;
		}
		
	}

}