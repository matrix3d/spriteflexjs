package fairygui
{
	/*import com.greensock.TweenLite;*/
	
	import flash.geom.Point;	

	public class GearLook extends GearBase
	{
		//public var tweener:TweenLite;
		
		private var _storage:Object;
		private var _default:GearLookValue;
		private var _tweenValue:Point;
		
		public function GearLook(owner:GObject)
		{
			super(owner);
		}
		
		override protected function init():void
		{
			_default = new GearLookValue(_owner.alpha, _owner.rotation, _owner.grayed);
			_storage = {};
		}
		
		override protected function addStatus(pageId:String, value:String):void
		{
			if(value=="-")
				return;
			
			var arr:Array = value.split(",");
			var gv:GearLookValue;
			if(pageId==null)
				gv = _default;
			else
			{
				gv = new GearLookValue();
				_storage[pageId] = gv;
			}
			gv.alpha = parseFloat(arr[0]);
			gv.rotation = parseInt(arr[1]);
			gv.grayed = arr[2]=="1"?true:false;
		}
		
		override public function apply():void
		{
			var gv:GearLookValue = _storage[_controller.selectedPageId];
			if(!gv)
				gv = _default;
			
			if(_tween && !UIPackage._constructing && !disableAllTweenEffect)
			{
				_owner._gearLocked = true;
				_owner.grayed = gv.grayed;
				_owner._gearLocked = false;
				
				var a:Boolean;
				var b:Boolean;
				/*if(tweener!=null)
				{
					a = tweener.vars.onUpdateParams[0];
					b = tweener.vars.onUpdateParams[1];
					if(a && tweener.vars.x!=gv.alpha || b && tweener.vars.y!=gv.rotation)
					{
						_owner._gearLocked = true;
						if(a)
							_owner.alpha = tweener.vars.x;
						if(b)
							_owner.rotation = tweener.vars.y;
						_owner._gearLocked = false;
						tweener.kill();
						tweener = null;
						if(_displayLockToken!=0)
						{
							_owner.releaseDisplayLock(_displayLockToken);
							_displayLockToken = 0;
						}
					}
					else
						return;
				}*/
				
				a = gv.alpha!=_owner.alpha;
				b = gv.rotation!=_owner.rotation;
				if(a || b)
				{
					if(_owner.checkGearController(0, _controller))
						_displayLockToken = _owner.addDisplayLock();
					var vars:Object = 
						{
							ease: _easeType,
							x: gv.alpha,
							y: gv.rotation,
							delay: _delay,
							overwrite:0
						};
					vars.onUpdate = __tweenUpdate;
					vars.onUpdateParams = [a,b];
					vars.onComplete = __tweenComplete;
					//if(_tweenValue==null)
					//	_tweenValue = new Point();
					//_tweenValue.x = _owner.alpha;
					//_tweenValue.y = _owner.rotation;
					//tweener = TweenLite.to(_tweenValue, _tweenTime, vars);
				}
			}
			else
			{
				_owner._gearLocked = true;
				_owner.alpha = gv.alpha;
				_owner.rotation = gv.rotation;
				_owner.grayed = gv.grayed;
				_owner._gearLocked = false;
			}
		}
		
		private function __tweenUpdate(a:Boolean, b:Boolean):void
		{
			_owner._gearLocked = true;
			if(a)
				_owner.alpha = _tweenValue.x;
			if(b)
				_owner.rotation = _tweenValue.y;
			_owner._gearLocked = false;		
		}
		
		private function __tweenComplete():void
		{
			if(_displayLockToken!=0)
			{
				_owner.releaseDisplayLock(_displayLockToken);
				_displayLockToken = 0;
			}
			//tweener = null;
		}
		
		override public function updateState():void
		{
			var gv:GearLookValue = _storage[_controller.selectedPageId];
			if(!gv)
			{
				gv = new GearLookValue();
				_storage[_controller.selectedPageId] = gv;
			}

			gv.alpha = _owner.alpha;
			gv.rotation = _owner.rotation;
			gv.grayed = _owner.grayed;
		}
	}
}

class GearLookValue
{
	public var alpha:Number;
	public var rotation:Number;
	public var grayed:Boolean;
	
	public function GearLookValue(alpha:Number=0, rotation:Number=0, grayed:Boolean=false)
	{
		this.alpha = alpha;
		this.rotation = rotation;
		this.grayed = grayed;
	}
}
