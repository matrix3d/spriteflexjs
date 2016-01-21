package com.hsharma.hungryHero 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TextureAtlas 
	{
		private var xml:Object;
		private var bmd:BitmapData;
		public var bmds:Object = { };
		public function TextureAtlas(bmd:BitmapData,xml:Object) 
		{
			this.bmd = bmd;
			this.xml = xml;
			for each(var s:Object in xml.children) {
				if (s.localName == "SubTexture") {
					var a:Object = s.attributes || { }; 
					var b:BitmapData = new BitmapData(int(a.width), int(a.height), true, 0xffff0000);
					b.copyPixels(bmd, new Rectangle(int(a.x), int(a.y), b.width, b.height), new Point);
					bmds[a.name] = [b, s]; 
				}
			}
		}
		
		public function getTexture(name:String):BitmapData {
			var arr:Array = bmds[name];
			if (arr) return arr[0];
			return null;
		}
		public function getTextures(name:String):Array 
		{
			var arr:Array = [];
			for (var n:String in bmds) {
				if (n.indexOf(name)==0) {
					arr.push(bmds[n]);
				}
			}
			return arr;
		}
	}

}