/**
 * Generated by Apache Royale Compiler from flash/geom/Vector3D.as
 * flash.geom.Vector3D
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.geom.Vector3D');
/* Royale Dependency List: */
goog.require('org.apache.royale.utils.Language');
/* Royale Static Dependency List: org.apache.royale.utils.Language*/



/**
 * @constructor
 * @param {number=} x
 * @param {number=} y
 * @param {number=} z
 * @param {number=} w
 */
flash.geom.Vector3D = function(x, y, z, w) {
  x = typeof x !== 'undefined' ? x : 0.0;
  y = typeof y !== 'undefined' ? y : 0.0;
  z = typeof z !== 'undefined' ? z : 0.0;
  w = typeof w !== 'undefined' ? w : 0.0;
  ;
  this.x = x;
  this.y = y;
  this.z = z;
  this.w = w;
};


/**
 * @nocollapse
 * @const
 * @type {flash.geom.Vector3D}
 */
flash.geom.Vector3D.X_AXIS;


/**
 * @nocollapse
 * @const
 * @type {flash.geom.Vector3D}
 */
flash.geom.Vector3D.Y_AXIS;


/**
 * @nocollapse
 * @const
 * @type {flash.geom.Vector3D}
 */
flash.geom.Vector3D.Z_AXIS;


/**
 * @type {number}
 */
flash.geom.Vector3D.prototype.x = NaN;


/**
 * @type {number}
 */
flash.geom.Vector3D.prototype.y = NaN;


/**
 * @type {number}
 */
flash.geom.Vector3D.prototype.z = NaN;


/**
 * @type {number}
 */
flash.geom.Vector3D.prototype.w = NaN;


/**
 * @nocollapse
 * @param {flash.geom.Vector3D} a
 * @param {flash.geom.Vector3D} b
 * @return {number}
 */
flash.geom.Vector3D.angleBetween = function(a, b) {
  var /** @type {number} */ dot = a.x * b.x + a.y * b.y + a.z * b.z;
  var /** @type {number} */ al = a.length;
  var /** @type {number} */ bl = b.length;
  dot = dot / (al * bl);
  return Math.acos(dot);
};


/**
 * @nocollapse
 * @param {flash.geom.Vector3D} pt1
 * @param {flash.geom.Vector3D} pt2
 * @return {number}
 */
flash.geom.Vector3D.distance = function(pt1, pt2) {
  return pt1.subtract(pt2).length;
};


/**
 * @return {flash.geom.Vector3D}
 */
flash.geom.Vector3D.prototype.clone = function() {
  return new flash.geom.Vector3D(this.x, this.y, this.z, this.w);
};


/**
 * @param {flash.geom.Vector3D} a
 * @return {number}
 */
flash.geom.Vector3D.prototype.dotProduct = function(a) {
  return this.x * a.x + this.y * a.y + this.z * a.z;
};


/**
 * @param {flash.geom.Vector3D} a
 * @return {flash.geom.Vector3D}
 */
flash.geom.Vector3D.prototype.crossProduct = function(a) {
  return new flash.geom.Vector3D(this.y * a.z - this.z * a.y, this.z * a.x - this.x * a.z, this.x * a.y - this.y * a.x, 1);
};


/**
 * @return {number}
 */
flash.geom.Vector3D.prototype.normalize = function() {
  var /** @type {number} */ len = this.length;
  var /** @type {number} */ lenInv = len != 0 ? 1 / len : 0;
  this.x = this.x * lenInv;
  this.y = this.y * lenInv;
  this.z = this.z * lenInv;
  return len;
};


/**
 * @param {number} s
 */
flash.geom.Vector3D.prototype.scaleBy = function(s) {
  this.x = this.x * s;
  this.y = this.y * s;
  this.z = this.z * s;
};


/**
 * @param {flash.geom.Vector3D} a
 */
flash.geom.Vector3D.prototype.incrementBy = function(a) {
  this.x = this.x + a.x;
  this.y = this.y + a.y;
  this.z = this.z + a.z;
};


