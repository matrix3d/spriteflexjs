package fairygui
{

	public class GearAnimation extends GearBase
	{
		private var _storage:Object;
		private var _default:GearAnimationValue;
		
		public function GearAnimation(owner:GObject)
		{
			super(owner);
		}
		
		override protected function init():void
		{
			_default = new GearAnimationValue(IAnimationGear(_owner).playing, IAnimationGear(_owner).frame);
			_storage = {};
		}
		
		override protected function addStatus(pageId:String, value:String):void
		{
			if(value=="-")
				return;
			
			var gv:GearAnimationValue;
			if(pageId==null)
				gv = _default;
			else
			{
				gv = new GearAnimationValue();
				_storage[pageId] = gv; 
			}
			var arr:Array = value.split(",");
			gv.frame = int(arr[0]);
			gv.playing = arr[1]=="p";
		}
		
		override public function apply():void
		{
			_owner._gearLocked = true;
			
			var gv:GearAnimationValue = _storage[_controller.selectedPageId];
			if(!gv)
				gv = _default;
			
			IAnimationGear(_owner).playing = gv.playing;
			IAnimationGear(_owner).frame = gv.frame;
			
			_owner._gearLocked = false;
		}
		
		override public function updateState():void
		{
			var mc:IAnimationGear = IAnimationGear(_owner);
			var gv:GearAnimationValue = _storage[_controller.selectedPageId];
			if(!gv)
			{
				gv = new GearAnimationValue();
				_storage[_controller.selectedPageId] = gv;
			}
			
			gv.playing = mc.playing;
			gv.frame = mc.frame;
		}
	}
}

class GearAnimationValue
{
	public var playing:Boolean;
	public var frame:int;
	
	public function GearAnimationValue(playing:Boolean=true, frame:int=0):void
	{
		this.playing = playing;
		this.frame = frame;
	}
}
