package flash.text
{
   import flash.display.DisplayObject;
   
   [native(instance="StaticTextObject",methods="auto",cls="StaticTextClass",construct="restricted-check",gc="exact")]
   public final class StaticText extends DisplayObject
   {
       
      public function StaticText()
      {
         super();
      }
      
      native public function get text() : String;
   }
}