/**
 * @param {flash.geom.Vector3D} a
 */
flash.geom.Vector3D.prototype.decrementBy = function(a) {
  this.x = this.x - a.x;
  this.y = this.y - a.y;
  this.z = this.z - a.z;
};


/**
 * @param {flash.geom.Vector3D} a
 * @return {flash.geom.Vector3D}
 */
flash.geom.Vector3D.prototype.add = function(a) {
  return new flash.geom.Vector3D(this.x + a.x, this.y + a.y, this.z + a.z);
};


/**
 * @param {flash.geom.Vector3D} a
 * @return {flash.geom.Vector3D}
 */
flash.geom.Vector3D.prototype.subtract = function(a) {
  return new flash.geom.Vector3D(this.x - a.x, this.y - a.y, this.z - a.z);
};


/**
 */
flash.geom.Vector3D.prototype.negate = function() {
  this.x = -this.x;
  this.y = -this.y;
  this.z = -this.z;
};


/**
 * @param {flash.geom.Vector3D} toCompare
 * @param {boolean=} allFour
 * @return {boolean}
 */
flash.geom.Vector3D.prototype.equals = function(toCompare, allFour) {
  allFour = typeof allFour !== 'undefined' ? allFour : false;
  return this.x === toCompare.x && this.y === toCompare.y && this.z === toCompare.z && (allFour ? this.w === toCompare.w : true);
};


/**
 * @param {flash.geom.Vector3D} toCompare
 * @param {number} tolerance
 * @param {boolean=} allFour
 * @return {boolean}
 */
flash.geom.Vector3D.prototype.nearEquals = function(toCompare, tolerance, allFour) {
  allFour = typeof allFour !== 'undefined' ? allFour : false;
  var /** @type {number} */ diff = this.x - toCompare.x;
  diff = diff < 0 ? 0 - diff : diff;
  var /** @type {boolean} */ goodEnough = diff < tolerance;
  if (goodEnough) {
    diff = this.y - toCompare.y;
    diff = diff < 0 ? 0 - diff : diff;
    goodEnough = diff < tolerance;
    if (goodEnough) {
      diff = this.z - toCompare.z;
      diff = diff < 0 ? 0 - diff : diff;
      goodEnough = diff < tolerance;
      if (goodEnough && allFour) {
        diff = this.w = toCompare.w;
        diff = diff < 0 ? 0 - diff : diff;
        goodEnough = diff < tolerance;
      }
    }
  }
  return goodEnough;
};


/**
 */
flash.geom.Vector3D.prototype.project = function() {
  var /** @type {number} */ tRecip = 1 / this.w;
  this.x = this.x * tRecip;
  this.y = this.y * tRecip;
  this.z = this.z * tRecip;
};


/**
 * @return {string}
 */
flash.geom.Vector3D.prototype.toString = function() {
  var /** @type {string} */ s = "Vector3D(" + this.x + ", " + this.y + ", " + this.z;
  s = s + ")";
  return s;
};


/**
 * @param {flash.geom.Vector3D} sourceVector3D
 */
flash.geom.Vector3D.prototype.copyFrom = function(sourceVector3D) {
  this.x = sourceVector3D.x;
  this.y = sourceVector3D.y;
  this.z = sourceVector3D.z;
};


/**
 * @param {number} xa
 * @param {number} ya
 * @param {number} za
 */
flash.geom.Vector3D.prototype.setTo = function(xa, ya, za) {
  this.x = xa;
  this.y = ya;
  this.z = za;
};


flash.geom.Vector3D.prototype.get__length = function() {
  var /** @type {number} */ r = this.x * this.x + this.y * this.y + this.z * this.z;
  if (r <= 0) {
    return 0;
  }
  return Math.sqrt(r);
};


flash.geom.Vector3D.prototype.get__lengthSquared = function() {
  return this.x * this.x + this.y * this.y + this.z * this.z;
};


