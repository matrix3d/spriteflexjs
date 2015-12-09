package flash.text
{
   [ExcludeClass]
   public class TextRun extends Object
   {
       
      public var beginIndex:int;
      
      public var endIndex:int;
      
      public var textFormat:TextFormat;
      
      public function TextRun(beginIndex:int, endIndex:int, textFormat:TextFormat)
      {
         super();
         this.beginIndex = beginIndex;
         this.endIndex = endIndex;
         this.textFormat = textFormat;
      }
   }
}
