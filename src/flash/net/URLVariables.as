package flash.net
{
   import flash.utils.*;
   
   public dynamic class URLVariables extends Object
   {
       
      public function URLVariables(source:String = null)
      {
         super();
         if(source != null)
         {
            this.decode(source);
         }
      }
      
      public function decode(source:String) : void
      {
         /*var param:String = null;
         var equalsIndex:* = 0;
         var name:String = null;
         var value:String = null;
         var oldValue:* = undefined;
         var params:Array = source.split("&");
         for(var i:uint = 0; i < params.length; i++)
         {
            param = params[i];
            equalsIndex = param.indexOf("=");
            if(equalsIndex == -1)
            {
               Error.throwError(Error,2101);
            }
            else
            {
               name = this._unescape(param.substr(0,equalsIndex));
               value = this._unescape(param.substr(equalsIndex + 1));
               oldValue = this[name];
               if(oldValue != undefined)
               {
                  if(!(oldValue is Array))
                  {
                     this[name] = oldValue = [oldValue];
                  }
                  oldValue.push(value);
               }
               else
               {
                  this[name] = value;
               }
            }
         }*/
      }
      
      /*public function toString() : String
      {
         var name:String = null;
         var escapedName:String = null;
         var value:* = undefined;
         var i:uint = 0;
         var s:String = "";
         var first:Boolean = true;
         for(name in this)
         {
            escapedName = escapeMultiByte(name);
            value = this[name];
            if(value is Array)
            {
               for(i = 0; i < value.length; i++)
               {
                  if(!first)
                  {
                     s = s + "&";
                  }
                  s = s + escapedName;
                  s = s + "=";
                  s = s + escapeMultiByte(String(value[i]));
                  first = false;
               }
            }
            else
            {
               if(!first)
               {
                  s = s + "&";
               }
               s = s + escapedName;
               s = s + "=";
               s = s + escapeMultiByte(String(value));
               first = false;
            }
         }
         return s;
      }
      
      private function _unescape(value:String) : String
      {
         return unescapeMultiByte(value.replace(new RegExp("\\+","g")," "));
      }*/
   }
}
