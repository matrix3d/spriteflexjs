/**
 * Generated by Apache Royale Compiler from flash/__native/GLCanvasPattern.as
 * flash.__native.GLCanvasPattern
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.__native.GLCanvasPattern');
/* Royale Dependency List: */



/**
 * @constructor
 * @param {Object} image
 * @param {string} repetition
 */
flash.__native.GLCanvasPattern = function(image, repetition) {
  this.repetition = repetition;
  this.image = image;
};


/**
 * @type {Object}
 */
flash.__native.GLCanvasPattern.prototype.image = null;


/**
 * @type {string}
 */
flash.__native.GLCanvasPattern.prototype.repetition = null;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.__native.GLCanvasPattern.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'GLCanvasPattern', qName: 'flash.__native.GLCanvasPattern', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.__native.GLCanvasPattern.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'image': { type: 'Object', get_set: function (/** flash.__native.GLCanvasPattern */ inst, /** * */ v) {return v !== undefined ? inst.image = v : inst.image;}},
        'repetition': { type: 'String', get_set: function (/** flash.__native.GLCanvasPattern */ inst, /** * */ v) {return v !== undefined ? inst.repetition = v : inst.repetition;}}
      };
    },
    methods: function () {
      return {
        'GLCanvasPattern': { type: '', declaredBy: 'flash.__native.GLCanvasPattern', parameters: function () { return [ 'Object', false ,'String', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.__native.GLCanvasPattern.prototype.ROYALE_COMPILE_FLAGS = 9;