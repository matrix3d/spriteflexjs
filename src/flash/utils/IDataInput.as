//
// D:\sdk\airsdk24\frameworks\libs\player\21.0\playerglobal.swc\flash\utils\IDataInput
//
package flash.utils
{
	import flash.utils.ByteArray;

	/**
	 * The IDataInput interface provides a set of methods for reading binary data.
	 * This interface is the I/O counterpart to the IDataOutput interface, which
	 * writes binary data.
	 * <p class="- topic/p ">All IDataInput and IDataOutput operations are "bigEndian" by default (the most significant
	 * byte in the sequence is stored at the lowest or first storage address),
	 * and are nonblocking.
	 * If insufficient data is available, an <codeph class="+ topic/ph pr-d/codeph ">EOFError</codeph> exception
	 * is thrown. Use the <codeph class="+ topic/ph pr-d/codeph ">IDataInput.bytesAvailable</codeph> property to determine
	 * how much data is available to read.</p><p class="- topic/p ">Sign extension matters only when you read data, not when you write it. Therefore you do not need separate
	 * write methods to work with <codeph class="+ topic/ph pr-d/codeph ">IDataInput.readUnsignedByte()</codeph> and
	 * <codeph class="+ topic/ph pr-d/codeph ">IDataInput.readUnsignedShort()</codeph>. In other words:</p><ul class="- topic/ul "><li class="- topic/li ">Use <codeph class="+ topic/ph pr-d/codeph ">IDataOutput.writeByte()</codeph> with <codeph class="+ topic/ph pr-d/codeph ">IDataInput.readUnsignedByte()</codeph> and
	 * <codeph class="+ topic/ph pr-d/codeph ">IDataInput.readByte()</codeph>.</li><li class="- topic/li ">Use <codeph class="+ topic/ph pr-d/codeph ">IDataOutput.writeShort()</codeph> with <codeph class="+ topic/ph pr-d/codeph ">IDataInput.readUnsignedShort()</codeph> and
	 * <codeph class="+ topic/ph pr-d/codeph ">IDataInput.readShort()</codeph>.</li></ul>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example uses the class <codeph class="+ topic/ph pr-d/codeph ">DataInputExample</codeph> to write a boolean
	 * and the double-precision floating-point representation of pi to a byte array.  This is accomplished 
	 * using the following steps:
	 * <ol class="- topic/ol "><li class="- topic/li ">Declare a new ByteArray object instance <codeph class="+ topic/ph pr-d/codeph ">byteArr</codeph>.</li><li class="- topic/li ">Write the byte-equivalent value of the Boolean <codeph class="+ topic/ph pr-d/codeph ">false</codeph> and the  double-precision 
	 * floating-point equivalent of the mathematical value of pi.</li><li class="- topic/li ">Read back the boolean and double-precision floating-point number.</li></ol><p class="- topic/p ">Notice how a code segment is added at the end to check for end of file errors to ensure that
	 * the byte stream is not read past its end.</p><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * package {
	 * import flash.display.Sprite;
	 * import flash.utils.ByteArray;
	 * import flash.errors.EOFError;
	 * 
	 *   public class DataInputExample extends Sprite {        
	 * public function DataInputExample() {
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
	public interface IDataInput
	{
		/**
		 * Returns the number of bytes of data available for reading
		 * in the input buffer.
		 * User code must call bytesAvailable to ensure
		 * that sufficient data is available before trying to read
		 * it with one of the read methods.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		function get bytesAvailable () : uint;

		/**
		 * The byte order for the data, either the BIG_ENDIAN or LITTLE_ENDIAN constant
		 * from the Endian class.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		function get endian () : String;
		function set endian (type:String) : void;

		/**
		 * Used to determine whether the AMF3 or AMF0 format is used when writing or reading binary data using the
		 * readObject() method. The value is a constant from the ObjectEncoding class.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		function get objectEncoding () : uint;
		function set objectEncoding (version:uint) : void;

		/**
		 * Reads a Boolean value from the file stream, byte stream, or byte array. A single byte is read
		 * and true is returned if the byte is nonzero,
		 * false otherwise.
		 * @return	A Boolean value, true if the byte is nonzero,
		 *   false otherwise.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readBoolean () : Boolean;

		/**
		 * Reads a signed byte from the file stream, byte stream, or byte array.
		 * @return	The returned value is in the range -128 to 127.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readByte () : int;

		/**
		 * Reads the number of data bytes, specified by the length parameter,
		 * from the file stream, byte stream, or byte array. The bytes are read into the
		 * ByteArray objected specified by the bytes parameter, starting at
		 * the position specified by offset.
		 * @param	bytes	The ByteArray object to read
		 *   data into.
		 * @param	offset	The offset into the bytes parameter at which data
		 *   read should begin.
		 * @param	length	The number of bytes to read.  The default value
		 *   of 0 causes all available data to be read.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readBytes (bytes:ByteArray, offset:uint=0, length:uint=0) : void;

		/**
		 * Reads an IEEE 754 double-precision floating point number from the file stream, byte stream, or byte array.
		 * @return	An IEEE 754 double-precision floating point number.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readDouble () : Number;

		/**
		 * Reads an IEEE 754 single-precision floating point number from the file stream, byte stream, or byte array.
		 * @return	An IEEE 754 single-precision floating point number.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readFloat () : Number;

		/**
		 * Reads a signed 32-bit integer from the file stream, byte stream, or byte array.
		 * @return	The returned value is in the range -2147483648 to 2147483647.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readInt () : int;

		/**
		 * Reads a multibyte string of specified length from the file stream, byte stream, or byte array using the
		 * specified character set.
		 * @param	length	The number of bytes from the byte stream to read.
		 * @param	charSet	The string denoting the character set to use to interpret the bytes.
		 *   Possible character set strings include "shift-jis", "cn-gb",
		 *   "iso-8859-1", and others.
		 *   For a complete list, see Supported Character Sets.
		 *   
		 *     Note: If the value for the charSet parameter is not recognized by the current
		 *   system, then Adobe® Flash® Player or
		 *   Adobe® AIR® uses the system's default
		 *   code page as the character set. For example, a value for the charSet parameter, as in
		 *   myTest.readMultiByte(22, "iso-8859-01"), that uses  01 instead of
		 *   1 might work on your development system, but not on another system. On the other
		 *   system, Flash Player or the AIR runtime will use the system's
		 *   default code page.
		 * @return	UTF-8 encoded string.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readMultiByte (length:uint, charSet:String) : String;

		/**
		 * Reads an object from the file stream, byte stream, or byte array, encoded in AMF
		 * serialized format.
		 * @return	The deserialized object
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readObject () : *;

		/**
		 * Reads a signed 16-bit integer from the file stream, byte stream, or byte array.
		 * @return	The returned value is in the range -32768 to 32767.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readShort () : int;

		/**
		 * Reads an unsigned byte from the file stream, byte stream, or byte array.
		 * @return	The returned value is in the range 0 to 255.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readUnsignedByte () : uint;

		/**
		 * Reads an unsigned 32-bit integer from the file stream, byte stream, or byte array.
		 * @return	The returned value is in the range 0 to 4294967295.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readUnsignedInt () : uint;

		/**
		 * Reads an unsigned 16-bit integer from the file stream, byte stream, or byte array.
		 * @return	The returned value is in the range 0 to 65535.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readUnsignedShort () : uint;

		/**
		 * Reads a UTF-8 string from the file stream, byte stream, or byte array.  The string
		 * is assumed to be prefixed with an unsigned short indicating
		 * the length in bytes.
		 * 
		 *   This method is similar to the readUTF()
		 * method in the Java® IDataInput interface.
		 * @return	A UTF-8 string produced by the byte representation of characters.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readUTF () : String;

		/**
		 * Reads a sequence of UTF-8 bytes from the byte stream or byte array and returns a string.
		 * @param	length	The number of bytes to read.
		 * @return	A UTF-8 string produced by the byte representation of characters of the specified length.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 * @throws	EOFError There is not sufficient data available
		 *   to read.
		 */
		function readUTFBytes (length:uint) : String;
	}
}
