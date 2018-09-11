package fairygui.text
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	
	import fairygui.PackageItem;
	import fairygui.UIPackage;
	import fairygui.utils.CharSize;
	import fairygui.utils.FontUtils;
	import fairygui.utils.ToolSet;
	
	public class RichTextField extends Sprite 
	{
		private var _textField:TextField;
		private var _ALinkFormat:TextFormat;
		private var _AHoverFormat:TextFormat;
		private var _defaultTextFormat:TextFormat;
		private var _lineInfo:Array;
		private var _linkButtonCache:Vector.<LinkButton>;
		private var _nodeCache:Vector.<HtmlNode>;
		private var _needUpdateNodePos:Boolean;
		
		public static var objectFactory:IRichTextObjectFactory = new RichTextObjectFactory();

		public function RichTextField():void 
		{
			this.mouseEnabled = false;
			
			_linkButtonCache = new Vector.<LinkButton>();
			_nodeCache = new Vector.<HtmlNode>();
			_ALinkFormat = new TextFormat();
			_ALinkFormat.underline = true;
			_AHoverFormat = new TextFormat();
			_AHoverFormat.underline = true;
			
			_lineInfo = [];
			
			_textField = new TextField();
			_textField.wordWrap = true;
			_textField.selectable = false;
			addChild(_textField);
		}
		
		override public function set width(value:Number):void
		{
			_textField.width = value;
		}
		
		override public function set height(value:Number):void
		{
			if(_textField.height!=value) 
			{
				_textField.height = value;
				adjustNodes();
			}
		}
		
		override public function get width():Number 
		{
			return _textField.width;
		}
		
		override public function get height():Number 
		{
			return _textField.height;
		}
		
		public function get nativeTextField():TextField
		{
			return _textField;
		}
		
		public function get text():String
		{
			return _textField.text;
		}
		
		public function set text(val:String):void 
		{
			clear();
			if(val.length)
				appendText(val);
			else
				fixTextSize();
		}
		
		public function set defaultTextFormat(val:TextFormat):void 
		{
			_defaultTextFormat = val;
			if(_defaultTextFormat) 
			{
				if(_defaultTextFormat.underline==null)
					_defaultTextFormat.underline = false;
				if(_defaultTextFormat.letterSpacing==null)
					_defaultTextFormat.letterSpacing = 0;
				if(_defaultTextFormat.kerning==null)
					_defaultTextFormat.kerning = false;
			}
			
			_textField.embedFonts = FontUtils.isEmbeddedFont(_defaultTextFormat);
			_textField.defaultTextFormat = _defaultTextFormat;
		}
		
		public function get defaultTextFormat():TextFormat
		{
			return _textField.defaultTextFormat;
		}
		
		public function get ALinkFormat():TextFormat
		{
			return _ALinkFormat;
		}
		
		public function set ALinkFormat(val:TextFormat):void 
		{
			_ALinkFormat = val;
		}
		
		public function get AHoverFormat():TextFormat
		{
			return _AHoverFormat;
		}
		
		public function set AHoverFormat(val:TextFormat):void
		{
			_AHoverFormat = val;
		}
		
		public function set selectable(val:Boolean):void
		{
			_textField.selectable = val;
			_textField.mouseEnabled = val;
		}
		
		public function get selectable():Boolean 
		{
			return _textField.selectable;
		}
		
		public function get textHeight():Number 
		{
			return _textField.textHeight;
		}
		
		public function get textWidth():Number
		{
			return _textField.textWidth;
		}
		
		public function get numLines():int
		{
			return _textField.numLines;
		}
		
		public function getLinkCount():int
		{
			var rcnt:int = 0;
			var cnt:int = _lineInfo.length;
			for(var i:int=0;i<cnt;i++) 
			{
				var lineInfo:Vector.<HtmlNode> = _lineInfo[i];
				if(lineInfo) 
				{
					var cnt2:int = lineInfo.length;
					for(var j:int=0;j<cnt2;j++) 
					{
						if(lineInfo[j].element.type==HtmlElement.LINK)
							rcnt++;
					}
				}
			}
			return rcnt;
		}
		
		public function getImageCount():int 
		{
			var rcnt:int = 0;
			var cnt:int = _lineInfo.length;
			for(var i:int=0;i<cnt;i++) 
			{
				var lineInfo:Vector.<HtmlNode> = _lineInfo[i];
				if(lineInfo) 
				{
					var cnt2:int = lineInfo.length;
					for(var j:int=0;j<cnt2;j++)
					{
						if(lineInfo[j].element.type==HtmlElement.IMAGE)
							rcnt++;
					}
				}
			}
			return rcnt;
		}
		
		public function getObjectRect(objId:String, targetCoordinate:DisplayObject):Rectangle 
		{
			var cnt:int = _lineInfo.length;
			for(var i:int=0;i<cnt;i++)
			{
				var lineInfo:Vector.<HtmlNode> = _lineInfo[i];
				if(lineInfo)
				{
					var cnt2:int = lineInfo.length;
					for(var j:int=0;j<cnt2;j++)
					{
						var node:HtmlNode = lineInfo[j];
						if(node.element.id==objId && node.displayObject!=null) {
							return node.displayObject.getRect(targetCoordinate);
						}
					}
				}
			}
			return null;
		}
		
		public function getLinkRectByOrder(ord:int, targetCoordinate:DisplayObject):Rectangle
		{
			var cnt:int = _lineInfo.length;
			for(var i:int=0;i<cnt;i++) 
			{
				var lineInfo:Vector.<HtmlNode> = _lineInfo[i];
				if(lineInfo) 
				{
					var cnt2:int = lineInfo.length;
					for(var j:int=0;j<cnt2;j++) 
					{
						var node:HtmlNode = lineInfo[j];
						if(node.element.type==HtmlElement.LINK && node.displayObject!=null && ord--==0) 
						{
							return node.displayObject.getRect(targetCoordinate);
						}
					}
				}
			}
			return null;
		}
		
		public function getLinkRectByHref(href:String, targetCoordinate:DisplayObject):Rectangle
		{
			var cnt:int = _lineInfo.length;
			for(var i:int=0;i<cnt;i++) 
			{
				var lineInfo:Vector.<HtmlNode> = _lineInfo[i];
				if(lineInfo) 
				{
					var cnt2:int = lineInfo.length;
					for(var j:int=0;j<cnt2;j++) 
					{
						var node:HtmlNode = lineInfo[j];
						if(node.element.type==HtmlElement.LINK && node.displayObject!=null && node.element.href==href)
						{
							return node.displayObject.getRect(targetCoordinate);
						}
					}
				}
			}
			return null;
		}
		
		public function getLinkHref(ord:int):String
		{
			var cnt:int = _lineInfo.length;
			for(var i:int=0;i<cnt;i++) 
			{
				var lineInfo:Vector.<HtmlNode> = _lineInfo[i];
				if(lineInfo) 
				{
					var cnt2:int = lineInfo.length;
					for(var j:int=0;j<cnt2;j++)
					{
						var node:HtmlNode = lineInfo[j];
						if(node.element.type==HtmlElement.LINK && ord--==0) 
						{
							return node.element.href;
						}
					}
				}
			}
			return null;
		}
		
		public function appendText(val:String):void 
		{
			appendParsedText(new HtmlText(val));
		}
		
		public function appendParsedText(ht:HtmlText):void 
		{
			if(_defaultTextFormat)
				_textField.defaultTextFormat = _defaultTextFormat;
			var startPos:int = _textField.text.length;
			var text:String = ht.parsedText;
			_textField.replaceText(startPos, startPos, text);
			var i:int;
			var cnt:int = ht.elements.length;
			for(i=cnt-1;i>=0;i--) 
			{
				var e:HtmlElement = ht.elements[i];
				if(e.type==HtmlElement.LINK) 
				{
					if(_ALinkFormat)
						_textField.setTextFormat(_ALinkFormat, startPos+e.start, startPos+e.end+1);
				}
				else if(e.type==HtmlElement.IMAGE)
				{
					var imageWidth:int = 20, imageHeight:int = 20;
					if(ToolSet.startsWith(e.src, "ui://"))
					{
						var item:PackageItem = UIPackage.getItemByURL(e.src);
						if(item!=null)
						{
							imageWidth = item.width;
							imageHeight = item.height;
						}
					}
					if(e.width==0)
						e.realWidth = imageWidth;
					else
						e.realWidth = e.width;
					if(e.height==0)
						e.realHeight = imageHeight;
					else
						e.realHeight = e.height;
					e.textformat.font = CharSize.PLACEHOLDER_FONT;
					e.textformat.size = e.realHeight + 2;
					e.textformat.underline = false;
					e.textformat.letterSpacing = e.realWidth+4-CharSize.getHolderWidth(e.realHeight + 2);
					_textField.setTextFormat(e.textformat, startPos+e.start, startPos+e.end+1);
				}
				else
					_textField.setTextFormat(e.textformat, startPos+e.start, startPos+e.end+1);
			}
			fixTextSize();
			
			for(i=0;i<cnt;i++) 
			{
				e = ht.elements[i];
				if(e.type==HtmlElement.LINK)
					addLink(startPos, e);
				else if(e.type==HtmlElement.IMAGE)
					addImage(startPos, e);
			}

			//如果RichTextField不在舞台，那么getCharBoundaries返回的字符的位置会错误（flash 问题），
			//所以这里设了一个标志，等待加到舞台后再刷新
			if(this.stage==null && !_needUpdateNodePos)
			{
				_needUpdateNodePos = true;
				this.addEventListener(Event.ADDED_TO_STAGE, __addedToStage, false, 0, true);
			}
		}
		
		private function __addedToStage(evt:Event):void
		{
			if(!_needUpdateNodePos)
				return;
			
			adjustNodes();
			_needUpdateNodePos = false;
		}
		
		public function deleteLines(from:int, count:int):void 
		{
			if(from+count>_textField.numLines){
				count = _textField.numLines-from;
				if(count<=0)
					return;
			}

			var offset1:int = _textField.getLineOffset(from);
			var offset2:int;
			if(from==_textField.numLines-1)
				offset2 = _textField.text.length;
			else if(count!=1) 
			{
				var end:int = from+count-1;
				offset2 = _textField.getLineOffset(end)+_textField.getLineLength(end);
			}
			else
				offset2 = _textField.getLineLength(from);
			var deleteCount:int = offset2-offset1;
			if(offset1!=0 && _textField.text.charCodeAt(offset1-1)!=13) {
				_textField.replaceText(offset1, offset2, "\r");
				deleteCount--;
			}
			else
				_textField.replaceText(offset1, offset2, "");
			
			var i:int, j:int;
			var lineInfo:Vector.<HtmlNode>, node:HtmlNode;
			for(i=0;i<count;i++) 
			{
				lineInfo = _lineInfo[from+i];
				if(lineInfo) 
				{
					for(j=0;j<lineInfo.length;j++)
					{
						node = lineInfo[j];
						destroyNode(node);
					}
				}
			}
			_lineInfo.splice(from, count);
			
			for(i=from;i<_lineInfo.length;i++)
			{
				lineInfo = _lineInfo[i];
				if(lineInfo)
				{
					var v:Boolean = isLineVisible(i);
					for(j=0;j<lineInfo.length;j++)
					{
						node = lineInfo[j];
						node.charStart -= deleteCount;
						node.charEnd -= deleteCount;
						node.lineIndex -= count;
						node.posUpdated = false;
						if(v)
							showNode(node);
						else
							hideNode(node);
					}
				}
			}
		}
		
		private function adjustNodes():void
		{
			var cnt1:int = _lineInfo.length;
			for(var i:int=0;i<cnt1;i++)
			{
				var lineInfo:Object = _lineInfo[i];
				if(lineInfo) 
				{
					var cnt2:int = lineInfo.length;
					if(isLineVisible(i))
					{
						for(var j:int=0;j<cnt2;j++)
						{
							var node:HtmlNode = lineInfo[j];
							if(_needUpdateNodePos)
								node.posUpdated = false;							
							showNode(node);
						}
					}
					else
					{
						for(j=0;j<cnt2;j++)
						{
							node = lineInfo[j];
							if(_needUpdateNodePos)
								node.posUpdated = false;
							hideNode(node);
						}
					}
				}
			}
		}
		
		private function clear():void {
			var cnt:int = _lineInfo.length;
			for(var i:int=0;i<cnt;i++)
			{
				var lineInfo:Vector.<HtmlNode> = _lineInfo[i];
				if(lineInfo) 
				{
					for(var j:int=0;j<lineInfo.length;j++)
					{
						var node:HtmlNode = lineInfo[j];
						destroyNode(node);
					}
				}
			}
			_lineInfo.length = 0;

			_textField.htmlText = "";
			if(_defaultTextFormat)
				_textField.defaultTextFormat = _defaultTextFormat;

			_needUpdateNodePos = false;
		}
		
		private function fixTextSize():void
		{
			//--for update text field width/height
			_textField.textWidth;
			_textField.height;
		}
		
		private function isLineVisible(line:int):Boolean
		{
			return true;
		}
		
		private function createNode(line:int):HtmlNode
		{
			var lineInfo:Vector.<HtmlNode> = _lineInfo[line];
			if(!lineInfo) 
			{
				lineInfo = new Vector.<HtmlNode>();
				_lineInfo[line] = lineInfo;
			}
			var node:HtmlNode;
			if(_nodeCache.length)
				node = _nodeCache.pop();
			else
				node = new HtmlNode();
			node.lineIndex = line;
			node.nodeIndex = lineInfo.length;
			lineInfo.push(node);
			return node;
		}
		
		private function destroyNode(node:HtmlNode):void
		{
			if(node.displayObject!=null) {
				if(node.displayObject.parent!=null)
					removeChild(node.displayObject);
				if(node.element.type==HtmlElement.LINK)
					_linkButtonCache.push(node.displayObject);
				else if(node.element.type==HtmlElement.IMAGE)
					objectFactory.freeObject(node.displayObject);
			}
			node.reset();
			_nodeCache.push(node);
		}
		
		private function addLink(startPos:int, element:HtmlElement):void
		{
			var start:int = startPos+element.start;
			var end:int = startPos+element.end;
			var line1:int = _textField.getLineIndexOfChar(start);
			var line2:int = _textField.getLineIndexOfChar(end);
			if(line1==line2) 
			{ //single line
				addLinkButton(line1, start, end, element);
			}
			else
			{
				var lineOffset:int = _textField.getLineOffset(line1);
				addLinkButton(line1, start, lineOffset+_textField.getLineLength(line1)-1, element);
				for(var j:int=line1+1;j<line2;j++)
				{
					lineOffset = _textField.getLineOffset(j);
					addLinkButton(j, lineOffset, lineOffset+_textField.getLineLength(j)-1, element);
				}
				addLinkButton(line2, _textField.getLineOffset(line2), end, element);
			}
		}
		
		private function addLinkButton(line:int, charStart:int, charEnd:int, element:HtmlElement):void
		{
			charStart = skipLeftCR(charStart, charEnd);
			charEnd = skipRightCR(charStart, charEnd);
			
			var node:HtmlNode = createNode(line);
			node.charStart = charStart;
			node.charEnd = charEnd;
			node.element = element;
			if(isLineVisible(line))
				showNode(node);
		}
		
		private function addImage(startPos:int, element:HtmlElement):void 
		{
			var start:int = startPos+element.start;
			var line:int = _textField.getLineIndexOfChar(start);
			
			var node:HtmlNode = createNode(line);
			node.charStart = start;
			node.charEnd = start;
			node.element = element;
			if(isLineVisible(line))
				showNode(node);
		}
		
		private function showNode(node:HtmlNode):void
		{
			var element:HtmlElement = node.element;
			if(element.type==HtmlElement.LINK) 
			{
				if(node.displayObject==null)
				{
					var btn:LinkButton;
					if(_linkButtonCache.length)
						btn = _linkButtonCache.pop();
					else 
					{
						btn = new LinkButton();
						btn.addEventListener(MouseEvent.ROLL_OVER, __linkRollOver);
						btn.addEventListener(MouseEvent.ROLL_OUT, __linkRollOut);
						btn.addEventListener(MouseEvent.CLICK, __linkClick);
					}
					btn.owner = node;
					node.displayObject = btn;
				}
				
				if(!node.posUpdated)
				{
					var rect1:Rectangle = _textField.getCharBoundaries(node.charStart);
					if(rect1==null)
						return;
					var rect2:Rectangle = _textField.getCharBoundaries(node.charEnd);
					if(rect2==null)
						return;
					
					var w:int = rect2.right-rect1.left;
					if(rect1.left+w>_textField.width-2)
						w = _textField.width-rect1.left-2;					
					var h:int = Math.max(rect1.height, rect2.height);
					node.displayObject.x = rect1.left;
					node.displayObject.width = w;
					node.displayObject.height = h;
					if(rect1.top<rect2.top)
						node.topY = 0;
					else
						node.topY = rect2.top-rect1.top;
					node.posUpdated = true;
				}
				else
				{
					rect1 = _textField.getCharBoundaries(node.charStart);
					if(rect1==null)
						return;
				}
				
				node.displayObject.y = rect1.top + node.topY;
				if(node.displayObject.parent==null)
					addChild(node.displayObject);
			}
			else if(element.type==HtmlElement.IMAGE)
			{
				if(node.displayObject==null) {
					if(objectFactory!=null)
						node.displayObject = objectFactory.createObject(element.src, element.width, element.height);
					if(node.displayObject==null)
						return;
				}
				
				rect1 = _textField.getCharBoundaries(node.charStart);
				if(rect1==null)
					return;
				
				var tm:TextLineMetrics = _textField.getLineMetrics(node.lineIndex);
				if(tm==null)
					return;
				
				node.displayObject.x = rect1.left + 2;
				if(element.realHeight<tm.ascent)
					node.displayObject.y = rect1.top+tm.ascent-element.realHeight;
				else
					node.displayObject.y = rect1.bottom-element.realHeight;
				if(node.displayObject.x+node.displayObject.width<_textField.width-2) 
				{
					if(node.displayObject.parent==null)
						addChildAt(node.displayObject, this.numChildren);
				}
			}
		}
		
		private function hideNode(node:HtmlNode):void 
		{
			if(node.displayObject && node.displayObject.parent) 
			{
				removeChild(node.displayObject);
			}
		}
		
		private function skipLeftCR(start:int, end:int):int
		{
			var text:String = _textField.text;
			for(var i:int=start;i<end;i++) 
			{
				var c:String = text.charAt(i);
				if(c!="\r" && c!="\n")
					break;
			}
			return i;
		}
		
		private function skipRightCR(start:int, end:int):int
		{
			var text:String = _textField.text;
			for(var i:int=end;i>start;i--) 
			{
				var c:String = text.charAt(i);
				if(c!="\r" && c!="\n")
					break;
			}
			return i;
		}
		
		private function findLinkStart(linkNode:HtmlNode, hovered:Boolean):int
		{
			var i:int = linkNode.nodeIndex;
			var j:int = linkNode.lineIndex;
			i--;
			var ne:HtmlNode, se:HtmlNode;
			var lineInfo:Vector.<HtmlNode> = _lineInfo[j];

			while(true)
			{
				if(i<0) 
				{
					if(se==linkNode)
						break;
					se = linkNode;
					j--;
					lineInfo = _lineInfo[j];
					if(!lineInfo)
						break;
					i=lineInfo.length-1;
				}
				ne = lineInfo[i];
				if(ne.element.type==HtmlElement.LINK)
				{
					if(ne.element!=linkNode.element)
						break;
					linkNode = ne;

				}
				i--;
			}
			return linkNode.charStart;
		}
		
		private function findLinkEnd(linkNode:HtmlNode, hovered:Boolean):int
		{
			var i:int = linkNode.nodeIndex;
			var j:int = linkNode.lineIndex;
			i++;
			var ne:HtmlNode, se:HtmlNode;
			var lineInfo:Vector.<HtmlNode> = _lineInfo[j];
			if(!lineInfo)
				return linkNode.charEnd;

			while(true) 
			{
				if(i>lineInfo.length-1) 
				{
					if(se==linkNode)
						break;
					se = linkNode;
					j++;
					lineInfo = _lineInfo[j];
					if(!lineInfo)
						break;
					i=0;
				}
				ne = lineInfo[i];
				if(ne.element.type==HtmlElement.LINK)
				{
					if(ne.element!=linkNode.element)
						break;
					linkNode = ne;
				}
				i++;
			}
			return linkNode.charEnd;
		}
		
		private function __linkRollOver(evt:Event):void 
		{
			var node:HtmlNode = LinkButton(evt.currentTarget).owner;
			var i1:int = findLinkStart(node, true);
			var i2:int = findLinkEnd(node, true)+1;
			if(_AHoverFormat)
				_textField.setTextFormat(_AHoverFormat, i1, i2);
		}
		
		private function __linkRollOut(evt:Event):void 
		{
			var node:HtmlNode = LinkButton(evt.currentTarget).owner;
			if(node.lineIndex==-1) //destroyed
				return;
			if(_AHoverFormat && _ALinkFormat)
				_textField.setTextFormat(_ALinkFormat, 
					findLinkStart(node, false), findLinkEnd(node, false)+1);
		}
		
		private function __linkClick(evt:Event):void
		{
			evt.stopPropagation();
			var node:HtmlNode = LinkButton(evt.currentTarget).owner;
			var url:String =  node.element.href;
			var i:int = url.indexOf("event:");
			if(i==0)
				this.dispatchEvent(new TextEvent(TextEvent.LINK, true, false, url.substring(6)));
			else
				flash.net.navigateToURL(new URLRequest(url), node.element.target);
		}
	}
	
}


