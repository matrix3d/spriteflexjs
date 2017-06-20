package fairygui
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	
	import fairygui.display.Frame;
	import fairygui.text.BitmapFont;

	public class PackageItem
	{
		public var owner:UIPackage;
		
		public var type:int;
		public var id:String;
		public var name:String;
		public var width:int;
		public var height:int;
		public var file:String;
		public var lastVisitTime:int;
		
		public var callbacks:Array = [];
		public var loading:int;
		public var loaded:Boolean;
		
		//image
		public var scale9Grid:Rectangle;
		public var scaleByTile:Boolean;
		public var smoothing:Boolean;
		public var tileGridIndice:int;
		public var image:BitmapData;
		
		//movieclip
		public var interval:Number;
		public var repeatDelay:Number;
		public var swing:Boolean;
		public var frames:Vector.<Frame>;
		
		//componenet
		public var componentData:XML;
		public var displayList:Vector.<DisplayListItem>;
		public var extensionType:Object;
		
		//sound
		public var sound:Sound;
		
		//font 
		public var bitmapFont:BitmapFont;
		
		public function PackageItem()
		{
		}

		public function addCallback(callback:Function):void
		{
			var i:int = callbacks.indexOf(callback);
			if(i==-1)
				callbacks.push(callback);
		}
		
		public function removeCallback(callback:Function):Function
		{
			var i:int = callbacks.indexOf(callback);
			if(i!=-1)
			{
				callbacks.splice(i,1);
				return callback;
			}
			else
				return null;
		}
		
		public function completeLoading():void
		{
			loading = 0;
			loaded = true;
			var arr:Array = callbacks.slice();
			for each(var callback:Function in arr)
				callback(this);
			callbacks.length = 0;
		}
		
		public function toString():String
		{
			return name;
		}
	}
}