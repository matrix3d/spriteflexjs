package flash.text
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;
	
	public class TextField extends InteractiveObject
	{
		private var input:HTMLInputElement;
		private var _type:String = TextFieldType.DYNAMIC;
		private var graphics:Graphics = new Graphics;
		private var graphicsDirty:Boolean = true;
		private static var richTextFields:Array = ["font", "size", "color", "bold", "italic", "underline", "url", "target", "align", "leftMargin", "rightMargin", "indent", "leading", "blockIndent", "kerning", "letterSpacing", "display"];
		private var _text:String="";
		private var lines:Array = [];
		private var _textFormat:TextFormat=new TextFormat;
		private var _width:Number = 100;
		private var _height:Number = 100;
		private var _autoSize:String;
		private var _background:Boolean = false;
		private var _backgroundColor:uint = 0xFFFFFF;
		private var _border:Boolean = false;
		private var _borderColor:uint = 0;
		private var boundHelpRect:Rectangle = new Rectangle;
		private var _fullBounds:Rectangle;
		
		private var _cacheCanvas:HTMLCanvasElement;
		private var _cacheCTX:CanvasRenderingContext2D;
		private var _cacheImage:BitmapData = new BitmapData(1, 1);
		private var _cacheMatrix:Matrix;
		private var _cacheOffsetX:Number = 0;
		private var _cacheOffsetY:Number = 0;
		private var _filterOffsetX:Number = 0;
		private var _filterOffsetY:Number = 0;
		
		
		public function TextField()
		{
			textColor = 0;
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}
		
		private function removedFromStage(e:Event):void 
		{
			if (input && input.parentElement){
				input.parentElement.removeChild(input);
			}
		}
		
		public static function isFontCompatible(param1:String, param2:String):Boolean  { return false; }
		
		public function get alwaysShowSelection():Boolean  { return false; }
		
		public function set alwaysShowSelection(param1:Boolean):void  {/**/ }
		
		public function get antiAliasType():String  { return null; }
		
		public function set antiAliasType(param1:String):void  {/**/ }
		
		public function get autoSize():String  { return _autoSize; }
		
		public function set autoSize(param1:String):void  {
			_autoSize = param1; 
			graphicsDirty = true;
			SpriteFlexjs.dirtyGraphics = true;
		}
		
		public function get background():Boolean  { return _background; }
		
		public function set background(param1:Boolean):void  {
			_background = param1;
			graphicsDirty = true;
			SpriteFlexjs.dirtyGraphics = true;
		}
		
		public function get backgroundColor():uint  { return _backgroundColor; }
		
		public function set backgroundColor(param1:uint):void  {
			_backgroundColor=param1 
			graphicsDirty = true;
			SpriteFlexjs.dirtyGraphics = true;
		}
		
		public function get border():Boolean  { return _border; }
		
		public function set border(param1:Boolean):void  {
			_border = param1;
			graphicsDirty = true;
			SpriteFlexjs.dirtyGraphics = true;
		}
		
		public function get borderColor():uint  { return _borderColor; }
		
		public function set borderColor(param1:uint):void  {
			_borderColor = param1 ;
			graphicsDirty = true;
			SpriteFlexjs.dirtyGraphics = true;
		}
		
		public function get bottomScrollV():int  { return 0; }
		
		public function get caretIndex():int  { return 0; }
		
		public function get condenseWhite():Boolean  { return false; }
		
		public function set condenseWhite(param1:Boolean):void  {/**/ }
		
		public function get defaultTextFormat():TextFormat  { return _textFormat; }
		
		public function set defaultTextFormat(param1:TextFormat):void  {
			_textFormat = param1; 
			graphicsDirty = true;
			SpriteFlexjs.dirtyGraphics = true;
		}
		
		public function get embedFonts():Boolean  { return false; }
		
		public function set embedFonts(param1:Boolean):void  {/**/ }
		
		public function get gridFitType():String  { return null; }
		
		public function set gridFitType(param1:String):void  {/**/ }
		
		public function get htmlText():String  { return null; }
		
		public function set htmlText(param1:String):void  {/**/ }
		
		public function get length():int  { return 0; }
		
		public function get textInteractionMode():String  { return null; }
		
		public function get maxChars():int  { return 0; }
		
		public function set maxChars(param1:int):void  {/**/ }
		
		public function get maxScrollH():int  { return 0; }
		
		public function get maxScrollV():int  { return 0; }
		
		public function get mouseWheelEnabled():Boolean  { return false; }
		
		public function set mouseWheelEnabled(param1:Boolean):void  {/**/ }
		
		public function get multiline():Boolean  { return false; }
		
		public function set multiline(param1:Boolean):void  {/**/ }
		
		public function get numLines():int  { return 0; }
		
		public function get displayAsPassword():Boolean  { return false; }
		
		public function set displayAsPassword(param1:Boolean):void  {/**/ }
		
		public function get restrict():String  { return null; }
		
		public function set restrict(param1:String):void  {/**/ }
		
		public function get scrollH():int  { return 0; }
		
		public function set scrollH(param1:int):void  {/**/ }
		
		public function get scrollV():int  { return 0; }
		
		public function set scrollV(param1:int):void  {/**/ }
		
		public function get selectable():Boolean  { return false; }
		
		public function set selectable(param1:Boolean):void  {/**/ }
		
		public function get selectedText():String
		{
			return this.text.substring(this.selectionBeginIndex, this.selectionEndIndex);
		}
		
		public function get selectionBeginIndex():int  { return 0; }
		
		public function get selectionEndIndex():int  { return 0; }
		
		public function get sharpness():Number  { return 0; }
		
		public function set sharpness(param1:Number):void  {/**/ }
		
		public function get styleSheet():StyleSheet  { return null; }
		
		public function set styleSheet(param1:StyleSheet):void  {/**/ }
		
		public function get text():String  { return _text; }
		
		public function set text(txt:String):void  {
			_text = txt; 
			lines = txt.split("\n");
			SpriteFlexjs.dirtyGraphics = true;
			graphicsDirty = true;
		}
		
		public function get textColor():uint  { return int(_textFormat.color); }
		
		public function set textColor(color:uint):void
		{
			_textFormat.color = color;
			graphicsDirty = true;
			SpriteFlexjs.dirtyGraphics = true;
		}
		
		public function get textHeight():Number  { 
			return lines?int(defaultTextFormat.size) * lines.length : 0; 
		}
		
		public function get textWidth():Number  { 
			if (stage && lines)
			{
				var ctx:CanvasRenderingContext2D = stage.ctx2d;
				ctx.font = defaultTextFormat.css;
				var w:int = 0;
				for (var i:int = 0; i < lines.length;i++ ){
					var w2:int = ctx.measureText(lines[i]).width;
					if (w2>w){
						w = w2;
					}
				}
				return w;
			}
			return 0; 
		}
		
		public function get thickness():Number  { return 0; }
		
		public function set thickness(param1:Number):void  {/**/ }
		
		public function get type():String  { return _type; }
		
		public function set type(param1:String):void  {
			_type = param1;
			if (_type==TextFieldType.INPUT){
				if (input==null){
					input = document.createElement("input") as HTMLInputElement;
					input.oninput = input_change;
					input.style.position = "absolute";
					input.style.backgroundColor = "transparent";
					input.style.borderWidth = 0;
					input.style.outline = "none";
				}
			}
		}
		
		private function input_change(e:Event):void 
		{
			text = input.value;
		}
		
		public function get wordWrap():Boolean  { return false; }
		
		public function set wordWrap(param1:Boolean):void  {/**/ }
		
		public function appendText(newText:String):void
		{
			this.replaceText(this.text.length, this.text.length, newText);
		}
		
		override public function get width():Number 
		{
			return autoSize==TextFieldAutoSize.LEFT?(textWidth+4):_width;
		}
		
		override public function set width(value:Number):void 
		{
			_width = value;
		}
		
		override public function get height():Number 
		{
			return autoSize==TextFieldAutoSize.LEFT?(textHeight+2):_height;
		}
		
		override public function set height(value:Number):void 
		{
			_height = value;
		}
		
		/*private function copyRichText() : String
		   {
		   return this.getXMLText(this.selectionBeginIndex,this.selectionEndIndex);
		   }*/
		   
		override public function getBounds(v:DisplayObject):Rectangle
		{ 
			var bounds:Rectangle = new Rectangle(0, 0, textWidth, textHeight);
			if (border || background) bounds.inflate(4, 4);
			return bounds;
		}
		
		override public function getFullBounds(v:DisplayObject):Rectangle 
		{
			var bounds:Rectangle = new Rectangle(0, 0, width, height);
			if (border || background) bounds.inflate(3.5, 3);
			
			// adjust bounds for rotation
			var radians:Number = rotation * (Math.PI / 180);
			var w:Number = Math.round((bounds.height * Math.sin(radians) + bounds.width * Math.cos(radians)) * 10) / 10;
			var h:Number = Math.round((bounds.height * Math.cos(radians) + bounds.width * Math.sin(radians)) * 10) / 10;
			
			// adjust rectangle bigger if needed
			w = (w > bounds.width) ? w - bounds.width : 0;
			h = (h > bounds.height) ? h - bounds.width : 0;
			bounds.inflate(w / 2, h / 2);
			
			_fullBounds = bounds.clone();
			
			return bounds;
		}
		
		public function getCharBoundaries(param1:int):Rectangle  { return null; }
		
		public function getCharIndexAtPoint(param1:Number, param2:Number):int  { return 0; }
		
		private function getCharIndexNearestPoint(param1:Number, param2:Number):int  { return 0; }
		
		public function getFirstCharInParagraph(param1:int):int  { return 0; }
		
		public function getLineIndexAtPoint(param1:Number, param2:Number):int  { return 0; }
		
		public function getLineIndexOfChar(param1:int):int  { return 0; }
		
		public function getLineLength(param1:int):int  { return 0; }
		
		public function getLineMetrics(param1:int):TextLineMetrics  { return null; }
		
		public function getLineOffset(param1:int):int  { return 0; }
		
		public function getLineText(param1:int):String  { return null; }
		
		public function getParagraphLength(param1:int):int  { return 0; }
		
		public function getTextFormat(param1:int = -1, param2:int = -1):TextFormat  { return _textFormat; }
		
		public function getTextRuns(param1:int = 0, param2:int = 2147483647):Array  { return null; }
		
		public function getRawText():String  { return null; }
		
		/*public function getXMLText(beginIndex:int = 0, endIndex:int = 2147483647) : String
		   {
		   var run:TextRun = null;
		   var format:TextFormat = null;
		   var text:String = null;
		   var runXML:XML = null;
		   var j:uint = 0;
		   var name:String = null;
		   var value:* = undefined;
		   var runs:Array = this.getTextRuns(beginIndex,endIndex);
		   var entireText:String = this.getRawText();
		   var result:XML = <flashrichtext version="1"/>;
		   for(var i:uint = 0; i < runs.length; i++)
		   {
		   run = runs[i];
		   format = run.textFormat;
		   text = entireText.substring(run.beginIndex,run.endIndex);
		   text = "(" + text + ")";
		   runXML = <textformat>{text}</textformat>;
		   for(j = 0; j < richTextFields.length; j++)
		   {
		   name = richTextFields[j];
		   value = format[name];
		   if(value != null)
		   {
		   runXML["@" + name] = value;
		   }
		   }
		   result.flashrichtext = result.flashrichtext + runXML;
		   }
		   return result.toXMLString();
		   }
		
		   public function insertXMLText(beginIndex:int, endIndex:int, richText:String, pasting:Boolean = false) : void
		   {
		   var run:XML = null;
		   var temp:* = 0;
		   var attributes:XMLList = null;
		   var format:TextFormat = null;
		   var attribute:XML = null;
		   var text:String = null;
		   var name:String = null;
		   var value:String = null;
		   var spaceAvail:* = 0;
		   var richTextXML:XML = XML(richText);
		   if(richTextXML.@version != "1")
		   {
		   Error.throwError(Error,2138);
		   }
		   if(beginIndex > endIndex)
		   {
		   temp = beginIndex;
		   beginIndex = endIndex;
		   endIndex = temp;
		   }
		   var first:Boolean = true;
		   for each(run in richTextXML..textformat)
		   {
		   attributes = run.attributes();
		   format = new TextFormat();
		   for each(attribute in attributes)
		   {
		   name = attribute.name().localName;
		   value = String(attribute);
		   if(name == "bold" || name == "italic" || name == "underline")
		   {
		   format[name] = value == "true";
		   }
		   else
		   {
		   format[name] = value;
		   }
		   }
		   text = String(run.children());
		   text = text.substring(1,text.length - 1);
		   if(this.maxChars > 0 && pasting == true)
		   {
		   spaceAvail = this.maxChars - this.length + (endIndex - beginIndex);
		   if(spaceAvail < text.length)
		   {
		   if(spaceAvail <= 0)
		   {
		   return;
		   }
		   text = text.substring(0,spaceAvail);
		   }
		   }
		   this.replaceText(beginIndex,endIndex,text);
		   this.setTextFormat(format,beginIndex,beginIndex + text.length);
		   beginIndex = beginIndex + text.length;
		   endIndex = beginIndex;
		   if(pasting)
		   {
		   this.setSelection(beginIndex,endIndex);
		   }
		   first = false;
		   }
		   if(first)
		   {
		   this.replaceText(beginIndex,endIndex,"");
		   }
		   }
		
		   private function pasteRichText(richText:String) : Boolean
		   {
		   if(richText == null)
		   {
		   Error.throwError(TypeError,2007,"richText");
		   }
		   try
		   {
		   this.insertXMLText(this.selectionBeginIndex,this.selectionEndIndex,richText,true);
		   }
		   catch(e:Error)
		   {
		   return false;
		   }
		   return true;
		   }*/
		
		public function replaceSelectedText(param1:String):void  {/**/ }
		
		public function replaceText(beginIndex:int, endIndex:int, newText:String):void  {
			text = _text.substr(0, beginIndex) + newText + _text.substr(endIndex);
		}
		
		public function setSelection(param1:int, param2:int):void  {/**/ }
		
		public function setTextFormat(param1:TextFormat, param2:int = -1, param3:int = -1):void  { _textFormat = param1; }
		
		public function getImageReference(param1:String):DisplayObject  { return null; }
		
		public function get useRichTextClipboard():Boolean  { return false; }
		
		public function set useRichTextClipboard(param1:Boolean):void  {/**/ }
		
		override public function set cacheAsBitmap(value:Boolean):void 
		{
			if (value && _type != TextFieldType.INPUT)
			{
				var bounds:Rectangle = getFullBounds(this);
				
				bounds.inflate(_filterOffsetX, _filterOffsetY); // add space for filter effects
				
				_cacheCanvas = document.createElement("canvas") as HTMLCanvasElement;
				_cacheCanvas.width = bounds.width;
				_cacheCanvas.height = bounds.height;
				_cacheCTX = _cacheCanvas.getContext('2d') as CanvasRenderingContext2D;
				//_cacheCTX.fillStyle = "blue";
				//_cacheCTX.fillRect(0, 0, _cacheCanvas.width, _cacheCanvas.height);
				_cacheOffsetX = bounds.width - bounds.right - x;
				_cacheOffsetY = bounds.height - bounds.bottom - y;
				
				if (parent) 
				{
					_cacheOffsetX -= parent.x;
					_cacheOffsetY -= parent.y;
				}
				
				var mat:Matrix = transform.concatenatedMatrix.clone();
				mat.translate(_cacheOffsetX, _cacheOffsetY);
				
				__draw(_cacheCTX, mat);
				
				_cacheImage.image = _cacheCanvas;
				updateTransforms();
				
				// cache after drawing all graphics
				super.cacheAsBitmap = value;
			}
			else
			{
				_cacheCanvas = null;
				_cacheCTX = null;
			}
		}
		
		public function get cacheImage():BitmapData 
		{
			return _cacheImage;
		}
		
		public function get cacheOffsetX():Number 
		{
			return _cacheOffsetX;
		}
		
		public function get cacheOffsetY():Number 
		{
			return _cacheOffsetY;
		}
		
		override public function __update(ctx:CanvasRenderingContext2D):void
		{
			super.__update(ctx);
			if (_text != null && visible)
			{
				if (filters.length && !cacheAsBitmap && !parent.cacheAsBitmap) cacheAsBitmap = true;
				
				if (cacheAsBitmap && !parent.cacheAsBitmap && _type != TextFieldType.INPUT)
				{
					SpriteFlexjs.renderer.renderImage(ctx, _cacheImage, transform.concatenatedMatrix, blendMode, transform.concatenatedColorTransform, -this.x - _cacheOffsetX, -this.y - _cacheOffsetY);
				}
				else
				{
					__draw(ctx, transform.concatenatedMatrix);
				}
				SpriteFlexjs.drawCounter++;
			}
		}
		
		public function __draw(ctx:CanvasRenderingContext2D, m:Matrix):void
		{
			if ((_border || _background) && !cacheAsBitmap)
			{
				if (graphicsDirty)
				{
					graphicsDirty = false;
					graphics.clear();
					if (border) graphics.lineStyle(0, borderColor);
					if (background) graphics.beginFill(backgroundColor);
					graphics.drawRect( -2, 0, width + 4, height + 2);
				}
				SpriteFlexjs.renderer.renderGraphics(ctx, graphics, m, blendMode, transform.concatenatedColorTransform);
				ApplyFilters(ctx);
			}
			
			if (type == TextFieldType.DYNAMIC)
			{
				if (!_background) ApplyFilters(ctx, true, true);  // shadows need to be applied before rendering text.
				for (var i:int = 0; i < lines.length; i++ ){
					//if(m.ty>0) alert(m.toString()+","+transform.matrix.toString()+" "+y);
					SpriteFlexjs.renderer.renderText(ctx, lines[i], defaultTextFormat, m, blendMode, transform.concatenatedColorTransform, 0, i * int(defaultTextFormat.size));
				}
				if (!_background) ApplyFilters(ctx, true, false, true);
			}
			else
			{
				input.style.left = m.tx+"px";
				input.style.top = m.ty + "px";
				input.style.width = width + "px";
				input.style.height = height + "px";
				input.style.fontFamily = defaultTextFormat.font;
				input.style.fontSize = defaultTextFormat.size+"px";
				input.style.color = defaultTextFormat.csscolor;
				if(input.value!=text)
				input.value = text;
				//input.style.transform = "matrix("+m.a+","+m.b+","+m.c+","+m.d+","+m.tx+","+m.ty+")";
				if(input.parentElement==null){
					stage.__htmlWrapper.appendChild(input);
				}
			}
		}
		
		override protected function __doMouse(e:flash.events.MouseEvent):DisplayObject 
		{
			if (mouseEnabled && visible) {
				if (hitTestPoint(stage.mouseX, stage.mouseY)) {
					return this;
				}
			}
			return null;
		}
		
		override public function __getRect():Rectangle 
		{
			if (text && text != "") {
				boundHelpRect.width = width;
				boundHelpRect.height = height;
				return boundHelpRect;
			}
			return null;
		}
	}
}
