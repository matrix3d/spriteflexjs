package com.hsharma.hungryHero 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author lizhi
	 */
	public class StarlingMovieClip extends Shape
	{
		private var bmds:Array;
		public var fps:Number = 10;
		public var frame:Number = 0;
		public var lastFrame:int =-1;
		public function StarlingMovieClip(bmds:Array,num:int) 
		{
			this.bmds = bmds;
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			enterFrame(null);
		}
		
		private function enterFrame(e:Event):void 
		{
			var iframe:int = int(frame);
			if (iframe>=bmds.length){
				frame =iframe= 0;
			}
			if(lastFrame!=iframe){
				var bmd:String = bmds[iframe];
				if (bmd != null) {
					graphics.clear();
					Assets.getAtlas().getTexture(graphics,bmd);
				}
				lastFrame = iframe;
			}
			frame+=fps/60;
		}
	}

}