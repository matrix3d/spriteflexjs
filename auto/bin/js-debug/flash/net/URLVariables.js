/**
 * Generated by Apache Royale Compiler from flash/net/URLVariables.as
 * flash.net.URLVariables
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.net.URLVariables');
/* Royale Dependency List: org.apache.royale.utils.Language*/



/**
 * @constructor
 * @param {string=} source
 */
flash.net.URLVariables = function(source) {
  source = typeof source !== 'undefined' ? source : null;
  ;
  if (source != null) {
    this.decode(source);
  }
};


/**
 * @param {string} source
 */
flash.net.URLVariables.prototype.decode = function(source) {
  var /** @type {string} */ param = null;
  var /** @type {*} */ equalsIndex = 0;
  var /** @type {string} */ name = null;
  var /** @type {string} */ value = null;
  var /** @type {*} */ oldValue = undefined;
  var /** @type {Array} */ params = source.split("&");
  for (var /** @type {number} */ i = 0; i < params.length; i++) {
    param = org.apache.royale.utils.Language.string(params[i]);
    equalsIndex = param.indexOf("=");
    if (equalsIndex == -1) {
      Error.throwError(Error, 2101);
    } else {
      name = unescape(param.substr(0, Number(equalsIndex)));
      value = unescape(param.substr(Number(equalsIndex + 1)));
      oldValue = this[name];
      if (oldValue != undefined) {
        if (!org.apache.royale.utils.Language.is(oldValue, Array)) {
          this[name] = oldValue = [oldValue];
        }
        oldValue.push(value);
      } else {
        this[name] = value;
      }
    }
  }
};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.net.URLVariables.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'URLVariables', qName: 'flash.net.URLVariables', kind: 'class', isDynamic: true}] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.net.URLVariables.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    methods: function () {
      return {
        'URLVariables': { type: '', declaredBy: 'flash.net.URLVariables', parameters: function () { return [ 'String', true ]; }},
        'decode': { type: 'void', declaredBy: 'flash.net.URLVariables', parameters: function () { return [ 'String', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.net.URLVariables.prototype.ROYALE_COMPILE_FLAGS = 9;