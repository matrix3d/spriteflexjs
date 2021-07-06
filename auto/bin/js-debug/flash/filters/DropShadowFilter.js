/**
 * Generated by Apache Royale Compiler from flash/filters/DropShadowFilter.as
 * flash.filters.DropShadowFilter
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.filters.DropShadowFilter');
/* Royale Dependency List: */

goog.require('flash.filters.BitmapFilter');



/**
 * Creates a new DropShadowFilter instance with the specified parameters.
 * @asparam	distance	Offset distance for the shadow, in pixels.
 * @asparam	angle	Angle of the shadow, 0 to 360 degrees(floating point).
 * @asparam	color	Color of the shadow, in hexadecimal format 
 *   0xRRGGBB. The default value is 0x000000.
 * @asparam	alpha	Alpha transparency value for the shadow color. Valid values are 0.0 to 1.0. 
 *   For example,
 *   .25 sets a transparency value of 25%.
 * @asparam	blurX	Amount of horizontal blur. Valid values are 0 to 255.0(floating point).
 * @asparam	blurY	Amount of vertical blur. Valid values are 0 to 255.0(floating point).
 * @asparam	strength	The strength of the imprint or spread. The higher the value, 
 *   the more color is imprinted and the stronger the contrast between the shadow and the background. 
 *   Valid values are 0 to 255.0.
 * @asparam	quality	The number of times to apply the filter. Use the BitmapFilterQuality constants:
 *   BitmapFilterQuality.LOWBitmapFilterQuality.MEDIUMBitmapFilterQuality.HIGHFor more information about these values, see the quality property description.
 * @asparam	inner	Indicates whether or not the shadow is an inner shadow. A value of true specifies
 *   an inner shadow. A value of false specifies an outer shadow(a
 *   shadow around the outer edges of the object).
 * @asparam	knockout	Applies a knockout effect(true), which effectively 
 *   makes the object's fill transparent and reveals the background color of the document.
 * @asparam	hideObject	Indicates whether or not the object is hidden. A value of true 
 *   indicates that the object itself is not drawn; only the shadow is visible.
 * @langversion	3.0
 * @playerversion	Flash 9
 * @example	The following example creates a new DropShadowFilter object
 *   with the default values:
 *   <pre xml:space="preserve" class="- topic/pre ">
 *   myFilter = new flash.filters.DropShadowFilter()
 *   </pre>
 * @constructor
 * @extends {flash.filters.BitmapFilter}
 * @param {number=} distance
 * @param {number=} angle
 * @param {number=} color
 * @param {number=} alpha
 * @param {number=} blurX
 * @param {number=} blurY
 * @param {number=} strength
 * @param {number=} quality
 * @param {boolean=} inner
 * @param {boolean=} knockout
 * @param {boolean=} hideObject
 */
flash.filters.DropShadowFilter = function(distance, angle, color, alpha, blurX, blurY, strength, quality, inner, knockout, hideObject) {
  flash.filters.DropShadowFilter.base(this, 'constructor');
  distance = typeof distance !== 'undefined' ? distance : 4;
  angle = typeof angle !== 'undefined' ? angle : 45;
  color = typeof color !== 'undefined' ? color : 0;
  alpha = typeof alpha !== 'undefined' ? alpha : 1;
  blurX = typeof blurX !== 'undefined' ? blurX : 4;
  blurY = typeof blurY !== 'undefined' ? blurY : 4;
  strength = typeof strength !== 'undefined' ? strength : 1;
  quality = typeof quality !== 'undefined' ? quality : 1;
  inner = typeof inner !== 'undefined' ? inner : false;
  knockout = typeof knockout !== 'undefined' ? knockout : false;
  hideObject = typeof hideObject !== 'undefined' ? hideObject : false;
  this.flash_filters_DropShadowFilter__distance = distance;
  this.flash_filters_DropShadowFilter__angle = angle;
  this.flash_filters_DropShadowFilter__color = color;
  this.flash_filters_DropShadowFilter__alpha = alpha;
  this.flash_filters_DropShadowFilter__blurX = blurX;
  this.flash_filters_DropShadowFilter__blurY = blurY;
  this.flash_filters_DropShadowFilter__strength = strength;
  this.flash_filters_DropShadowFilter__quality = quality;
  this.flash_filters_DropShadowFilter__inner = inner;
  this.flash_filters_DropShadowFilter__knockout = knockout;
  this.flash_filters_DropShadowFilter__hideObject = hideObject;
  var /** @type {number} */ radians = Math.PI / 180 * angle;
  this._offsetX = distance * Math.cos(radians);
  this._offsetY = distance * Math.sin(radians);
  this.flash_filters_DropShadowFilter__rgba = "rgba(" + (color >> 16 & 0xff) + "," + (color >> 8 & 0xff) + "," + (color & 0xff) + "," + alpha + ")";
  this.flash_filters_DropShadowFilter__blur = Math.max(blurX, blurY);
};
goog.inherits(flash.filters.DropShadowFilter, flash.filters.BitmapFilter);


/**
 * @private
 * @type {number}
 */
