package fairygui.display
{
	import fairygui.utils.GTimers;

	public class PlayState
	{
		public var reachEnding:Boolean; //是否已播放到结尾
		public var reversed:Boolean; //是否已反向播放
		public var repeatedCount:int; //重复次数
		
		private var _curFrame:int; //当前帧
		private var _curFrameDelay:int; //当前帧延迟
		private var _lastUpdateSeq:uint;
		
		public function PlayState()
		{
		}
		
		public function update(mc:MovieClip):void
		{
			var elapsed:Number;
			var frameId:uint = GTimers.workCount;
			if (frameId - _lastUpdateSeq != 1) 
				//1、如果>1，表示不是连续帧了，说明刚启动（或者停止过），这里不能用流逝的时间了，不然会跳过很多帧
				//2、如果==0，表示在本帧已经处理过了，这通常是因为一个PlayState用于多个MovieClip共享，目的是多个MovieClip同步播放
				elapsed = 0;
			else
				elapsed = GTimers.deltaTime;
			_lastUpdateSeq = frameId;
			
			reachEnding = false;
			_curFrameDelay += elapsed;
			var interval:int = mc.interval + mc.frames[_curFrame].addDelay + ((_curFrame == 0 && repeatedCount > 0) ? mc.repeatDelay : 0);
			if (_curFrameDelay < interval)
				return;
			
			_curFrameDelay -= interval;
			if(_curFrameDelay>mc.interval)
				_curFrameDelay = mc.interval;
			
			if (mc.swing)
			{
				if(reversed)
				{
					_curFrame--;
					if(_curFrame<0)
					{
						_curFrame = Math.min(1, mc.frameCount-1);
						repeatedCount++;
						reversed = !reversed;
					}
				}
				else
				{
					_curFrame++;
					if (_curFrame > mc.frameCount - 1)
					{
						_curFrame = Math.max(0, mc.frameCount-2);
						repeatedCount++;
						reachEnding = true;
						reversed = !reversed;
					}
				}				
			}
			else
			{
				_curFrame++;
				if (_curFrame > mc.frameCount - 1)
				{
					_curFrame = 0;
					repeatedCount++;
					reachEnding = true;
				}
			}
		}
		
		public function get currentFrame():int
		{
			return _curFrame;
		}
		
		public function set currentFrame(value:int):void
		{
			_curFrame = value; 
			_curFrameDelay = 0;
		}
		
		public function rewind():void
		{
			_curFrame = 0;
			_curFrameDelay = 0;
			reversed = false;
			reachEnding = false;
		}
		
		public function reset():void
		{
			_curFrame = 0;
			_curFrameDelay = 0;
			repeatedCount = 0;
			reachEnding = false;
			reversed = false;
		}
		
		public function copy(src:PlayState):void
		{
			_curFrame = src._curFrame;
			_curFrameDelay = src._curFrameDelay;
			repeatedCount = src.repeatedCount;
			reachEnding = src.reachEnding;
			reversed = src.reversed;
		}
	}
}