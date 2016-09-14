package flash.text
{
   public final class CSMSettings extends Object
   {
       
      public var fontSize:Number;
      
      public var insideCutoff:Number;
      
      public var outsideCutoff:Number;
      
      public function CSMSettings(fontSize:Number, insideCutoff:Number, outsideCutoff:Number)
      {
         super();
         this.fontSize = fontSize;
         this.insideCutoff = insideCutoff;
         this.outsideCutoff = outsideCutoff;
      }
   }
}
