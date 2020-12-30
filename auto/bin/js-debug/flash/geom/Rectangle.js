/**
 * Generated by Apache Royale Compiler from flash/geom/Rectangle.as
 * flash.geom.Rectangle
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.geom.Rectangle');
/* Royale Dependency List: flash.geom.Point*/




/**
 * @constructor
 * @param {number=} x
 * @param {number=} y
 * @param {number=} width
 * @param {number=} height
 */
flash.geom.Rectangle = function(x, y, width, height) {
  x = typeof x !== 'undefined' ? x : 0;
  y = typeof y !== 'undefined' ? y : 0;
  width = typeof width !== 'undefined' ? width : 0;
  height = typeof height !== 'undefined' ? height : 0;
  ;
  this.x = x;
  this.y = y;
  this.width = width;
  this.height = height;
};


/**
 * @type {number}
 */
flash.geom.Rectangle.prototype.x = NaN;


/**
 * @type {number}
 */
flash.geom.Rectangle.prototype.y = NaN;


/**
 * @type {number}
 */
flash.geom.Rectangle.prototype.width = NaN;


/**
 * @type {number}
 */
flash.geom.Rectangle.prototype.height = NaN;


/**
 * @return {flash.geom.Rectangle}
 */
flash.geom.Rectangle.prototype.clone = function() {
  return new flash.geom.Rectangle(this.x, this.y, this.width, this.height);
};


/**
 * @return {boolean}
 */
flash.geom.Rectangle.prototype.isEmpty = function() {
  return this.width <= 0 || this.height <= 0;
};


/**
 */
flash.geom.Rectangle.prototype.setEmpty = function() {
  this.x = 0;
  this.y = 0;
  this.width = 0;
  this.height = 0;
};


/**
 * @param {number} dx
 * @param {number} dy
 */
flash.geom.Rectangle.prototype.inflate = function(dx, dy) {
  this.x = this.x - dx;
  this.width = this.width + 2 * dx;
  this.y = this.y - dy;
  this.height = this.height + 2 * dy;
};


/**
 * @param {flash.geom.Point} point
 */
flash.geom.Rectangle.prototype.inflatePoint = function(point) {
  this.x = this.x - point.x;
  this.width = this.width + 2 * point.x;
  this.y = this.y - point.y;
  this.height = this.height + 2 * point.y;
};


/**
 * @param {number} dx
 * @param {number} dy
 */
flash.geom.Rectangle.prototype.offset = function(dx, dy) {
  this.x = this.x + dx;
  this.y = this.y + dy;
};


/**
 * @param {flash.geom.Point} point
 */
flash.geom.Rectangle.prototype.offsetPoint = function(point) {
  this.x = this.x + point.x;
  this.y = this.y + point.y;
};


/**
 * @param {number} x
 * @param {number} y
 * @return {boolean}
 */
flash.geom.Rectangle.prototype.contains = function(x, y) {
  return x >= this.x && x < this.x + this.width && y >= this.y && y < this.y + this.height;
};


/**
 * @param {flash.geom.Point} point
 * @return {boolean}
 */
flash.geom.Rectangle.prototype.containsPoint = function(point) {
  return point.x >= this.x && point.x < this.x + this.width && point.y >= this.y && point.y < this.y + this.height;
};


/**
 * @param {flash.geom.Rectangle} rect
 * @return {boolean}
 */
flash.geom.Rectangle.prototype.containsRect = function(rect) {
  var /** @type {number} */ r1 = rect.x + rect.width;
  var /** @type {number} */ b1 = rect.y + rect.height;
  var /** @type {number} */ r2 = this.x + this.width;
  var /** @type {number} */ b2 = this.y + this.height;
  return rect.x >= this.x && rect.x < r2 && rect.y >= this.y && rect.y < b2 && r1 > this.x && r1 <= r2 && b1 > this.y && b1 <= b2;
};


/**
 * @param {flash.geom.Rectangle} toIntersect
 * @return {flash.geom.Rectangle}
 */
flash.geom.Rectangle.prototype.intersection = function(toIntersect) {
  var /** @type {flash.geom.Rectangle} */ result = new flash.geom.Rectangle();
  if (this.isEmpty() || toIntersect.isEmpty()) {
    result.setEmpty();
    return result;
  }
  result.x = Math.max(this.x, toIntersect.x);
  result.y = Math.max(this.y, toIntersect.y);
  result.width = Math.min(this.x + this.width, toIntersect.x + toIntersect.width) - result.x;
  result.height = Math.min(this.y + this.height, toIntersect.y + toIntersect.height) - result.y;
  if (result.width <= 0 || result.height <= 0) {
    result.setEmpty();
  }
  return result;
};


