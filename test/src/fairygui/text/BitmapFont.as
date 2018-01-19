package fairygui.text
{
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapFont
	{
		public var id:String;
		public var size:int;
		public var ttf:Boolean;
		public var resizable:Boolean;
		public var colored:Boolean;
		public var atlas:BitmapData;		
		public var glyphs:Object;
		
		public function BitmapFont()
		{
			glyphs = {};
		}

		public function dispose():void
		{
			if(atlas!=null)
				atlas.dispose();
		}
		
		public function translateChannel(channel:int):int
		{
			switch(channel)
			{
				case 1:
					return BitmapDataChannel.BLUE;
				case 2:
					return BitmapDataChannel.GREEN;
				case 4:
					return BitmapDataChannel.RED;
				case 8:
					return BitmapDataChannel.ALPHA;
				default:
					return 0;
			}
		}
		
		private static var sHelperRect:Rectangle = new Rectangle();
		private static var sTransform:ColorTransform = new ColorTransform(0,0,0,1);
		private static var sHelperMat:Matrix = new Matrix();
		private static var sHelperBmd:BitmapData = new BitmapData(200,200,true,0);
		private static var sPoint0:Point = new Point(0,0);
		
		public function draw(target:BitmapData, glyph:BMGlyph, charPosX:Number, charPosY:Number, color:uint, fontScale:Number):void
		{
			charPosX += Math.ceil(glyph.offsetX*fontScale);
			charPosY += Math.ceil(glyph.offsetY*fontScale);
			
			var drawBmd:BitmapData = null;
			
			if(ttf)
			{
				if(atlas!=null)
				{
					sHelperBmd.fillRect(sHelperBmd.rect, 0);
					
					sHelperRect.x = 0;
					sHelperRect.y = 0;
					sHelperRect.width = glyph.width;
					sHelperRect.height = glyph.height;
					
					if(glyph.channel==0)
						sHelperBmd.fillRect(sHelperRect, 0);
					else
						sHelperBmd.fillRect(sHelperRect, 0xFFFFFFFF);
					
					sHelperRect.x = glyph.x;
					sHelperRect.y = glyph.y;
					
					if(glyph.channel==0)
						sHelperBmd.copyPixels(atlas, sHelperRect, sPoint0);
					else
						sHelperBmd.copyChannel(atlas, sHelperRect, sPoint0, glyph.channel, BitmapDataChannel.ALPHA);
					
					drawBmd = sHelperBmd;
				}
			}
			else if(glyph.imageItem!=null)
				drawBmd = glyph.imageItem.image;
			
			if(drawBmd!=null)
			{
				sHelperMat.identity();
				sHelperMat.scale(fontScale, fontScale);
				sHelperMat.translate(charPosX, charPosY);
				sHelperRect.x = charPosX;
				sHelperRect.y = charPosY;
				sHelperRect.width = Math.ceil(glyph.width*fontScale);
				sHelperRect.height = Math.ceil(glyph.height*fontScale);
				if(colored)
				{
					sTransform.redMultiplier = ((color>>16)&0xFF)/255;
					sTransform.greenMultiplier =  ((color>>8)&0xFF)/255;
					sTransform.blueMultiplier = (color&0xFF)/255;
					target.draw(drawBmd, sHelperMat, sTransform, null, sHelperRect, true);
				}
				else
					target.draw(drawBmd, sHelperMat, null, null, sHelperRect, true);
			}
		}
	}
}


