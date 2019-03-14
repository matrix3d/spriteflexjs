package flash.filters
{
	import flash.filters.BitmapFilter;

	/**
	 * The DropShadowFilter class lets you add a drop shadow to display objects.
	 * The shadow algorithm is based on the same box filter that the blur filter uses. You have 
	 * several options for the style of the drop shadow, including inner or outer shadow and knockout mode.
	 * You can apply the filter to any display object (that is, objects that inherit from the DisplayObject class), 
	 * such as MovieClip, SimpleButton, TextField, and Video objects, as well as to BitmapData objects.
	 * 
	 *   <p class="- topic/p ">The use of filters depends on the object to which you apply the filter:</p><ul class="- topic/ul "><li class="- topic/li ">To apply filters to display objects use the
	 * <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property (inherited from DisplayObject). Setting the <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> 
	 * property of an object does not modify the object, and you can remove the filter by clearing the
	 * <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property. </li><li class="- topic/li ">To apply filters to BitmapData objects, use the <codeph class="+ topic/ph pr-d/codeph ">BitmapData.applyFilter()</codeph> method.
	 * Calling <codeph class="+ topic/ph pr-d/codeph ">applyFilter()</codeph> on a BitmapData object takes the source BitmapData object 
	 * and the filter object and generates a filtered image as a result.</li></ul><p class="- topic/p ">If you apply a filter to a display object, the value of the <codeph class="+ topic/ph pr-d/codeph ">cacheAsBitmap</codeph> property of the 
	 * display object is set to <codeph class="+ topic/ph pr-d/codeph ">true</codeph>. If you clear all filters, the original value of 
	 * <codeph class="+ topic/ph pr-d/codeph ">cacheAsBitmap</codeph> is restored.</p><p class="- topic/p ">This filter supports Stage scaling. However, it does not support general scaling, rotation, and 
	 * skewing. If the object itself is scaled (if <codeph class="+ topic/ph pr-d/codeph ">scaleX</codeph> and <codeph class="+ topic/ph pr-d/codeph ">scaleY</codeph> are 
	 * set to a value other than 1.0), the filter is not scaled. It is scaled only when 
	 * the user zooms in on the Stage.</p><p class="- topic/p ">A filter is not applied if the resulting image exceeds the maximum dimensions.
	 * In  AIR 1.5 and Flash Player 10, the maximum is 8,191 pixels in width or height, 
	 * and the total number of pixels cannot exceed 16,777,215 pixels. (So, if an image is 8,191 pixels 
	 * wide, it can only be 2,048 pixels high.) In Flash Player 9 and earlier and AIR 1.1 and earlier, 
	 * the limitation is 2,880 pixels in height and 2,880 pixels in width.
	 * If, for example, you zoom in on a large movie clip with a filter applied, the filter is 
	 * turned off if the resulting image exceeds the maximum dimensions.</p>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example creates a yellow square and applies a drop shadow to it. 
	 * The general workflow of this example is as follows:
	 * <ol class="- topic/ol "><li class="- topic/li ">Declare three properties that are used to draw the square to which the 
	 * filter is applied.</li><li class="- topic/li ">Create the constructor function. The constructor calls the <codeph class="+ topic/ph pr-d/codeph ">draw()</codeph> method,
	 * which uses methods of the Graphics class accessed through the <codeph class="+ topic/ph pr-d/codeph ">graphics</codeph>
	 * property of Sprite to draw an orange square.</li><li class="- topic/li ">In the constructor, declare a variable <codeph class="+ topic/ph pr-d/codeph ">filter</codeph> as a BitmapFilter object 
	 * and assign it to the return value of a call to <codeph class="+ topic/ph pr-d/codeph ">getBitmapFilter()</codeph>.
	 * The <codeph class="+ topic/ph pr-d/codeph ">getBitmapFilter()</codeph> method defines the drop shadow filter used.</li><li class="- topic/li ">Create a new Array object <codeph class="+ topic/ph pr-d/codeph ">myFilters</codeph> and add <codeph class="+ topic/ph pr-d/codeph ">filter</codeph> to
	 * the array. Assign the <codeph class="+ topic/ph pr-d/codeph ">myFilters</codeph> array to the <codeph class="+ topic/ph pr-d/codeph ">filters</codeph> property of 
	 * the DropShadowFilterExample object.  This applies all filters found in <codeph class="+ topic/ph pr-d/codeph ">myFilters</codeph>, which in this case
	 * is only <codeph class="+ topic/ph pr-d/codeph ">filter</codeph>.</li></ol><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * 
	 *   package {
	 * import flash.display.Sprite;
	 * import flash.events.Event;
	 * import flash.events.MouseEvent;
	 * import flash.filters.BitmapFilter;
	 * import flash.filters.BitmapFilterQuality;
	 * import flash.filters.DropShadowFilter;
	 * 
	 *   public class DropShadowFilterExample extends Sprite {
	 * private var bgColor:uint = 0xFFCC00;
	 * private var size:uint    = 80;
	 * private var offset:uint  = 50;
	 * 
	 *   public function DropShadowFilterExample() {
	 * draw();
	 * var filter:BitmapFilter = getBitmapFilter();
	 * var myFilters:Array = new Array();
	 * myFilters.push(filter);
	 * filters = myFilters;
	 * }
	 * 
	 *   private function getBitmapFilter():BitmapFilter {
	 * var color:Number = 0x000000;
	 * var angle:Number = 45;
	 * var alpha:Number = 0.8;
	 * var blurX:Number = 8;
	 * var blurY:Number = 8;
	 * var distance:Number = 15;
	 * var strength:Number = 0.65;
	 * var inner:Boolean = false;
	 * var knockout:Boolean = false;
	 * var quality:Number = BitmapFilterQuality.HIGH;
	 * return new DropShadowFilter(distance,
	 * angle,
	 * color,
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
	public final class DropShadowFilter extends BitmapFilter
	{
		private var _alpha:Number = 1;
		private var _angle:Number = 0;
		private var _blurX:Number = 0;
		private var _blurY:Number = 0;
		private var _color:uint = 0x000000;
		private var _distance:Number = 5;
		private var _hideObject:Boolean = false;
		private var _inner:Boolean = false;
		private var _knockout:Boolean = false;
		private var _quality:int = 1;
		private var _strength:Number = 1;
		private var _rgba:String;
		private var _blur:Number;

		/**
		 * The alpha transparency value for the shadow color. Valid values are 0.0 to 1.0. 
		 * For example,
		 * .25 sets a transparency value of 25%. The default value is 1.0.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>alpha</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.DropShadowFilter;
		 *   var mc:MovieClip = createDropShadowRectangle("DropShadowAlpha");
		 *   mc.onRelease = function() {
		 *   var filter:DropShadowFilter = this.filters[0];
		 *   filter.alpha = .4;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createDropShadowRectangle(name:String):MovieClip {
		 *   var art:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   art.beginFill(0x003366);
		 *   art.lineTo(w, 0);
		 *   art.lineTo(w, h);
		 *   art.lineTo(0, h);
		 *   art.lineTo(0, 0);
		 *   art._x = 20;
		 *   art._y = 20;
		 *   
		 *     var filter:DropShadowFilter = new DropShadowFilter(15, 45, 0x000000, .8, 16, 16, 1, 3, false, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   art.filters = filterArray;
		 *   return art;
		 *   }
		 *   </listing>
		 */
		public function get alpha():Number { return _alpha; }
		public function set alpha(value:Number):void { _alpha = value; }

		/**
		 * The angle of the shadow. Valid values are 0 to 360 degrees(floating point). The
		 * default value is 45.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>angle</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.DropShadowFilter;
		 *   var mc:MovieClip = createDropShadowRectangle("DropShadowAngle");
		 *   mc.onRelease = function() {
		 *   var filter:DropShadowFilter = this.filters[0];
		 *   filter.angle = 135;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createDropShadowRectangle(name:String):MovieClip {
		 *   var art:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   art.beginFill(0x003366);
		 *   art.lineTo(w, 0);
		 *   art.lineTo(w, h);
		 *   art.lineTo(0, h);
		 *   art.lineTo(0, 0);
		 *   art._x = 20;
		 *   art._y = 20;
		 *   
		 *     var filter:DropShadowFilter = new DropShadowFilter(15, 45, 0x000000, .8, 16, 16, 1, 3, false, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   art.filters = filterArray;
		 *   return art;
		 *   }
		 *   </listing>
		 */
		public function get angle():Number { return _angle; }
		public function set angle(value:Number):void { _angle = value; }

		/**
		 * The amount of horizontal blur. Valid values are 0 to 255.0(floating point). The
		 * default value is 4.0.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>blurX</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.DropShadowFilter;
		 *   var mc:MovieClip = createDropShadowRectangle("DropShadowBlurX");
		 *   mc.onRelease = function() {
		 *   var filter:DropShadowFilter = this.filters[0];
		 *   filter.blurX = 40;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createDropShadowRectangle(name:String):MovieClip {
		 *   var art:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   art.beginFill(0x003366);
		 *   art.lineTo(w, 0);
		 *   art.lineTo(w, h);
		 *   art.lineTo(0, h);
		 *   art.lineTo(0, 0);
		 *   art._x = 20;
		 *   art._y = 20;
		 *   
		 *     var filter:DropShadowFilter = new DropShadowFilter(15, 45, 0x000000, .8, 16, 16, 1, 3, false, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   art.filters = filterArray;
		 *   return art;
		 *   }
		 *   </listing>
		 */
		public function get blurX():Number { return _blurX; }
		public function set blurX(value:Number):void { _blurX = value; }

		/**
		 * The amount of vertical blur. Valid values are 0 to 255.0(floating point). The
		 * default value is 4.0.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>blurY</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.DropShadowFilter;
		 *   var mc:MovieClip = createDropShadowRectangle("DropShadowBlurY");
		 *   mc.onRelease = function() {
		 *   var filter:DropShadowFilter = this.filters[0];
		 *   filter.blurY = 40;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createDropShadowRectangle(name:String):MovieClip {
		 *   var art:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   art.beginFill(0x003366);
		 *   art.lineTo(w, 0);
		 *   art.lineTo(w, h);
		 *   art.lineTo(0, h);
		 *   art.lineTo(0, 0);
		 *   art._x = 20;
		 *   art._y = 20;
		 *   
		 *     var filter:DropShadowFilter = new DropShadowFilter(15, 45, 0x000000, .8, 16, 16, 1, 3, false, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   art.filters = filterArray;
		 *   return art;
		 *   }
		 *   </listing>
		 */
		public function get blurY():Number { return _blurY; }
		public function set blurY(value:Number):void { _blurY = value; }

		/**
		 * The color of the shadow. Valid values are in hexadecimal format 0xRRGGBB. The 
		 * default value is 0x000000.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>color</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.DropShadowFilter;
		 *   var mc:MovieClip = createDropShadowRectangle("DropShadowColor");
		 *   mc.onRelease = function() {
		 *   var filter:DropShadowFilter = this.filters[0];
		 *   filter.color = 0xFF0000;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createDropShadowRectangle(name:String):MovieClip {
		 *   var art:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   art.beginFill(0x003366);
		 *   art.lineTo(w, 0);
		 *   art.lineTo(w, h);
		 *   art.lineTo(0, h);
		 *   art.lineTo(0, 0);
		 *   art._x = 20;
		 *   art._y = 20;
		 *   
		 *     var filter:DropShadowFilter = new DropShadowFilter(15, 45, 0x000000, .8, 16, 16, 1, 3, false, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   art.filters = filterArray;
		 *   return art;
		 *   }
		 *   </listing>
		 */
		public function get color():uint { return _color; }
		public function set color(value:uint):void { _color = value; }

		/**
		 * The offset distance for the shadow, in pixels. The default
		 * value is 4.0(floating point).
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>distance</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.DropShadowFilter;
		 *   var mc:MovieClip = createDropShadowRectangle("DropShadowDistance");
		 *   mc.onRelease = function() {
		 *   var filter:DropShadowFilter = this.filters[0];
		 *   filter.distance = 40;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createDropShadowRectangle(name:String):MovieClip {
		 *   var art:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   art.beginFill(0x003366);
		 *   art.lineTo(w, 0);
		 *   art.lineTo(w, h);
		 *   art.lineTo(0, h);
		 *   art.lineTo(0, 0);
		 *   art._x = 20;
		 *   art._y = 20;
		 *   
		 *     var filter:DropShadowFilter = new DropShadowFilter(15, 45, 0x000000, .8, 16, 16, 1, 3, false, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   art.filters = filterArray;
		 *   return art;
		 *   }
		 *   </listing>
		 */
		public function get distance():Number { return _distance; }
		public function set distance(value:Number):void { _distance = value; }


		/**
		 * Indicates whether or not the object is hidden. The value true 
		 * indicates that the object itself is not drawn; only the shadow is visible.
		 * The default is false(the object is shown).
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>hideObject</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.DropShadowFilter;
		 *   var mc:MovieClip = createDropShadowRectangle("DropShadowHideObject");
		 *   mc.onRelease = function() {
		 *   var filter:DropShadowFilter = this.filters[0];
		 *   filter.hideObject = true;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createDropShadowRectangle(name:String):MovieClip {
		 *   var art:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   art.beginFill(0x003366);
		 *   art.lineTo(w, 0);
		 *   art.lineTo(w, h);
		 *   art.lineTo(0, h);
		 *   art.lineTo(0, 0);
		 *   art._x = 20;
		 *   art._y = 20;
		 *   
		 *     var filter:DropShadowFilter = new DropShadowFilter(15, 45, 0x000000, .8, 16, 16, 1, 3, false, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   art.filters = filterArray;
		 *   return art;
		 *   }
		 *   </listing>
		 */
		public function get hideObject():Boolean { return _hideObject; }
		public function set hideObject(value:Boolean):void { _hideObject = value; }

		/**
		 * Indicates whether or not the shadow is an inner shadow. The value true indicates
		 * an inner shadow. The default is false, an outer shadow(a
		 * shadow around the outer edges of the object).
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>inner</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.DropShadowFilter;
		 *   var mc:MovieClip = createDropShadowRectangle("DropShadowInner");
		 *   mc.onRelease = function() {
		 *   var filter:DropShadowFilter = this.filters[0];
		 *   filter.inner = true;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createDropShadowRectangle(name:String):MovieClip {
		 *   var art:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   art.beginFill(0x003366);
		 *   art.lineTo(w, 0);
		 *   art.lineTo(w, h);
		 *   art.lineTo(0, h);
		 *   art.lineTo(0, 0);
		 *   art._x = 20;
		 *   art._y = 20;
		 *   
		 *     var filter:DropShadowFilter = new DropShadowFilter(15, 45, 0x000000, .8, 16, 16, 1, 3, false, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   art.filters = filterArray;
		 *   return art;
		 *   }
		 *   </listing>
		 */
		public function get inner():Boolean { return _inner; }
		public function set inner(value:Boolean):void { _inner = value; }

		/**
		 * Applies a knockout effect(true), which effectively 
		 * makes the object's fill transparent and reveals the background color of the document. The 
		 * default is false(no knockout).
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>knockout</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.DropShadowFilter;
		 *   var mc:MovieClip = createDropShadowRectangle("DropShadowKnockout");
		 *   mc.onRelease = function() {
		 *   var filter:DropShadowFilter = this.filters[0];
		 *   filter.knockout = true;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createDropShadowRectangle(name:String):MovieClip {
		 *   var art:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   art.beginFill(0x003366);
		 *   art.lineTo(w, 0);
		 *   art.lineTo(w, h);
		 *   art.lineTo(0, h);
		 *   art.lineTo(0, 0);
		 *   art._x = 20;
		 *   art._y = 20;
		 *   
		 *     var filter:DropShadowFilter = new DropShadowFilter(15, 45, 0x000000, .8, 16, 16, 1, 3, false, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   art.filters = filterArray;
		 *   return art;
		 *   }
		 *   </listing>
		 */
		public function get knockout():Boolean { return _knockout; }
		public function set knockout(value:Boolean):void { _knockout = value; }

		/**
		 * The number of times to apply the filter. 
		 * The default value is BitmapFilterQuality.LOW, which is equivalent to applying
		 * the filter once. The value BitmapFilterQuality.MEDIUM applies the filter twice;
		 * the value BitmapFilterQuality.HIGH applies it three times. Filters with lower values
		 * are rendered more quickly.
		 * 
		 *   For most applications, a quality value of low, medium, or high is sufficient. 
		 * Although you can use additional numeric values up to 15 to achieve different effects,
		 * higher values are rendered more slowly. Instead of increasing the value of quality,
		 * you can often get a similar effect, and with faster rendering, by simply increasing
		 * the values of the blurX and blurY properties.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>quality</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.DropShadowFilter;
		 *   var mc:MovieClip = createDropShadowRectangle("DropShadowQuality");
		 *   mc.onRelease = function() {
		 *   var filter:DropShadowFilter = this.filters[0];
		 *   filter.quality = 0;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createDropShadowRectangle(name:String):MovieClip {
		 *   var art:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   art.beginFill(0x003366);
		 *   art.lineTo(w, 0);
		 *   art.lineTo(w, h);
		 *   art.lineTo(0, h);
		 *   art.lineTo(0, 0);
		 *   art._x = 20;
		 *   art._y = 20;
		 *   
		 *     var filter:DropShadowFilter = new DropShadowFilter(15, 45, 0x000000, .8, 16, 16, 1, 3, false, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   art.filters = filterArray;
		 *   return art;
		 *   }
		 *   </listing>
		 */
		public function get quality():int { return _quality; }
		public function set quality(value:int):void { _quality = value; }

		/**
		 * The strength of the imprint or spread. The higher the value, 
		 * the more color is imprinted and the stronger the contrast between the shadow and the background. 
		 * Valid values are from 0 to 255.0. The default is 1.0.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example changes the <code>strength</code> property on an existing MovieClip 
		 *   when a user clicks on it.
		 *   <listing version="2.0">
		 *   import flash.filters.DropShadowFilter;
		 *   var mc:MovieClip = createDropShadowRectangle("DropShadowStrength");
		 *   mc.onRelease = function() {
		 *   var filter:DropShadowFilter = this.filters[0];
		 *   filter.strength = .6;
		 *   this.filters = new Array(filter);
		 *   }
		 *   
		 *     function createDropShadowRectangle(name:String):MovieClip {
		 *   var art:MovieClip = this.createEmptyMovieClip(name, this.getNextHighestDepth());
		 *   var w:Number = 100;
		 *   var h:Number = 100;
		 *   art.beginFill(0x003366);
		 *   art.lineTo(w, 0);
		 *   art.lineTo(w, h);
		 *   art.lineTo(0, h);
		 *   art.lineTo(0, 0);
		 *   art._x = 20;
		 *   art._y = 20;
		 *   
		 *     var filter:DropShadowFilter = new DropShadowFilter(15, 45, 0x000000, .8, 16, 16, 1, 3, false, false, false);
		 *   var filterArray:Array = new Array();
		 *   filterArray.push(filter);
		 *   art.filters = filterArray;
		 *   return art;
		 *   }
		 *   </listing>
		 */
		public function get strength():Number { return _strength; }
		public function set strength(value:Number):void { _strength = value; }
		
		public function get rgba():String { return _rgba; }
		public function get blur():Number { return _blur; }

		/**
		 * Returns a copy of this filter object.
		 * @return	A new DropShadowFilter instance with all the
		 *   properties of the original DropShadowFilter instance.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example creates three DropShadowFilter objects and compares them.  <code>filter_1</code>
		 *   is created using the DropShadowFilter construtor.  <code>filter_2</code> is created by setting it equal to 
		 *   <code>filter_1</code>.  And, <code>clonedFilter</code> is created by cloning <code>filter_1</code>.  Notice
		 *   that while <code>filter_2</code> evaluates as being equal to <code>filter_1</code>, <code>clonedFilter</code>,
		 *   even though it contains the same values as <code>filter_1</code>, does not.
		 *   <listing version="2.0">
		 *   import flash.filters.DropShadowFilter;
		 *   
		 *     var filter_1:DropShadowFilter = new DropShadowFilter(15, 45, 0x000000, .8, 16, 16, 1, 3, false, false, false);
		 *   var filter_2:DropShadowFilter = filter_1;
		 *   var clonedFilter:DropShadowFilter = filter_1.clone();
		 *   
		 *     trace(filter_1 == filter_2);		// true
		 *   trace(filter_1 == clonedFilter);	// false
		 *   
		 *     for(var i in filter_1) {
		 *   trace("&gt;&gt; " + i + ": " + filter_1[i]);
		 *   // &gt;&gt; clone: [type Function]
		 *   // &gt;&gt; hideObject: false
		 *   // &gt;&gt; strength: 1
		 *   // &gt;&gt; blurY: 16
		 *   // &gt;&gt; blurX: 16
		 *   // &gt;&gt; knockout: false
		 *   // &gt;&gt; inner: false
		 *   // &gt;&gt; quality: 3
		 *   // &gt;&gt; alpha: 0.8
		 *   // &gt;&gt; color: 0
		 *   // &gt;&gt; angle: 45
		 *   // &gt;&gt; distance: 15
		 *   }
		 *   
		 *     for(var i in clonedFilter) {
		 *   trace("&gt;&gt; " + i + ": " + clonedFilter[i]);
		 *   // &gt;&gt; clone: [type Function]
		 *   // &gt;&gt; hideObject: false
		 *   // &gt;&gt; strength: 1
		 *   // &gt;&gt; blurY: 16
		 *   // &gt;&gt; blurX: 16
		 *   // &gt;&gt; knockout: false
		 *   // &gt;&gt; inner: false
		 *   // &gt;&gt; quality: 3
		 *   // &gt;&gt; alpha: 0.8
		 *   // &gt;&gt; color: 0
		 *   // &gt;&gt; angle: 45
		 *   // &gt;&gt; distance: 15
		 *   }
		 *   </listing>
		 *   To further demonstrate the relationships between <code>filter_1</code>, <code>filter_2</code>, and <code>clonedFilter</code>
		 *   the example below modifies the <code>knockout</code> property of <code>filter_1</code>.  Modifying <code>knockout</code> demonstrates
		 *   that the <code>clone()</code> method creates a new instance based on values of the <code>filter_1</code> instead of pointing to 
		 *   them in reference.
		 *   <listing version="2.0">
		 *   import flash.filters.DropShadowFilter;
		 *   
		 *     var filter_1:DropShadowFilter = new DropShadowFilter(15, 45, 0x000000, .8, 16, 16, 1, 3, false, false, false);
		 *   var filter_2:DropShadowFilter = filter_1;
		 *   var clonedFilter:DropShadowFilter = filter_1.clone();
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
		override public function clone():flash.filters.BitmapFilter
		{ 
			return null; 
		}

		/**
		 * Creates a new DropShadowFilter instance with the specified parameters.
		 * @param	distance	Offset distance for the shadow, in pixels.
		 * @param	angle	Angle of the shadow, 0 to 360 degrees(floating point).
		 * @param	color	Color of the shadow, in hexadecimal format 
		 *   0xRRGGBB. The default value is 0x000000.
		 * @param	alpha	Alpha transparency value for the shadow color. Valid values are 0.0 to 1.0. 
		 *   For example,
		 *   .25 sets a transparency value of 25%.
		 * @param	blurX	Amount of horizontal blur. Valid values are 0 to 255.0(floating point).
		 * @param	blurY	Amount of vertical blur. Valid values are 0 to 255.0(floating point).
		 * @param	strength	The strength of the imprint or spread. The higher the value, 
		 *   the more color is imprinted and the stronger the contrast between the shadow and the background. 
		 *   Valid values are 0 to 255.0.
		 * @param	quality	The number of times to apply the filter. Use the BitmapFilterQuality constants:
		 *   BitmapFilterQuality.LOWBitmapFilterQuality.MEDIUMBitmapFilterQuality.HIGHFor more information about these values, see the quality property description.
		 * @param	inner	Indicates whether or not the shadow is an inner shadow. A value of true specifies
		 *   an inner shadow. A value of false specifies an outer shadow(a
		 *   shadow around the outer edges of the object).
		 * @param	knockout	Applies a knockout effect(true), which effectively 
		 *   makes the object's fill transparent and reveals the background color of the document.
		 * @param	hideObject	Indicates whether or not the object is hidden. A value of true 
		 *   indicates that the object itself is not drawn; only the shadow is visible.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @example	The following example creates a new DropShadowFilter object
		 *   with the default values:
		 *   <pre xml:space="preserve" class="- topic/pre ">
		 *   myFilter = new flash.filters.DropShadowFilter()
		 *   </pre>
		 */
		public function DropShadowFilter(distance:Number = 4, angle:Number = 45, color:uint = 0, alpha:Number = 1, blurX:Number = 4, blurY:Number = 4, strength:Number = 1, quality:int = 1, inner:Boolean = false, knockout:Boolean = false, hideObject:Boolean = false)
		{
			_distance = distance;
			_angle = angle;
			_color = color;
			_alpha = alpha;
			_blurX = blurX;
			_blurY = blurY;
			_strength = strength;
			_quality = quality;
			_inner = inner;
			_knockout = knockout;
			_hideObject = hideObject;
			
			var radians:Number = Math.PI / 180 * angle;
			_offsetX = distance * Math.cos(radians);
			_offsetY = distance * Math.sin(radians);
			
			_rgba = "rgba(" + (color >> 16 & 0xff) + "," + (color >> 8 & 0xff) + "," + (color & 0xff) + "," + alpha + ")";
			_blur = Math.max(blurX, blurY);
		}
	}
}
