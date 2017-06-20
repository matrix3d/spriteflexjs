package fairygui.text
{
	import flash.display.DisplayObject;
	
	import fairygui.LoaderFillType;
	import fairygui.GLoader;
	import fairygui.PackageItem;
	import fairygui.UIPackage;
	import fairygui.display.UIDisplayObject;

	public class RichTextObjectFactory implements IRichTextObjectFactory
	{
		public var pool:Array;
		
		public function RichTextObjectFactory()
		{
			pool = [];
		}
		
		public function createObject(src:String, width:int, height:int):DisplayObject
		{
			var loader:GLoader;
			
			if (pool.length > 0)
				loader = pool.pop();
			else
			{
				loader = new GLoader();
				loader.fill = LoaderFillType.ScaleFree;
			}
			loader.url = src;
			
			var pi:PackageItem = UIPackage.getItemByURL(src);
			if(width!=0)
				loader.width = width;
			else
			{
				if (pi != null)
					width = pi.width;
				else
					width = 20;
				loader.width = width;
			}
			
			if(height!=0)
				loader.height = height;
			else
			{
				if (pi != null)
					height = pi.height;
				else
					height = 20;
				loader.height = height;
			}
			
			return loader.displayObject;
		}
		
		public function freeObject(obj:DisplayObject):void
		{
			var loader:GLoader = GLoader(UIDisplayObject(obj).owner);
			loader.url = null;
			pool.push(loader);
		}
	}
}