package fairygui
{
	public class GGroup extends GObject
	{
		internal var _updating:Boolean;
		private var _empty:Boolean;

		public function GGroup()
		{
		}
		
		public function updateBounds():void
		{
			if(_updating || !parent)
				return;
			
			var cnt:int = _parent.numChildren;
			var i:int;
			var child:GObject;
			var ax:int=int.MAX_VALUE, ay:int=int.MAX_VALUE;
			var ar:int = int.MIN_VALUE, ab:int = int.MIN_VALUE;
			var tmp:int;
			_empty = true;
			for(i=0;i<cnt;i++)
			{
				child = _parent.getChildAt(i);
				if(child.group==this)
				{
					tmp = child.x;
					if(tmp<ax)
						ax = tmp;
					tmp = child.y;
					if(tmp<ay)
						ay = tmp;
					tmp = child.x + child.width;
					if(tmp>ar)
						ar = tmp;
					tmp = child.y + child.height;
					if(tmp>ab)
						ab = tmp;
					_empty = false;
				}
			}
			
			_updating = true;
			if(!_empty)
			{
				setXY(ax, ay);
				setSize(ar-ax, ab-ay);
			}
			else
				setSize(0,0);
			_updating = false;
		}
		
		internal function moveChildren(dx:Number, dy:Number):void
		{
			if(_updating || !parent)
				return;
			
			_updating = true;
			var cnt:int = _parent.numChildren;
			var i:int;
			var child:GObject;
			for(i=0;i<cnt;i++)
			{
				child = _parent.getChildAt(i);
				if(child.group==this)
				{
					child.setXY(child.x+dx, child.y+dy);
				}
			}
			_updating = false;
		}
		
		override protected function updateAlpha():void
		{
			super.updateAlpha();
			
			if(this._underConstruct)
				return;
			
			var cnt:int = _parent.numChildren;
			for(var i:int =0;i<cnt;i++)
			{
				var child:GObject = _parent.getChildAt(i);
				if(child.group==this)
					child.alpha = this.alpha;
			}
		}
	}
}