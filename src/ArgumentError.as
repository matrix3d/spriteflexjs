package
{
   public dynamic class ArgumentError extends Error
   {
      
      public static const length:int = 1;
      
      public function ArgumentError(message:* = "", id:* = 0)
      {
         super(message,id);
         this.name = "ArgumentError";
      }
   }
}
