package flash.text
{
   [native(instance="FontObject",methods="auto",cls="FontClass")]
   public class Font extends Object
   {
       
      public function Font()
      {
         super();
      }
      
      native public static function enumerateFonts(param1:Boolean = false) : Array;
      
      native public static function registerFont(param1:Class) : void;
      
      native public function get fontName() : String;
      
      native public function get fontStyle() : String;
      
      native public function get fontType() : String;
      
      native public function hasGlyphs(param1:String) : Boolean;
   }
}