flash.filters.DropShadowFilter.prototype.flash_filters_DropShadowFilter__alpha = 1;


/**
 * @private
 * @type {number}
 */
flash.filters.DropShadowFilter.prototype.flash_filters_DropShadowFilter__angle = 0;


/**
 * @private
 * @type {number}
 */
flash.filters.DropShadowFilter.prototype.flash_filters_DropShadowFilter__blurX = 0;


/**
 * @private
 * @type {number}
 */
flash.filters.DropShadowFilter.prototype.flash_filters_DropShadowFilter__blurY = 0;


/**
 * @private
 * @type {number}
 */
flash.filters.DropShadowFilter.prototype.flash_filters_DropShadowFilter__color = 0x0;


/**
 * @private
 * @type {number}
 */
flash.filters.DropShadowFilter.prototype.flash_filters_DropShadowFilter__distance = 5;


/**
 * @private
 * @type {boolean}
 */
flash.filters.DropShadowFilter.prototype.flash_filters_DropShadowFilter__hideObject = false;


/**
 * @private
 * @type {boolean}
 */
flash.filters.DropShadowFilter.prototype.flash_filters_DropShadowFilter__inner = false;


/**
 * @private
 * @type {boolean}
 */
flash.filters.DropShadowFilter.prototype.flash_filters_DropShadowFilter__knockout = false;


/**
 * @private
 * @type {number}
 */
flash.filters.DropShadowFilter.prototype.flash_filters_DropShadowFilter__quality = 1;


/**
 * @private
 * @type {number}
 */
flash.filters.DropShadowFilter.prototype.flash_filters_DropShadowFilter__strength = 1;


/**
 * @private
 * @type {string}
 */
flash.filters.DropShadowFilter.prototype.flash_filters_DropShadowFilter__rgba = null;


/**
 * @private
 * @type {number}
 */
flash.filters.DropShadowFilter.prototype.flash_filters_DropShadowFilter__blur = NaN;


/**
 * Returns a copy of this filter object.
 * @asreturn	A new DropShadowFilter instance with all the
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
 * @override
 */
flash.filters.DropShadowFilter.prototype.clone = function() {
  return null;
};


flash.filters.DropShadowFilter.prototype.get__alpha = function() {
  return this.flash_filters_DropShadowFilter__alpha;
};


flash.filters.DropShadowFilter.prototype.set__alpha = function(value) {
  this.flash_filters_DropShadowFilter__alpha = value;
};


flash.filters.DropShadowFilter.prototype.get__angle = function() {
  return this.flash_filters_DropShadowFilter__angle;
};


flash.filters.DropShadowFilter.prototype.set__angle = function(value) {
  this.flash_filters_DropShadowFilter__angle = value;
};


flash.filters.DropShadowFilter.prototype.get__blurX = function() {
  return this.flash_filters_DropShadowFilter__blurX;
};


flash.filters.DropShadowFilter.prototype.set__blurX = function(value) {
  this.flash_filters_DropShadowFilter__blurX = value;
};


flash.filters.DropShadowFilter.prototype.get__blurY = function() {
  return this.flash_filters_DropShadowFilter__blurY;
};


flash.filters.DropShadowFilter.prototype.set__blurY = function(value) {
  this.flash_filters_DropShadowFilter__blurY = value;
};


flash.filters.DropShadowFilter.prototype.get__color = function() {
  return this.flash_filters_DropShadowFilter__color;
};


flash.filters.DropShadowFilter.prototype.set__color = function(value) {
  this.flash_filters_DropShadowFilter__color = value;
};


flash.filters.DropShadowFilter.prototype.get__distance = function() {
  return this.flash_filters_DropShadowFilter__distance;
};


flash.filters.DropShadowFilter.prototype.set__distance = function(value) {
  this.flash_filters_DropShadowFilter__distance = value;
};


flash.filters.DropShadowFilter.prototype.get__hideObject = function() {
  return this.flash_filters_DropShadowFilter__hideObject;
};


flash.filters.DropShadowFilter.prototype.set__hideObject = function(value) {
  this.flash_filters_DropShadowFilter__hideObject = value;
};


flash.filters.DropShadowFilter.prototype.get__inner = function() {
  return this.flash_filters_DropShadowFilter__inner;
};


flash.filters.DropShadowFilter.prototype.set__inner = function(value) {
  this.flash_filters_DropShadowFilter__inner = value;
};


flash.filters.DropShadowFilter.prototype.get__knockout = function() {
  return this.flash_filters_DropShadowFilter__knockout;
};


flash.filters.DropShadowFilter.prototype.set__knockout = function(value) {
  this.flash_filters_DropShadowFilter__knockout = value;
};


flash.filters.DropShadowFilter.prototype.get__quality = function() {
  return this.flash_filters_DropShadowFilter__quality;
};


flash.filters.DropShadowFilter.prototype.set__quality = function(value) {
  this.flash_filters_DropShadowFilter__quality = value;
};


flash.filters.DropShadowFilter.prototype.get__strength = function() {
  return this.flash_filters_DropShadowFilter__strength;
};


flash.filters.DropShadowFilter.prototype.set__strength = function(value) {
  this.flash_filters_DropShadowFilter__strength = value;
};


