/**
 * Generated by Apache Royale Compiler from flash/utils/IDataInput.as
 * flash.utils.IDataInput
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.utils.IDataInput');
/* Royale Dependency List: flash.utils.ByteArray*/




/**
 * @interface
 */
flash.utils.IDataInput = function() {
};
/**  * @type {number}
 */flash.utils.IDataInput.prototype.bytesAvailable;
/**  * @type {string}
 */flash.utils.IDataInput.prototype.endian;
/**  * @type {number}
 */flash.utils.IDataInput.prototype.objectEncoding;
/**
 * @return {boolean}
 */
flash.utils.IDataInput.prototype.readBoolean = function() {
};
/**
 * @return {number}
 */
flash.utils.IDataInput.prototype.readByte = function() {
};
/**
 * @param {flash.utils.ByteArray} bytes
 * @param {number=} offset
 * @param {number=} length
 */
flash.utils.IDataInput.prototype.readBytes = function(bytes, offset, length) {
};
/**
 * @return {number}
 */
flash.utils.IDataInput.prototype.readDouble = function() {
};
/**
 * @return {number}
 */
flash.utils.IDataInput.prototype.readFloat = function() {
};
/**
 * @return {number}
 */
flash.utils.IDataInput.prototype.readInt = function() {
};
/**
 * @param {number} length
 * @param {string} charSet
 * @return {string}
 */
flash.utils.IDataInput.prototype.readMultiByte = function(length, charSet) {
};
/**
 * @return {*}
 */
flash.utils.IDataInput.prototype.readObject = function() {
};
/**
 * @return {number}
 */
flash.utils.IDataInput.prototype.readShort = function() {
};
/**
 * @return {number}
 */
flash.utils.IDataInput.prototype.readUnsignedByte = function() {
};
/**
 * @return {number}
 */
flash.utils.IDataInput.prototype.readUnsignedInt = function() {
};
/**
 * @return {number}
 */
flash.utils.IDataInput.prototype.readUnsignedShort = function() {
};
/**
 * @return {string}
 */
flash.utils.IDataInput.prototype.readUTF = function() {
};
/**
 * @param {number} length
 * @return {string}
 */
flash.utils.IDataInput.prototype.readUTFBytes = function(length) {
};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.utils.IDataInput.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'IDataInput', qName: 'flash.utils.IDataInput', kind: 'interface' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.utils.IDataInput.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    accessors: function () {
      return {
        'bytesAvailable': { type: 'uint', access: 'readonly', declaredBy: 'flash.utils.IDataInput'},
        'endian': { type: 'String', access: 'readwrite', declaredBy: 'flash.utils.IDataInput'},
        'objectEncoding': { type: 'uint', access: 'readwrite', declaredBy: 'flash.utils.IDataInput'}
      };
    },
    methods: function () {
      return {
        'readBoolean': { type: 'Boolean', declaredBy: 'flash.utils.IDataInput'},
        'readByte': { type: 'int', declaredBy: 'flash.utils.IDataInput'},
        'readBytes': { type: 'void', declaredBy: 'flash.utils.IDataInput', parameters: function () { return [ 'flash.utils.ByteArray', false ,'uint', true ,'uint', true ]; }},
        'readDouble': { type: 'Number', declaredBy: 'flash.utils.IDataInput'},
        'readFloat': { type: 'Number', declaredBy: 'flash.utils.IDataInput'},
        'readInt': { type: 'int', declaredBy: 'flash.utils.IDataInput'},
        'readMultiByte': { type: 'String', declaredBy: 'flash.utils.IDataInput', parameters: function () { return [ 'uint', false ,'String', false ]; }},
        'readObject': { type: '*', declaredBy: 'flash.utils.IDataInput'},
        'readShort': { type: 'int', declaredBy: 'flash.utils.IDataInput'},
        'readUnsignedByte': { type: 'uint', declaredBy: 'flash.utils.IDataInput'},
        'readUnsignedInt': { type: 'uint', declaredBy: 'flash.utils.IDataInput'},
        'readUnsignedShort': { type: 'uint', declaredBy: 'flash.utils.IDataInput'},
        'readUTF': { type: 'String', declaredBy: 'flash.utils.IDataInput'},
        'readUTFBytes': { type: 'String', declaredBy: 'flash.utils.IDataInput', parameters: function () { return [ 'uint', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.utils.IDataInput.prototype.ROYALE_COMPILE_FLAGS = 9;