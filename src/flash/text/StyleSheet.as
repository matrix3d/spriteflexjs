package flash.text
{
   import flash.events.EventDispatcher;
   
   public dynamic class StyleSheet extends EventDispatcher
   {
       
      private var _css:Object;
      
      public function StyleSheet()
      {
         this._css = {};
         super();
         this._styles = {};
      }
      
      public function getStyle(styleName:String) : Object
      {
         return this._copy(this._css[styleName.toLowerCase()]);
      }
      
      public function setStyle(styleName:String, styleObject:Object) : void
      {
         var lowerStr:String = styleName.toLowerCase();
         this._css[lowerStr] = this._copy(styleObject);
         this.doTransform(lowerStr);
         this._update();
      }
      
      public function clear() : void
      {
         this._css = {};
         this._styles = {};
         this._update();
      }
      
      public function get styleNames() : Array
      {
         var n:Object = null;
         var a:Array = [];
         for(n in this._css)
         {
            a.push(n);
         }
         return a;
      }
      
      public function transform(formatObject:Object) : TextFormat
      {
         if(formatObject == null)
         {
            return null;
         }
         var f:TextFormat = new TextFormat();
         var v:* = formatObject.textAlign;
         if(v)
         {
            f.align = v;
         }
         v = formatObject.fontSize;
         if(v)
         {
            v = parseInt(v,10);
            if(v > 0)
            {
               f.size = v;
            }
         }
         v = formatObject.textDecoration;
         if(v == "none")
         {
            f.underline = false;
         }
         else if(v == "underline")
         {
            f.underline = true;
         }
         v = formatObject.marginLeft;
         if(v)
         {
            f.leftMargin = parseInt(v,10);
         }
         v = formatObject.marginRight;
         if(v)
         {
            f.rightMargin = parseInt(v,10);
         }
         v = formatObject.leading;
         if(v)
         {
            f.leading = parseInt(v,10);
         }
         v = formatObject.kerning;
         if(v == "true")
         {
            f.kerning = 1;
         }
         else if(v == "false")
         {
            f.kerning = 0;
         }
         else
         {
            f.kerning = parseInt(v,10);
         }
         v = formatObject.letterSpacing;
         if(v)
         {
            f.letterSpacing = parseFloat(v);
         }
         v = formatObject.fontFamily;
         if(v)
         {
            f.font = this._parseCSSFontFamily(v);
         }
         v = formatObject.display;
         if(v)
         {
            f.display = v;
         }
         v = formatObject.fontWeight;
         if(v == "bold")
         {
            f.bold = true;
         }
         else if(v == "normal")
         {
            f.bold = false;
         }
         v = formatObject.fontStyle;
         if(v == "italic")
         {
            f.italic = true;
         }
         else if(v == "normal")
         {
            f.italic = false;
         }
         v = formatObject.textIndent;
         if(v)
         {
            f.indent = parseInt(v,10);
         }
         v = formatObject.color;
         if(v)
         {
            v = this._parseColor(v);
            if(v != null)
            {
               f.color = v;
            }
         }
         return f;
      }
      
      public function parseCSS(CSSText:String) : void
      {
         var n:String = null;
         var r:Object = this._parseCSSInternal(CSSText);
         if(typeof r == "null")
         {
            return;
         }
         for(n in r)
         {
            this._css[n] = this._copy(r[n]);
            this.doTransform(n);
         }
         this._update();
      }
      
       private function get _styles() : Object{return null}
      
       private function set _styles(param1:Object) : void{/**/}
      
      private function doTransform(n:String) : void
      {
         var f:TextFormat = this.transform(this._css[n]);
         this._styles[n] = f;
      }
      
      private function _copy(o:Object) : Object
      {
         var n:Object = null;
         if(typeof o != "object")
         {
            return null;
         }
         var r:Object = {};
         for(n in o)
         {
            r[n] = o[n];
         }
         return r;
      }
      
       private function _update() : void{/**/}
      
       private function _parseCSSInternal(param1:String) : Object{return null}
      
       private function _parseCSSFontFamily(param1:String) : String{return null}
      
       private function _parseColor(param1:String) : uint{return 0;}
   }
}
