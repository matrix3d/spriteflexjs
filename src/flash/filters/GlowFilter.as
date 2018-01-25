package flash.filters
{
	import flash.filters.BitmapFilter;

	/**
	 * The GlowFilter class lets you apply a glow effect to display objects.
	 * You have several options for the style of the 
	 * glow, including inner or outer glow and knockout mode. 
	 * The glow filter is similar to the drop shadow filter with the <codeph class="+ topic/ph pr-d/codeph ">distance</codeph>
	 * and <codeph class="+ topic/ph pr-d/codeph ">angle</codeph> properties of the drop shadow filter set to 0. 
	 * You can apply the filter to any display object (that is, objects that inherit from the DisplayObject class), 
	 * such as MovieClip, SimpleButton, TextField, and Video objects, as well as to BitmapData objects.
	 * 
	 *   <p class="- topic/p ">The use of filters depends on the object to which you apply the filter:</p><ul class="- topic/ul "><li class="- topic/li ">To apply filters to display objects, use the
	 * <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property (inherited from DisplayObject). Setting the <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> 
	 * property of an object does not modify the object, and you can remove the filter by clearing the
	 * <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property. </li><li class="- topic/li ">To apply filters to BitmapData objects, use the <codeph class="+ topic/ph pr-d/codeph ">BitmapData.applyFilter()</codeph> method.
	 * Calling <codeph class="+ topic/ph pr-d/codeph ">applyFilter()</codeph> on a BitmapData object takes the source BitmapData object 
	 * and the filter object and generates a filtered image as a result.</li></ul><p class="- topic/p ">If you apply a filter to a display object, the <codeph class="+ topic/ph pr-d/codeph ">cacheAsBitmap</codeph> property of the 
	 * display object is set to <codeph class="+ topic/ph pr-d/codeph ">true</codeph>. If you clear all filters, the original value of 
	 * <codeph class="+ topic/ph pr-d/codeph ">cacheAsBitmap</codeph> is restored.</p><p class="- topic/p ">This filter supports Stage scaling. However, it does not support general scaling, rotation, and 
	 * skewing. If the object itself is scaled (if <codeph class="+ topic/ph pr-d/codeph ">scaleX</codeph> and <codeph class="+ topic/ph pr-d/codeph ">scaleY</codeph> are 
	 * set to a value other than 1.0), the filter is not scaled. It is scaled only when the user zooms
	 * in on the Stage.</p><p class="- topic/p ">A filter is not applied if the resulting image exceeds the maximum dimensions.
	 * In  AIR 1.5 and Flash Player 10, the maximum is 8,191 pixels in width or height, 
	 * and the total number of pixels cannot exceed 16,777,215 pixels. (So, if an image is 8,191 pixels 
	 * wide, it can only be 2,048 pixels high.) In Flash Player 9 and earlier and AIR 1.1 and earlier, 
	 * the limitation is 2,880 pixels in height and 2,880 pixels in width.
	 * For example, if you zoom in on a large movie clip with a filter applied, the filter is 
	 * turned off if the resulting image exceeds the maximum dimensions.</p>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example draws a square and applies a blur filter to it.
	 * The general workflow of the example is as follows:
	 * <ol class="- topic/ol "><li class="- topic/li ">Import the required classes.</li><li class="- topic/li ">Declare three properties used in the <codeph class="+ topic/ph pr-d/codeph ">draw</codeph> method, which uses methods
	 * of the Graphics class accessed through the <codeph class="+ topic/ph pr-d/codeph ">graphics</codeph> property of Sprite
	 * to draw an orange square.</li><li class="- topic/li ">Create the constructor function, which does the following:
	 * <ul class="- topic/ul "><li class="- topic/li ">Calls the <codeph class="+ topic/ph pr-d/codeph ">draw</codeph> function to create a rectangle.</li><li class="- topic/li ">Creates a BitmapFilter object <codeph class="+ topic/ph pr-d/codeph ">glowFilter</codeph> and assigns it the return values from the <codeph class="+ topic/ph pr-d/codeph ">getBitmapFilter()</codeph> function.</li><li class="- topic/li ">Assigns the array of values from the <codeph class="+ topic/ph pr-d/codeph ">glowFilter</codeph> object to the <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property of the root display object. In this case,
	 * all display object children of the root display object inherit the glow filter properties. So, the rectangle created in the the <codeph class="+ topic/ph pr-d/codeph ">draw()</codeph> 
	 * function displays the glow filter properties.</li></ul></li></ol><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * 
	 *   package {
	 * import flash.display.Sprite;
	 * import flash.events.Event;
	 * import flash.events.MouseEvent;
	 * import flash.filters.BitmapFilter;
	 * import flash.filters.BitmapFilterQuality;
	 * import flash.filters.GlowFilter;
	 * 
	 *   public class GlowFilterExample extends Sprite {
	 * private var bgColor:uint = 0xFFCC00;
	 * private var size:uint    = 80;
	 * private var offset:uint  = 50;
	 * 
	 *   public function GlowFilterExample() {
	 * //draw the rectangle using the draw() function below
	 * draw();
	 * 
	 *   //assign the values from getBitmapFilter function below
	 * //to a BitmapFilter object "glowFilter"
	 * var glowFilter:BitmapFilter = getBitmapFilter();
	 * 
	 *   //populate the filters property of the root display object with the array of values
	 * //from the glowFilter object.
	 * filters = [ glowFilter ];
	 * }
	 * 
	 *   private function getBitmapFilter():BitmapFilter {
	 * var color:Number = 0x33CCFF;
	 * var alpha:Number = 0.8;
	 * var blurX:Number = 35;
	 * var blurY:Number = 35;
	 * var strength:Number = 2;
	 * var inner:Boolean = false;
	 * var knockout:Boolean = false;
	 * var quality:Number = BitmapFilterQuality.HIGH;
	 * 
	 *   return new GlowFilter(color,
	 * alpha,
	 * blurX,
	 * blurY,
	 * strength,
	 * quality,
	 * inner,
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
	public final class GlowFilter extends BitmapFilter
	{
		private var _color:uint;
		private var _alpha:Number;
		private var _blurX:Number;
		private var _blurY:Number;
		private var _strength:Number;
		private var _quality:int;
		private var _inner:Boolean;
		private var _knockout:Boolean;
		private var _blur:Number;
		private var _rgba:String;
		
		/**
		 * The alpha transparency value for the color. Valid values are 0 to 1. 
		 * For example,
		 * .25 sets a transparency value of 25%. The default value is 1.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example changes the <code>alpha</code> property on an existing movie clip 
		 *   when a user clicks it.
		 *   <listing version="2.0">
		 *   import flash.filters.GlowFilter;
		 *   
		 *     var mc:MovieClip = createGlowFilterRectangle("GlowFilterAlpha");
		 *   mc.onRelease = function() {
		 *   var filter:GlowFilter = this.filters[0];
		 *   filter.alpha = .4;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createGlowFilterRectangle(name:String):MovieClip {
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
		 *     var filter:GlowFilter = new GlowFilter(0x000000, .8, 16, 16, 1, 3, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   rect.filters = filterArray;
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get alpha () : Number{
			return _alpha;
		}
		public function set alpha (value:Number) : void{
			_alpha = value;
		}

		/**
		 * The amount of horizontal blur. Valid values are 0 to 255 (floating point). The
		 * default value is 6. Values that are a power of 2 (such as 2, 4, 
		 * 8, 16, and 32) are optimized 
		 * to render more quickly than other values.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example changes the <code>blurX</code> property on an existing movie clip 
		 *   when a user clicks it.
		 *   <listing version="2.0">
		 *   import flash.filters.GlowFilter;
		 *   
		 *     var mc:MovieClip = createGlowFilterRectangle("GlowFilterBlurX");
		 *   mc.onRelease = function() {
		 *   var filter:GlowFilter = this.filters[0];
		 *   filter.blurX = 20;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createGlowFilterRectangle(name:String):MovieClip {
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
		 *     var filter:GlowFilter = new GlowFilter(0x000000, .8, 16, 16, 1, 3, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   rect.filters = filterArray;
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get blurX () : Number{
			return _blurX;
		}
		public function set blurX (value:Number) : void{
			_blurX = value;
			_blur = Math.max(blurX, blurY);
			_offsetX = _offsetY = _blur;
		}

		/**
		 * The amount of vertical blur. Valid values are 0 to 255 (floating point). The
		 * default value is 6. Values that are a power of 2 (such as 2, 4, 
		 * 8, 16, and 32) are optimized 
		 * to render more quickly than other values.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example changes the <code>blurY</code> property on an existing movie clip 
		 *   when a user clicks it.
		 *   <listing version="2.0">
		 *   import flash.filters.GlowFilter;
		 *   
		 *     var mc:MovieClip = createGlowFilterRectangle("GlowFilterBlurY");
		 *   mc.onRelease = function() {
		 *   var filter:GlowFilter = this.filters[0];
		 *   filter.blurY = 20;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createGlowFilterRectangle(name:String):MovieClip {
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
		 *     var filter:GlowFilter = new GlowFilter(0x000000, .8, 16, 16, 1, 3, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   rect.filters = filterArray;
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get blurY () : Number{
			return _blurY;
		}
		public function set blurY (value:Number) : void{
			_blurY = value;
			_blur = Math.max(blurX, blurY);
			_offsetX = _offsetY = _blur;
		}

		/**
		 * The color of the glow. Valid values are in the hexadecimal format 
		 * 0xRRGGBB. The default value is 0xFF0000.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example changes the <code>color</code> property on an existing movie clip 
		 *   when a user clicks it.
		 *   <listing version="2.0">
		 *   import flash.filters.GlowFilter;
		 *   
		 *     var mc:MovieClip = createGlowFilterRectangle("GlowFilterColor");
		 *   mc.onRelease = function() {
		 *   var filter:GlowFilter = this.filters[0];
		 *   filter.color = 0x00FF33;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createGlowFilterRectangle(name:String):MovieClip {
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
		 *     var filter:GlowFilter = new GlowFilter(0x000000, .8, 16, 16, 1, 3, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   rect.filters = filterArray;
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get color () : uint{
			return _color;
		}
		public function set color (value:uint) : void{
			_color = value;
			_rgba = "rgba(" + (color >> 16 & 0xff) + "," + (color >> 8 & 0xff) + "," + (color & 0xff) + "," + alpha + ")";
		}

		/**
		 * Specifies whether the glow is an inner glow. The value true indicates 
		 * an inner glow. The default is false, an outer glow (a glow
		 * around the outer edges of the object).
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example changes the <code>inner</code> property on an existing movie clip 
		 *   when a user clicks it.
		 *   <listing version="2.0">
		 *   import flash.filters.GlowFilter;
		 *   
		 *     var mc:MovieClip = createGlowFilterRectangle("GlowFilterInner");
		 *   mc.onRelease = function() {
		 *   var filter:GlowFilter = this.filters[0];
		 *   filter.inner = true;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createGlowFilterRectangle(name:String):MovieClip {
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
		 *     var filter:GlowFilter = new GlowFilter(0x000000, .8, 16, 16, 1, 3, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   rect.filters = filterArray;
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get inner () : Boolean{
			return _inner;
		}
		public function set inner (value:Boolean) : void{
			_inner = value;
		}

		/**
		 * Specifies whether the object has a knockout effect. A value of true 
		 * makes the object's fill transparent and reveals the background color of the document. The 
		 * default value is false (no knockout effect).
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example changes the <code>knockout</code> property on an existing movie clip 
		 *   when a user clicks it.
		 *   <listing version="2.0">
		 *   import flash.filters.GlowFilter;
		 *   
		 *     var mc:MovieClip = createGlowFilterRectangle("GlowFilterKnockout");
		 *   mc.onRelease = function() {
		 *   var filter:GlowFilter = this.filters[0];
		 *   filter.knockout = true;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createGlowFilterRectangle(name:String):MovieClip {
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
		 *     var filter:GlowFilter = new GlowFilter(0x000000, .8, 16, 16, 1, 3, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   rect.filters = filterArray;
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get knockout () : Boolean{
			return _knockout;
		}
		public function set knockout (value:Boolean) : void{
			_knockout = value;
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
		 * of the blurX and blurY properties.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example changes the <code>quality</code> property on an existing movie clip 
		 *   when a user clicks it.
		 *   <listing version="2.0">
		 *   import flash.filters.GlowFilter;
		 *   
		 *     var mc:MovieClip = createGlowFilterRectangle("GlowFilterQuality");
		 *   mc.onRelease = function() {
		 *   var filter:GlowFilter = this.filters[0];
		 *   filter.quality = 1;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createGlowFilterRectangle(name:String):MovieClip {
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
		 *     var filter:GlowFilter = new GlowFilter(0x000000, .8, 16, 16, 1, 3, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   rect.filters = filterArray;
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get quality () : int{
			return _quality;
		}
		public function set quality (value:int) : void{
			_quality = value;
		}

		/**
		 * The strength of the imprint or spread. The higher the value, 
		 * the more color is imprinted and the stronger the contrast between the glow and the background. 
		 * Valid values are 0 to 255. The default is 2.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example changes the <code>strength</code> property on an existing movie clip 
		 *   when a user clicks it.
		 *   <listing version="2.0">
		 *   import flash.filters.GlowFilter;
		 *   
		 *     var mc:MovieClip = createGlowFilterRectangle("GlowFilterStrength");
		 *   mc.onRelease = function() {
		 *   var filter:GlowFilter = this.filters[0];
		 *   filter.strength = .8;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createGlowFilterRectangle(name:String):MovieClip {
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
		 *     var filter:GlowFilter = new GlowFilter(0x000000, .8, 16, 16, 1, 3, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   rect.filters = filterArray;
		 *   return rect;
		 *   }
		 *   </listing>
		 */
		public function get strength () : Number{
			return _strength;
		}
		public function set strength (value:Number) : void{
			_strength = value;
		}
		
		public function get blur():Number 
		{
			return _blur;
		}
		
		public function get rgba():String 
		{
			return _rgba;
		}

		/**
		 * Returns a copy of this filter object.
		 * @return	A new GlowFilter instance with all the
		 *   properties of the original GlowFilter instance.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example creates three GlowFilter objects and compares them: <code>filter_1</code>
		 *   is created by using the GlowFilter constructor; <code>filter_2</code> is created by setting it equal to 
		 *   <code>filter_1</code>; and <code>clonedFilter</code> is created by cloning <code>filter_1</code>.  Notice
		 *   that although <code>filter_2</code> evaluates as being equal to <code>filter_1</code>, <code>clonedFilter</code>,
		 *   even though it contains the same values as <code>filter_1</code>, does not.
		 *   <listing version="2.0">
		 *   import flash.filters.GlowFilter;
		 *   
		 *     var filter_1:GlowFilter = new GlowFilter(0x33CCFF, .8, 35, 35, 2, 3, false, false);
		 *   var filter_2:GlowFilter = filter_1;
		 *   var clonedFilter:GlowFilter = filter_1.clone();
		 *   
		 *     trace(filter_1 == filter_2);		// true
		 *   trace(filter_1 == clonedFilter);	// false
		 *   
		 *     for(var i in filter_1) {
		 *   trace("&gt;&gt; " + i + ": " + filter_1[i]);
		 *   // &gt;&gt; clone: [type Function]
		 *   // &gt;&gt; strength: 2
		 *   // &gt;&gt; blurY: 35
		 *   // &gt;&gt; blurX: 35
		 *   // &gt;&gt; knockout: false
		 *   // &gt;&gt; inner: false
		 *   // &gt;&gt; quality: 3
		 *   // &gt;&gt; alpha: 0.8
		 *   // &gt;&gt; color: 3394815
		 *   }
		 *   
		 *     for(var i in clonedFilter) {
		 *   trace("&gt;&gt; " + i + ": " + clonedFilter[i]);
		 *   // &gt;&gt; clone: [type Function]
		 *   // &gt;&gt; strength: 2
		 *   // &gt;&gt; blurY: 35
		 *   // &gt;&gt; blurX: 35
		 *   // &gt;&gt; knockout: false
		 *   // &gt;&gt; inner: false
		 *   // &gt;&gt; quality: 3
		 *   // &gt;&gt; alpha: 0.8
		 *   // &gt;&gt; color: 3394815
		 *   }
		 *   </listing>
		 *   To further demonstrate the relationships between <code>filter_1</code>, <code>filter_2</code>, and <code>clonedFilter</code>,
		 *   the following example modifies the <code>knockout</code> property of <code>filter_1</code>.  Modifying <code>knockout</code> demonstrates
		 *   that the <code>clone()</code> method creates a new instance based on the values of <code>filter_1</code> instead of pointing to 
		 *   them in reference.
		 *   <listing version="2.0">
		 *   import flash.filters.GlowFilter;
		 *   
		 *     var filter_1:GlowFilter = new GlowFilter(0x33CCFF, .8, 35, 35, 2, 3, false, false);
		 *   var filter_2:GlowFilter = filter_1;
		 *   var clonedFilter:GlowFilter = filter_1.clone();
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
		//public function clone () : flash.filters.BitmapFilter;

		/**
		 * Initializes a new GlowFilter instance with the specified parameters.
		 * @param	color	The color of the glow, in the hexadecimal format 
		 *   0xRRGGBB. The default value is 0xFF0000.
		 * @param	alpha	The alpha transparency value for the color. Valid values are 0 to 1. For example,
		 *   .25 sets a transparency value of 25%.
		 * @param	blurX	The amount of horizontal blur. Valid values are 0 to 255 (floating point). Values
		 *   that are a power of 2 (such as 2, 4, 8, 16 and 32) are optimized 
		 *   to render more quickly than other values.
		 * @param	blurY	The amount of vertical blur. Valid values are 0 to 255 (floating point). 
		 *   Values that are a power of 2 (such as 2, 4, 8, 16 and 32) are optimized 
		 *   to render more quickly than other values.
		 * @param	strength	The strength of the imprint or spread. The higher the value, 
		 *   the more color is imprinted and the stronger the contrast between the glow and the background. 
		 *   Valid values are 0 to 255.
		 * @param	quality	The number of times to apply the filter. Use the BitmapFilterQuality constants:
		 *   BitmapFilterQuality.LOWBitmapFilterQuality.MEDIUMBitmapFilterQuality.HIGHFor more information, see the description of the quality property.
		 * @param	inner	Specifies whether the glow is an inner glow. The value  true specifies
		 *   an inner glow. The value false specifies an outer glow (a glow
		 *   around the outer edges of the object).
		 * @param	knockout	Specifies whether the object has a knockout effect. The value true
		 *   makes the object's fill transparent and reveals the background color of the document.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @maelexample	The following example instantiates a new GlowFilter instance and applies
		 *   it to a flat, rectangular shape.
		 *   <listing version="2.0">
		 *   import flash.filters.GlowFilter;
		 *   
		 *     var rect:MovieClip = createRectangle(100, 100, 0x003366, "gradientGlowFilterExample");
		 *   
		 *     var color:Number = 0x33CCFF;
		 *   var alpha:Number = .8;
		 *   var blurX:Number = 35;
		 *   var blurY:Number = 35;
		 *   var strength:Number = 2;
		 *   var quality:Number = 3;
		 *   var inner:Boolean = false;
		 *   var knockout:Boolean = false;
		 *   
		 *     var filter:GlowFilter = new GlowFilter(color, 
		 *   alpha, 
		 *   blurX, 
		 *   blurY, 
		 *   strength, 
		 *   quality, 
		 *   inner, 
		 *   knockout);
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
		public function GlowFilter (color:uint = 0xFF0000, alpha:Number = 1, blurX:Number = 6, blurY:Number = 6, strength:Number = 2, quality:int = 1, inner:Boolean = false, knockout:Boolean = false)
		{
			_color = color;
			_alpha = alpha;
			_blurX = blurX;
			_blurY = blurY;
			_strength = strength;
			_quality = quality;
			_inner = inner;
			_knockout = knockout;
			
			_rgba = "rgba(" + (color >> 16 & 0xff) + "," + (color >> 8 & 0xff) + "," + (color & 0xff) + "," + alpha + ")";
			_offsetX = _offsetY = _blur = Math.max(blurX, blurY);
		}
	}
}
