package fairygui
{
	import fairygui.utils.ToolSet;

	public class GearColor extends GearBase
	{
		private var _storage:Object;
		private var _default:GearColorValue;
		
		public function GearColor(owner:GObject)
		{
			super(owner);			
		}
		
		override protected function init():void
		{
			if(_owner is ITextColorGear)
				_default = new GearColorValue(IColorGear(_owner).color, ITextColorGear(_owner).strokeColor);
			else
				_default = new GearColorValue(IColorGear(_owner).color);
			_storage = {};
		}
		
		override protected function addStatus(pageId:String, value:String):void
		{
			if(value=="-")
				return;
			
			var pos:int = value.indexOf(",");
			var col1:uint;
			var col2:uint;
			if(pos==-1)
			{
				col1 = ToolSet.convertFromHtmlColor(value);
				col2 = 0xFF000000; //为兼容旧版本，用这个值表示不设置
			}
			else
			{
				col1 = ToolSet.convertFromHtmlColor(value.substr(0,pos));
				col2 = ToolSet.convertFromHtmlColor(value.substr(pos+1));
			}
			if(pageId==null)
			{
				_default.color = col1;
				_default.strokeColor = col2;
			}
			else
				_storage[pageId] = new GearColorValue(col1, col2);
		}
		
		override public function apply():void
		{
			_owner._gearLocked = true;

			var gv:GearColorValue = _storage[_controller.selectedPageId];
			if(!gv)
				gv = _default;
			
			IColorGear(_owner).color = gv.color;
			if((_owner is ITextColorGear) && gv.strokeColor!=0xFF000000)
				ITextColorGear(_owner).strokeColor = gv.strokeColor;
			
			_owner._gearLocked = false;
		}
		
		override public function updateState():void
		{
			var gv:GearColorValue = _storage[_controller.selectedPageId];
			if(!gv)
			{
				gv = new GearColorValue();
				_storage[_controller.selectedPageId] = gv;
			}
			
			gv.color = IColorGear(_owner).color;
			if(_owner is ITextColorGear)
				gv.strokeColor = ITextColorGear(_owner).strokeColor;
		}
	}
}

class GearColorValue
{
	public var color:uint;
	public var strokeColor:uint;
	
	public function GearColorValue(color:uint=0, strokeColor:uint=0)
	{
		this.color = color;
		this.strokeColor = strokeColor;
	}
}