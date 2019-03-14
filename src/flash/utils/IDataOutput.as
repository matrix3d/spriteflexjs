//
// D:\sdk\airsdk24\frameworks\libs\player\21.0\playerglobal.swc\flash\utils\IDataOutput
//
package flash.utils
{
	import flash.utils.ByteArray;

	/**
	 * The IDataOutput interface provides a set of methods for writing binary data.
	 * This interface is the I/O counterpart to the IDataInput interface, which
	 * reads binary data. The IDataOutput interface is implemented by the FileStream, Socket
	 * and ByteArray classes.
	 * <p class="- topic/p ">All IDataInput and IDataOutput operations are "bigEndian" by default (the most significant
	 * byte in the sequence is stored at the lowest or first storage address),
	 * and are nonblocking. </p><p class="- topic/p ">Sign extension matters only when you read data, not when you write it. Therefore, you do not need separate
	 * write methods to work with <codeph class="+ topic/ph pr-d/codeph ">IDataInput.readUnsignedByte()</codeph> and
	 * <codeph class="+ topic/ph pr-d/codeph ">IDataInput.readUnsignedShort()</codeph>. In other words:</p><ul class="- topic/ul "><li class="- topic/li ">Use <codeph class="+ topic/ph pr-d/codeph ">IDataOutput.writeByte()</codeph> with <codeph class="+ topic/ph pr-d/codeph ">IDataInput.readUnsignedByte()</codeph> and
	 * <codeph class="+ topic/ph pr-d/codeph ">IDataInput.readByte()</codeph>.</li><li class="- topic/li ">Use <codeph class="+ topic/ph pr-d/codeph ">IDataOutput.writeShort()</codeph> with <codeph class="+ topic/ph pr-d/codeph ">IDataInput.readUnsignedShort()</codeph> and
	 * <codeph class="+ topic/ph pr-d/codeph ">IDataInput.readShort()</codeph>.</li></ul>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example uses the class <codeph class="+ topic/ph pr-d/codeph ">DataOutputExample</codeph> to write a boolean
	 * and the double-precision floating-point representation of pi to a byte array.  This is accomplished 
	 * using the following steps:
	 * <ol class="- topic/ol "><li class="- topic/li ">Declare a new ByteArray object instance <codeph class="+ topic/ph pr-d/codeph ">byteArr</codeph>.</li><li class="- topic/li ">Write the byte-equivalent value of the Boolean <codeph class="+ topic/ph pr-d/codeph ">false</codeph> and the double-precision 
	 * floating-point equivalent of the mathematical value of pi.</li><li class="- topic/li ">Read back the boolean and double-precision floating-point number.</li></ol><p class="- topic/p ">Notice how a code segment is added at the end to check for end of file errors to ensure that
	 * the byte stream is not read past its end.</p><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * package {
	 * import flash.display.Sprite;
	 * import flash.utils.ByteArray;
	 * import flash.errors.EOFError;
	 * 
	 *   public class DataOutputExample extends Sprite {        
	 * public function DataOutputExample() {
	 * var byteArr:ByteArray = new ByteArray();
	 * 
	 *   byteArr.writeBoolean(false);
	 * byteArr.writeDouble(Math.PI);
	 * 
	 *   byteArr.position = 0;
	 * 
	 *   try {
	 * trace(byteArr.readBoolean()); // false
	 * } 
	 * catch(e:EOFError) {
	 * trace(e);           // EOFError: Error #2030: End of file was encountered.
	 * }
	 * 
	 *   try {
	 * trace(byteArr.readDouble());    // 3.141592653589793
	 * } 
	 * catch(e:EOFError) {
	 * trace(e);           // EOFError: Error #2030: End of file was encountered.
	 * }
	 * 
	 *   try {
	 * trace(byteArr.readDouble());
	 * } 
	 * catch(e:EOFError) {
	 * trace(e);        // EOFError: Error #2030: End of file was encountered.
	 * }
	 * }
	 * }
	 * }
	 * </codeblock>
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 * @playerversion	Lite 4
	 */
	public interface IDataOutput
	{
		/**
		 * The byte order for the data, either the BIG_ENDIAN or LITTLE_ENDIAN
		 * constant from the Endian class.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		function get endian () : String;
		function set endian (type:String) : void;

		/**
		 * Used to determine whether the AMF3 or AMF0 format is used when writing or reading binary data using the
		 * writeObject() method. The value is a constant from the ObjectEncoding class.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		function get objectEncoding () : uint;
		function set objectEncoding (version:uint) : void;

		/**
		 * Writes a Boolean value. A single byte is written according to the value parameter,
		 * either 1 if true or 0 if false.
		 * @param	value	A Boolean value determining which byte is written. If the parameter is true,
		 *   1 is written; if false, 0 is written.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	throws IOError An I/O error occurred?
		 */
		function writeBoolean (value:Boolean) : void;

		/**
		 * Writes a byte.
		 * The low 8 bits of the
		 * parameter are used; the high 24 bits are ignored.
		 * @param	value	A byte value as an integer.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	throws IOError An I/O error occurred?
		 */
		function writeByte (value:int) : void;

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
		 * @param	bytes	The byte array to write.
		 * @param	offset	A zero-based index specifying the position into the array to begin writing.
		 * @param	length	An unsigned integer specifying how far into the buffer to write.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	throws IOError An I/O error occurred?
		 */
		function writeBytes (bytes:ByteArray, offset:uint=0, length:uint=0) : void;

		/**
		 * Writes an IEEE 754 double-precision (64-bit) floating point number.
		 * @param	value	A double-precision (64-bit) floating point number.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	throws IOError An I/O error occurred?
		 */
		function writeDouble (value:Number) : void;

		/**
		 * Writes an IEEE 754 single-precision (32-bit) floating point number.
		 * @param	value	A single-precision (32-bit) floating point number.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	throws IOError An I/O error occurred?
		 */
		function writeFloat (value:Number) : void;

		/**
		 * Writes a 32-bit signed integer.
		 * @param	value	A byte value as a signed integer.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	throws IOError An I/O error occurred?
		 */
		function writeInt (value:int) : void;

		/**
		 * Writes a multibyte string to the file stream, byte stream, or byte array, using the specified character set.
		 * @param	value	The string value to be written.
		 * @param	charSet	The string denoting the character set to use. Possible character set strings
		 *   include "shift-jis", "cn-gb", "iso-8859-1", and others.
		 *   For a complete list, see Supported Character Sets.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		function writeMultiByte (value:String, charSet:String) : void;

		/**
		 * Writes an object to the file stream, byte stream, or byte array, in AMF serialized
		 * format.
		 * @param	object	The object to be serialized.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	throws IOError An I/O error occurred?
		 */
		function writeObject (object:*) : void;

		/**
		 * Writes a 16-bit integer. The low 16 bits of the parameter are used;
		 * the high 16 bits are ignored.
		 * @param	value	A byte value as an integer.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	throws IOError An I/O error occurred?
		 */
		function writeShort (value:int) : void;

		/**
		 * Writes a 32-bit unsigned integer.
		 * @param	value	A byte value as an unsigned integer.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	throws IOError An I/O error occurred?
		 */
		function writeUnsignedInt (value:uint) : void;

		/**
		 * Writes a UTF-8 string to the file stream, byte stream, or byte array. The length of the UTF-8 string in bytes
		 * is written first, as a 16-bit integer, followed by the bytes representing the
		 * characters of the string.
		 * @param	value	The string value to be written.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	throws IOError An I/O error occurred?
		 * @throws	RangeError If the length is larger than
		 *   65535.
		 */
		function writeUTF (value:String) : void;

		/**
		 * Writes a UTF-8 string. Similar to writeUTF(),
		 * but does not prefix the string with a 16-bit length word.
		 * @param	value	The string value to be written.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	throws IOError An I/O error occurred?
		 */
		function writeUTFBytes (value:String) : void;
	}
}
