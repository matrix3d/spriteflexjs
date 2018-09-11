package fairygui.utils  {
	
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class GTimers {
		private var _items:Object;
		private var _itemMap:Dictionary;
		private var _itemPool:Object;
		private var _timer:Timer;

		private var _lastTime:Number;
		
		private var _enumI:int;
		private var _enumCount:int;
		
		public static var deltaTime:int;
		public static var time:Number;
		public static var workCount:uint;
		
		public static const inst:GTimers = new GTimers();
		
		private static const FPS24:int = int(1000/24);
		
		public function GTimers():void {
			_items = new Vector.<TimerItem>() as Object;
			_itemMap = new Dictionary();
			_itemPool = new Vector.<TimerItem>() as Object;
			
			deltaTime = 1;
			_lastTime = getTimer();
			time = _lastTime;
			
			_timer = new Timer(10);
			_timer.addEventListener(TimerEvent.TIMER, __timer);
			_timer.start();
		}
		
		private function getItem():TimerItem
		{
			if(_itemPool.length)
				return _itemPool.pop();
			else
				return new TimerItem();
		}
		
		public function add(delayInMiniseconds:int, repeat:int, callback:Function, callbackParam:Object=null):void {
			var item:TimerItem = _itemMap[callback];
			if(!item)
			{
				item = getItem();
				item.callback = callback;
				item.hasParam = callback.length==1;
				_itemMap[callback] = item;
				_items.push(item);
			}
			item.delay = delayInMiniseconds;
			item.counter = 0;
			item.repeat = repeat;
			item.param = callbackParam;
			item.end = false;
		}
		
		public function callLater(callback:Function, callbackParam:Object=null):void
		{
			add(1,1,callback,callbackParam);
		}
		
		public function callDelay(delay:int, callback:Function, callbackParam:Object=null):void
		{
			add(delay,1,callback,callbackParam);
		}
		
		public function callBy24Fps(callback:Function, callbackParam:Object=null):void
		{
			add(FPS24,0,callback,callbackParam);
		}

		public function exists(callback:Function):Boolean {
			return _itemMap[callback]!=undefined;
		}
		
		public function remove(callback:Function):void {
			var item:TimerItem = _itemMap[callback];
			if(item)
			{
				var i:int = _items.indexOf(item);
				_items.splice(i,1);
				if(i<_enumI)
					_enumI--;
				_enumCount--;
				
				item.callback = null;
				item.param = null;
				delete _itemMap[callback];
				_itemPool.push(item);
			}
		}
		
		private function __timer(evt:TimerEvent):void {
			time =  getTimer();
			workCount++;
			
			deltaTime = time-_lastTime;
			_lastTime = time;
			
			if(deltaTime>125)
				deltaTime = 125;

			_enumI = 0;
			_enumCount = _items.length;
			
			while(_enumI<_enumCount)
			{
				var item:TimerItem = _items[_enumI];
				_enumI++;
				
				if(item.advance(deltaTime)) {
					if(item.end)
					{
						_enumI--;
						_enumCount--;
						_items.splice(_enumI,1);
						delete _itemMap[item.callback];
						_itemPool.push(item);
					}
					
					if(item.hasParam)
						item.callback(item.param);
					else
						item.callback();
				}
			}
		}
	}
}

class TimerItem
{
	public var delay:int;
	public var counter:int;
	public var repeat:int;
	public var callback:Function;
	public var param:Object;
	
	public var hasParam:Boolean;
	public var end:Boolean;
	
	public function TimerItem()
	{	
	}
	
	public function advance(elapsed:int):Boolean
	{
		counter += elapsed;
		if(counter>=delay) {
			counter -= delay;
			if(counter>delay)
				counter = delay;
			
			if(repeat>0)
			{
				repeat--;
				if(repeat==0)
					end = true;
			}
			
			return true;
		}
		else
			return false;
	}
}