Object.defineProperties(flash.geom.Vector3D.prototype, /** @lends {flash.geom.Vector3D.prototype} */ {
/**
 * @type {number}
 */
length: {
get: flash.geom.Vector3D.prototype.get__length},
/**
 * @type {number}
 */
lengthSquared: {
get: flash.geom.Vector3D.prototype.get__lengthSquared}}
);

flash.geom.Vector3D.X_AXIS = new flash.geom.Vector3D(1, 0, 0);
flash.geom.Vector3D.Y_AXIS = new flash.geom.Vector3D(0, 1, 0);
flash.geom.Vector3D.Z_AXIS = new flash.geom.Vector3D(0, 0, 1);




/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.geom.Vector3D.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'Vector3D', qName: 'flash.geom.Vector3D', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.geom.Vector3D.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'x': { type: 'Number', get_set: function (/** flash.geom.Vector3D */ inst, /** * */ v) {return v !== undefined ? inst.x = v : inst.x;}},
        'y': { type: 'Number', get_set: function (/** flash.geom.Vector3D */ inst, /** * */ v) {return v !== undefined ? inst.y = v : inst.y;}},
        'z': { type: 'Number', get_set: function (/** flash.geom.Vector3D */ inst, /** * */ v) {return v !== undefined ? inst.z = v : inst.z;}},
        'w': { type: 'Number', get_set: function (/** flash.geom.Vector3D */ inst, /** * */ v) {return v !== undefined ? inst.w = v : inst.w;}}
      };
    },
    accessors: function () {
      return {
        'length': { type: 'Number', access: 'readonly', declaredBy: 'flash.geom.Vector3D'},
        'lengthSquared': { type: 'Number', access: 'readonly', declaredBy: 'flash.geom.Vector3D'}
      };
    },
    methods: function () {
      return {
        'Vector3D': { type: '', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'Number', true ,'Number', true ,'Number', true ,'Number', true ]; }},
        '|angleBetween': { type: 'Number', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'flash.geom.Vector3D', false ,'flash.geom.Vector3D', false ]; }},
        '|distance': { type: 'Number', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'flash.geom.Vector3D', false ,'flash.geom.Vector3D', false ]; }},
        'clone': { type: 'flash.geom.Vector3D', declaredBy: 'flash.geom.Vector3D'},
        'dotProduct': { type: 'Number', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'flash.geom.Vector3D', false ]; }},
        'crossProduct': { type: 'flash.geom.Vector3D', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'flash.geom.Vector3D', false ]; }},
        'normalize': { type: 'Number', declaredBy: 'flash.geom.Vector3D'},
        'scaleBy': { type: 'void', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'Number', false ]; }},
        'incrementBy': { type: 'void', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'flash.geom.Vector3D', false ]; }},
        'decrementBy': { type: 'void', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'flash.geom.Vector3D', false ]; }},
        'add': { type: 'flash.geom.Vector3D', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'flash.geom.Vector3D', false ]; }},
        'subtract': { type: 'flash.geom.Vector3D', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'flash.geom.Vector3D', false ]; }},
        'negate': { type: 'void', declaredBy: 'flash.geom.Vector3D'},
        'equals': { type: 'Boolean', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'flash.geom.Vector3D', false ,'Boolean', true ]; }},
        'nearEquals': { type: 'Boolean', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'flash.geom.Vector3D', false ,'Number', false ,'Boolean', true ]; }},
        'project': { type: 'void', declaredBy: 'flash.geom.Vector3D'},
        'toString': { type: 'String', declaredBy: 'flash.geom.Vector3D'},
        'copyFrom': { type: 'void', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'flash.geom.Vector3D', false ]; }},
        'setTo': { type: 'void', declaredBy: 'flash.geom.Vector3D', parameters: function () { return [ 'Number', false ,'Number', false ,'Number', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.geom.Vector3D.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
flash.geom.Vector3D.prototype.ROYALE_INITIAL_STATICS = Object.keys(flash.geom.Vector3D);
