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
			addChild(new Bitmap(bmd));
			buttonMode = true;
		}
		
	}

}