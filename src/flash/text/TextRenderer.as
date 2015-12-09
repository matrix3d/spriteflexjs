package flash.text
{
   [native(methods="auto",cls="TextRendererClass")]
   public final class TextRenderer extends Object
   {
       
      public function TextRenderer()
      {
         super();
      }
      
      [Inspectable(environment="none")]
      native public static function get antiAliasType() : String;
      
      native public static function set antiAliasType(param1:String) : void;
      
      native public static function setAdvancedAntiAliasingTable(param1:String, param2:String, param3:String, param4:Array) : void;
      
      native public static function get maxLevel() : int;
      
      native public static function set maxLevel(param1:int) : void;
      
      native public static function get displayMode() : String;
      
      native public static function set displayMode(param1:String) : void;
   }
}
