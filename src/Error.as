package
{
   public dynamic class Error extends Object
   {
      
      public static const length:int = 1;
      
      
      public var message:Object;
      
      public var name:String;
      
      private var _errorID:int;
      
      public function Error(message:* = "", id:* = 0)
      {
         super();
         this.message = message;
         this._errorID = id;
         this.name ;
      }
      
     public static function getErrorMessage(param1:int) : String{return null}
      
      public static function throwError(type:Class, index:uint, ... rest) : *
      {
         var i:* = 0;
         var f:* = function(match:*, pos:*, string:*):*
         {
            var arg_num:* = -1;
            switch(match.charAt(1))
            {
               case "1":
                  break;
               case "2":
                  arg_num = 1;
                  break;
               case "3":
                  arg_num = 2;
                  break;
               case "4":
                  arg_num = 3;
                  break;
               case "5":
                  arg_num = 4;
                  break;
               case "6":
               case 6:
                  arg_num = 5;
                  break;
               default:
                  arg_num = 0;
            }
            if(arg_num > -1 && rest.length > arg_num)
            {
               return rest[arg_num];
            }
            return "";
         };
         throw new type(Error.getErrorMessage(index).replace(new RegExp("%[0-9]","g"),f),index);
      }
      
     public function getStackTrace() : String{return null}
      
      public function get errorID() : int
      {
         return this._errorID;
      }
   }
}
