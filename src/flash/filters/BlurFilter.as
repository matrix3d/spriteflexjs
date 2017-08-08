//
// D:\sdk\airsdk24\frameworks\libs\player\18.0\playerglobal.swc\flash\filters\BlurFilter
//
package flash.filters
{
	import flash.filters.BitmapFilter;

	/**
	 * The BlurFilter class lets you apply a blur visual effect to display objects.
	 * A blur effect softens the details of an image. You can produce blurs that
	 * range from a softly unfocused look to a Gaussian blur, a hazy
	 * appearance like viewing an image through semi-opaque glass. When the <codeph class="+ topic/ph pr-d/codeph ">quality</codeph> property
	 * of this filter is set to low, the result is a softly unfocused look.
	 * When the <codeph class="+ topic/ph pr-d/codeph ">quality</codeph> property is set to high, it approximates a Gaussian blur
	 * filter.  You can apply the filter to any display object (that is, objects that inherit 
	 * from the DisplayObject class), 
	 * such as MovieClip, SimpleButton, TextField, and Video objects, as well as to BitmapData objects.
	 * 
	 *   <p class="- topic/p ">To create a new filter, use the constructor <codeph class="+ topic/ph pr-d/codeph ">new BlurFilter()</codeph>. 
	 * The use of filters depends on the object to which you apply the filter:</p><ul class="- topic/ul "><li class="- topic/li ">To apply filters to movie clips, text fields, buttons, and video, use the
	 * <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property (inherited from DisplayObject). Setting the <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> 
	 * property of an object does not modify the object, and you can remove the filter by clearing the
	 * <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property. </li><li class="- topic/li ">To apply filters to BitmapData objects, use the <codeph class="+ topic/ph pr-d/codeph ">BitmapData.applyFilter()</codeph> method.
	 * Calling <codeph class="+ topic/ph pr-d/codeph ">applyFilter()</codeph> on a BitmapData object takes the source BitmapData object 
	 * and the filter object and generates a filtered image as a result.</li></ul><p class="- topic/p ">If you apply a filter to a display object, the <codeph class="+ topic/ph pr-d/codeph ">cacheAsBitmap</codeph> property of the 
	 * display object is set to <codeph class="+ topic/ph pr-d/codeph ">true</codeph>. If you remove all filters, the original value of 
	 * <codeph class="+ topic/ph pr-d/codeph ">cacheAsBitmap</codeph> is restored.</p><p class="- topic/p ">This filter supports Stage scaling. However, it does not support general scaling, 
	 * rotation, and skewing. If the object itself is scaled (<codeph class="+ topic/ph pr-d/codeph ">scaleX</codeph> and <codeph class="+ topic/ph pr-d/codeph ">scaleY</codeph> are not set to 100%), the 
	 * filter effect is not scaled. It is scaled only when the user zooms in on the Stage.</p><p class="- topic/p ">A filter is not applied if the resulting image exceeds the maximum dimensions.
	 * In  AIR 1.5 and Flash Player 10, the maximum is 8,191 pixels in width or height, 
	 * and the total number of pixels cannot exceed 16,777,215 pixels. (So, if an image is 8,191 pixels 
	 * wide, it can only be 2,048 pixels high.) In Flash Player 9 and earlier and AIR 1.1 and earlier, 
	 * the limitation is 2,880 pixels in height and 2,880 pixels in width.
	 * If, for example, you zoom in on a large movie clip with a filter applied, the filter is 
	 * turned off if the resulting image exceeds the maximum dimensions.</p>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example creates a dark yellow square and applies a Gaussian-style blur filter
	 * to it. The general workflow for this example is as follows:
	 * <ol class="- topic/ol "><li class="- topic/li ">Import the required classes.</li><li class="- topic/li ">Declare three properties used in the <codeph class="+ topic/ph pr-d/codeph ">draw()</codeph> function, which draws the object
	 * to which the blur filter is applied. </li><li class="- topic/li ">Create the <codeph class="+ topic/ph pr-d/codeph ">BlurFilterExample()</codeph> constructor function, which does the following:
	 * <ul class="- topic/ul "><li class="- topic/li ">Calls the <codeph class="+ topic/ph pr-d/codeph ">draw()</codeph> function, which is declared later.</li><li class="- topic/li ">Declares a <codeph class="+ topic/ph pr-d/codeph ">filter</codeph> variable as a BitmapFilter object
	 * and assigns it to the return of a call to <codeph class="+ topic/ph pr-d/codeph ">getBitmapFilter()</codeph>.</li><li class="- topic/li ">Creates a new Array object <codeph class="+ topic/ph pr-d/codeph ">myFilters</codeph> and adds <codeph class="+ topic/ph pr-d/codeph ">filter</codeph> to
	 * the array, and assigns <codeph class="+ topic/ph pr-d/codeph ">myFilters</codeph> to the <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property of 
	 * the BlurFilterExample object. This applies all filters found in <codeph class="+ topic/ph pr-d/codeph ">myFilters</codeph>, which in this case
	 * is only <codeph class="+ topic/ph pr-d/codeph ">filter</codeph>.</li></ul></li><li class="- topic/li ">Create the <codeph class="+ topic/ph pr-d/codeph ">getBitmapFilter()</codeph> function to create and set properties for the filter.</li><li class="- topic/li ">Create the <codeph class="+ topic/ph pr-d/codeph ">draw()</codeph> function. This function
	 * uses methods of the Graphics class, accessed through the <codeph class="+ topic/ph pr-d/codeph ">graphics</codeph> property
	 * of the Sprite class, to draw the square.</li></ol><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * 
	 *   package {
	 * import flash.display.Sprite;
	 * import flash.filters.BitmapFilter;
	 * import flash.filters.BitmapFilterQuality;
	 * import flash.filters.BlurFilter;
	 * 
	 *   public class BlurFilterExample extends Sprite {
	 * private var bgColor:uint = 0xFFCC00;
	 * private var size:uint    = 80;
	 * private var offset:uint  = 50;
	 * 
	 *   public function BlurFilterExample() {
	 * draw();
	 * var filter:BitmapFilter = getBitmapFilter();
	 * var myFilters:Array = new Array();
	 * myFilters.push(filter);
	 * filters = myFilters;
	 * }
	 * 
	 *   private function getBitmapFilter():BitmapFilter {
	 * var blurX:Number = 30;
	 * var blurY:Number = 30;
	 * return new BlurFilter(blurX, blurY, BitmapFilterQuality.HIGH);
	 * }
	 * 
	 *   private function draw():void {
	 * graphics.beginFill(bgColor);
	 * graphics.drawRect(offset, offset, size, size);
	 * graphics.endFill();
	 * }
	 * }
	 * }
	 * </codeblock>
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 */
	public final class BlurFilter extends BitmapFilter
	{
		/**
		 * The amount of horizontal blur. Valid values are from 0 to 255 (floating point). The
		 * default value is 4. Values that are a power of 2 (such as 2, 4, 8, 16 and 32) are optimized 
		 * to render more quickly than other values.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example changes the <code>blurX</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BlurFilter;
		 *   var mc:MovieClip = createBlurFilterRectangle("BlurFilterBlurX");
		 *   mc.onRelease = function() {
		 *   var filter:BlurFilter = this.filters[0];
		 *   filter.blurX = 200;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBlurFilterRectangle(name:String):MovieClip {
		 *   var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   rect.beginFill(0x003366);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BlurFilter = new BlurFilter(30, 30, 2);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   rect.filters = filterArray;
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get blurX () : Number{
			return 0;
		}
		public function set blurX (value:Number) : void{
			
		}

		/**
		 * The amount of vertical blur. Valid values are from 0 to 255 (floating point). The
		 * default value is 4. Values that are a power of 2 (such as 2, 4, 8, 16 and 32) are optimized 
		 * to render more quickly than other values.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example changes the <code>blurY</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BlurFilter;
		 *   var mc:MovieClip = createBlurFilterRectangle("BlurFilterBlurY");
		 *   mc.onRelease = function() {
		 *   var filter:BlurFilter = this.filters[0];
		 *   filter.blurY = 200;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBlurFilterRectangle(name:String):MovieClip {
		 *   var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   rect.beginFill(0x003366);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BlurFilter = new BlurFilter(30, 30, 2);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   rect.filters = filterArray;
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get blurY () : Number{
			return 0;
		}
		public function set blurY (value:Number) : void{
			
		}

		/**
		 * The number of times to perform the blur. The default value is BitmapFilterQuality.LOW, 
		 * which is equivalent to applying the filter once. The value BitmapFilterQuality.MEDIUM
		 * applies the filter twice; the value BitmapFilterQuality.HIGH applies it three times
		 * and approximates a Gaussian blur. Filters with lower values are rendered more quickly.
		 * 
		 *   For most applications, a quality value of low, medium, or high is sufficient. 
		 * Although you can use additional numeric values up to 15 to increase the number of times the blur
		 * is applied, 
		 * higher values are rendered more slowly. Instead of increasing the value of quality,
		 * you can often get a similar effect, and with faster rendering, by simply increasing the values 
		 * of the blurX and blurY properties.You can use the following BitmapFilterQuality constants to specify values of the
		 * quality property:BitmapFilterQuality.LOWBitmapFilterQuality.MEDIUMBitmapFilterQuality.HIGH
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example changes the <code>quality</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BlurFilter;
		 *   var mc:MovieClip = createBlurFilterRectangle("BlurFilterQuality");
		 *   mc.onRelease = function() {
		 *   var filter:BlurFilter = this.filters[0];
		 *   filter.quality = 1;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBlurFilterRectangle(name:String):MovieClip {
		 *   var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   rect.beginFill(0x003366);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BlurFilter = new BlurFilter(30, 30, 2);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   rect.filters = filterArray;
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get quality () : int{
			return 0;
		}
		public function set quality (value:int) : void{
			
		}

		/**
		 * Initializes the filter with the specified parameters.
		 * 
		 *   The default values create a soft, unfocused image.
		 * @param	blurX	The amount to blur horizontally. Valid values are from 0 to 255.0 (floating-point 
		 *   value).
		 * @param	blurY	The amount to blur vertically. Valid values are from 0 to 255.0 (floating-point 
		 *   value).
		 * @param	quality	The number of times to apply the filter. You can specify the quality using
		 *   the BitmapFilterQuality constants:
		 *   flash.filters.BitmapFilterQuality.LOWflash.filters.BitmapFilterQuality.MEDIUMflash.filters.BitmapFilterQuality.HIGHHigh quality approximates a Gaussian blur. 
		 *   For most applications, these three values are sufficient.  
		 *   Although you can use additional numeric values up to 15 to achieve different effects, be aware
		 *   that higher values are rendered more slowly.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	Instantiate a new <code>BlurFilter</code> and apply it to a flat, rectangular shape.
		 *   <listing version="2.0">
		 *   import flash.filters.BlurFilter;
		 *   var rect:MovieClip = createRectangle(100, 100, 0x003366, "BlurFilterExample");
		 *   
		 *     var blurX:Number = 30;
		 *   var blurY:Number = 30;
		 *   var quality:Number = 3;
		 *   
		 *     var filter:BlurFilter = new BlurFilter(blurX, blurY, quality);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   rect.filters = filterArray;
		 *   
		 *     function createRectangle(w:Number, h:Number, bgColor:Number, name:String):MovieClip {
		 *   var mc:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   mc.beginFill(bgColor);
		 *   mc.lineTo(w, 0);
		 *   mc.lineTo(w, h);
		 *   mc.lineTo(0, h);
		 *   mc.lineTo(0, 0);
		 *   mc._x = 20;
		 *   mc._y = 20;
		 *   return mc;
		 *   }
		 *   </listing>
		 */
		public function BlurFilter (blurX:Number = 4, blurY:Number = 4, quality:int = 1){
			
		}

		/**
		 * Returns a copy of this filter object.
		 * @return	A new BlurFilter instance with all the same
		 *   properties as the original BlurFilter instance.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example creates three BlurFilter objects and compares them.  <code>filter_1</code>
		 *   is created using the BlurFilter constructor.  <code>filter_2</code> is created by setting it equal to 
		 *   <code>filter_1</code>.  And, <code>clonedFilter</code> is created by cloning <code>filter_1</code>.  Notice
		 *   that while <code>filter_2</code> evaluates as being equal to <code>filter_1</code>, <code>clonedFilter</code>,
		 *   even though it contains the same values as <code>filter_1</code>, does not.
		 *   <listing version="2.0">
		 *   import flash.filters.BlurFilter;
		 *   
		 *     var filter_1:BlurFilter = new BlurFilter(30, 30, 2);
		 *   var filter_2:BlurFilter = filter_1;
		 *   var clonedFilter:BlurFilter = filter_1.clone();
		 *   
		 *     trace(filter_1 == filter_2);		// true
		 *   trace(filter_1 == clonedFilter);	// false
		 *   
		 *     for(var i in filter_1) {
		 *   trace("&gt;&gt; " + i + ": " + filter_1[i]);
		 *   // &gt;&gt; clone: [type Function]
		 *   // &gt;&gt; quality: 2
		 *   // &gt;&gt; blurY: 30
		 *   // &gt;&gt; blurX: 30
		 *   }
		 *   
		 *     for(var i in clonedFilter) {
		 *   trace("&gt;&gt; " + i + ": " + clonedFilter[i]);
		 *   // &gt;&gt; clone: [type Function]
		 *   // &gt;&gt; quality: 2
		 *   // &gt;&gt; blurY: 30
		 *   // &gt;&gt; blurX: 30
		 *   }
		 *   </listing>
		 *   To further demonstrate the relationships between <code>filter_1</code>, <code>filter_2</code>, and <code>clonedFilter</code>
		 *   the example below modifies the <code>quality</code> property of <code>filter_1</code>.  Modifying <code>quality</code> demonstrates
		 *   that the <code>clone()</code> method creates a new instance based on values of the <code>filter_1</code> instead of pointing to 
		 *   them in reference.
		 *   <listing version="2.0">
		 *   import flash.filters.BlurFilter;
		 *   
		 *     var filter_1:BlurFilter = new BlurFilter(30, 30, 2);
		 *   var filter_2:BlurFilter = filter_1;
		 *   var clonedFilter:BlurFilter = filter_1.clone();
		 *   
		 *     trace(filter_1.quality);			// 2
		 *   trace(filter_2.quality);			// 2
		 *   trace(clonedFilter.quality);		// 2
		 *   
		 *     filter_1.quality = 1;
		 *   
		 *     trace(filter_1.quality);			// 1
		 *   trace(filter_2.quality);			// 1
		 *   trace(clonedFilter.quality);		// 2
		 *   </listing>
		 */
		/*public function clone () : flash.filters.BitmapFilter;*/
	}
}
