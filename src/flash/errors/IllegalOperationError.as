package flash.errors
{
   public dynamic class IllegalOperationError extends Error
   {
       
      public function IllegalOperationError(message:String = "", id:int = 0)
      {
         super(message,id);
      }
   }
}
