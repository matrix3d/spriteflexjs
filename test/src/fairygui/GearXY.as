package fairygui
{
	import com.greensock.TweenLite;
	
	import flash.geom.Point;	
	
	public class GearXY extends GearBase
	{
		public var tweener:TweenLite;
		
		private var _storage:Object;
		private var _default:Point;
		private var _tweenValue:Point;
		
		public function GearXY(owner:GObject)
		{
			super(owner);
		}
		
		override protected function init():void
		{
			_default = new Point(_owner.x, _owner.y);
			_storage = {};
		}
		
		override protected function addStatus(pageId:String, value:String):void
		{
			if(value=="-")
				return;
			
			var arr:Array = value.split(",");
			var pt:Point;
			if(pageId==null)
				pt = _default;
			else
			{
				pt = new Point();
				_storage[pageId] = pt;
			}
			pt.x = parseInt(arr[0]);
			pt.y = parseInt(arr[1]);
		}

		override public function apply():void
		{
			var pt:Point = _storage[_controller.selectedPageId];
			if(!pt)
				pt = _default;

			if(_tween && !UIPackage._constructing && !disableAllTweenEffect)
			{
				if(tweener!=null)
				{
					if(tweener.vars.x!=pt.x || tweener.vars.y!=pt.y)
					{
						_owner._gearLocked = true;
						_owner.setXY(tweener.vars.x, tweener.vars.y);
						_owner._gearLocked = false;
						tweener.kill();
						tweener = null;
						_owner.releaseDisplayLock(_displayLockToken);
						_displayLockToken = 0;
					}
					else
						return;
				}
				
				if (_owner.x != pt.x || _owner.y != pt.y)
				{
					if(_owner.checkGearController(0, _controller))
						_displayLockToken = _owner.addDisplayLock();
					var vars:Object = 
						{
							x: pt.x,
							y: pt.y,
							ease: _easeType,
							delay: _delay,
							overwrite:0
						};
					vars.onUpdate = __tweenUpdate;
					vars.onComplete = __tweenComplete;
					if(_tweenValue==null)
						_tweenValue = new Point();
					_tweenValue.x = _owner.x;
					_tweenValue.y = _owner.y;
					tweener = TweenLite.to(_tweenValue, _tweenTime, vars);
				}
			}
			else
			{
				_owner._gearLocked = true;
				_owner.setXY(pt.x, pt.y);
				_owner._gearLocked = false;
			}
		}
		
		private function __tweenUpdate():void
		{
			_owner._gearLocked = true;
			_owner.setXY(_tweenValue.x, _tweenValue.y);
			_owner._gearLocked = false;
		}
		
		private function __tweenComplete():void
		{
			if(_displayLockToken!=0)
			{
				_owner.releaseDisplayLock(_displayLockToken);
				_displayLockToken = 0;
			}
			tweener = null;
		}
		
		override public function updateState():void
		{
			var pt:Point = _storage[_controller.selectedPageId];
			if(!pt) {
				pt = new Point();
				_storage[_controller.selectedPageId] = pt;
			}
			
			pt.x = _owner.x;
			pt.y = _owner.y;
		}
		
		override public function updateFromRelations(dx:Number, dy:Number):void
		{
			if(_controller==null || _storage==null)
				return;
			
			for each (var pt:Point in _storage)
			{
				pt.x += dx;
				pt.y += dy;
			}
			_default.x += dx;
			_default.y += dy;
			
			updateState();
		}
	}
}
