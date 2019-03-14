package fairygui
{
	import fairygui.utils.ToolSet;
	
	public class GLabel extends GComponent implements IColorGear
	{
		protected var _titleObject:GObject;
		protected var _iconObject:GObject;
		
		public function GLabel()
		{
			super();
		}
		
		override public function get icon():String
		{
			if(_iconObject!=null)
				return _iconObject.icon;
			else
				return null;
		}
		
		override public function set icon(value:String):void
		{
			if(_iconObject!=null)
				_iconObject.icon = value;
			updateGear(7);
		}
		
		final public function get title():String
		{
			if(_titleObject)
				return _titleObject.text;
			else
				return null;
		}
		
		public function set title(value:String):void
		{
			if(_titleObject)
				_titleObject.text = value;
			updateGear(6);
		}
		
		override final public function get text():String
		{
			return this.title;
		}
		
		override public function set text(value:String):void
		{
			this.title = value;
		}
		
		final public function get titleColor():uint
		{
			var tf:GTextField = getTextField();
			if(tf)
				return tf.color;
			else
				return 0;
		}
		
		public function set titleColor(value:uint):void
		{
			var tf:GTextField = getTextField();
			if(tf)
				tf.color = value;
			updateGear(4);
		}
		
		final public function get titleFontSize():int
		{
			var tf:GTextField = getTextField();
			if(tf)
				return tf.fontSize;
			else
				return 0;
		}
		
		public function set titleFontSize(value:int):void
		{
			var tf:GTextField = getTextField();
			if(tf)
				tf.fontSize = value;
		}
		
		public function get color():uint
		{
			return this.titleColor;
		}
		
		public function set color(value:uint):void 
		{
			this.titleColor = value;
		}
		
		public function set editable(val:Boolean):void
		{
			var tf:GTextField = getTextField();
			if(tf && (tf is GTextInput))
				tf.asTextInput.editable = val;
		}
		
		public function get editable():Boolean
		{
			var tf:GTextField = getTextField();
			if(tf && (tf is GTextInput))
				return tf.asTextInput.editable;
			else
				return false;
		}
		
		public function getTextField():GTextField
		{
			if(_titleObject is GTextField)
				return GTextField(_titleObject);
			else if(_titleObject is GLabel)
				return GLabel(_titleObject).getTextField();
			else if(_titleObject is GButton)
				return GButton(_titleObject).getTextField();
			else
				return null;
		}
		
		override protected function constructFromXML(xml:XML):void
		{
			super.constructFromXML(xml);
			
			_titleObject = getChild("title");
			_iconObject = getChild("icon");
		}
		
		override public function setup_afterAdd(xml:XML):void
		{
			super.setup_afterAdd(xml);
			
			xml = xml.Label[0];
			if(xml)
			{
				var str:String;
				str = xml.@title;
				if(str)
					this.text = str;
				str = xml.@icon;
				if(str)
					this.icon = str;
				str = xml.@titleColor;
				if(str)
					this.titleColor = ToolSet.convertFromHtmlColor(str);
				str = xml.@titleFontSize;
				if(str)
					this.titleFontSize = parseInt(str);
				
				var tf:GTextField = getTextField();
				if(tf is GTextInput)
				{
					str = xml.@prompt;
					if(str)
						GTextInput(tf).promptText = str;
					str = xml.@maxLength;
					if(str)
						GTextInput(tf).maxLength = parseInt(str);
					str = xml.@restrict;
					if(str)
						GTextInput(tf).restrict = str;
					str = xml.@password;
					if(str)
						GTextInput(tf).password = str=="true";
				}
			}
		}
	}
}

