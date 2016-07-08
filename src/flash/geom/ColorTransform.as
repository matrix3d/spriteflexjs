package flash.geom
{
	
	public class ColorTransform extends Object
	{
		
		private var _redMultiplier:Number;
		
		private var _greenMultiplier:Number;
		
		private var _blueMultiplier:Number;
		
		private var _alphaMultiplier:Number;
		
		public var redOffset:Number;
		
		public var greenOffset:Number;
		
		public var blueOffset:Number;
		
		public var alphaOffset:Number;
		
		public var tint:uint = 0xffffffff;
		public function ColorTransform(redMultiplier:Number = 1.0, greenMultiplier:Number = 1.0, blueMultiplier:Number = 1.0, alphaMultiplier:Number = 1.0, redOffset:Number = 0, greenOffset:Number = 0, blueOffset:Number = 0, alphaOffset:Number = 0)
		{
			super();
			this.redMultiplier = redMultiplier;
			this.greenMultiplier = greenMultiplier;
			this.blueMultiplier = blueMultiplier;
			this.alphaMultiplier = alphaMultiplier;
			this.redOffset = redOffset;
			this.greenOffset = greenOffset;
			this.blueOffset = blueOffset;
			this.alphaOffset = alphaOffset;
		}
		
		public function get color():uint
		{
			return this.redOffset << 16 | this.greenOffset << 8 | this.blueOffset;
		}
		
		public function set color(newColor:uint):void
		{
			this.redMultiplier = this.greenMultiplier = this.blueMultiplier = 0;
			this.redOffset = newColor >> 16 & 255;
			this.greenOffset = newColor >> 8 & 255;
			this.blueOffset = newColor & 255;
		}
		
		public function get redMultiplier():Number 
		{
			return _redMultiplier;
		}
		
		public function set redMultiplier(value:Number):void 
		{
			_redMultiplier = value;
			tint = ((_redMultiplier*0xff) << 0)|((_greenMultiplier*0xff) << 8)|((_blueMultiplier*0xff) << 16) | ((_alphaMultiplier*0xff) << 24);
			//_glColorArr[0] = value;
		}
		
		public function get greenMultiplier():Number 
		{
			return _greenMultiplier;
		}
		
		public function set greenMultiplier(value:Number):void 
		{
			_greenMultiplier = value;
			//_glColorArr[1] = value;
			tint = ((_redMultiplier*0xff) << 0)|((_greenMultiplier*0xff) << 8)|((_blueMultiplier*0xff) << 16) | ((_alphaMultiplier*0xff) << 24);
		}
		
		public function get blueMultiplier():Number 
		{
			return _blueMultiplier;
		}
		
		public function set blueMultiplier(value:Number):void 
		{
			_blueMultiplier = value;
			//_glColorArr[2] = value;
			tint = ((_redMultiplier*0xff) << 0)|((_greenMultiplier*0xff) << 8)|((_blueMultiplier*0xff) << 16) | ((_alphaMultiplier*0xff) << 24);
		}
		
		public function get alphaMultiplier():Number 
		{
			return _alphaMultiplier;
		}
		
		public function set alphaMultiplier(value:Number):void 
		{
			_alphaMultiplier = value;
			//_glColorArr[3] = value;
			tint = ((_redMultiplier*0xff) << 0)|((_greenMultiplier*0xff) << 8)|((_blueMultiplier*0xff) << 16) | ((_alphaMultiplier*0xff) << 24);
		}
		
		public function concat(second:ColorTransform):void
		{
			this.alphaOffset = this.alphaOffset + this.alphaMultiplier * second.alphaOffset;
			this.alphaMultiplier = this.alphaMultiplier * second.alphaMultiplier;
			this.redOffset = this.redOffset + this.redMultiplier * second.redOffset;
			this.redMultiplier = this.redMultiplier * second.redMultiplier;
			this.greenOffset = this.greenOffset + this.greenMultiplier * second.greenOffset;
			this.greenMultiplier = this.greenMultiplier * second.greenMultiplier;
			this.blueOffset = this.blueOffset + this.blueMultiplier * second.blueOffset;
			this.blueMultiplier = this.blueMultiplier * second.blueMultiplier;
		}
		
		public function toString():String
		{
			return "(redMultiplier=" + this.redMultiplier + ", greenMultiplier=" + this.greenMultiplier + ", blueMultiplier=" + this.blueMultiplier + ", alphaMultiplier=" + this.alphaMultiplier + ", redOffset=" + this.redOffset + ", greenOffset=" + this.greenOffset + ", blueOffset=" + this.blueOffset + ", alphaOffset=" + this.alphaOffset + ")";
		}
	}
}
