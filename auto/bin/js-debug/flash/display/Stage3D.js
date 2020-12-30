/**
 * Generated by Apache Royale Compiler from flash/display/Stage3D.as
 * flash.display.Stage3D
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.display.Stage3D');
/* Royale Dependency List: flash.display.Stage,flash.display3D.Context3D,flash.events.Event*/

goog.require('flash.events.EventDispatcher');



/**
 * @constructor
 * @extends {flash.events.EventDispatcher}
 */
flash.display.Stage3D = function() {
  this.flash_display_Stage3D_id = flash.display.Stage3D.ID++;
  flash.display.Stage3D.base(this, 'constructor');
};
goog.inherits(flash.display.Stage3D, flash.events.EventDispatcher);


/**
 * @type {flash.display.Stage}
 */
flash.display.Stage3D.prototype.__stage = null;


/**
 * @private
 * @type {flash.display3D.Context3D}
 */
flash.display.Stage3D.prototype.flash_display_Stage3D__context3D = null;


/**
 * @private
 * @type {number}
 */
flash.display.Stage3D.ID = 0;


/**
 * @private
 * @type {number}
 */
flash.display.Stage3D.prototype.flash_display_Stage3D_id = 0;


/**
 * @param {string=} param1
 * @param {string=} param2
 */
flash.display.Stage3D.prototype.requestContext3D = function(param1, param2) {
  param1 = typeof param1 !== 'undefined' ? param1 : "auto";
  param2 = typeof param2 !== 'undefined' ? param2 : "baseline";
  this.flash_display_Stage3D__context3D = new flash.display3D.Context3D();
  var /** @type {HTMLCanvasElement} */ canvas = document.getElementById("spriteflexjsstage3d" + this.flash_display_Stage3D_id);
  if (canvas == null) {
    canvas = document.createElement("canvas");
    canvas.style.position = "absolute";
    canvas.style.left = "0px";
    canvas.style.top = "0px";
    canvas.style.zIndex = this.flash_display_Stage3D_id - 20;
    this.__stage.__rootHtmlElement.appendChild(canvas);
  }
  this.flash_display_Stage3D__context3D.canvas = canvas;
  this.flash_display_Stage3D__context3D.gl = (canvas.getContext("webgl", {alpha:false, antialias:false}) || canvas.getContext("experimental-webgl", {alpha:false, antialias:false}));
  this.dispatchEvent(new flash.events.Event(flash.events.Event.CONTEXT3D_CREATE));
};


/**
 * @param {Array.<string>} param1
 */
flash.display.Stage3D.prototype.requestContext3DMatchingProfiles = function(param1) {
  this.requestContext3D();
};


flash.display.Stage3D.prototype.get__context3D = function() {
  return this.flash_display_Stage3D__context3D;
};


flash.display.Stage3D.prototype.get__x = function() {
  return 0;
};


flash.display.Stage3D.prototype.set__x = function(param1) {
};


flash.display.Stage3D.prototype.get__y = function() {
  return 0;
};


flash.display.Stage3D.prototype.set__y = function(param1) {
};


flash.display.Stage3D.prototype.get__visible = function() {
  return false;
};


flash.display.Stage3D.prototype.set__visible = function(param1) {
};


Object.defineProperties(flash.display.Stage3D.prototype, /** @lends {flash.display.Stage3D.prototype} */ {
/**
 * @type {flash.display3D.Context3D}
 */
context3D: {
get: flash.display.Stage3D.prototype.get__context3D},
/**
 * @type {number}
 */
x: {
get: flash.display.Stage3D.prototype.get__x,
set: flash.display.Stage3D.prototype.set__x},
/**
 * @type {number}
 */
y: {
get: flash.display.Stage3D.prototype.get__y,
set: flash.display.Stage3D.prototype.set__y},
/**
 * @type {boolean}
 */
visible: {
get: flash.display.Stage3D.prototype.get__visible,
set: flash.display.Stage3D.prototype.set__visible}}
);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.display.Stage3D.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'Stage3D', qName: 'flash.display.Stage3D', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.display.Stage3D.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        '__stage': { type: 'flash.display.Stage', get_set: function (/** flash.display.Stage3D */ inst, /** * */ v) {return v !== undefined ? inst.__stage = v : inst.__stage;}}
      };
    },
    accessors: function () {
      return {
        'context3D': { type: 'flash.display3D.Context3D', access: 'readonly', declaredBy: 'flash.display.Stage3D'},
        'x': { type: 'Number', access: 'readwrite', declaredBy: 'flash.display.Stage3D'},
        'y': { type: 'Number', access: 'readwrite', declaredBy: 'flash.display.Stage3D'},
        'visible': { type: 'Boolean', access: 'readwrite', declaredBy: 'flash.display.Stage3D'}
      };
    },
    methods: function () {
      return {
        'Stage3D': { type: '', declaredBy: 'flash.display.Stage3D'},
        'requestContext3D': { type: 'void', declaredBy: 'flash.display.Stage3D', parameters: function () { return [ 'String', true ,'String', true ]; }},
        'requestContext3DMatchingProfiles': { type: 'void', declaredBy: 'flash.display.Stage3D', parameters: function () { return [ 'Vector.<String>', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.display.Stage3D.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
flash.display.Stage3D.prototype.ROYALE_INITIAL_STATICS = Object.keys(flash.display.Stage3D);
