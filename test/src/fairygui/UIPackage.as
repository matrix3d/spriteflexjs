package fairygui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import fairygui.display.Frame;
	import fairygui.text.BMGlyph;
	import fairygui.text.BitmapFont;
	import fairygui.utils.GTimers;
	import fairygui.utils.PixelHitTestData;
	import fairygui.utils.ToolSet;
	
	public class UIPackage
	{
		private var _id:String;
		private var _name:String;
		private var _basePath:String;
		private var _items:Vector.<PackageItem>;
		private var _itemsById:Object;
		private var _itemsByName:Object;
		private var _hitTestDatas:Object;
		private var _customId:String;
		
		private var _reader:IUIPackageReader;
		
		internal static var _constructing:int;
		
		private static var _packageInstById:Object = {};
		private static var _packageInstByName:Object = {};
		private static var _bitmapFonts:Object = {};
		private static var _loadingQueue:Array = [];
		private static var _stringsSource:Object = null;
		
		public function UIPackage()
		{
			_items = new Vector.<PackageItem>();
			_hitTestDatas = {};
		}
		
		public static function getById(id:String):UIPackage
		{
			return _packageInstById[id];
		}
		
		public static function getByName(name:String):UIPackage
		{
			return _packageInstByName[name];
		}
		
		public static function addPackage(desc:ByteArray, res:ByteArray):UIPackage
		{
			var pkg:UIPackage = new UIPackage();
			var reader:ZipUIPackageReader = new ZipUIPackageReader(desc, res);
			pkg.create(reader);
			_packageInstById[pkg.id] = pkg;
			_packageInstByName[pkg.name] = pkg;
			return pkg;
		}
		
		public static function addPackage2(reader:IUIPackageReader):UIPackage
		{
			var pkg:UIPackage = new UIPackage();
			pkg.create(reader);
			_packageInstById[pkg.id] = pkg;
			_packageInstByName[pkg.name] = pkg;
			return pkg;
		}
		
		public static function removePackage(packageId:String):void
		{
			var pkg:UIPackage = _packageInstById[packageId];
			pkg.dispose();
			delete _packageInstById[pkg.id];
			if(pkg._customId!=null)
				delete _packageInstById[pkg._customId];
			delete _packageInstByName[pkg.name];
		}
		
		public static function createObject(pkgName:String, resName:String, userClass:Object=null):GObject
		{
			var pkg:UIPackage = getByName(pkgName);
			if(pkg)
				return pkg.createObject(resName, userClass);
			else
				return null;
		}
		
		public static function createObjectFromURL(url:String, userClass:Object=null):GObject
		{
			var pi:PackageItem = getItemByURL(url);
			if(pi)
				return pi.owner.internalCreateObject(pi, userClass);
			else
				return null;
		}		
		
		public static function getItemURL(pkgName:String, resName:String):String
		{
			var pkg:UIPackage = getByName(pkgName);
			if(!pkg)
				return null;
			
			var pi:PackageItem = pkg._itemsByName[resName];
			if(!pi)
				return null;
			
			return "ui://"+pkg.id+pi.id;
		}
		
		public static function getItemByURL(url:String):PackageItem
		{
			if (url == null)
				return null;
			
			var pos1:int = url.indexOf("//");
			if (pos1 == -1)
				return null;
			
			var pos2:int = url.indexOf("/", pos1 + 2);
			if (pos2 == -1)
			{
				if (url.length > 13)
				{
					var pkgId:String = url.substr(5, 8);
					var pkg:UIPackage = getById(pkgId);
					if (pkg != null)
					{
						var srcId:String = url.substr(13);
						return pkg.getItemById(srcId);
					}
				}
			}
			else
			{
				var pkgName:String = url.substr(pos1 + 2, pos2 - pos1 - 2);
				pkg = getByName(pkgName);
				if (pkg != null)
				{
					var srcName:String = url.substr(pos2 + 1);
					return pkg.getItemByName(srcName);
				}
			}
			
			return null;
		}
		
		public static function normalizeURL(url:String):String
		{
			if(url==null)
				return null;
			
			var pos1:int = url.indexOf("//");
			if (pos1 == -1)
				return null;
			
			var pos2:int = url.indexOf("/", pos1 + 2);
			if (pos2 == -1)
				return url;

			var pkgName:String = url.substr(pos1 + 2, pos2 - pos1 - 2);
			var srcName:String = url.substr(pos2 + 1);
			return getItemURL(pkgName, srcName);
		}
		
		public static function getBitmapFontByURL(url:String):BitmapFont
		{
			return _bitmapFonts[url];
		}
		
		public static function setStringsSource(source:XML):void
		{
			_stringsSource = {};
			var list:XMLList = source.string;
			for each(var xml:XML in list)
			{
				var key:String = xml.@name;
				var text:String = xml.toString();
				var i:int = key.indexOf("-");
				if(i==-1)
					continue;
				
				var key2:String = key.substr(0, i);
				var key3:String = key.substr(i+1);
				var col:Object = _stringsSource[key2];
				if(!col)
				{
					col = {};
					_stringsSource[key2] = col;
				}
				col[key3] = text;
			}
		}
		
		public static function loadingCount():int
		{
			return _loadingQueue.length;
		}
		
		public static function waitToLoadCompleted(callback:Function):void
		{
			GTimers.inst.add(10, 0, checkComplete, callback);
		}
		
		private static function checkComplete(callback:Function):void
		{
			if(_loadingQueue.length==0)
			{
				GTimers.inst.remove(checkComplete);
				callback();
			}
		}
		
		private function create(reader:IUIPackageReader):void
		{
			_reader = reader;
			
			var str:String = _reader.readDescFile("package.xml");
			
			var ignoreWhitespace:Boolean = XML.ignoreWhitespace;
			XML.ignoreWhitespace = true;
			var xml:XML = new XML(str);
			XML.ignoreWhitespace = ignoreWhitespace;
			
			_id = xml.@id;
			_name = xml.@name;
			
			var resources:XMLList = xml.resources.elements();
			
			_itemsById = {};
			_itemsByName = {};
			var pi:PackageItem;
			var cxml:XML;
			var arr:Array;
			for each(cxml in resources)
			{
				pi = new PackageItem();
				pi.owner = this;
				pi.type = PackageItemType.parseType(cxml.name().localName);
				pi.id = cxml.@id;
				pi.name = cxml.@name;
				pi.file = cxml.@file;
				str = cxml.@size;
				arr = str.split(",");
				pi.width = int(arr[0]);
				pi.height = int(arr[1]);
				switch(pi.type)
				{
					case PackageItemType.Image:
					{
						str = cxml.@scale;
						if(str=="9grid")
						{
							pi.scale9Grid = new Rectangle();
							str = cxml.@scale9grid;
							arr = str.split(",");
							pi.scale9Grid.x = arr[0];
							pi.scale9Grid.y = arr[1];
							pi.scale9Grid.width = arr[2];
							pi.scale9Grid.height = arr[3];
							
							str = cxml.@gridTile;
							if(str)
								pi.tileGridIndice = parseInt(str);
						}
						else if(str=="tile")
						{
							pi.scaleByTile = true;
						}
						str = cxml.@smoothing;
						pi.smoothing = str!="false";
						break;
					}
						
					case PackageItemType.Component:
						UIObjectFactory.resolvePackageItemExtension(pi);
						break;
				}
				
				_items.push(pi);
				_itemsById[pi.id] = pi;
				if(pi.name!=null)
					_itemsByName[pi.name] = pi;
			}
			
			var ba:ByteArray = _reader.readResFile("hittest.bytes");
			if(ba!=null)
			{
				while(ba.bytesAvailable)
				{
					var hitTestData:PixelHitTestData = new PixelHitTestData();
					_hitTestDatas[ba.readUTF()] = hitTestData;
					hitTestData.load(ba);
				}
			}

			var cnt:int = _items.length;
			for (var i:int = 0; i < cnt; i++)
			{
				pi = _items[i];
				if (pi.type == PackageItemType.Font)
				{
					loadFont(pi);
					_bitmapFonts[pi.bitmapFont.id] = pi.bitmapFont;
				}
			}
		}
		
		public function loadAllImages():void
		{
			var cnt:int = _items.length;
			for(var i:int=0;i<cnt;i++)
			{
				var pi:PackageItem = _items[i];
				if(pi.type!=PackageItemType.Image || pi.image!=null || pi.loading)
					continue;
				
				loadImage(pi);
			}
		}
		
		public function dispose():void
		{
			var cnt:int=_items.length;
			for(var i:int=0;i<cnt;i++)
			{
				var pi:PackageItem = _items[i];
				var image:BitmapData = pi.image;
				if(image!=null)
					image.dispose();
				else if(pi.frames!=null)
				{
					var frameCount:int = pi.frames.length;
					for(var j:int=0;j<frameCount;j++)
					{
						image = pi.frames[j].image;
						if(image!=null)
							image.dispose();
					}
				}
				else if(pi.bitmapFont!=null)
				{
					delete _bitmapFonts[pi.bitmapFont.id];
					pi.bitmapFont.dispose();
				}
			}
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get customId():String
		{
			return _customId;
		}
		
		public function set customId(value:String):void
		{
			if (_customId != null)
				delete _packageInstById[_customId];
			_customId = value;
			if (_customId != null)
				_packageInstById[_customId] = this;
		}
		
		public function createObject(resName:String, userClass:Object=null):GObject
		{
			var pi:PackageItem = _itemsByName[resName];
			if(pi)
				return internalCreateObject(pi, userClass);
			else
				return null;
		}
		
		internal function internalCreateObject(item:PackageItem, userClass:Object):GObject
		{
			var g:GObject = null;
			if (item.type == PackageItemType.Component)
			{
				if(userClass!=null)
				{
					if(userClass is Class)
						g = new userClass();
					else
						g = GObject(userClass);
				}
				else
					g = UIObjectFactory.newObject(item);
			}
			else
				g = UIObjectFactory.newObject(item);
			
			if (g == null)
				return null;
			
			_constructing++;
			g.packageItem = item;
			g.constructFromResource();
			_constructing--;
			return g;
		}

		public function getItemById(itemId:String):PackageItem
		{
			return _itemsById[itemId];
		}
		
		public function getItemByName(resName:String):PackageItem
		{
			return _itemsByName[resName];
		}
		
		private function getXMLDesc(file:String):XML
		{
			var ignoreWhitespace:Boolean = XML.ignoreWhitespace;
			XML.ignoreWhitespace = true;
			var ret:XML = new XML(_reader.readDescFile(file));
			XML.ignoreWhitespace = ignoreWhitespace;
			return ret;
		}
		
		public function getItemRaw(item:PackageItem):ByteArray
		{
			return _reader.readResFile(item.file);
		}
		
		public function getImage(resName:String):BitmapData
		{
			var pi:PackageItem = _itemsByName[resName];
			if(pi)
				return pi.image;
			else
				return null;
		}
		
		public function getPixelHitTestData(itemId:String):PixelHitTestData
		{
			return _hitTestDatas[itemId];
		}
		
		public function getComponentData(item:PackageItem):XML
		{
			if(!item.componentData)
			{
				var xml:XML = getXMLDesc(item.id+".xml");
				item.componentData = xml;
				
				loadComponentChildren(item);
				translateComponent(item);
			}
			
			return item.componentData;
		}
		
		private function loadComponentChildren(item:PackageItem):void
		{
			var listNode:XML = item.componentData.displayList[0];
			if (listNode != null)
			{
				var col:XMLList = listNode.elements();
				var dcnt:int = col.length();
				item.displayList = new Vector.<DisplayListItem>(dcnt);
				var di:DisplayListItem;
				for (var i:int = 0; i < dcnt; i++)
				{
					var cxml:XML = col[i];
					var tagName:String = cxml.name().localName;
					
					var src:String = cxml.@src;
					if (src)
					{
						var pkgId:String = cxml.@pkg;
						var pkg:UIPackage;
						if (pkgId && pkgId != item.owner.id)
							pkg = UIPackage.getById(pkgId);
						else
							pkg = item.owner;
						
						var pi:PackageItem = pkg != null ? pkg.getItemById(src) : null;
						if (pi != null)
							di = new DisplayListItem(pi, null);
						else
							di = new DisplayListItem(null, tagName);
					}
					else
					{
						if (tagName == "text" && cxml.@input=="true")
							di = new DisplayListItem(null, "inputtext");
						else
							di = new DisplayListItem(null, tagName);
					}
					
					di.desc = cxml;
					item.displayList[i] = di;
				}
			}
			else
				item.displayList =new Vector.<DisplayListItem>(0);
		}
		
		private function translateComponent(item:PackageItem):void
		{
			if(_stringsSource==null)
				return;
			
			var strings:Object = _stringsSource[this.id + item.id];
			if(strings==null)
				return;

			var cnt:int = item.displayList.length;
			var value:*;
			var cxml:XML, dxml:XML;
			for(var i:int=0;i<cnt;i++)
			{
				cxml = item.displayList[i].desc;
				var ename:String = cxml.name().localName;
				var elementId:String = cxml.@id;
				
				if(cxml.@tooltips.length()>0)
				{
					value = strings[elementId+"-tips"];
					if(value!=undefined)
						cxml.@tooltips = value;
				}
				
				dxml = cxml.gearText[0];
				if (dxml)
				{
					value = strings[elementId+"-texts"];
					if(value!=undefined)
						dxml.@values = value;
					
					value = strings[elementId+"-texts_def"];
					if(value!=undefined)
						dxml.@default = value;
				}
				
				if(ename=="text" || ename=="richtext")
				{
					value = strings[elementId];
					if(value!=undefined)
						cxml.@text = value;
					value = strings[elementId+"-prompt"];
					if(value!=undefined)
						cxml.@prompt = value;
				}
				else if(ename=="list")
				{
					var items:XMLList = cxml.item;
					var j:int = 0;
					for each(var exml:XML in items)
					{
						value = strings[elementId+"-"+j];
						if(value!=undefined)
							exml.@title = value;
						j++;
					}
				}
				else if(ename=="component")
				{
					dxml = cxml.Button[0];
					if(dxml)
					{
						value = strings[elementId];
						if(value!=undefined)
							dxml.@title = value;
						value = strings[elementId+"-0"];
						if(value!=undefined)
							dxml.@selectedTitle = value;
						continue;
					}
					
					dxml = cxml.Label[0];
					if(dxml)
					{
						value = strings[elementId];
						if(value!=undefined)
							dxml.@title = value;
						value = strings[elementId+"-prompt"];
						if(value!=undefined)
							dxml.@prompt = value;
						continue;
					}

					dxml = cxml.ComboBox[0];
					if(dxml)
					{
						value = strings[elementId];
						if(value!=undefined)
							dxml.@title = value;
						
						items = dxml.item;
						j = 0;
						for each(exml in items)
						{
							value = strings[elementId+"-"+j];
							if(value!=undefined)
								exml.@title = value;
							j++;
						}
						continue;
					}
				}
			}
		}
		
		public function getSound(item:PackageItem):Sound
		{
			if(!item.loaded)
				loadSound(item);
			return item.sound;
		}
		
		public function addCallback(resName:String, callback:Function):void
		{
			var pi:PackageItem = _itemsByName[resName];
			if(pi)
				addItemCallback(pi, callback);
		}
		
		public function removeCallback(resName:String, callback:Function):void
		{
			var pi:PackageItem = _itemsByName[resName];
			if(pi)
				removeItemCallback(pi, callback);
		}
		
		public function addItemCallback(pi:PackageItem, callback:Function):void
		{
			pi.lastVisitTime = getTimer();
			if(pi.type==PackageItemType.Image)
			{
				if(pi.loaded)
				{
					GTimers.inst.add(0, 1, callback);
					return;	
				}
				
				pi.addCallback(callback);
				if(pi.loading)
					return;
				
				loadImage(pi);
			}
			else if(pi.type==PackageItemType.MovieClip)
			{
				if(pi.loaded)
				{
					GTimers.inst.add(0, 1, callback);
					return;	
				}
				
				pi.addCallback(callback);
				if(pi.loading)
					return;
				
				loadMovieClip(pi);
			}
			else if(pi.type==PackageItemType.Swf)
			{
				pi.addCallback(callback);
				loadSwf(pi);
			}
			else if(pi.type==PackageItemType.Sound)
			{
				if(!pi.loaded)
					loadSound(pi);
				
				GTimers.inst.add(0, 1, callback);
			}
		}
		
		public function removeItemCallback(pi:PackageItem, callback:Function):void
		{
			pi.removeCallback(callback);
		}
		
		private function loadImage(pi:PackageItem):void
		{
			var ba:ByteArray = _reader.readResFile(pi.file);
			var loader:PackageItemLoader = new PackageItemLoader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __imageLoaded);
			loader.loadBytes(ba);
			
			loader.item = pi;
			pi.loading = 1;
			_loadingQueue.push(loader);
		}
		
		private function __imageLoaded(evt:Event):void
		{
			var loader:PackageItemLoader = PackageItemLoader(LoaderInfo(evt.currentTarget).loader);
			var i:int = _loadingQueue.indexOf(loader);
			if(i==-1)
				return;
			
			_loadingQueue.splice(i, 1);
			
			var pi:PackageItem = loader.item; 
			pi.image = Bitmap(loader.content).bitmapData;
			pi.completeLoading();
		}
		
		private function loadSwf(pi:PackageItem):void
		{
			var ba:ByteArray = _reader.readResFile(pi.file);
			var loader:PackageItemLoader = new PackageItemLoader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __swfLoaded);
			var context:LoaderContext = new LoaderContext();
			context.allowCodeImport = true;
			loader.loadBytes(ba, context);
			
			loader.item = pi;
			_loadingQueue.push(loader);
		}
		
		private function __swfLoaded(evt:Event):void
		{
			var loader:PackageItemLoader = PackageItemLoader(LoaderInfo(evt.currentTarget).loader);
			var i:int = _loadingQueue.indexOf(loader);
			if(i==-1)
				return;
			
			_loadingQueue.splice(i, 1);
			
			var pi:PackageItem = loader.item;
			var callback:Function = pi.callbacks.pop();
			if(callback!=null)
				callback(loader.content);
		}
		
		private function loadMovieClip(item:PackageItem):void
		{
			var xml:XML = getXMLDesc(item.id + ".xml");
			var str:String;
			var arr:Array;
			str = xml.@interval;
			if (str != null)
				item.interval = parseInt(str);
			str = xml.@swing;
			if (str != null)
				item.swing = str=="true";
			str = xml.@repeatDelay;
			if (str != null)
				item.repeatDelay = parseInt(str);
			
			var frameCount:int = parseInt(xml.@frameCount);
			item.frames = new Vector.<Frame>(frameCount);
			var frameNodes:XMLList = xml.frames.elements();
			for (var i:int = 0; i < frameCount; i++)
			{
				var frame:Frame = new Frame();
				var frameNode:XML = frameNodes[i];
				str = frameNode.@rect;
				arr = str.split(",");
				frame.rect = new Rectangle(parseInt(arr[0]), parseInt(arr[1]), parseInt(arr[2]), parseInt(arr[3]));
				str = frameNode.@addDelay;
				frame.addDelay = parseInt(str);
				item.frames[i] = frame;
				
				if (frame.rect.width == 0)
					continue;
				
				str = frameNode.@sprite;
				if (str)
					str = item.id + "_" + str + ".png";
				else				
					str = item.id + "_" + i + ".png";
				var ba:ByteArray = _reader.readResFile(str);
				if(ba)
				{
					var loader:FrameLoader = new FrameLoader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __frameLoaded);
					loader.loadBytes(ba);
					
					loader.item = item;
					loader.frame = frame;
					_loadingQueue.push(loader);
					item.loading++;
				}
			}
		}
		
		private function __frameLoaded(evt:Event):void
		{
			var loader:FrameLoader = FrameLoader(evt.currentTarget.loader);
			var i:int = _loadingQueue.indexOf(loader);
			if(i==-1)
				return;
			
			_loadingQueue.splice(i, 1);
			
			var pi:PackageItem = loader.item;
			var frame:Frame = loader.frame;
			frame.image = Bitmap(loader.content).bitmapData;
			pi.loading--;
			if(pi.loading==0)
				pi.completeLoading();
		}
		
		private function loadSound(item:PackageItem):void
		{
			var sound:Sound = new Sound();
			var ba:ByteArray = _reader.readResFile(item.file);
			sound.loadCompressedDataFromByteArray(ba, ba.length);
			item.sound = sound;
			item.loaded = true;
		}
		
		private function loadFont(item:PackageItem):void
		{
			var font:BitmapFont = new BitmapFont();
			font.id = "ui://"+this.id+item.id;
			var str:String = _reader.readDescFile(item.id + ".fnt");
			
			var lines:Array = str.split("\n");
			var lineCount:int = lines.length;
			var i:int;
			var kv:Object = {};
			var ttf:Boolean = false;
			var size:int = 0;
			var xadvance:int = 0;
			var resizable:Boolean = false;
			var colored:Boolean = false;
			var lineHeight:int = 0;
			
			for(i=0;i<lineCount;i++)
			{
				str = lines[i];
				if(str.length==0)
					continue;
				
				str = ToolSet.trim(str);
				var arr:Array = str.split(" ");
				for(var j:int=1;j<arr.length;j++)
				{
					var arr2:Array = arr[j].split("=");
					kv[arr2[0]] = arr2[1];
				}
				
				str = arr[0];
				if(str=="char")
				{
					var bg:BMGlyph = new BMGlyph();
					bg.x = kv.x;
					bg.y = kv.y;
					bg.offsetX = kv.xoffset;
					bg.offsetY = kv.yoffset;
					bg.width = kv.width;
					bg.height = kv.height;
					bg.advance = kv.xadvance;					
					bg.channel = font.translateChannel(kv.chnl);
					
					if(!ttf)
					{
						if(kv.img)
						{
							var charImg:PackageItem = _itemsById[kv.img];
							if(charImg!=null)
							{
								bg.imageItem = charImg;
								bg.width = charImg.width;
								bg.height = charImg.height;
								loadImage(charImg);
							}
						}
					}
					
					if(ttf)
						bg.lineHeight = lineHeight;
					else
					{
						if(bg.advance==0)
						{
							if(xadvance==0)
								bg.advance = bg.offsetX + bg.width;
							else
								bg.advance = xadvance;
						}
						bg.lineHeight = bg.offsetY < 0 ? bg.height : (bg.offsetY + bg.height);
						if(size>0 && bg.lineHeight<size)
							bg.lineHeight = size;
					}
					
					font.glyphs[String.fromCharCode(kv.id)] = bg;
				}
				else if(str=="info")
				{
					ttf = kv.face!=null;
					colored = ttf;
					size = kv.size;
					resizable = kv.resizable=="true";
					if(kv.colored!=undefined)
						colored = kv.colored=="true";
					if(ttf)
					{
						var ba:ByteArray = _reader.readResFile(item.id+".png");
						var loader:PackageItemLoader = new PackageItemLoader();
						loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __fontAtlasLoaded);
						loader.loadBytes(ba);
						
						loader.item = item;
						_loadingQueue.push(loader);
					}
				}
				else if(str=="common")
				{
					lineHeight = kv.lineHeight;
					if(size==0)
						size = lineHeight;
					else if(lineHeight==0)
						lineHeight = size;
					xadvance = kv.xadvance;
				}
			}
			
			if(size==0 && bg)
				size = bg.height;
			
			font.ttf = ttf;
			font.size = size;
			font.resizable = resizable;
			font.colored = colored;
			item.bitmapFont = font;
		}
		
		private function __fontAtlasLoaded(evt:Event):void
		{
			var loader:PackageItemLoader = PackageItemLoader(LoaderInfo(evt.currentTarget).loader);
			var i:int = _loadingQueue.indexOf(loader);
			if(i==-1)
				return;
			
			_loadingQueue.splice(i, 1);
			
			var pi:PackageItem = loader.item;
			pi.bitmapFont.atlas = Bitmap(loader.content).bitmapData;
		}
	}
}

import flash.display.Loader;

import fairygui.PackageItem;
import fairygui.display.Frame;

class PackageItemLoader extends Loader
{
	public function PackageItemLoader():void
	{
		
	}
	public var item:PackageItem;
}

class FrameLoader extends Loader
{
	public function FrameLoader():void
	{
		
	}
	
	public var item:PackageItem;
	public var frame:Frame;
}
