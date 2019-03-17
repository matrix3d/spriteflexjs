package flash.__native.te 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author lizhi
	 */
	public class UVTexture 
	{
		private var _bmd:BitmapData;
		public function UVTexture() 
		{
			
		}
		
		
		public function get bmd():BitmapData{
			if (_bmd==null){
				//gen bmd
			}
			return _bmd;
		}
		
	}

}