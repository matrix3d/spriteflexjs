package flash.display
{
	/**
	 * The Scene class includes properties for identifying the name, labels, and number of frames 
	 * in a scene. A Scene object instance is created in Flash Professional, not by
	 * writing ActionScript code.
	 * The MovieClip class includes a <codeph class="+ topic/ph pr-d/codeph ">currentScene</codeph> property, which is 
	 * a Scene object that identifies the scene in which the playhead is located in the 
	 * timeline of the MovieClip instance. The <codeph class="+ topic/ph pr-d/codeph ">scenes</codeph> property of the 
	 * MovieClip class is an array of Scene objects. Also, the <codeph class="+ topic/ph pr-d/codeph ">gotoAndPlay()</codeph> 
	 * and <codeph class="+ topic/ph pr-d/codeph ">gotoAndStop()</codeph> methods of the MovieClip class use Scene objects as 
	 * parameters.
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 * @playerversion	Lite 4
	 */
	public final class Scene extends Object
	{
		private var _labels:Array = [];
		private var _name:String = "Scene 1";
		private var _numFrames:int = 1;
		
		/**
		 * An array of FrameLabel objects for the scene. Each FrameLabel object contains
		 * a frame property, which specifies the frame number corresponding to the 
		 * label, and a name property.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get labels():Array { return _labels; }

		/**
		 * The name of the scene.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get name():String { return _name; }

		/**
		 * The number of frames in the scene.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function get numFrames():int { return _numFrames; }

		public function Scene (name:String, labels:Array, numFrames:int)
		{
			_name = name;
			_labels = labels;
			_numFrames = numFrames;
		}
	}
}