/**
 * @param {flash.geom.Rectangle} toIntersect
 * @return {boolean}
 */
flash.geom.Rectangle.prototype.intersects = function(toIntersect) {
  if (this.isEmpty() || toIntersect.isEmpty()) {
    return false;
  }
  var /** @type {number} */ resultx = Math.max(this.x, toIntersect.x);
  var /** @type {number} */ resulty = Math.max(this.y, toIntersect.y);
  var /** @type {number} */ resultwidth = Math.min(this.x + this.width, toIntersect.x + toIntersect.width) - resultx;
  var /** @type {number} */ resultheight = Math.min(this.y + this.height, toIntersect.y + toIntersect.height) - resulty;
  if (resultwidth <= 0 || resultheight <= 0) {
    return false;
  }
  return true;
};


/**
 * @param {flash.geom.Rectangle} toUnion
 * @return {flash.geom.Rectangle}
 */
flash.geom.Rectangle.prototype.union = function(toUnion) {
  var /** @type {flash.geom.Rectangle} */ r = null;
  if (this.isEmpty()) {
    return toUnion.clone();
  }
  if (toUnion.isEmpty()) {
    return this.clone();
  }
  r = new flash.geom.Rectangle();
  r.x = Math.min(this.x, toUnion.x);
  r.y = Math.min(this.y, toUnion.y);
  r.width = Math.max(this.x + this.width, toUnion.x + toUnion.width) - r.x;
  r.height = Math.max(this.y + this.height, toUnion.y + toUnion.height) - r.y;
  return r;
};


/**
 * @param {flash.geom.Rectangle} toCompare
 * @return {boolean}
 */
flash.geom.Rectangle.prototype.equals = function(toCompare) {
  return toCompare.x === this.x && toCompare.y === this.y && toCompare.width === this.width && toCompare.height === this.height;
};


/**
 * @return {string}
 */
flash.geom.Rectangle.prototype.toString = function() {
  return "(x=" + this.x + ", y=" + this.y + ", w=" + this.width + ", h=" + this.height + ")";
};


/**
 * @param {flash.geom.Rectangle} sourceRect
 */
flash.geom.Rectangle.prototype.copyFrom = function(sourceRect) {
  this.x = sourceRect.x;
  this.y = sourceRect.y;
  this.width = sourceRect.width;
  this.height = sourceRect.height;
};


/**
 * @param {number} xa
 * @param {number} ya
 * @param {number} widtha
 * @param {number} heighta
 */
flash.geom.Rectangle.prototype.setTo = function(xa, ya, widtha, heighta) {
  this.x = xa;
  this.y = ya;
  this.width = widtha;
  this.height = heighta;
};


flash.geom.Rectangle.prototype.get__left = function() {
  return this.x;
};


flash.geom.Rectangle.prototype.set__left = function(value) {
  this.width = this.width + (this.x - value);
  this.x = value;
};


flash.geom.Rectangle.prototype.get__right = function() {
  return this.x + this.width;
};


flash.geom.Rectangle.prototype.set__right = function(value) {
  this.width = value - this.x;
};


flash.geom.Rectangle.prototype.get__top = function() {
  return this.y;
};


flash.geom.Rectangle.prototype.set__top = function(value) {
  this.height = this.height + (this.y - value);
  this.y = value;
};


flash.geom.Rectangle.prototype.get__bottom = function() {
  return this.y + this.height;
};


flash.geom.Rectangle.prototype.set__bottom = function(value) {
  this.height = value - this.y;
};


flash.geom.Rectangle.prototype.get__topLeft = function() {
  return new flash.geom.Point(this.x, this.y);
};


flash.geom.Rectangle.prototype.set__topLeft = function(value) {
  this.width = this.width + (this.x - value.x);
  this.height = this.height + (this.y - value.y);
  this.x = value.x;
  this.y = value.y;
};


flash.geom.Rectangle.prototype.get__bottomRight = function() {
  return new flash.geom.Point(this.right, this.bottom);
};


flash.geom.Rectangle.prototype.set__bottomRight = function(value) {
  this.width = value.x - this.x;
  this.height = value.y - this.y;
};


flash.geom.Rectangle.prototype.get__size = function() {
  return new flash.geom.Point(this.width, this.height);
};


flash.geom.Rectangle.prototype.set__size = function(value) {
  this.width = value.x;
  this.height = value.y;
};


