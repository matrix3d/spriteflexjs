package flash.errors
{
   public dynamic class IOError extends Error
   {
       
      public function IOError(message:String = "", id:int = 0)
      {
         super(message,id);
      }
   }
}
