package flash.geom
{
	
	public class ColorTransform extends Object
	{
		
		public var redMultiplier:Number;
		
		public var greenMultiplier:Number;
		
		public var blueMultiplier:Number;
		
		public var alphaMultiplier:Number;
		
		public var redOffset:Number;
		
		public var greenOffset:Number;
		
		public var blueOffset:Number;
		
		public var alphaOffset:Number;
		
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
