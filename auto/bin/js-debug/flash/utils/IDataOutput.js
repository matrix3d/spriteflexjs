/**
 * Generated by Apache Royale Compiler from flash/utils/IDataOutput.as
 * flash.utils.IDataOutput
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.utils.IDataOutput');
/* Royale Dependency List: flash.utils.ByteArray*/




/**
 * @interface
 */
flash.utils.IDataOutput = function() {
};
/**  * @type {string}
 */flash.utils.IDataOutput.prototype.endian;
/**  * @type {number}
 */flash.utils.IDataOutput.prototype.objectEncoding;
/**
 * Writes a Boolean value. A single byte is written according to the value parameter,
 * either 1 if true or 0 if false.
 * @asparam	value	A Boolean value determining which byte is written. If the parameter is true,
 *   1 is written; if false, 0 is written.
 * @langversion	3.0
 * @playerversion	Flash 9
 * @playerversion	Lite 4
 * @throws	throws IOError An I/O error occurred?
 * @param {boolean} value
 */
flash.utils.IDataOutput.prototype.writeBoolean = function(value) {
};
/**
 * Writes a byte.
 * The low 8 bits of the
 * parameter are used; the high 24 bits are ignored.
 * @asparam	value	A byte value as an integer.
 * @langversion	3.0
 * @playerversion	Flash 9
 * @playerversion	Lite 4
 * @throws	throws IOError An I/O error occurred?
 * @param {number} value
 */
flash.utils.IDataOutput.prototype.writeByte = function(value) {
};
/**
 * Writes a sequence of bytes from the
 * specified byte array, bytes,
 * starting at the byte specified by offset
 * (using a zero-based index)
 * with a length specified by length,
 * into the file stream, byte stream, or byte array.
 * 
 *   If the length parameter is omitted, the default
 * length of 0 is used and the entire buffer starting at
 * offset is written.
 * If the offset parameter is also omitted, the entire buffer is
 * written. If the offset or length parameter
 * is out of range, they are clamped to the beginning and end
 * of the bytes array.
 * @asparam	bytes	The byte array to write.
 * @asparam	offset	A zero-based index specifying the position into the array to begin writing.
 * @asparam	length	An unsigned integer specifying how far into the buffer to write.
 * @langversion	3.0
 * @playerversion	Flash 9
 * @playerversion	Lite 4
 * @throws	throws IOError An I/O error occurred?
 * @param {flash.utils.ByteArray} bytes
 * @param {number=} offset
 * @param {number=} length
 */
flash.utils.IDataOutput.prototype.writeBytes = function(bytes, offset, length) {
};
/**
 * Writes an IEEE 754 double-precision (64-bit) floating point number.
 * @asparam	value	A double-precision (64-bit) floating point number.
 * @langversion	3.0
 * @playerversion	Flash 9
 * @playerversion	Lite 4
 * @throws	throws IOError An I/O error occurred?
 * @param {number} value
 */
flash.utils.IDataOutput.prototype.writeDouble = function(value) {
};
/**
 * Writes an IEEE 754 single-precision (32-bit) floating point number.
 * @asparam	value	A single-precision (32-bit) floating point number.
 * @langversion	3.0
 * @playerversion	Flash 9
 * @playerversion	Lite 4
 * @throws	throws IOError An I/O error occurred?
 * @param {number} value
 */
flash.utils.IDataOutput.prototype.writeFloat = function(value) {
};
/**
 * Writes a 32-bit signed integer.
 * @asparam	value	A byte value as a signed integer.
 * @langversion	3.0
 * @playerversion	Flash 9
 * @playerversion	Lite 4
 * @throws	throws IOError An I/O error occurred?
 * @param {number} value
 */
flash.utils.IDataOutput.prototype.writeInt = function(value) {
};
/**
 * Writes a multibyte string to the file stream, byte stream, or byte array, using the specified character set.
 * @asparam	value	The string value to be written.
 * @asparam	charSet	The string denoting the character set to use. Possible character set strings
 *   include "shift-jis", "cn-gb", "iso-8859-1", and others.
 *   For a complete list, see Supported Character Sets.
 * @langversion	3.0
 * @playerversion	Flash 9
 * @playerversion	Lite 4
 * @param {string} value
 * @param {string} charSet
 */