Object.defineProperties(flash.geom.Rectangle.prototype, /** @lends {flash.geom.Rectangle.prototype} */ {
/**
 * @type {number}
 */
left: {
get: flash.geom.Rectangle.prototype.get__left,
set: flash.geom.Rectangle.prototype.set__left},
/**
 * @type {number}
 */
right: {
get: flash.geom.Rectangle.prototype.get__right,
set: flash.geom.Rectangle.prototype.set__right},
/**
 * @type {number}
 */
top: {
get: flash.geom.Rectangle.prototype.get__top,
set: flash.geom.Rectangle.prototype.set__top},
/**
 * @type {number}
 */
bottom: {
get: flash.geom.Rectangle.prototype.get__bottom,
set: flash.geom.Rectangle.prototype.set__bottom},
/**
 * @type {flash.geom.Point}
 */
topLeft: {
get: flash.geom.Rectangle.prototype.get__topLeft,
set: flash.geom.Rectangle.prototype.set__topLeft},
/**
 * @type {flash.geom.Point}
 */
bottomRight: {
get: flash.geom.Rectangle.prototype.get__bottomRight,
set: flash.geom.Rectangle.prototype.set__bottomRight},
/**
 * @type {flash.geom.Point}
 */
size: {
get: flash.geom.Rectangle.prototype.get__size,
set: flash.geom.Rectangle.prototype.set__size}}
);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.geom.Rectangle.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'Rectangle', qName: 'flash.geom.Rectangle', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.geom.Rectangle.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'x': { type: 'Number', get_set: function (/** flash.geom.Rectangle */ inst, /** * */ v) {return v !== undefined ? inst.x = v : inst.x;}},
        'y': { type: 'Number', get_set: function (/** flash.geom.Rectangle */ inst, /** * */ v) {return v !== undefined ? inst.y = v : inst.y;}},
        'width': { type: 'Number', get_set: function (/** flash.geom.Rectangle */ inst, /** * */ v) {return v !== undefined ? inst.width = v : inst.width;}},
        'height': { type: 'Number', get_set: function (/** flash.geom.Rectangle */ inst, /** * */ v) {return v !== undefined ? inst.height = v : inst.height;}}
      };
    },
    accessors: function () {
      return {
        'left': { type: 'Number', access: 'readwrite', declaredBy: 'flash.geom.Rectangle'},
        'right': { type: 'Number', access: 'readwrite', declaredBy: 'flash.geom.Rectangle'},
        'top': { type: 'Number', access: 'readwrite', declaredBy: 'flash.geom.Rectangle'},
        'bottom': { type: 'Number', access: 'readwrite', declaredBy: 'flash.geom.Rectangle'},
        'topLeft': { type: 'flash.geom.Point', access: 'readwrite', declaredBy: 'flash.geom.Rectangle'},
        'bottomRight': { type: 'flash.geom.Point', access: 'readwrite', declaredBy: 'flash.geom.Rectangle'},
        'size': { type: 'flash.geom.Point', access: 'readwrite', declaredBy: 'flash.geom.Rectangle'}
      };
    },
    methods: function () {
      return {
        'Rectangle': { type: '', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'Number', true ,'Number', true ,'Number', true ,'Number', true ]; }},
        'clone': { type: 'flash.geom.Rectangle', declaredBy: 'flash.geom.Rectangle'},
        'isEmpty': { type: 'Boolean', declaredBy: 'flash.geom.Rectangle'},
        'setEmpty': { type: 'void', declaredBy: 'flash.geom.Rectangle'},
        'inflate': { type: 'void', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'Number', false ,'Number', false ]; }},
        'inflatePoint': { type: 'void', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'flash.geom.Point', false ]; }},
        'offset': { type: 'void', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'Number', false ,'Number', false ]; }},
        'offsetPoint': { type: 'void', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'flash.geom.Point', false ]; }},
        'contains': { type: 'Boolean', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'Number', false ,'Number', false ]; }},
        'containsPoint': { type: 'Boolean', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'flash.geom.Point', false ]; }},
        'containsRect': { type: 'Boolean', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'flash.geom.Rectangle', false ]; }},
        'intersection': { type: 'flash.geom.Rectangle', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'flash.geom.Rectangle', false ]; }},
        'intersects': { type: 'Boolean', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'flash.geom.Rectangle', false ]; }},
        'union': { type: 'flash.geom.Rectangle', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'flash.geom.Rectangle', false ]; }},
        'equals': { type: 'Boolean', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'flash.geom.Rectangle', false ]; }},
        'toString': { type: 'String', declaredBy: 'flash.geom.Rectangle'},
        'copyFrom': { type: 'void', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'flash.geom.Rectangle', false ]; }},
        'setTo': { type: 'void', declaredBy: 'flash.geom.Rectangle', parameters: function () { return [ 'Number', false ,'Number', false ,'Number', false ,'Number', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.geom.Rectangle.prototype.ROYALE_COMPILE_FLAGS = 9;