flash.filters.DropShadowFilter.prototype.get__rgba = function() {
  return this.flash_filters_DropShadowFilter__rgba;
};


flash.filters.DropShadowFilter.prototype.get__blur = function() {
  return this.flash_filters_DropShadowFilter__blur;
};


Object.defineProperties(flash.filters.DropShadowFilter.prototype, /** @lends {flash.filters.DropShadowFilter.prototype} */ {
/**
 * @type {number}
 */
alpha: {
get: flash.filters.DropShadowFilter.prototype.get__alpha,
set: flash.filters.DropShadowFilter.prototype.set__alpha},
/**
 * @type {number}
 */
angle: {
get: flash.filters.DropShadowFilter.prototype.get__angle,
set: flash.filters.DropShadowFilter.prototype.set__angle},
/**
 * @type {number}
 */
blurX: {
get: flash.filters.DropShadowFilter.prototype.get__blurX,
set: flash.filters.DropShadowFilter.prototype.set__blurX},
/**
 * @type {number}
 */
blurY: {
get: flash.filters.DropShadowFilter.prototype.get__blurY,
set: flash.filters.DropShadowFilter.prototype.set__blurY},
/**
 * @type {number}
 */
color: {
get: flash.filters.DropShadowFilter.prototype.get__color,
set: flash.filters.DropShadowFilter.prototype.set__color},
/**
 * @type {number}
 */
distance: {
get: flash.filters.DropShadowFilter.prototype.get__distance,
set: flash.filters.DropShadowFilter.prototype.set__distance},
/**
 * @type {boolean}
 */
hideObject: {
get: flash.filters.DropShadowFilter.prototype.get__hideObject,
set: flash.filters.DropShadowFilter.prototype.set__hideObject},
/**
 * @type {boolean}
 */
inner: {
get: flash.filters.DropShadowFilter.prototype.get__inner,
set: flash.filters.DropShadowFilter.prototype.set__inner},
/**
 * @type {boolean}
 */
knockout: {
get: flash.filters.DropShadowFilter.prototype.get__knockout,
set: flash.filters.DropShadowFilter.prototype.set__knockout},
/**
 * @type {number}
 */
quality: {
get: flash.filters.DropShadowFilter.prototype.get__quality,
set: flash.filters.DropShadowFilter.prototype.set__quality},
/**
 * @type {number}
 */
strength: {
get: flash.filters.DropShadowFilter.prototype.get__strength,
set: flash.filters.DropShadowFilter.prototype.set__strength},
/**
 * @type {string}
 */
rgba: {
get: flash.filters.DropShadowFilter.prototype.get__rgba},
/**
 * @type {number}
 */
blur: {
get: flash.filters.DropShadowFilter.prototype.get__blur}}
);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.filters.DropShadowFilter.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'DropShadowFilter', qName: 'flash.filters.DropShadowFilter', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.filters.DropShadowFilter.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    accessors: function () {
      return {
        'alpha': { type: 'Number', access: 'readwrite', declaredBy: 'flash.filters.DropShadowFilter'},
        'angle': { type: 'Number', access: 'readwrite', declaredBy: 'flash.filters.DropShadowFilter'},
        'blurX': { type: 'Number', access: 'readwrite', declaredBy: 'flash.filters.DropShadowFilter'},
        'blurY': { type: 'Number', access: 'readwrite', declaredBy: 'flash.filters.DropShadowFilter'},
        'color': { type: 'uint', access: 'readwrite', declaredBy: 'flash.filters.DropShadowFilter'},
        'distance': { type: 'Number', access: 'readwrite', declaredBy: 'flash.filters.DropShadowFilter'},
        'hideObject': { type: 'Boolean', access: 'readwrite', declaredBy: 'flash.filters.DropShadowFilter'},
        'inner': { type: 'Boolean', access: 'readwrite', declaredBy: 'flash.filters.DropShadowFilter'},
        'knockout': { type: 'Boolean', access: 'readwrite', declaredBy: 'flash.filters.DropShadowFilter'},
        'quality': { type: 'int', access: 'readwrite', declaredBy: 'flash.filters.DropShadowFilter'},
        'strength': { type: 'Number', access: 'readwrite', declaredBy: 'flash.filters.DropShadowFilter'},
        'rgba': { type: 'String', access: 'readonly', declaredBy: 'flash.filters.DropShadowFilter'},
        'blur': { type: 'Number', access: 'readonly', declaredBy: 'flash.filters.DropShadowFilter'}
      };
    },
    methods: function () {
      return {
        'clone': { type: 'flash.filters.BitmapFilter', declaredBy: 'flash.filters.DropShadowFilter'},
        'DropShadowFilter': { type: '', declaredBy: 'flash.filters.DropShadowFilter', parameters: function () { return [ 'Number', true ,'Number', true ,'uint', true ,'Number', true ,'Number', true ,'Number', true ,'Number', true ,'int', true ,'Boolean', true ,'Boolean', true ,'Boolean', true ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.filters.DropShadowFilter.prototype.ROYALE_COMPILE_FLAGS = 9;