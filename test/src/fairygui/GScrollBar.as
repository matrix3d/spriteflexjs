package fairygui
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import fairygui.event.GTouchEvent;

	public class GScrollBar extends GComponent
	{
		private var _grip:GObject;
		private var _arrowButton1:GObject;
		private var _arrowButton2:GObject;
		private var _bar:GObject;
		private var _target:ScrollPane;
		
		private var _vertical:Boolean;
		private var _scrollPerc:Number;
		private var _fixedGripSize:Boolean;
		
		private var _dragOffset:Point;
		
		public function GScrollBar()
		{
			_dragOffset = new Point();
			_scrollPerc = 0;
		}

		public function setScrollPane(target:ScrollPane, vertical:Boolean):void
		{
			_target = target;
			_vertical = vertical;
		}

		public function set displayPerc(val:Number):void
		{
			if(_vertical)
			{
				if(!_fixedGripSize)
					_grip.height = Math.floor(val*_bar.height);
				_grip.y = _bar.y+(_bar.height-_grip.height)*_scrollPerc;
			}
			else
			{
				if(!_fixedGripSize)
					_grip.width = Math.floor(val*_bar.width);
				_grip.x = _bar.x+(_bar.width-_grip.width)*_scrollPerc;
			}
		}
		
		public function set scrollPerc(val:Number):void
		{
			_scrollPerc = val;
			if(_vertical)
				_grip.y = _bar.y+(_bar.height-_grip.height)*_scrollPerc;
			else
				_grip.x = _bar.x+(_bar.width-_grip.width)*_scrollPerc;
		}
		
		public function get minSize():int
		{
			if(_vertical)
				return (_arrowButton1!=null?_arrowButton1.height:0)+(_arrowButton2!=null?_arrowButton2.height:0);
			else
				return (_arrowButton1!=null?_arrowButton1.width:0)+(_arrowButton2!=null?_arrowButton2.width:0);
		}
		
		override protected function constructFromXML(xml:XML):void
		{
			super.constructFromXML(xml);
			
			xml = xml.ScrollBar[0];
			if(xml!=null)
				_fixedGripSize = xml.@fixedGripSize=="true";							
			
			_grip = getChild("grip");
			if(!_grip)
			{
				trace("需要定义grip");
				return;
			}
			
			_bar = getChild("bar");
			if(!_bar)
			{
				trace("需要定义bar");
				return;
			}
			
			_arrowButton1 = getChild("arrow1");
			_arrowButton2 = getChild("arrow2");
			
			_grip.addEventListener(GTouchEvent.BEGIN, __gripMouseDown);
			_grip.addEventListener(GTouchEvent.DRAG, __gripDragging);

			if(_arrowButton1)
				_arrowButton1.addEventListener(GTouchEvent.BEGIN, __arrowButton1Click);
			if(_arrowButton2)
				_arrowButton2.addEventListener(GTouchEvent.BEGIN, __arrowButton2Click);
			
			addEventListener(GTouchEvent.BEGIN, __barMouseDown);
		}

		private function __gripMouseDown(evt:GTouchEvent):void
		{
			if(!_bar)
				return;
			
			evt.stopPropagation();
			
			_dragOffset = this.globalToLocal(evt.stageX, evt.stageY);
			_dragOffset.x -= _grip.x;
			_dragOffset.y -= _grip.y;
		}
		
		private function __gripDragging(evt:GTouchEvent):void
		{
			var pt:Point = this.globalToLocal(evt.stageX, evt.stageY);
			if(_vertical)
			{
				var curY:Number = pt.y-_dragOffset.y;
				var diff:Number = _bar.height-_grip.height;
				if(diff==0)
					_target.setPercY(0, false);
				else
					_target.setPercY( (curY-_bar.y)/diff, false);
			}
			else
			{
				var curX:Number = pt.x-_dragOffset.x;
				diff = _bar.width-_grip.width;
				if(diff==0)
					_target.setPercX(0, false);
				else
					_target.setPercX( (curX-_bar.x)/diff, false);
			}
		}
		
		private function __arrowButton1Click(evt:Event):void
		{
			evt.stopPropagation();
			
			if(_vertical)
				_target.scrollUp();
			else
				_target.scrollLeft();
		}
		
		private function __arrowButton2Click(evt:Event):void
		{
			evt.stopPropagation();
			
			if(_vertical)
				_target.scrollDown();
			else
				_target.scrollRight();
		}
		
		private function __barMouseDown(evt:GTouchEvent):void
		{
			var pt:Point = _grip.globalToLocal(evt.stageX, evt.stageY);
			if(_vertical)
			{
				if(pt.y<0)
					_target.scrollUp(4);
				else
					_target.scrollDown(4);
			}
			else
			{
				if(pt.x<0)
					_target.scrollLeft(4);
				else
					_target.scrollRight(4);
			}
		}
	}
}