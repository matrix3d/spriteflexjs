package fairygui
{
	/*import com.greensock.easing.Ease;
	import com.greensock.easing.EaseLookup;
	import com.greensock.easing.Quad;*/
	
	public class GearBase
	{
		public static var disableAllTweenEffect:Boolean = false;
		
		protected var _tween:Boolean;
		protected var _easeType:Object//Ease;
		protected var _tweenTime:Number;
		protected var _delay:Number;
		protected var _displayLockToken:uint;
		
		protected var _owner:GObject;
		protected var _controller:Controller;
		
		public function GearBase(owner:GObject)
		{
			_owner = owner;
			//_easeType = Quad.easeOut;
			_tweenTime = 0.3;
			_delay = 0;
		}

		final public function get controller():Controller
		{
			return _controller;
		}
		
		public function set controller(val:Controller):void
		{
			if(val!=_controller)
			{
				_controller = val;
				if(_controller)
					init();
			}
		}

		final public function get tween():Boolean
		{
			return _tween;
		}
		
		public function set tween(val:Boolean):void
		{
			_tween = val;
		}
		
		final public function get tweenTime():Number
		{
			return _tweenTime;
		}
		
		public function set tweenTime(value:Number):void
		{
			_tweenTime = value;
		}
		
		final public function get delay():Number
		{
			return _delay;
		}
		
		public function set delay(value:Number):void
		{
			_delay = value;
		}
		
		final public function get easeType():Object/*Ease*/
		{
			return _easeType;
		}
		
		public function set easeType(value:Object/*Ease*/):void
		{
			_easeType = value;
		}
		
		public function setup(xml:XML):void
		{
			_controller = _owner.parent.getController(xml.@controller);
			if(!_controller)
				return;
			
			init();
			
			var str:String;

			str = xml.@tween;
			if(str)
				_tween = true;
			
			str = xml.@ease;
			if(str)
			{
				var pos:int = str.indexOf(".");
				if(pos!=-1)
					str = str.substr(0,pos) + ".ease" + str.substr(pos+1);
				//if(str=="Linear")
				//	_easeType = EaseLookup.find("linear.easenone");
				//else
				//	_easeType = EaseLookup.find(str);
			}
			
			str = xml.@duration;
			if(str)
				_tweenTime = parseFloat(str);
			
			str = xml.@delay;
			if(str)
				_delay = parseFloat(str);
			
			if(this is GearDisplay)
			{
				str = xml.@pages;
				if(str)
				{
					var arr:Array = str.split(",");
					GearDisplay(this).pages = arr;
				}
			}
			else
			{
				var pages:Array;
				var values:Array;
				
				str = xml.@pages;
				if(str)
					pages = str.split(",");
				
				str = xml.@values;
				if(str)
					values = str.split("|");
				
				if(pages && values)
				{
					for(var i:int=0;i<values.length;i++)
						addStatus(pages[i], values[i]);
				}
				
				str = xml.@["default"];
				if(str)
					addStatus(null, str);
			}	
		}
		
		public function updateFromRelations(dx:Number, dy:Number):void
		{
		}
		
		protected function addStatus(pageId:String, value:String):void
		{
			
		}
		
		protected function init():void
		{
			
		}
		
		public function apply():void
		{
		}
		
		public function updateState():void
		{
		}
	}
}