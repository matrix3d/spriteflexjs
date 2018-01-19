package fairygui
{
	internal class RelationItem
	{
		private var _owner:GObject;
		private var _target:GObject;
		private var _defs:Vector.<RelationDef>;
		private var _targetX:Number;
		private var _targetY:Number;
		private var _targetWidth:Number;
		private var _targetHeight:Number;
		
		public function RelationItem(owner:GObject)
		{
			_owner = owner;
			_defs =  new Vector.<RelationDef>();
		}
		
		final public function get owner():GObject
		{
			return _owner;
		}
		
		public function set target(value:GObject):void
		{
			if(_target!=value)
			{
				if(_target)
					releaseRefTarget(_target);
				_target = value;
				if(_target)
					addRefTarget(_target);
			}
		}
		
		final public function get target():GObject
		{
			return _target;
		}
		
		public function add(relationType:int, usePercent:Boolean):void
		{
			if (relationType == RelationType.Size)
			{
				add(RelationType.Width, usePercent);
				add(RelationType.Height, usePercent);
				return;
			}
			
			for each (var def:RelationDef in _defs)
			{
				if (def.type == relationType)
					return;
			}
			
			internalAdd(relationType, usePercent);
		}
		
		public function internalAdd(relationType:int, usePercent:Boolean):void
		{
			if (relationType == RelationType.Size)
			{
				internalAdd(RelationType.Width, usePercent);
				internalAdd(RelationType.Height, usePercent);
				return;
			}
			
			var info:RelationDef = new RelationDef();
			info.percent = usePercent;
			info.type = relationType;
			_defs.push(info);
			
			//当使用中线关联时，因为需要除以2，很容易因为奇数宽度/高度造成小数点坐标；当使用百分比时，也会造成小数坐标；
			//所以设置了这类关联的对象，自动启用pixelSnapping
			if (usePercent || relationType == RelationType.Left_Center || relationType == RelationType.Center_Center || relationType == RelationType.Right_Center
				|| relationType == RelationType.Top_Middle || relationType == RelationType.Middle_Middle || relationType == RelationType.Bottom_Middle)
				_owner.pixelSnapping = true;
		}
		
		public function remove(relationType:int):void
		{
			if (relationType == RelationType.Size)
			{
				remove(RelationType.Width);
				remove(RelationType.Height);
				return;
			}
			
			var dc:int = _defs.length;
			for (var k:int = 0; k < dc; k++)
			{
				if (_defs[k].type == relationType)
				{
					_defs.splice(k, 1);
					break;
				}
			}
		}
		
		public function copyFrom(source:RelationItem):void
		{
			this.target = source.target;
			
			_defs.length = 0;
			for each (var info:RelationDef in source._defs)
			{
				var info2:RelationDef = new RelationDef();
				info2.copyFrom(info);
				_defs.push(info2);
			}
		}
		
		public function dispose():void
		{
			if (_target != null)
			{
				releaseRefTarget(_target);
				_target = null;
			}
		}
		
		final public function get isEmpty():Boolean
		{
			return _defs.length == 0;
		}
		
		public function applyOnSelfResized(dWidth:Number, dHeight:Number):void
		{
			var ox:Number = _owner.x;
			var oy:Number = _owner.y;
			for each (var info:RelationDef in _defs)
			{
				switch (info.type)
				{
					case RelationType.Center_Center:
					case RelationType.Right_Center:
						_owner.x -= dWidth / 2;
						break;
					
					case RelationType.Right_Left:
					case RelationType.Right_Right:
						_owner.x -= dWidth;
						break;
					
					case RelationType.Middle_Middle:
					case RelationType.Bottom_Middle:
						_owner.y -= dHeight / 2;
						break;
					case RelationType.Bottom_Top:
					case RelationType.Bottom_Bottom:
						_owner.y -= dHeight;
						break;
				}
			}
			
			if (ox!=_owner.x || oy!=_owner.y)
			{
				ox = _owner.x - ox;
				oy = _owner.y - oy;
				
				_owner.updateGearFromRelations(1, ox, oy);
				
				if (_owner.parent != null && _owner.parent._transitions.length > 0)
				{
					for each (var trans:Transition in _owner.parent._transitions)
					{
						trans.updateFromRelations(_owner.id, ox, oy);
					}
				}
			}
		}
		
		private function applyOnXYChanged(info:RelationDef, dx:Number, dy:Number):void
		{
			var tmp:Number;
			switch (info.type)
			{
				case RelationType.Left_Left:
				case RelationType.Left_Center:
				case RelationType.Left_Right:
				case RelationType.Center_Center:
				case RelationType.Right_Left:
				case RelationType.Right_Center:
				case RelationType.Right_Right:
					_owner.x += dx;
					break;
				
				case RelationType.Top_Top:
				case RelationType.Top_Middle:
				case RelationType.Top_Bottom:
				case RelationType.Middle_Middle:
				case RelationType.Bottom_Top:
				case RelationType.Bottom_Middle:
				case RelationType.Bottom_Bottom:
					_owner.y += dy;
					break;
				
				case RelationType.Width:
				case RelationType.Height:
					break;
				
				case RelationType.LeftExt_Left:
				case RelationType.LeftExt_Right:
					tmp = _owner.x;
					_owner.x += dx;
					_owner.width = _owner._rawWidth - (_owner.x - tmp);
					break;
				
				case RelationType.RightExt_Left:
				case RelationType.RightExt_Right:
					_owner.width = _owner._rawWidth + dx;
					break;
				
				case RelationType.TopExt_Top:
				case RelationType.TopExt_Bottom:
					tmp = _owner.y;
					_owner.y += dy;
					_owner.height = _owner._rawHeight - (_owner.y - tmp);
					break;
				
				case RelationType.BottomExt_Top:
				case RelationType.BottomExt_Bottom:
					_owner.height = _owner._rawHeight + dy;
					break;
			}
		}
		
		private function applyOnSizeChanged(info:RelationDef):void
		{
			var targetX:Number, targetY:Number;
			if (_target != _owner.parent)
			{
				targetX = _target.x;
				targetY = _target.y;
			}
			else
			{
				targetX = 0;
				targetY = 0;
			}
			var v:Number, tmp:Number;
			
			switch (info.type)
			{
				case RelationType.Left_Left:
					if(info.percent && _target==_owner.parent)
					{
						v = _owner.x - targetX;
						if (info.percent)
							v = v / _targetWidth * _target._rawWidth;
						_owner.x = targetX + v;
					}
					break;
				case RelationType.Left_Center:
					v = _owner.x - (targetX + _targetWidth / 2);
					if (info.percent)
						v = v / _targetWidth * _target._rawWidth;
					_owner.x = targetX + _target._rawWidth / 2 + v;
					break;
				case RelationType.Left_Right:
					v = _owner.x - (targetX + _targetWidth);
					if (info.percent)
						v = v / _targetWidth * _target._rawWidth;
					_owner.x = targetX + _target._rawWidth + v;
					break;
				case RelationType.Center_Center:
					v = _owner.x + _owner._rawWidth / 2 - (targetX + _targetWidth / 2);
					if (info.percent)
						v = v / _targetWidth * _target._rawWidth;
					_owner.x = targetX + _target._rawWidth / 2 + v - _owner._rawWidth / 2;
					break;
				case RelationType.Right_Left:
					v = _owner.x + _owner._rawWidth - targetX;
					if (info.percent)
						v = v / _targetWidth * _target._rawWidth;
					_owner.x = targetX + v - _owner._rawWidth;
					break;
				case RelationType.Right_Center:
					v = _owner.x + _owner._rawWidth - (targetX + _targetWidth / 2);
					if (info.percent)
						v = v / _targetWidth * _target._rawWidth;
					_owner.x = targetX + _target._rawWidth / 2 + v - _owner._rawWidth;
					break;
				case RelationType.Right_Right:
					v = _owner.x + _owner._rawWidth - (targetX + _targetWidth);
					if (info.percent)
						v = v / _targetWidth * _target._rawWidth;
					_owner.x = targetX + _target._rawWidth + v - _owner._rawWidth;
					break;
				
				case RelationType.Top_Top:
					if(info.percent && _target==_owner.parent)
					{
						v = _owner.y - targetY;
						if (info.percent)
							v = v / _targetHeight * _target._rawHeight;
						_owner.y = targetY + v;
					}
					break;
				case RelationType.Top_Middle:
					v = _owner.y - (targetY + _targetHeight / 2);
					if (info.percent)
						v = v / _targetHeight * _target._rawHeight;
					_owner.y = targetY + _target._rawHeight / 2 + v;
					break;
				case RelationType.Top_Bottom:
					v = _owner.y - (targetY + _targetHeight);
					if (info.percent)
						v = v / _targetHeight * _target._rawHeight;
					_owner.y = targetY + _target._rawHeight + v;
					break;
				case RelationType.Middle_Middle:
					v = _owner.y + _owner._rawHeight / 2 - (targetY + _targetHeight / 2);
					if (info.percent)
						v = v / _targetHeight * _target._rawHeight;
					_owner.y = targetY + _target._rawHeight / 2 + v - _owner._rawHeight / 2;
					break;
				case RelationType.Bottom_Top:
					v = _owner.y + _owner._rawHeight - targetY;
					if (info.percent)
						v = v / _targetHeight * _target._rawHeight;
					_owner.y = targetY + v - _owner._rawHeight;
					break;
				case RelationType.Bottom_Middle:
					v = _owner.y + _owner._rawHeight - (targetY + _targetHeight / 2);
					if (info.percent)
						v = v / _targetHeight * _target._rawHeight;
					_owner.y = targetY + _target._rawHeight / 2 + v - _owner._rawHeight;
					break;
				case RelationType.Bottom_Bottom:
					v = _owner.y + _owner._rawHeight - (targetY + _targetHeight);
					if (info.percent)
						v = v / _targetHeight * _target._rawHeight;
					_owner.y = targetY + _target._rawHeight + v - _owner._rawHeight;
					break;
				
				case RelationType.Width:
					if(_owner._underConstruct && _owner==_target.parent)
						v = _owner.sourceWidth - _target._initWidth;
					else
						v = _owner._rawWidth - _targetWidth;
					if (info.percent)
						v = v / _targetWidth * _target._rawWidth;
					if(_target==_owner.parent)
						_owner.setSize(_target._rawWidth + v, _owner._rawHeight, true);
					else
						_owner.width = _target._rawWidth + v;
					break;
				case RelationType.Height:
					if(_owner._underConstruct && _owner==_target.parent)
						v = _owner.sourceHeight - _target._initHeight;
					else
						v = _owner._rawHeight - _targetHeight;
					if (info.percent)
						v = v / _targetHeight * _target._rawHeight;
					if(_target==_owner.parent)
						_owner.setSize(_owner._rawWidth, _target._rawHeight + v, true);
					else
						_owner.height = _target._rawHeight + v;
					break;
				
				case RelationType.LeftExt_Left:
					break;
				case RelationType.LeftExt_Right:
					v = _owner.x - (targetX + _targetWidth);
					if (info.percent)
						v = v / _targetWidth * _target._rawWidth;
					tmp = _owner.x;
					_owner.x = targetX + _target._rawWidth + v;
					_owner.width = _owner._rawWidth-(_owner.x - tmp);
					break;
				case RelationType.RightExt_Left:
					break;
				case RelationType.RightExt_Right:
					if(_owner._underConstruct && _owner==_target.parent)
						v = _owner.sourceWidth - (targetX + _target._initWidth);
					else
						v = _owner._rawWidth - (targetX + _targetWidth);
					if (_owner != _target.parent)
						v += _owner.x;
					if (info.percent)
						v = v / _targetWidth * _target._rawWidth;
					if (_owner != _target.parent)
						_owner.width = targetX + _target._rawWidth + v - _owner.x;
					else
						_owner.width = targetX + _target._rawWidth + v;
					break;
				case RelationType.TopExt_Top:
					break;
				case RelationType.TopExt_Bottom:
					v = _owner.y - (targetY + _targetHeight);
					if (info.percent)
						v = v / _targetHeight * _target._rawHeight;
					tmp = _owner.y;
					_owner.y = targetY + _target._rawHeight + v;
					_owner.height = _owner._rawHeight - (_owner.y - tmp);
					break;
				case RelationType.BottomExt_Top:
					break;
				case RelationType.BottomExt_Bottom:
					if(_owner._underConstruct && _owner==_target.parent)
						v = _owner.sourceHeight - (targetY + _target._initHeight);
					else
						v = _owner._rawHeight - (targetY + _targetHeight);
					if (_owner != _target.parent)
						v += _owner.y;
					if (info.percent)
						v = v / _targetHeight * _target._rawHeight;
					if (_owner != _target.parent)
						_owner.height = targetY + _target._rawHeight + v - _owner.y;
					else
						_owner.height = targetY + _target._rawHeight + v;
					break;
			}
		}
		
		private function addRefTarget(target:GObject):void
		{
			if(target!=_owner.parent)
				target.addXYChangeCallback(__targetXYChanged);
			target.addSizeChangeCallback(__targetSizeChanged);
			target.addSizeDelayChangeCallback(__targetSizeWillChange);
			_targetX = _target.x;
			_targetY = _target.y;
			_targetWidth = _target._rawWidth;
			_targetHeight = _target._rawHeight;
		}
		
		private function releaseRefTarget(target:GObject):void
		{
			target.removeXYChangeCallback(__targetXYChanged);
			target.removeSizeChangeCallback(__targetSizeChanged);
			target.removeSizeDelayChangeCallback(__targetSizeWillChange);
		}
		
		private function __targetXYChanged(target:GObject):void
		{
			if (_owner.relations.handling!=null || _owner.group!=null && _owner.group._updating)
			{
				_targetX = _target.x;
				_targetY = _target.y;
				return;
			}
			
			_owner.relations.handling = target;
			
			var ox:Number = _owner.x;
			var oy:Number = _owner.y;
			var dx:Number = _target.x-_targetX;
			var dy:Number = _target.y-_targetY;
			for each(var info:RelationDef in _defs)
			{
				applyOnXYChanged(info, dx, dy);
			}
			_targetX = _target.x;
			_targetY = _target.y;
			
			if (ox!=_owner.x || oy!=_owner.y)
			{
				ox = _owner.x - ox;
				oy = _owner.y - oy;
				
				_owner.updateGearFromRelations(1, ox, oy);
				
				if (_owner.parent != null && _owner.parent._transitions.length > 0)
				{
					for each (var trans:Transition in _owner.parent._transitions)
					{
						trans.updateFromRelations(_owner.id, ox, oy);
					}
				}
			}

			_owner.relations.handling = null;
		}
		
		private function __targetSizeChanged(target:GObject):void
		{
			if (_owner.relations.handling!=null)
			{
				_targetWidth = _target._rawWidth;
				_targetHeight = _target._rawHeight;
				return;
			}
			
			_owner.relations.handling = target;
			
			var ox:Number = _owner.x;
			var oy:Number = _owner.y;
			var ow:Number = _owner._rawWidth;
			var oh:Number = _owner._rawHeight;
			for each(var info:RelationDef in _defs)
			{
				applyOnSizeChanged(info);
			}
			_targetWidth = _target._rawWidth;
			_targetHeight = _target._rawHeight;
			
			if (ox!=_owner.x || oy!=_owner.y)
			{
				ox = _owner.x - ox;
				oy = _owner.y - oy;
				
				_owner.updateGearFromRelations(1, ox, oy);
				
				if (_owner.parent != null && _owner.parent._transitions.length > 0)
				{
					for each (var trans:Transition in _owner.parent._transitions)
					{
						trans.updateFromRelations(_owner.id, ox, oy);
					}
				}
			}
			
			if (ow!=_owner._rawWidth || oh!=_owner._rawHeight)
			{
				ow = _owner._rawWidth - ow;
				oh = _owner._rawHeight - oh;
				
				_owner.updateGearFromRelations(2, ow, oh);
			}

			_owner.relations.handling = null;
		}
		
		private function __targetSizeWillChange(target:GObject):void
		{
			_owner.relations.sizeDirty = true;
		}
	}
}

class RelationDef
{
	public var percent:Boolean;
	public var type:int;
	
	public function RelationDef()
	{
	}
	
	public function copyFrom(source:RelationDef):void
	{
		this.percent = source.percent;
		this.type = source.type;
	}
}
