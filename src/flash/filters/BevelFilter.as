//
// D:\sdk\airsdk24\frameworks\libs\player\18.0\playerglobal.swc\flash\filters\BevelFilter
//
package flash.filters
{
	import flash.filters.BitmapFilter;

	/**
	 * The BevelFilter class lets you add a bevel effect to display objects.
	 * A bevel effect gives objects such as buttons a three-dimensional look. You can customize
	 * the look of the bevel with different highlight and shadow colors, the amount
	 * of blur on the bevel, the angle of the bevel, the placement of the bevel, 
	 * and a knockout effect.
	 * You can apply the filter to any display object (that is, objects that inherit from the 
	 * DisplayObject class), such as MovieClip, SimpleButton, TextField, and Video objects, 
	 * as well as to BitmapData objects.
	 * 
	 *   <p class="- topic/p ">To create a new filter, use the constructor <codeph class="+ topic/ph pr-d/codeph ">new BevelFilter()</codeph>.
	 * The use of filters depends on the object to which you apply the filter:</p><ul class="- topic/ul "><li class="- topic/li ">To apply filters to movie clips, text fields, buttons, and video, use the
	 * <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property (inherited from DisplayObject). Setting the <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> 
	 * property of an object does not modify the object, and you can remove the filter by clearing the
	 * <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property. </li><li class="- topic/li ">To apply filters to BitmapData objects, use the <codeph class="+ topic/ph pr-d/codeph ">BitmapData.applyFilter()</codeph> method.
	 * Calling <codeph class="+ topic/ph pr-d/codeph ">applyFilter()</codeph> on a BitmapData object takes the source BitmapData object 
	 * and the filter object and generates a filtered image as a result.</li></ul><p class="- topic/p ">If you apply a filter to a display object, the value of the <codeph class="+ topic/ph pr-d/codeph ">cacheAsBitmap</codeph> property of the 
	 * object is set to <codeph class="+ topic/ph pr-d/codeph ">true</codeph>. If you remove all filters, the original value of 
	 * <codeph class="+ topic/ph pr-d/codeph ">cacheAsBitmap</codeph> is restored.</p><p class="- topic/p ">This filter supports Stage scaling. However, it does not support general scaling, rotation, and 
	 * skewing. If the object itself is scaled (if the <codeph class="+ topic/ph pr-d/codeph ">scaleX</codeph> and <codeph class="+ topic/ph pr-d/codeph ">scaleY</codeph> properties are 
	 * not set to 100%), the filter is not scaled. It is scaled only when the user zooms in on the Stage.</p><p class="- topic/p ">A filter is not applied if the resulting image exceeds the maximum dimensions.
	 * In  AIR 1.5 and Flash Player 10, the maximum is 8,191 pixels in width or height, 
	 * and the total number of pixels cannot exceed 16,777,215 pixels. (So, if an image is 8,191 pixels 
	 * wide, it can only be 2,048 pixels high.) In Flash Player 9 and earlier and AIR 1.1 and earlier, 
	 * the limitation is 2,880 pixels in height and 2,880 pixels in width.
	 * If, for example, you zoom in on a large movie clip with a filter applied, the filter is 
	 * turned off if the resulting image exceeds the maximum dimensions.</p>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example creates a dark yellow square and applies a bevel with a
	 * bright yellow (0xFFFF00) highlight and a blue (0x0000FF) shadow. The general workflow for this
	 * example is as follows:
	 * <ol class="- topic/ol "><li class="- topic/li ">Import the required classes.</li><li class="- topic/li ">Declare three properties used in the <codeph class="+ topic/ph pr-d/codeph ">draw()</codeph> function, which draws the 
	 * object to which the bevel filter is applied.</li><li class="- topic/li ">Create the <codeph class="+ topic/ph pr-d/codeph ">BevelFilterExample()</codeph> constructor function, which does the following:
	 * <ul class="- topic/ul "><li class="- topic/li ">Calls the <codeph class="+ topic/ph pr-d/codeph ">draw()</codeph> function, which is declared later.</li><li class="- topic/li ">Declares a variable <codeph class="+ topic/ph pr-d/codeph ">filter</codeph> as a BitmapFilter object
	 * and assigns it to the return of a call to <codeph class="+ topic/ph pr-d/codeph ">getBitmapFilter()</codeph>.</li><li class="- topic/li ">Creates a new Array object <codeph class="+ topic/ph pr-d/codeph ">myFilters</codeph> and adds <codeph class="+ topic/ph pr-d/codeph ">filter</codeph> to
	 * the array, and assigns <codeph class="+ topic/ph pr-d/codeph ">myFilters</codeph> to the <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property of 
	 * BevelFilterExample object. This applies all filters found in <codeph class="+ topic/ph pr-d/codeph ">myFilters</codeph>, which in this case
	 * is only <codeph class="+ topic/ph pr-d/codeph ">filter</codeph>.</li></ul></li><li class="- topic/li ">Create the <codeph class="+ topic/ph pr-d/codeph ">getBitmapFilter</codeph> function to create and set properties for the filter.</li><li class="- topic/li ">Create the <codeph class="+ topic/ph pr-d/codeph ">draw()</codeph> function. This function
	 * uses methods of the Graphics class, accessed through the <codeph class="+ topic/ph pr-d/codeph ">graphics</codeph> property
	 * of the Sprite class, to draw the square.</li></ol><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * package {
	 * import flash.display.Sprite;
	 * import flash.filters.BevelFilter;
	 * import flash.filters.BitmapFilter;
	 * import flash.filters.BitmapFilterQuality;
	 * import flash.filters.BitmapFilterType;
	 * 
	 *   public class BevelFilterExample extends Sprite {
	 * private var bgColor:uint = 0xFFCC00;
	 * private var size:uint    = 80;
	 * private var offset:uint  = 50;
	 * 
	 *   public function BevelFilterExample() {
	 * draw();
	 * var filter:BitmapFilter = getBitmapFilter();
	 * var myFilters:Array = new Array();
	 * myFilters.push(filter);
	 * filters = myFilters;
	 * }
	 * 
	 *   private function getBitmapFilter():BitmapFilter {
	 * var distance:Number       = 5;
	 * var angleInDegrees:Number = 45;
	 * var highlightColor:Number = 0xFFFF00;
	 * var highlightAlpha:Number = 0.8;
	 * var shadowColor:Number    = 0x0000FF;
	 * var shadowAlpha:Number    = 0.8;
	 * var blurX:Number          = 5;
	 * var blurY:Number          = 5;
	 * var strength:Number       = 5;
	 * var quality:Number        = BitmapFilterQuality.HIGH;
	 * var type:String           = BitmapFilterType.INNER;
	 * var knockout:Boolean      = false;
	 * 
	 *   return new BevelFilter(distance,
	 * angleInDegrees,
	 * highlightColor,
	 * highlightAlpha,
	 * shadowColor,
	 * shadowAlpha,
	 * blurX,
	 * blurY,
	 * strength,
	 * quality,
	 * type,
	 * knockout);
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
	public final class BevelFilter extends BitmapFilter
	{
		/**
		 * The angle of the bevel. Valid values are from 0 to 360°. The default value is 45°.
		 * 
		 *   The angle value represents the angle of the theoretical light source falling on the object
		 * and determines the placement of the effect relative to the object. If the distance
		 * property is set to 0, the effect is not offset from the object and, therefore, 
		 * the angle property has no effect.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>angle</code> property on an existing MovieClip 
		 *   <code>rect</code> when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var rect:MovieClip = createBevelRectangle("BevelDistance");
		 *   rect.onRelease = function() {
		 *   var filter:BevelFilter = this.filters[0];
		 *   filter.angle = 225;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBevelRectangle(name:String):MovieClip {
		 *   var w:uint = 100;
		 *   var h:uint = 100;
		 *   var bgColor:uint = 0x00CC00;
		 *   
		 *     var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   rect.beginFill(bgColor);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   rect.filters = new Array(filter);
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get angle () : Number{
			return 0;
		}
		public function set angle (value:Number) : void{
			
		}

		/**
		 * The amount of horizontal blur, in pixels. Valid values are from 0 to 255 (floating point). 
		 * The default value is 4. Values that are a power of 2 (such as 2, 4, 8, 16, and 32) are optimized 
		 * to render more quickly than other values.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>blurX</code> property on the existing MovieClip 
		 *   <code>rect</code> when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var rect:MovieClip = createBevelRectangle("BevelBlurX");
		 *   rect.onRelease = function() {
		 *   var filter:BevelFilter = this.filters[0];
		 *   filter.blurX = 10;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBevelRectangle(name:String):MovieClip {
		 *   var w:uint = 100;
		 *   var h:uint = 100;
		 *   var bgColor:uint = 0x00CC00;
		 *   
		 *     var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   rect.beginFill(bgColor);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   rect.filters = new Array(filter);
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
		 * The amount of vertical blur, in pixels. Valid values are from 0 to 255 (floating point).
		 * The default value is 4. Values that are a power of 2 (such as 2, 4, 8, 16, and 32) are optimized 
		 * to render more quickly than other values.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>blurY</code> property on the existing MovieClip 
		 *   <code>rect</code> when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var rect:MovieClip = createBevelRectangle("BevelBlurY");
		 *   rect.onRelease = function() {
		 *   var filter:BevelFilter = this.filters[0];
		 *   filter.blurY = 10;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBevelRectangle(name:String):MovieClip {
		 *   var w:uint = 100;
		 *   var h:uint = 100;
		 *   var bgColor:uint = 0x00CC00;
		 *   
		 *     var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   rect.beginFill(bgColor);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   rect.filters = new Array(filter);
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
		 * The offset distance of the bevel. Valid values are in pixels (floating point). The default is 4.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>distance</code> property on the existing MovieClip 
		 *   <code>rect</code> when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var rect:MovieClip = createBevelRectangle("BevelDistance");
		 *   rect.onRelease = function() {
		 *   var filter:BevelFilter = this.filters[0];
		 *   filter.distance = 3;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBevelRectangle(name:String):MovieClip {
		 *   var w:uint = 100;
		 *   var h:uint = 100;
		 *   var bgColor:uint = 0x00CC00;
		 *   
		 *     var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   rect.beginFill(bgColor);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   rect.filters = new Array(filter);
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get distance () : Number{
			return 0;
		}
		public function set distance (value:Number) : void{
			
		}

		/**
		 * The alpha transparency value of the highlight color. The value is specified as a normalized
		 * value from 0 to 1. For example,
		 * .25 sets a transparency value of 25%. The default value is 1.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>highlightAlpha</code> property on the existing MovieClip 
		 *   <code>rect</code> when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var rect:MovieClip = createBevelRectangle("BevelHighlightAlpha");
		 *   rect.onRelease = function() {
		 *   var filter:BevelFilter = this.filters[0];
		 *   filter.highlightAlpha = .2;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBevelRectangle(name:String):MovieClip {
		 *   var w:uint = 100;
		 *   var h:uint = 100;
		 *   var bgColor:uint = 0x00CC00;
		 *   
		 *     var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   rect.beginFill(bgColor);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   rect.filters = new Array(filter);
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get highlightAlpha () : Number{
			return 0;
		}
		public function set highlightAlpha (value:Number) : void{
			
		}

		/**
		 * The highlight color of the bevel. Valid values are in hexadecimal format, 
		 * 0xRRGGBB. The default is 0xFFFFFF.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>highlightColor</code> property on the existing MovieClip 
		 *   <code>rect</code> when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var rect:MovieClip = createBevelRectangle("BevelHighlightColor");
		 *   rect.onRelease = function() {
		 *   var filter:BevelFilter = this.filters[0];
		 *   filter.highlightColor = 0x0000FF;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBevelRectangle(name:String):MovieClip {
		 *   var w:uint = 100;
		 *   var h:uint = 100;
		 *   var bgColor:uint = 0x00CC00;
		 *   
		 *     var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   rect.beginFill(bgColor);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   rect.filters = new Array(filter);
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get highlightColor () : uint{
			return 0;
		}
		public function set highlightColor (value:uint) : void{
			
		}

		/**
		 * Applies a knockout effect (true), which effectively 
		 * makes the object's fill transparent and reveals the background color of the document. The 
		 * default value is false (no knockout).
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>knockout</code> property on the existing MovieClip 
		 *   <code>rect</code> when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var rect:MovieClip = createBevelRectangle("BevelKnockout");
		 *   rect.onRelease = function() {
		 *   var filter:BevelFilter = this.filters[0];
		 *   filter.knockout = true;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBevelRectangle(name:String):MovieClip {
		 *   var w:uint = 100;
		 *   var h:uint = 100;
		 *   var bgColor:uint = 0x00CC00;
		 *   
		 *     var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   rect.beginFill(bgColor);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   rect.filters = new Array(filter);
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get knockout () : Boolean{
			return false;
		}
		public function set knockout (value:Boolean) : void{
			
		}

		/**
		 * The number of times to apply the filter. The default value is BitmapFilterQuality.LOW, 
		 * which is equivalent to applying the filter once. The value BitmapFilterQuality.MEDIUM
		 * applies the filter twice; the value BitmapFilterQuality.HIGH applies it three times.
		 * Filters with lower values are rendered more quickly.
		 * 
		 *   For most applications, a quality value of low, medium, or high is sufficient. 
		 * Although you can use additional numeric values up to 15 to achieve different effects, 
		 * higher values are rendered more slowly. Instead of increasing the value of quality,
		 * you can often get a similar effect, and with faster rendering, by simply increasing the values 
		 * of the blurX and blurY properties.You can use the following BitmapFilterQuality constants to specify values of the quality property:
		 * BitmapFilterQuality.LOWBitmapFilterQuality.MEDIUMBitmapFilterQuality.HIGH
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>quality</code> property on the existing MovieClip 
		 *   <code>rect</code> when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var rect:MovieClip = createBevelRectangle("BevelQuality");
		 *   rect.onRelease = function() {
		 *   var filter:BevelFilter = this.filters[0];
		 *   filter.quality = 1;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBevelRectangle(name:String):MovieClip {
		 *   var w:uint = 100;
		 *   var h:uint = 100;
		 *   var bgColor:uint = 0x00CC00;
		 *   
		 *     var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   rect.beginFill(bgColor);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   rect.filters = new Array(filter);
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
		 * The alpha transparency value of the shadow color. This value is specified as a normalized
		 * value from 0 to 1. For example,
		 * .25 sets a transparency value of 25%. The default is 1.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>shadowAlpha</code> property on the existing MovieClip 
		 *   <code>rect</code> when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var rect:MovieClip = createBevelRectangle("BevelShadowAlpha");
		 *   rect.onRelease = function() {
		 *   var filter:BevelFilter = this.filters[0];
		 *   filter.shadowAlpha = .2;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBevelRectangle(name:String):MovieClip {
		 *   var w:uint = 100;
		 *   var h:uint = 100;
		 *   var bgColor:uint = 0x00CC00;
		 *   
		 *     var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   rect.beginFill(bgColor);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   rect.filters = new Array(filter);
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get shadowAlpha () : Number{
			return 0;
		}
		public function set shadowAlpha (value:Number) : void{
			
		}

		/**
		 * The shadow color of the bevel. Valid values are in hexadecimal format, 0xRRGGBB. The default 
		 * is 0x000000.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>shadowColor</code> property on the existing MovieClip 
		 *   <code>rect</code> when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var rect:MovieClip = createBevelRectangle("BevelShadowColor");
		 *   rect.onRelease = function() {
		 *   var filter:BevelFilter = this.filters[0];
		 *   filter.shadowColor = 0xFFFF00;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBevelRectangle(name:String):MovieClip {
		 *   var w:uint = 100;
		 *   var h:uint = 100;
		 *   var bgColor:uint = 0x00CC00;
		 *   
		 *     var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   rect.beginFill(bgColor);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   rect.filters = new Array(filter);
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get shadowColor () : uint{
			return 0;
		}
		public function set shadowColor (value:uint) : void{
			
		}

		/**
		 * The strength of the imprint or spread. Valid values are from 0 to 255. The larger the value, 
		 * the more color is imprinted and the stronger the contrast between the bevel and the background.
		 * The default value is 1.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>strength</code> property on the existing MovieClip 
		 *   <code>rect</code> when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var rect:MovieClip = createBevelRectangle("BevelStrength");
		 *   rect.onRelease = function() {
		 *   var filter:BevelFilter = this.filters[0];
		 *   filter.strength = 10;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBevelRectangle(name:String):MovieClip {
		 *   var w:uint = 100;
		 *   var h:uint = 100;
		 *   var bgColor:uint = 0x00CC00;
		 *   
		 *     var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   rect.beginFill(bgColor);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   rect.filters = new Array(filter);
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get strength () : Number{
			return 0;
		}
		public function set strength (value:Number) : void{
			
		}

		/**
		 * The placement of the bevel on the object. Inner and outer bevels are placed on
		 * the inner or outer edge; a full bevel is placed on the entire object.
		 * Valid values are the BitmapFilterType constants:
		 * 
		 *   BitmapFilterType.INNERBitmapFilterType.OUTERBitmapFilterType.FULL
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>type</code> property on the existing MovieClip 
		 *   <code>rect</code> when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var rect:MovieClip = createBevelRectangle("BevelType");
		 *   rect.onRelease = function() {
		 *   var filter:BevelFilter = this.filters[0];
		 *   filter.type = "outer";
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createBevelRectangle(name:String):MovieClip {
		 *   var w:uint = 100;
		 *   var h:uint = 100;
		 *   var bgColor:uint = 0x00CC00;
		 *   
		 *     var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   rect.beginFill(bgColor);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   
		 *     var filter:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   rect.filters = new Array(filter);
		 *   return rect;
		 *   }
		 *   </listing>
		 * @throws	TypeError The string is null when being set
		 */
		public function get type () : String{
			return null;
		}
		public function set type (value:String) : void{
			
		}

		/**
		 * Initializes a new BevelFilter instance with the specified parameters.
		 * @param	distance	The offset distance of the bevel, in pixels (floating point).
		 * @param	angle	The angle of the bevel, from 0 to 360 degrees.
		 * @param	highlightColor	The highlight color of the bevel, 0xRRGGBB.
		 * @param	highlightAlpha	The alpha transparency value of the highlight color. Valid values are 0.0 to 
		 *   1.0. For example,
		 *   .25 sets a transparency value of 25%.
		 * @param	shadowColor	The shadow color of the bevel, 0xRRGGBB.
		 * @param	shadowAlpha	The alpha transparency value of the shadow color. Valid values are 0.0 to 1.0. For example,
		 *   .25 sets a transparency value of 25%.
		 * @param	blurX	The amount of horizontal blur in pixels. Valid values are 0 to 255.0 (floating point).
		 * @param	blurY	The amount of vertical blur in pixels. Valid values are 0 to 255.0 (floating point).
		 * @param	strength	The strength of the imprint or spread. The higher the value, the more color is imprinted and the stronger the contrast between the bevel and the background. Valid values are 0 to 255.0.
		 * @param	quality	The quality of the bevel. Valid values are 0 to 15, but for most applications,
		 *   you can use BitmapFilterQuality constants:
		 *   BitmapFilterQuality.LOWBitmapFilterQuality.MEDIUMBitmapFilterQuality.HIGHFilters with lower values render faster. You can use
		 *   the other available numeric values to achieve different effects.
		 * @param	type	The type of bevel. Valid values are BitmapFilterType constants: 
		 *   BitmapFilterType.INNER, BitmapFilterType.OUTER, or 
		 *   BitmapFilterType.FULL.
		 * @param	knockout	Applies a knockout effect (true), which effectively 
		 *   makes the object's fill transparent and reveals the background color of the document.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following code creates a new BevelFilter instance. The values given 
		 *   are the default values; you could call the constructor without any values and get the same result.
		 *   <listing> filter = new flash.filters.BevelFilter (4, 45, 0xFFFFFF, 1, 0x000000, 1, 4, 4, 1, 
		 *   1, "inner", false) 
		 *   </listing>
		 *   The next example instantiates a new BevelFilter and applies it to the MovieClip <code>rect</code>.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var distance:Number = 5;
		 *   var angleInDegrees:Number = 45;
		 *   var highlightColor:uint = 0xFFFF00;
		 *   var highlightAlpha:Number = .8;
		 *   var shadowColor:uint = 0x0000FF;
		 *   var shadowAlpha:Number = .8;
		 *   var blurX:Number = 20;
		 *   var blurY:Number = 20;
		 *   var strength:Number = 1;
		 *   var quality:int = 3;
		 *   var type:String = "inner";
		 *   var knockout:Boolean = false;
		 *   
		 *     var filter:BevelFilter = new BevelFilter(distance, angleInDegrees, highlightColor, highlightAlpha, shadowColor, shadowAlpha, blurX, blurY, strength, quality, type, knockout);
		 *   
		 *     var rect:MovieClip = createRectangle(100, 100, 0x00CC00, "bevelFilterExample");
		 *   rect.filters = new Array(filter);
		 *   
		 *     function createRectangle(w:Number, h:Number, bgColor:Number, name:String):MovieClip {
		 *   var rect:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   rect.beginFill(bgColor);
		 *   rect.lineTo(w, 0);
		 *   rect.lineTo(w, h);
		 *   rect.lineTo(0, h);
		 *   rect.lineTo(0, 0);
		 *   rect._x = 20;
		 *   rect._y = 20;
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function BevelFilter (distance:Number = 4, angle:Number = 45, highlightColor:uint = 16777215, highlightAlpha:Number = 1, shadowColor:uint = 0, shadowAlpha:Number = 1, blurX:Number = 4, blurY:Number = 4, strength:Number = 1, quality:int = 1, type:String = "inner", knockout:Boolean = false){
			
		}

		/**
		 * Returns a copy of this filter object.
		 * @return	A new BevelFilter instance with all the same properties as 
		 *   the original BevelFilter instance.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example creates three BevelFilter objects and compares them.  <code>filter_1</code>
		 *   is created using the BevelFilter construtor.  <code>filter_2</code> is created by setting it equal to 
		 *   <code>filter_1</code>.  And, <code>clonedFilter</code> is created by cloning <code>filter_1</code>.  Notice
		 *   that while <code>filter_2</code> evaluates as being equal to <code>filter_1</code>, <code>clonedFilter</code>,
		 *   even though it contains the same values as <code>filter_1</code>, does not.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var filter_1:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   var filter_2:BevelFilter = filter_1;
		 *   var clonedFilter:BevelFilter = filter_1.clone();
		 *   
		 *     trace(filter_1 == filter_2);		// true
		 *   trace(filter_1 == clonedFilter);	// false
		 *   
		 *     for(var i in filter_1) {
		 *   trace("&gt;&gt; " + i + ": " + filter_1[i]);
		 *   // &gt;&gt; clone: [type Function]
		 *   // &gt;&gt; type: inner
		 *   // &gt;&gt; blurY: 20
		 *   // &gt;&gt; blurX: 20
		 *   // &gt;&gt; knockout: false
		 *   // &gt;&gt; strength: 1
		 *   // &gt;&gt; quality: 3
		 *   // &gt;&gt; shadowAlpha: 0.8
		 *   // &gt;&gt; shadowColor: 255
		 *   // &gt;&gt; highlightAlpha: 0.8
		 *   // &gt;&gt; highlightColor: 16776960
		 *   // &gt;&gt; angle: 45
		 *   // &gt;&gt; distance: 5
		 *   }
		 *   
		 *     for(var i in clonedFilter) {
		 *   trace("&gt;&gt; " + i + ": " + clonedFilter[i]);
		 *   // &gt;&gt; clone: [type Function]
		 *   // &gt;&gt; type: inner
		 *   // &gt;&gt; blurY: 20
		 *   // &gt;&gt; blurX: 20
		 *   // &gt;&gt; knockout: false
		 *   // &gt;&gt; strength: 1
		 *   // &gt;&gt; quality: 3
		 *   // &gt;&gt; shadowAlpha: 0.8
		 *   // &gt;&gt; shadowColor: 255
		 *   // &gt;&gt; highlightAlpha: 0.8
		 *   // &gt;&gt; highlightColor: 16776960
		 *   // &gt;&gt; angle: 45
		 *   // &gt;&gt; distance: 5
		 *   }
		 *   </listing>
		 *   To further demonstrate the relationships between <code>filter_1</code>, <code>filter_2</code>, and <code>clonedFilter</code>
		 *   the example below modifies the <code>knockout</code> property of <code>filter_1</code>.  Modifying <code>knockout</code> demonstrates
		 *   that the <code>clone()</code> method creates a new instance based on values of the <code>filter_1</code> instead of pointing to 
		 *   them in reference.
		 *   <listing version="2.0">
		 *   import flash.filters.BevelFilter;
		 *   
		 *     var filter_1:BevelFilter = new BevelFilter(5, 45, 0xFFFF00, .8, 0x0000FF, .8, 20, 20, 1, 3, "inner", false);
		 *   var filter_2:BevelFilter = filter_1;
		 *   var clonedFilter:BevelFilter = filter_1.clone();
		 *   
		 *     trace(filter_1.knockout);			// false
		 *   trace(filter_2.knockout);			// false
		 *   trace(clonedFilter.knockout);		// false
		 *   
		 *     filter_1.knockout = true;
		 *   
		 *     trace(filter_1.knockout);			// true
		 *   trace(filter_2.knockout);			// true
		 *   trace(clonedFilter.knockout);		// false
		 *   </listing>
		 */
		/*public function clone () : flash.filters.BitmapFilter{
			return null;
		}*/
	}
}
