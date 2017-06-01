package flash.__native 
{
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	/**
	 * ...
	 * @author lizhi
	 */
	public class BitmapTexture 
	{
		public var texture:Texture;
		public var bmd:BitmapData;
		public var img:Object;
		public var width:int;
		public var height:int;
		public var dirty:Boolean = true;
		public function BitmapTexture() 
		{
			
		}
		
	}

}