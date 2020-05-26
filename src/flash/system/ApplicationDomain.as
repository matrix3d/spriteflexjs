package flash.system {
    import flash.utils.ByteArray;
    
    public final class ApplicationDomain {
         
        private static var _currentDomain:ApplicationDomain = new ApplicationDomain;
        public function ApplicationDomain(parentDomain:ApplicationDomain = null) {
        }
        
         public static function get currentDomain() : ApplicationDomain{
			 return _currentDomain;
		 }
        
         public static function get MIN_DOMAIN_MEMORY_LENGTH() : uint{
			 return 0;
		 }
        
        
         public function get parentDomain() : ApplicationDomain{
			 return null;
		 }
        
         public function getDefinition(param1:String) : Object{
			 return null;
		 }
        
         public function hasDefinition(param1:String) : Boolean{
			 return false;
		 }
        
         public function getQualifiedDefinitionNames() : Vector.<String>{
			 return null;
		 }
        
         public function get domainMemory() : ByteArray{
			 return null;
		 }
        
         public function set domainMemory(param1:ByteArray) : void {
		 }
    }
}