flash.utils.IDataOutput.prototype.writeMultiByte = function(value, charSet) {
};
/**
 * Writes an object to the file stream, byte stream, or byte array, in AMF serialized
 * format.
 * @asparam	object	The object to be serialized.
 * @langversion	3.0
 * @playerversion	Flash 9
 * @playerversion	Lite 4
 * @throws	throws IOError An I/O error occurred?
 * @param {*} object
 */
flash.utils.IDataOutput.prototype.writeObject = function(object) {
};
/**
 * Writes a 16-bit integer. The low 16 bits of the parameter are used;
 * the high 16 bits are ignored.
 * @asparam	value	A byte value as an integer.
 * @langversion	3.0
 * @playerversion	Flash 9
 * @playerversion	Lite 4
 * @throws	throws IOError An I/O error occurred?
 * @param {number} value
 */
flash.utils.IDataOutput.prototype.writeShort = function(value) {
};
/**
 * Writes a 32-bit unsigned integer.
 * @asparam	value	A byte value as an unsigned integer.
 * @langversion	3.0
 * @playerversion	Flash 9
 * @playerversion	Lite 4
 * @throws	throws IOError An I/O error occurred?
 * @param {number} value
 */
flash.utils.IDataOutput.prototype.writeUnsignedInt = function(value) {
};
/**
 * Writes a UTF-8 string to the file stream, byte stream, or byte array. The length of the UTF-8 string in bytes
 * is written first, as a 16-bit integer, followed by the bytes representing the
 * characters of the string.
 * @asparam	value	The string value to be written.
 * @langversion	3.0
 * @playerversion	Flash 9
 * @playerversion	Lite 4
 * @throws	throws IOError An I/O error occurred?
 * @throws	RangeError If the length is larger than
 *   65535.
 * @param {string} value
 */
flash.utils.IDataOutput.prototype.writeUTF = function(value) {
};
/**
 * Writes a UTF-8 string. Similar to writeUTF(),
 * but does not prefix the string with a 16-bit length word.
 * @asparam	value	The string value to be written.
 * @langversion	3.0
 * @playerversion	Flash 9
 * @playerversion	Lite 4
 * @throws	throws IOError An I/O error occurred?
 * @param {string} value
 */
flash.utils.IDataOutput.prototype.writeUTFBytes = function(value) {
};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.utils.IDataOutput.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'IDataOutput', qName: 'flash.utils.IDataOutput', kind: 'interface' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.utils.IDataOutput.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    accessors: function () {
      return {
        'endian': { type: 'String', access: 'readwrite', declaredBy: 'flash.utils.IDataOutput'},
        'objectEncoding': { type: 'uint', access: 'readwrite', declaredBy: 'flash.utils.IDataOutput'}
      };
    },
    methods: function () {
      return {
        'writeBoolean': { type: 'void', declaredBy: 'flash.utils.IDataOutput', parameters: function () { return [ 'Boolean', false ]; }},
        'writeByte': { type: 'void', declaredBy: 'flash.utils.IDataOutput', parameters: function () { return [ 'int', false ]; }},
        'writeBytes': { type: 'void', declaredBy: 'flash.utils.IDataOutput', parameters: function () { return [ 'flash.utils.ByteArray', false ,'uint', true ,'uint', true ]; }},
        'writeDouble': { type: 'void', declaredBy: 'flash.utils.IDataOutput', parameters: function () { return [ 'Number', false ]; }},
        'writeFloat': { type: 'void', declaredBy: 'flash.utils.IDataOutput', parameters: function () { return [ 'Number', false ]; }},
        'writeInt': { type: 'void', declaredBy: 'flash.utils.IDataOutput', parameters: function () { return [ 'int', false ]; }},
        'writeMultiByte': { type: 'void', declaredBy: 'flash.utils.IDataOutput', parameters: function () { return [ 'String', false ,'String', false ]; }},
        'writeObject': { type: 'void', declaredBy: 'flash.utils.IDataOutput', parameters: function () { return [ '*', false ]; }},
        'writeShort': { type: 'void', declaredBy: 'flash.utils.IDataOutput', parameters: function () { return [ 'int', false ]; }},
        'writeUnsignedInt': { type: 'void', declaredBy: 'flash.utils.IDataOutput', parameters: function () { return [ 'uint', false ]; }},
        'writeUTF': { type: 'void', declaredBy: 'flash.utils.IDataOutput', parameters: function () { return [ 'String', false ]; }},
        'writeUTFBytes': { type: 'void', declaredBy: 'flash.utils.IDataOutput', parameters: function () { return [ 'String', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.utils.IDataOutput.prototype.ROYALE_COMPILE_FLAGS = 9;