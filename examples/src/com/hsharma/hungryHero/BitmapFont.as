package com.hsharma.hungryHero 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author lizhi
	 */
	public class BitmapFont 
	{
		private var xml:Object;
		public function BitmapFont(bmd:BitmapData,xml:Object) 
		{
			this.xml = xml;
		}
		
		public function get name():String 
		{
			for each(var c:Object in xml.children) {
				if (c.localName=="info") {
					return c.attributes.face;
				}
			}
			return null;
		}
		
		public function get size():Number 
		{
			for each(var c:Object in xml.children) {
				if (c.localName=="info") {
					return int(c.attributes.size);
				}
			}
			return 0;
		}
		
	}

}