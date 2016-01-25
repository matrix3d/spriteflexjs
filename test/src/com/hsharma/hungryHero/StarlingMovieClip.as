package com.hsharma.hungryHero 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author lizhi
	 */
	public class StarlingMovieClip extends Sprite
	{
		public var fps:int;
		public function StarlingMovieClip(bmds:Array,num:int) 
		{
			if (bmds[0]) {
				addChild(new Bitmap(bmds[0][0]));
			}
		}
	}

}