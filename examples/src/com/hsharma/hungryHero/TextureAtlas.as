package com.hsharma.hungryHero 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TextureAtlas 
	{
		private var xml:Object;
		public var bmd:BitmapData;
		public var bmds:Object = { };
		public function TextureAtlas(bmd:BitmapData,xml:Object) 
		{
			this.bmd = bmd;
			this.xml = xml;
			for each(var s:Object in xml.children) {
				if (s.localName == "SubTexture") {
					var a:Object = s.attributes || { }; 
					//var b:BitmapData = new BitmapData(int(a.width), int(a.height), true, 0xffff0000);
					//b.copyPixels(bmd, new Rectangle(int(a.x), int(a.y), b.width, b.height), new Point);
					bmds[a.name] = [new Rectangle(int(a.x), int(a.y), int(a.width),int(a.height)), s]; 
				}
			}
		}
		
		public function getTexture(target:Graphics, name:String):void {
			if (name.indexOf("obst")==0&&name.indexOf("crash")!=-1){
				trace(name);
			}
			var rect:Rectangle = bmds[name][0];
			target.beginBitmapFill(bmd, new Matrix(1,0,0,1,-rect.x,-rect.y), true, true);
			target.drawRect(0, 0, rect.width, rect.height);
		}
		public function getTextures(name:String):Array 
		{
			var arr:Array = [];
			for (var n:String in bmds) {
				if (n.indexOf(name)==0) {
					arr.push(n/*bmds[n]*/);
				}
			}
			return arr;
		}
	}

}