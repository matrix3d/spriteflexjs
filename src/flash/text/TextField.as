package flash.text
{
	import flash.__native.GLCanvasRenderingContext2D;
	import flash.__native.GLDrawable;
	import flash.__native.GLIndexBufferSet;
	import flash.__native.WebGLRenderer;
	import flash.__native.te.Char;
	import flash.__native.te.LineInfo;
	import flash.__native.te.UVTexture;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
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
		private var glDirty:Boolean = false;
		private static var richTextFields:Array = ["font", "size", "color", "bold", "italic", "underline", "url", "target", "align", "leftMargin", "rightMargin", "indent", "leading", "blockIndent", "kerning", "letterSpacing", "display"];
		private var _text:String="";
		private var lines:Array = [];
		private var _textFormat:TextFormat=new TextFormat;
		private var _width:Number = 100;
		private var _height:Number = 100;
		private var _autoSize:String=TextFieldAutoSize.NONE;
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
		
		//for webgl
		public var chars:Array; 
		private static var indexPool:Object = {};
		private static var DRAWABLE_POOL:Object = {};
		private var da:GLDrawable;
		private var indexBufferSet:GLIndexBufferSet;
		private var nowKey:int = 0;
		private var num:int = 0;
		private var charVersion:int = 1;
		public var disWrapper:Sprite;
		public var _textWidth:int = -1;
		public var _textHeight:int = -1;
		private var _wordWrap:Boolean = false;
		private static var lineInfos:Array = [];
		public var hasATag:Boolean = false;//有a标签
		public var tagas:Array = [];
		private var href:String;
		private var _htmlText:String;
		
		
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
		
		
		public function get htmlText():String  { return null; }
		
		public function set htmlText(value:String):void  {
			hasATag = false;
			glDirty = true;
			if (value != null){
				tagas = [];
				//charsLength = 0;
				_text = "";
				value = value.replace(/\\n/g, "<br/>")
				.replace(/\n/g, "<br/>")
				.replace(/<br>/g, "<br/>");
				_htmlText = value;
				try{
					var xmllist:DOMParser = new DOMParser();
					var hd:HTMLDocument = parseFromString(value);
					
					for(var i:int=0;i<hd.body.childNodes.length;i++){
						doXML(hd.body.childNodes[i],_textFormat.font, int(_textFormat.size),int(_textFormat.color),null,int(_textFormat.indent),int(_textFormat.underline));
					}
					
					//for e(var xml:XML in xmllist){
						//doXML(xml, _defFont, _defSize, _defColor,null,_indent,_defUnderline);
					//}
				}catch (err:Error){
					text = value;
				}
			}
		}
		
		private function doXML(xml:Node, font:String, size:int, color:uint, href:String, indent:int, underline:int):void {
			this.href = href;
			if (xml==null){
				return;
			}
			var l:String = xml.localName;
			if (l === "br"){
				var txt:String = "\n";
			}else if(xml.nodeType===3){
				txt = xml.nodeValue.replace(/&nbsp;/g," ");
				txt = txt.replace(/ﾠ/g," ");
			}if(xml.attributes){
				if (l === "font"){
					if (xml.attributes.getNamedItem("face")){
						font = xml.attributes.getNamedItem("face").nodeValue;
					}
					if (xml.attributes.getNamedItem("size")){
						size = Number(xml.attributes.getNamedItem("size").nodeValue);
					}
					if (xml.attributes.getNamedItem("color")){
						color = parseInt(xml.attributes.getNamedItem("color").nodeValue.replace("#",""),16);
					}
				}else if (l === "a"){
					if (xml.attributes.getNamedItem("href")){
						hasATag = true;
						href = xml.attributes.getNamedItem("href").nodeValue;
						this.href = href;
					}
				}else if (l === "img"){
					if (xml.attributes.getNamedItem("src")){
						var imgsrc:String = xml.attributes.getNamedItem("src").nodeValue;
						if (xml.attributes.getNamedItem("width")){
							var imgwidth:Number = parseFloat(xml.attributes.getNamedItem("width").nodeValue);
						}
					}
				}else if (l === "textformat"){
					if (xml.attributes.getNamedItem("indent")){
						indent= Number(xml.attributes.getNamedItem("@indent").nodeValue);
					}
				}
			}
			if (l==="u"){
				underline = 1;
			}
			_textFormat.font = font?font.toLowerCase():font;
			_textFormat.size = size;
			_textFormat.color = color;
			_textFormat.indent = indent;
			_textFormat.underline = underline;
			
			if (imgsrc){
				//appendImg(id2img[imgsrc],imgwidth);
			}
			
			if (txt && txt.length > 0){
				appendText(txt);
			}
			
			
			if (xml.childNodes) {
				for(var i:int=0;i<xml.childNodes.length;i++){
					doXML(xml.childNodes[i],font,size,color,href,indent,underline);
				}
			}
		}
		
		public function get text():String  { return _text; }
		
		public function set text(value:String):void  {
			/*_text = txt; 
			SpriteFlexjs.dirtyGraphics = true;
			graphicsDirty = true;
			
			if (txt && txt.length > 0 && SpriteFlexjs.renderer is WebGLRenderer){
				glDirty = true;
				chars = [];
				var l:int = txt.length;
				for (var i:int = 0; i < l;i++ ){
					var c:Char = new Char(txt.charAt(i),_textFormat.size as int,_textFormat.font,_textFormat.color as uint);//color font size etc
					chars.push(c);
					WebGLRenderer.textCharSet.add(c);
				}
			}else{
				lines = txt.split("\n");
			}*/
			if (value === null){
				value = "";
			}
			if (_text===value){
				return;
			}
			hasATag = false;
			chars = null;
			appendText(value);
		}
		
		public function appendText(value:String):void{
			SpriteFlexjs.dirtyGraphics = true;
			graphicsDirty = true;
			if(_text!=null){
				_text += value;
			}else{
				_text = value;
			}
			if (_text && _text.length > 0 && SpriteFlexjs.renderer is WebGLRenderer){
				glDirty = true;
				var tl:int = value.length;
				chars = chars||[];
				for (var i:int = 0; i < tl;i++ ){
					var c:Char = new Char(value.charAt(i),_textFormat.size as int,_textFormat.font,_textFormat.color as uint);//color font size etc
					chars.push(c);
					WebGLRenderer.textCharSet.add(c);
				}
			}else{
				lines = lines || [];
				lines = lines.concat(value.split("\n"));
			}
			
			
		}
		
		private static function PUSH_POOL(key:int,da:GLDrawable):void{
			var arr:Array = DRAWABLE_POOL[key];
			if (arr==null){
				arr = DRAWABLE_POOL[key] = [];
			}
			arr.push(da);
		}
		
		private static function POP_POOL(pow2num:int):GLDrawable{
			var arr:Array = DRAWABLE_POOL[pow2num];
			if (arr==null){
				arr = DRAWABLE_POOL[pow2num] = [];
			}
			if (arr.length==0){
				var da:GLDrawable  = new GLDrawable(new Float32Array(pow2num * 8),new Float32Array(pow2num*8),null,WebGLRenderingContext.DYNAMIC_DRAW);
				return da;
			}
			return arr.pop();
		}
		
		private function __updateBuff():void{
			if(glDirty&&chars&&chars.length>0){
				var currentLineNum:int = -1;
				num = 0;
				charVersion++;
				//更新char相对位置
				var clen:int = 1;//todo  多个动态文本一起渲染
				for (i = 0; i < clen;i++ ){
					var line:TextField = this;
					
					if(line.disWrapper){
						while(line.disWrapper.numChildren>0){
							line.disWrapper.removeChildAt(0);
						}
					}
					
					line._textWidth = 0;
					//line.textMatrixVer = line.worldVersion;
					var startLineNum:int = currentLineNum+1;
					var cs:Array = line.chars;
					if (cs && line.chars.length){
						currentLineNum++;
						var lineInfo:LineInfo = lineInfos[currentLineNum] = lineInfos[currentLineNum] || new LineInfo;
						lineInfo.maxFontSize = 0;
						var tx:int = 2;
						var ty:int = 2;
						lineInfo.offsetY = ty;
						var tlen:int = line.chars.length;
						for (var j:int = 0; j < tlen; j++ ){
							var txt:Char = cs[j];
							txt.lineInfo = lineInfo;
							var char:UVTexture = txt.texture;
							if (char.u0==-1){
								return;
							}
							var tscale:Number = txt.size / char.fontSize;
							if (txt.v=="\n"){
								tx = 2;
								ty += lineInfo.maxFontSize+txt.leading;
								currentLineNum++;
								if(lineInfo&&line._textWidth<lineInfo.width){
									line._textWidth = lineInfo.width;
								}
								lineInfo = lineInfos[currentLineNum] = lineInfos[currentLineNum] || new LineInfo;
								lineInfo.maxFontSize = 0;
								lineInfo.width = 0;
								lineInfo.offsetY = ty;
								continue;
							}else if (txt.v==""){
								trace("img");
								/*if (char.dis){
									if (line.disWrapper==null){
										line.disWrapper = new Sprite;
										line.add(line.disWrapper);
									}
									line.disWrapper.addChild(char.dis);
									char.dis.x = tx;
									char.dis.y = ty;
								}*/
							}
							
							//tx为文字起始点 ts为文字末尾点
							if (line.wordWrap){
								if ((tx + char.width*tscale) > line._width){
									tx = 2;
									ty += lineInfo.maxFontSize+txt.leading;
									currentLineNum++;
									if(lineInfo&&line._textWidth<lineInfo.width){
										line._textWidth = lineInfo.width;
									}
									lineInfo = lineInfos[currentLineNum] = lineInfos[currentLineNum] || new LineInfo;
									lineInfo.maxFontSize = 0;
									lineInfo.width = 0;
									lineInfo.offsetY = ty;
								}
							}else{
								if(line.autoSize==TextFieldAutoSize.NONE){
									if ((tx+char.width*tscale)>line._width){
										//找下一个\n
										continue;
									}
								}
							}
							
							if (lineInfo.maxFontSize < txt.size) {
								lineInfo.maxFontSize = txt.size;
							}
							
							txt.charVersion = charVersion;
							txt.lineInfo = lineInfo;
							txt.x0 = tx;
							lineInfo.width = txt.x1 = tx+char.width*tscale;
							txt.y0 = ty - txt.size;
							txt.y1 = txt.y0 + char.height*tscale;
							tx += char.xadvance*tscale;
							num++;
							if (txt.underline){
								num++;
							}
						}
						
						line._textHeight = ty + lineInfo.maxFontSize;
						if(lineInfo&&line._textWidth<lineInfo.width){
							line._textWidth = lineInfo.width;
						}
						for (j = startLineNum; j <= currentLineNum;j++ ){
							lineInfo = lineInfos[j];
							if (line.autoSize==TextFieldAutoSize.CENTER){
								lineInfo.offsetX = line._width / 2 - lineInfo.width / 2;
							}else if (line.autoSize==TextFieldAutoSize.RIGHT){
								lineInfo.offsetX = line._width - lineInfo.width;
							}else{
								lineInfo.offsetX = 0;
							}
						}
						//查找隐藏的txt
						if (line.autoSize==TextFieldAutoSize.NONE&&line._textHeight>line._height){
							var offsetY:Number = (line._height - line._textHeight) * line.scrollV;
							for (j = 0; j < tlen; j++ ){
								txt = cs[j];
								lineInfo = txt.lineInfo;
								if (txt.charVersion==charVersion){
									if ((txt.y0 + offsetY+lineInfo.maxFontSize) < 0 || (txt.y0 + offsetY+lineInfo.maxFontSize) > line._height){
										num--;
										if (txt.underline){
											num--;
										}
										txt.charVersion--;
									}
								}
							}
						}
					}
				}
			
				//构建vbuff ibuff

				var pow2num:int = getNextPow2(num);
				if (da==null){
					nowKey = pow2num;
					da = POP_POOL(pow2num);
				}else if(nowKey!=pow2num){
					PUSH_POOL(nowKey, da);
					da = POP_POOL(pow2num);
					nowKey = pow2num;
				}
				
				indexBufferSet= indexPool[pow2num];
				var needNew:Boolean = indexBufferSet == null;
				if (needNew){
					indexBufferSet = indexPool[pow2num] = new GLIndexBufferSet(new Uint16Array(pow2num*6),WebGLRenderingContext.STATIC_DRAW);
					var indexd:Uint16Array = indexBufferSet.data;
					for (var i:int = 0; i < pow2num;i++ ){
						indexd[i * 6]  = i * 4;
						indexd[i * 6+1]  =indexd[i * 6+3] =i * 4+2;
						indexd[i * 6+2] = indexd[i * 6+4] =i * 4+1;
						indexd[i * 6+5] = i * 4+3;
					}
				}
				da.pos.dirty = true;
				da.color.dirty = true;
				da.uv.dirty = true;
				var posd:Float32Array = da.pos.data as Float32Array;
				var colord:Uint32Array = da.color.data as Uint32Array;
				var uvd:Float32Array = da.uv.data as Float32Array;
				
				var k:int = 0;
				for (i = 0; i < clen;i++ ){
					line = this;
					var alpha:uint = 1;// (line.a*0xff) << 24;
					cs = line.chars;
					if (cs && cs.length){
						tlen = cs.length;
						offsetY = (line._height - line._textHeight) * line.scrollV;
						if (offsetY>0){
							offsetY = 0;
						}
						for (j = 0; j < tlen; j++ ){
							txt = cs[j];
							if (txt.charVersion != charVersion){
								continue;
							}
							char = txt.texture;
							var maxFontSize:int = txt.lineInfo.maxFontSize + offsetY;
							var offsetX:int = txt.lineInfo.offsetX;
							
							posd[k * 8] = posd[k * 8 + 4] =txt.x0 + offsetX;
							posd[k * 8 + 1] = posd[k * 8 + 3] =txt.y0 + maxFontSize;
							posd[k * 8 + 2] =posd[k * 8 + 6] = txt.x1 + offsetX;
							posd[k * 8 + 5] =posd[k * 8 + 7] = txt.y1 + maxFontSize;
							

							uvd[k * 8] = uvd[k * 8 + 4] = char.u0;
							uvd[k * 8 + 1] = uvd[k * 8 + 3] = char.v0;
							uvd[k * 8 + 2] = uvd[k * 8 + 6] = char.u1;
							uvd[k * 8 + 5] = uvd[k * 8 + 7] = char.v1;
							
							/*var abgr:uint = alpha|txt.bgr;
							if (char.channel==0){
								var channel:uint = 
								0xffff00;
							}else{
								channel = 
								0xff0000ff;
							}*/
							
							/*fastmem.fastSetI32(abgr, k * 32);
							fastmem.fastSetI32(channel, k * 32+4);
							fastmem.fastSetI32(abgr, k * 32+8);
							fastmem.fastSetI32(channel, k * 32+12);
							fastmem.fastSetI32(abgr, k * 32+16);
							fastmem.fastSetI32(channel, k * 32+20);
							fastmem.fastSetI32(abgr, k * 32 + 24);
							fastmem.fastSetI32(channel, k * 32+28);*/
							
							/*colord.position = k * 32;
							colord.writeUnsignedInt(abgr);
							colord.writeUnsignedInt(channel);
							colord.writeUnsignedInt(abgr);
							colord.writeUnsignedInt(channel);
							colord.writeUnsignedInt(abgr);
							colord.writeUnsignedInt(channel);
							colord.writeUnsignedInt(abgr);
							colord.writeUnsignedInt(channel);*/
							var color:uint = 0xff000000|txt.bgr;
							colord[k * 4] = color;
							colord[k * 4+1] = color;
							colord[k * 4+2] = color;
							colord[k * 4+3] = color;
							
							k++;
							
							/*if (txt.underline){//下划线
								posd[k * 12] = pout[0] + (txt.x0 +offsetX)*pout[3]+(txt.lineInfo.offsetY+maxFontSize) * pout[6];
								posd[k * 12 + 1] = pout[1] +(txt.x0+offsetX)* pout[4]+(txt.lineInfo.offsetY+maxFontSize) * pout[7];
								posd[k * 12 + 2] = pout[2] + (txt.x0+offsetX) * pout[5]+(txt.lineInfo.offsetY+maxFontSize) * pout[8];
								
								posd[k * 12 + 3] = pout[0] + (txt.x1+offsetX) * pout[3]+(txt.lineInfo.offsetY+maxFontSize) * pout[6];
								posd[k * 12 + 4] = pout[1] + (txt.x1+offsetX) * pout[4]+(txt.lineInfo.offsetY+maxFontSize) * pout[7];
								posd[k * 12 + 5] = pout[2] + (txt.x1+offsetX) * pout[5]+(txt.lineInfo.offsetY+maxFontSize) * pout[8];
								
								posd[k * 12 + 6] = pout[0]  + (txt.x1+offsetX) * pout[3]+(txt.lineInfo.offsetY+txt.underline+maxFontSize) * pout[6];
								posd[k * 12 + 7] = pout[1] + (txt.x1+offsetX) * pout[4]+(txt.lineInfo.offsetY+txt.underline+maxFontSize) * pout[7];
								posd[k * 12 + 8] = pout[2] + (txt.x1+offsetX) * pout[5]+(txt.lineInfo.offsetY+txt.underline+maxFontSize) * pout[8];
								
								posd[k * 12 + 9] = pout[0] + (txt.x0+offsetX) * pout[3]+(txt.lineInfo.offsetY+txt.underline+maxFontSize) * pout[6];
								posd[k * 12 + 10] = pout[1] + (txt.x0+offsetX) * pout[4]+(txt.lineInfo.offsetY+txt.underline+maxFontSize) * pout[7];
								posd[k * 12 + 11] = pout[2] + (txt.x0+offsetX) * pout[5]+(txt.lineInfo.offsetY+txt.underline+maxFontSize) * pout[8];
								
								uvd[k * 8] = uvd[k * 8 + 6] = 1-1/2048//char.u0;最后一像素为黑色
								uvd[k * 8 + 1] = uvd[k * 8 + 3] = 1//char.v0;
								uvd[k * 8 + 2] = uvd[k * 8 + 4] = 1-1/2048//char.u1;
								uvd[k * 8 + 5] = uvd[k * 8 + 7] = 1////char.v1;
								
								colord.position = k * 32;
								colord.writeUnsignedInt(abgr);
								colord.writeUnsignedInt(channel);
								colord.writeUnsignedInt(abgr);
								colord.writeUnsignedInt(channel);
								colord.writeUnsignedInt(abgr);
								colord.writeUnsignedInt(channel);
								colord.writeUnsignedInt(abgr);
								colord.writeUnsignedInt(channel);
								
								k++;
							}*/
						}
					}
				}
				glDirty = false;
			}
		}
		
		public function __updateGL(ctx:GLCanvasRenderingContext2D):void{
			if(chars&&chars.length>0){
				__updateBuff();
				//draw vbuff ibuff
				if(num>0){
					da.index = indexBufferSet;
					da.numTriangles = num * 2;
					ctx.renderImage(WebGLRenderer.textCharSet.image, da, transform.concatenatedMatrix, null, false, false, true);
				}
			}
		}
		
		public function get textColor():uint  { return int(_textFormat.color); }
		
		public function set textColor(color:uint):void
		{
			_textFormat.color = color;
			graphicsDirty = true;
			SpriteFlexjs.dirtyGraphics = true;
		}
		
		public function get textHeight():Number  {
			__updateBuff();
			if (_textHeight !=-1){
				return _textHeight;
			}
			return lines?int(defaultTextFormat.size) * lines.length : 0; 
		}
		
		public function get textWidth():Number  {
			__updateBuff();
			if(_textWidth!=-1){
				return _textWidth;
			}
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
		
		public function get wordWrap():Boolean  { return _wordWrap; }
		
		public function set wordWrap(param1:Boolean):void  {_wordWrap = param1; }
		
		/*public function appendText(newText:String):void
		{
			this.replaceText(this.text.length, this.text.length, newText);
		}*/
		
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
				SpriteFlexjs.renderer.renderRichText(ctx, this);
				SpriteFlexjs.drawCounter++;
			}
		}
		
		public function __updateCanvas(ctx:CanvasRenderingContext2D):void{
			if (filters.length && !cacheAsBitmap && !parent.cacheAsBitmap) cacheAsBitmap = true;
				
			if (cacheAsBitmap && !parent.cacheAsBitmap && _type != TextFieldType.INPUT)
			{
				SpriteFlexjs.renderer.renderImage(ctx, _cacheImage, transform.concatenatedMatrix, blendMode, transform.concatenatedColorTransform, -this.x - _cacheOffsetX, -this.y - _cacheOffsetY);
			}
			else
			{
				__draw(ctx, transform.concatenatedMatrix);
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
		
		private function getNextPow2(v:int):int {
			var r:int = 1;
			while (r < v) {
				r *= 2;
			}
			return r;
		}
		
		private function parseFromString(markup:String):HTMLDocument {
			return (new DOMParser()).parseFromString(markup, "text/html") as HTMLDocument;
			// Firefox/Opera/IE throw errors on unsupported types
			/*try {
				// WebKit returns null on unsupported types
				if ((new DOMParser()).parseFromString("", "text/html")) {
					// text/html parsing is natively supported
					
				}
			} catch (ex) {}
			
			if (/^\s*text\/html\s*(?:;|$)/i.test(type)) {
				var
				  doc = document.implementation.createHTMLDocument("")
				;
					if (markup.toLowerCase().indexOf('<!doctype') > -1) {
						doc.documentElement.innerHTML = markup;
					}
					else {
						doc.body.innerHTML = markup;
					}
				return doc;
			} else {
				return nativeParse.apply(this, arguments);
			}*/
		}
	}
}
