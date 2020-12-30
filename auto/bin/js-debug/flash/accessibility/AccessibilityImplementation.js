/**
 * Generated by Apache Royale Compiler from flash/accessibility/AccessibilityImplementation.as
 * flash.accessibility.AccessibilityImplementation
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.accessibility.AccessibilityImplementation');
/* Royale Dependency List: flash.geom.Rectangle*/




/**
 * @constructor
 */
flash.accessibility.AccessibilityImplementation = function() {
};


/**
 * @type {number}
 */
flash.accessibility.AccessibilityImplementation.prototype.errno = 0;


/**
 * @type {boolean}
 */
flash.accessibility.AccessibilityImplementation.prototype.stub = false;


/**
 * @param {number} childID
 */
flash.accessibility.AccessibilityImplementation.prototype.accDoDefaultAction = function(childID) {
};


/**
 * @param {number} childID
 * @return {*}
 */
flash.accessibility.AccessibilityImplementation.prototype.accLocation = function(childID) {
  return null;
};


/**
 * @param {number} operation
 * @param {number} childID
 */
flash.accessibility.AccessibilityImplementation.prototype.accSelect = function(operation, childID) {
};


/**
 * @param {number} childID
 * @return {string}
 */
flash.accessibility.AccessibilityImplementation.prototype.get_accDefaultAction = function(childID) {
  return null;
};


/**
 * @return {number}
 */
flash.accessibility.AccessibilityImplementation.prototype.get_accFocus = function() {
  return (null) >>> 0;
};


/**
 * @param {number} childID
 * @return {string}
 */
flash.accessibility.AccessibilityImplementation.prototype.get_accName = function(childID) {
  return null;
};


/**
 * @param {number} childID
 * @return {number}
 */
flash.accessibility.AccessibilityImplementation.prototype.get_accRole = function(childID) {
  return (null) >>> 0;
};


/**
 * @return {Array}
 */
flash.accessibility.AccessibilityImplementation.prototype.get_accSelection = function() {
  return null;
};


/**
 * @param {number} childID
 * @return {number}
 */
flash.accessibility.AccessibilityImplementation.prototype.get_accState = function(childID) {
  return (null) >>> 0;
};


/**
 * @param {number} childID
 * @return {string}
 */
flash.accessibility.AccessibilityImplementation.prototype.get_accValue = function(childID) {
  return null;
};


/**
 * @return {*}
 */
flash.accessibility.AccessibilityImplementation.prototype.get_selectionActiveIndex = function() {
  return null;
};


/**
 * @return {*}
 */
flash.accessibility.AccessibilityImplementation.prototype.get_selectionAnchorIndex = function() {
  return null;
};


/**
 * @return {Array}
 */
flash.accessibility.AccessibilityImplementation.prototype.getChildIDArray = function() {
  return null;
};


/**
 * @param {flash.geom.Rectangle} labelBounds
 * @return {boolean}
 */
flash.accessibility.AccessibilityImplementation.prototype.isLabeledBy = function(labelBounds) {
  return false;
};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.accessibility.AccessibilityImplementation.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'AccessibilityImplementation', qName: 'flash.accessibility.AccessibilityImplementation', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.accessibility.AccessibilityImplementation.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'errno': { type: 'uint', get_set: function (/** flash.accessibility.AccessibilityImplementation */ inst, /** * */ v) {return v !== undefined ? inst.errno = v : inst.errno;}},
        'stub': { type: 'Boolean', get_set: function (/** flash.accessibility.AccessibilityImplementation */ inst, /** * */ v) {return v !== undefined ? inst.stub = v : inst.stub;}}
      };
    },
    methods: function () {
      return {
        'accDoDefaultAction': { type: 'void', declaredBy: 'flash.accessibility.AccessibilityImplementation', parameters: function () { return [ 'uint', false ]; }},
        'AccessibilityImplementation': { type: '', declaredBy: 'flash.accessibility.AccessibilityImplementation'},
        'accLocation': { type: '*', declaredBy: 'flash.accessibility.AccessibilityImplementation', parameters: function () { return [ 'uint', false ]; }},
        'accSelect': { type: 'void', declaredBy: 'flash.accessibility.AccessibilityImplementation', parameters: function () { return [ 'uint', false ,'uint', false ]; }},
        'get_accDefaultAction': { type: 'String', declaredBy: 'flash.accessibility.AccessibilityImplementation', parameters: function () { return [ 'uint', false ]; }},
        'get_accFocus': { type: 'uint', declaredBy: 'flash.accessibility.AccessibilityImplementation'},
        'get_accName': { type: 'String', declaredBy: 'flash.accessibility.AccessibilityImplementation', parameters: function () { return [ 'uint', false ]; }},
        'get_accRole': { type: 'uint', declaredBy: 'flash.accessibility.AccessibilityImplementation', parameters: function () { return [ 'uint', false ]; }},
        'get_accSelection': { type: 'Array', declaredBy: 'flash.accessibility.AccessibilityImplementation'},
        'get_accState': { type: 'uint', declaredBy: 'flash.accessibility.AccessibilityImplementation', parameters: function () { return [ 'uint', false ]; }},
        'get_accValue': { type: 'String', declaredBy: 'flash.accessibility.AccessibilityImplementation', parameters: function () { return [ 'uint', false ]; }},
        'get_selectionActiveIndex': { type: '*', declaredBy: 'flash.accessibility.AccessibilityImplementation'},
        'get_selectionAnchorIndex': { type: '*', declaredBy: 'flash.accessibility.AccessibilityImplementation'},
        'getChildIDArray': { type: 'Array', declaredBy: 'flash.accessibility.AccessibilityImplementation'},
        'isLabeledBy': { type: 'Boolean', declaredBy: 'flash.accessibility.AccessibilityImplementation', parameters: function () { return [ 'flash.geom.Rectangle', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.accessibility.AccessibilityImplementation.prototype.ROYALE_COMPILE_FLAGS = 9;
