//
// D:\sdk\airsdk24\frameworks\libs\player\18.0\playerglobal.swc\flash\filters\ColorMatrixFilter
//
package flash.filters
{
	import flash.filters.BitmapFilter;

	/**
	 * The ColorMatrixFilter class lets you apply a 4 x 5 matrix transformation on the RGBA color and alpha values
	 * of every pixel in the input image to produce a result with a new set of RGBA color and alpha values.
	 * It allows saturation changes, hue rotation, luminance to alpha, and various other effects.
	 * You can apply the filter to any display object (that is, objects that inherit from the DisplayObject class),
	 * such as MovieClip, SimpleButton, TextField, and Video objects, as well as to BitmapData objects.
	 * 
	 *   <p class="- topic/p "><b class="+ topic/ph hi-d/b ">Note:</b> For RGBA values, the most significant byte represents the red channel value, 
	 * followed by green, blue, and then alpha.</p><p class="- topic/p ">To create a new color matrix filter, use the syntax <codeph class="+ topic/ph pr-d/codeph ">new ColorMatrixFilter()</codeph>. 
	 * The use of filters depends on the object to which you apply the filter:</p><ul class="- topic/ul "><li class="- topic/li ">To apply filters to movie clips, text fields, buttons, and video, use the
	 * <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property (inherited from DisplayObject). Setting the <codeph class="+ topic/ph pr-d/codeph ">filters</codeph>
	 * property of an object does not modify the object, and you can remove the filter by clearing the
	 * <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property. </li><li class="- topic/li ">To apply filters to BitmapData objects, use the <codeph class="+ topic/ph pr-d/codeph ">BitmapData.applyFilter()</codeph> method.
	 * Calling <codeph class="+ topic/ph pr-d/codeph ">applyFilter()</codeph> on a BitmapData object takes the source BitmapData object
	 * and the filter object and generates a filtered image as a result.</li></ul><p class="- topic/p ">If you apply a filter to a display object, the <codeph class="+ topic/ph pr-d/codeph ">cacheAsBitmap</codeph> property of the
	 * display object is set to <codeph class="+ topic/ph pr-d/codeph ">true</codeph>. If you remove all filters, the original value of
	 * <codeph class="+ topic/ph pr-d/codeph ">cacheAsBitmap</codeph> is restored.</p><p class="- topic/p ">A filter is not applied if the resulting image exceeds the maximum dimensions.
	 * In  AIR 1.5 and Flash Player 10, the maximum is 8,191 pixels in width or height, 
	 * and the total number of pixels cannot exceed 16,777,215 pixels. (So, if an image is 8,191 pixels 
	 * wide, it can only be 2,048 pixels high.) In Flash Player 9 and earlier and AIR 1.1 and earlier, 
	 * the limitation is  2,880 pixels in height and 2,880 pixels in width.
	 * For example, if you zoom in on a large movie clip with a filter applied, the
	 * filter is turned off if the resulting image reaches the maximum dimensions.</p>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example applies different color matrix filters to
	 * an image file. The filter constructor calls
	 * <codeph class="+ topic/ph pr-d/codeph ">buildChild()</codeph> four times to load and display four instances of the image.
	 * The first call to <codeph class="+ topic/ph pr-d/codeph ">buildChild()</codeph> takes <codeph class="+ topic/ph pr-d/codeph ">null</codeph> as an argument,
	 * applying no filter to the first instance. Each subsequent call to <codeph class="+ topic/ph pr-d/codeph ">buildChild()</codeph>
	 * takes as an argument a function that applies a different color matrix filter to each 
	 * subsequent instance of the image.
	 * <p class="- topic/p ">The <codeph class="+ topic/ph pr-d/codeph ">buildChild()</codeph> function creates a new Loader object named
	 * <codeph class="+ topic/ph pr-d/codeph ">loader</codeph>. For each call to <codeph class="+ topic/ph pr-d/codeph ">buildChild()</codeph>, 
	 * attach an event listener to the Loader object to listen for <codeph class="+ topic/ph pr-d/codeph ">complete</codeph> events,
	 * which are handled by the function passed to <codeph class="+ topic/ph pr-d/codeph ">buildChild()</codeph>.</p><p class="- topic/p ">The <codeph class="+ topic/ph pr-d/codeph ">applyRed()</codeph>, <codeph class="+ topic/ph pr-d/codeph ">applyGreen()</codeph>, and <codeph class="+ topic/ph pr-d/codeph ">applyBlue()</codeph>
	 * functions use different values for the <codeph class="+ topic/ph pr-d/codeph ">matrix</codeph> array to achieve different
	 * effects.</p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Note</b>: For best results, use an image approximately 80 pixels in width.
	 * The name and location of the image file should match the value you pass to the 
	 * <codeph class="+ topic/ph pr-d/codeph ">url</codeph> property. For example, the value passed to <codeph class="+ topic/ph pr-d/codeph ">url</codeph> in the example
	 * points to an image file named "Image.jpg" that is in the same directory as your SWF file.
	 * </p><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * 
	 *   package {
	 * import flash.display.DisplayObject;
	 * import flash.display.Loader;
	 * import flash.display.Sprite;
	 * import flash.events.Event;
	 * import flash.events.IOErrorEvent;
	 * import flash.filters.ColorMatrixFilter;
	 * import flash.net.URLRequest;
	 * 
	 *   public class ColorMatrixFilterExample extends Sprite {
	 * private var size:uint  = 140;
	 * private var url:String = "Image.jpg";
	 * 
	 *   public function ColorMatrixFilterExample() {
	 * buildChild(null);
	 * buildChild(applyRed);
	 * buildChild(applyGreen);
	 * buildChild(applyBlue);
	 * }
	 * 
	 *   private function buildChild(loadHandler:Function):void {
	 * var loader:Loader = new Loader();
	 * loader.x = numChildren * size;
	 * loader.y = size;
	 * loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
	 * if (loadHandler != null) {
	 * loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadHandler);
	 * }
	 * 
	 *   var request:URLRequest = new URLRequest(url);
	 * loader.load(request);
	 * addChild(loader);
	 * }
	 * 
	 *   private function applyRed(event:Event):void {
	 * var child:DisplayObject = DisplayObject(event.target.loader);
	 * var matrix:Array = new Array();
	 * matrix = matrix.concat([1, 0, 0, 0, 0]); // red
	 * matrix = matrix.concat([0, 0, 0, 0, 0]); // green
	 * matrix = matrix.concat([0, 0, 0, 0, 0]); // blue
	 * matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
	 * 
	 *   applyFilter(child, matrix);
	 * }
	 * 
	 *   private function applyGreen(event:Event):void {
	 * var child:DisplayObject = DisplayObject(event.target.loader);
	 * var matrix:Array = new Array();
	 * matrix = matrix.concat([0, 0, 0, 0, 0]); // red
	 * matrix = matrix.concat([0, 1, 0, 0, 0]); // green
	 * matrix = matrix.concat([0, 0, 0, 0, 0]); // blue
	 * matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
	 * 
	 *   applyFilter(child, matrix);
	 * }
	 * 
	 *   private function applyBlue(event:Event):void {
	 * var child:DisplayObject = DisplayObject(event.target.loader);
	 * var matrix:Array = new Array();
	 * matrix = matrix.concat([0, 0, 0, 0, 0]); // red
	 * matrix = matrix.concat([0, 0, 0, 0, 0]); // green
	 * matrix = matrix.concat([0, 0, 1, 0, 0]); // blue
	 * matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
	 * 
	 *   applyFilter(child, matrix);
	 * }
	 * 
	 *   private function applyFilter(child:DisplayObject, matrix:Array):void {
	 * var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
	 * var filters:Array = new Array();
	 * filters.push(filter);
	 * child.filters = filters;
	 * }
	 * 
	 *   private function ioErrorHandler(event:IOErrorEvent):void {
	 * trace("Unable to load image: " + url);
	 * }
	 * }
	 * }
	 * </codeblock>
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 */
	public final class ColorMatrixFilter extends BitmapFilter
	{
		/**
		 * An array of 20 items for 4 x 5 color transform. The matrix property cannot
		 * be changed by directly modifying its value (for example, myFilter.matrix[2] = 1;).
		 * Instead, you must get a reference to the array, make the change to the reference, and reset the
		 * value.
		 * 
		 *   The color matrix filter separates each source pixel into its red, green, blue,
		 * and alpha components as srcR, srcG, srcB, srcA. To calculate the result of each of
		 * the four channels, the value of each pixel in the image is multiplied by the values in
		 * the transformation matrix. An offset, between -255 and 255, can optionally be added
		 * to each result (the fifth item in each row of the matrix). The filter combines each 
		 * color component back into a single pixel and writes out the result. In the following formula,
		 * a[0] through a[19] correspond to entries 0 through 19 in the 20-item array that is
		 * passed to the matrix property:
		 * redResult   = (a[0]  ~~ srcR) + (a[1]  ~~ srcG) + (a[2]  ~~ srcB) + (a[3]  ~~ srcA) + a[4]
		 * greenResult = (a[5]  ~~ srcR) + (a[6]  ~~ srcG) + (a[7]  ~~ srcB) + (a[8]  ~~ srcA) + a[9]
		 * blueResult  = (a[10] ~~ srcR) + (a[11] ~~ srcG) + (a[12] ~~ srcB) + (a[13] ~~ srcA) + a[14]
		 * alphaResult = (a[15] ~~ srcR) + (a[16] ~~ srcG) + (a[17] ~~ srcB) + (a[18] ~~ srcA) + a[19]
		 * For each color value in the array, a value of 1 is equal to 100% of that channel 
		 * being sent to the output, preserving the value of the color channel.The calculations are performed on unmultiplied color values. If the input graphic consists
		 * of premultiplied color values, those values are automatically converted into unmultiplied color
		 * values for this operation.Two optimized modes are available:Alpha only. When you pass to the filter a matrix that adjusts only the alpha component, as shown here, the filter optimizes its performance:
		 * 1 0 0 0 0
		 * 0 1 0 0 0
		 * 0 0 1 0 0
		 * 0 0 0 N 0  (where N is between 0.0 and 1.0)
		 * Faster version. Available only with SSE/AltiVec accelerator-enabled processors,
		 * such as Intel® Pentium® 3 and later and Apple® G4 and later. The accelerator is used when the multiplier terms are in the range
		 * -15.99 to 15.99 and the adder terms a[4], a[9], a[14], and a[19] are in the range -8000 to 8000.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example creates a new ColorMatrixFilter instance and then
		 *   changes its <code>matrix</code> property. The <code>matrix</code> property cannot be changed by directly modifying
		 *   its value (for example, <code>clonedFilter.matrix[2] = 1;</code>). Instead, you must
		 *   get a reference to the array, make the change to the reference, and reset the
		 *   value using <code>clonedFilter.matrix = changedMatrix</code>.
		 *   <listing version="2.0">
		 *   import flash.filters.ColorMatrixFilter;
		 *   
		 *     var matrix:Array = new Array();
		 *   matrix = matrix.concat([1, 0, 0, 0, 0]); // red
		 *   matrix = matrix.concat([0, 1, 0, 0, 0]); // green
		 *   matrix = matrix.concat([0, 0, 1, 0, 0]); // blue
		 *   matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
		 *   
		 *     var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
		 *   trace("filter: " + filter.matrix);
		 *   var changedMatrix:Array = filter.matrix;
		 *   changedMatrix[2] = 1;
		 *   filter.matrix = changedMatrix;
		 *   trace("filter: " + filter.matrix);
		 *   </listing>
		 * @throws	TypeError The Array is null when being set
		 */
		public function get matrix () : Array{
			return null;
		}
		public function set matrix (value:Array) : void{
			
		}

		/**
		 * Returns a copy of this filter object.
		 * @return	A new ColorMatrixFilter instance with all of the same properties as the original
		 *   one.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example creates a new ColorMatrixFilter instance and then
		 *   clones it using the <code>clone</code> method. The <code>matrix</code> property cannot be changed directly (for example,
		 *   <code>clonedFilter.matrix[2] = 1;</code>). Instead, you must get a reference
		 *   to the array, make the change, and reset the value using
		 *   <code>clonedFilter.matrix = changedMatrix</code>.
		 *   <listing version="2.0">
		 *   import flash.filters.ColorMatrixFilter;
		 *   
		 *     var matrix:Array = new Array();
		 *   matrix = matrix.concat([1, 0, 0, 0, 0]); // red
		 *   matrix = matrix.concat([0, 1, 0, 0, 0]); // green
		 *   matrix = matrix.concat([0, 0, 1, 0, 0]); // blue
		 *   matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
		 *   
		 *     var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
		 *   trace("filter:       " + filter.matrix);
		 *   
		 *     var clonedFilter:ColorMatrixFilter = filter.clone();
		 *   matrix = clonedFilter.matrix;
		 *   matrix[2] = 1;
		 *   clonedFilter.matrix = matrix;
		 *   trace("clonedFilter: " + clonedFilter.matrix);
		 *   </listing>
		 */
		/*public function clone () : flash.filters.BitmapFilter{
			
		}*/

		/**
		 * Initializes a new ColorMatrixFilter instance with the specified parameters.
		 * @param	matrix	An array of 20 items arranged as a 4 x 5 matrix.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 */
		public function ColorMatrixFilter (matrix:Array = null){
			
		}
	}
}
