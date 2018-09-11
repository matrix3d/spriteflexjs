package fairygui
{	
	/*import com.greensock.TweenLite;
	import com.greensock.easing.Linear;*/

	public class GProgressBar extends GComponent
	{
		private var _max:Number;
		private var _value:Number;
		private var _titleType:int;
		private var _reverse:Boolean;
		
		private var _titleObject:GTextField;
		private var _aniObject:GObject;
		private var _barObjectH:GObject;
		private var _barObjectV:GObject;
		private var _barMaxWidth:int;
		private var _barMaxHeight:int;
		private var _barMaxWidthDelta:int;
		private var _barMaxHeightDelta:int;
		private var _barStartX:int;
		private var _barStartY:int;
		
		//private var _tweener:TweenLite;		
		public var _tweenValue:int;
		
		public function GProgressBar()
		{
			super();
			
			_titleType = ProgressTitleType.Percent;
			_value = 50;
			_max = 100;
		}

		final public function get titleType():int
		{
			return _titleType;
		}

		final public function set titleType(value:int):void
		{
			if (_titleType != value)
			{
				_titleType = value;
				update(_value);
			}
		}

		final public function get max():Number
		{
			return _max;
		}

		final public function set max(value:Number):void
		{
			if(_max != value)
			{
				_max = value;
				update(_value);
			}
		}

		final public function get value():Number
		{
			return _value;
		}
		
		final public function set value(value:Number):void
		{
			/*if(_tweener)
			{
				_tweener.kill();
				_tweener = null;
			}*/
			
			if(_value != value)
			{
				_value = value;
				update(_value);
			}
		}
		
		/*public function tweenValue(value:Number, duration:Number):TweenLite
		{
			if(_value != value)
			{
				if(_tweener)
					_tweener.kill();
				
				_tweenValue = _value;
				_value = value;
				_tweener = TweenLite.to(this, duration,
					{_tweenValue:value, onUpdate:onTweenUpdate, onComplete:onTweenComplete, ease: Linear.ease});
				return _tweener;
			}
			else
				return null;
		}*/
		
		private function onTweenUpdate():void
		{
			update(_tweenValue);
		}
		
		private function onTweenComplete():void
		{
			//_tweener = null;
		}
		
		public function update(newValue:int):void
		{
			var percent:Number = _max!=0?Math.min(newValue/_max,1):0;
			if(_titleObject)
			{
				switch(_titleType)
				{
					case ProgressTitleType.Percent:
						_titleObject.text = Math.round(percent*100)+"%";
						break;
					
					case ProgressTitleType.ValueAndMax:
						_titleObject.text = Math.round(newValue) + "/" + Math.round(_max);
						break;
					
					case ProgressTitleType.Value:
						_titleObject.text = ""+Math.round(newValue);
						break;
					
					case ProgressTitleType.Max:
						_titleObject.text = ""+Math.round(_max);
						break;
				}
			}
			
			var fullWidth:int = this.width-this._barMaxWidthDelta;
			var fullHeight:int = this.height-this._barMaxHeightDelta;
			if(!_reverse)
			{
				if(_barObjectH)
					_barObjectH.width = fullWidth*percent;
				if(_barObjectV)
					_barObjectV.height = fullHeight*percent;
			}
			else
			{
				if(_barObjectH)
				{
					_barObjectH.width = fullWidth*percent;
					_barObjectH.x = _barStartX + (fullWidth-_barObjectH.width);
					
				}
				if(_barObjectV)
				{
					_barObjectV.height = fullHeight*percent;
					_barObjectV.y =  _barStartY + (fullHeight-_barObjectV.height);
				}
			}
			if(_aniObject is GMovieClip)
				GMovieClip(_aniObject).frame = Math.round(percent*100);
			else if(_aniObject is GSwfObject)
				GSwfObject(_aniObject).frame = Math.round(percent*100);
		}
		
		override protected function constructFromXML(xml:XML):void
		{
			super.constructFromXML(xml);
			
			xml = xml.ProgressBar[0];
			
			var str:String;
			str = xml.@titleType;
			if(str)
				_titleType = ProgressTitleType.parse(str);

			_reverse = xml.@reverse=="true";
			
			_titleObject = getChild("title") as GTextField;
			_barObjectH = getChild("bar");
			_barObjectV = getChild("bar_v");
			_aniObject = getChild("ani");
			
			if(_barObjectH)
			{
				_barMaxWidth = _barObjectH.width;
				_barMaxWidthDelta = this.width - _barMaxWidth;
				_barStartX = _barObjectH.x;
			}
			if(_barObjectV)
			{
				_barMaxHeight = _barObjectV.height;
				_barMaxHeightDelta = this.height - _barMaxHeight;
				_barStartY = _barObjectV.y;
			}
		}
		
		override protected function handleSizeChanged():void
		{
			super.handleSizeChanged();
			
			if(_barObjectH)
				_barMaxWidth = this.width - _barMaxWidthDelta;
			if(_barObjectV)
				_barMaxHeight = this.height - _barMaxHeightDelta;
			if(!this._underConstruct)
				update(_value);
		}
		
		override public function setup_afterAdd(xml:XML):void
		{
			super.setup_afterAdd(xml);
			
			xml = xml.ProgressBar[0];
			if(xml)
			{
				_value = parseInt(xml.@value);
				if(isNaN(_value))
					_value = 0;
				_max = parseInt(xml.@max);
				if(isNaN(_max))
					_max = 0;
			}
			update(_value);
		}
		
		override public function dispose():void
		{
			//if(_tweener)
			//	_tweener.kill();
			super.dispose();
		}
	}
}