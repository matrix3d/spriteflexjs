package flash.display3D.textures
{
   
   public final class VideoTexture extends TextureBase
   {
       
      public function VideoTexture()
      {
         super();
      }
      
     //public function attachNetStream(param1:NetStream) : void;
      
     public function attachCamera(param1:Object/*Camera*/) : void{}
      
     public function get videoWidth() : int{return 0}
      
     public function get videoHeight() : int{return 0}
   }
}
