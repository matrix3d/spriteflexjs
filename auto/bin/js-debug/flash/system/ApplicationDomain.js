/**
 * Generated by Apache Royale Compiler from flash/system/ApplicationDomain.as
 * flash.system.ApplicationDomain
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.system.ApplicationDomain');
/* Royale Dependency List: flash.utils.ByteArray*/




/**
 * @constructor
 * @param {flash.system.ApplicationDomain=} parentDomain
 */
flash.system.ApplicationDomain = function(parentDomain) {
};


/**
 * @private
 * @type {flash.system.ApplicationDomain}
 */
flash.system.ApplicationDomain._currentDomain;


/**
 * @param {string} param1
 * @return {Object}
 */
flash.system.ApplicationDomain.prototype.getDefinition = function(param1) {
  return null;
};


/**
 * @param {string} param1
 * @return {boolean}
 */
flash.system.ApplicationDomain.prototype.hasDefinition = function(param1) {
  return false;
};


/**
 * @return {Array.<string>}
 */
flash.system.ApplicationDomain.prototype.getQualifiedDefinitionNames = function() {
  return null;
};


flash.system.ApplicationDomain.prototype.get__parentDomain = function() {
  return null;
};


flash.system.ApplicationDomain.prototype.get__domainMemory = function() {
  return null;
};


flash.system.ApplicationDomain.prototype.set__domainMemory = function(param1) {
};


Object.defineProperties(flash.system.ApplicationDomain.prototype, /** @lends {flash.system.ApplicationDomain.prototype} */ {
/**
 * @type {flash.system.ApplicationDomain}
 */
parentDomain: {
get: flash.system.ApplicationDomain.prototype.get__parentDomain},
/**
 * @type {flash.utils.ByteArray}
 */
domainMemory: {
get: flash.system.ApplicationDomain.prototype.get__domainMemory,
set: flash.system.ApplicationDomain.prototype.set__domainMemory}}
);


/**
 * @nocollapse
 * @export
 * @type {flash.system.ApplicationDomain}
 */
flash.system.ApplicationDomain.currentDomain;


flash.system.ApplicationDomain.get__currentDomain = function() {
  return flash.system.ApplicationDomain._currentDomain;
};


/**
 * @nocollapse
 * @export
 * @type {number}
 */
flash.system.ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;


flash.system.ApplicationDomain.get__MIN_DOMAIN_MEMORY_LENGTH = function() {
  return 0;
};


Object.defineProperties(flash.system.ApplicationDomain, /** @lends {flash.system.ApplicationDomain} */ {
/**
 * @type {flash.system.ApplicationDomain}
 */
currentDomain: {
get: flash.system.ApplicationDomain.get__currentDomain},
/**
 * @type {number}
 */
MIN_DOMAIN_MEMORY_LENGTH: {
get: flash.system.ApplicationDomain.get__MIN_DOMAIN_MEMORY_LENGTH}}
);

flash.system.ApplicationDomain._currentDomain = new flash.system.ApplicationDomain();




/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.system.ApplicationDomain.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'ApplicationDomain', qName: 'flash.system.ApplicationDomain', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.system.ApplicationDomain.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    accessors: function () {
      return {
        '|currentDomain': { type: 'flash.system.ApplicationDomain', access: 'readonly', declaredBy: 'flash.system.ApplicationDomain'},
        '|MIN_DOMAIN_MEMORY_LENGTH': { type: 'uint', access: 'readonly', declaredBy: 'flash.system.ApplicationDomain'},
        'parentDomain': { type: 'flash.system.ApplicationDomain', access: 'readonly', declaredBy: 'flash.system.ApplicationDomain'},
        'domainMemory': { type: 'flash.utils.ByteArray', access: 'readwrite', declaredBy: 'flash.system.ApplicationDomain'}
      };
    },
    methods: function () {
      return {
        'ApplicationDomain': { type: '', declaredBy: 'flash.system.ApplicationDomain', parameters: function () { return [ 'flash.system.ApplicationDomain', true ]; }},
        'getDefinition': { type: 'Object', declaredBy: 'flash.system.ApplicationDomain', parameters: function () { return [ 'String', false ]; }},
        'hasDefinition': { type: 'Boolean', declaredBy: 'flash.system.ApplicationDomain', parameters: function () { return [ 'String', false ]; }},
        'getQualifiedDefinitionNames': { type: 'Vector.<String>', declaredBy: 'flash.system.ApplicationDomain'}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.system.ApplicationDomain.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
flash.system.ApplicationDomain.prototype.ROYALE_INITIAL_STATICS = Object.keys(flash.system.ApplicationDomain);