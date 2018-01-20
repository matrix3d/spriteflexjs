package flash.display
{
	import flash.utils.ByteArray;

	/**
	 * A ShaderData object contains properties representing any parameters and 
	 * inputs for a shader kernel, as well as properties containing any metadata 
	 * specified for the shader.
	 * 
	 *   <p class="- topic/p ">These properties are added to the ShaderData object when it is created. The properties' 
	 * names match the names specified in the shader's source code. The data type of each 
	 * property varies according to what aspect of the shader the property represents. The 
	 * properties that represent shader parameters are ShaderParameter instances, the properties 
	 * that represent input images are ShaderInput instances, and the properties that represent 
	 * shader metadata are instances of the ActionScript class corresponding to their data type 
	 * (for example, a String instance for textual metadata and a uint for uint metadata).</p><p class="- topic/p ">For example, consider this shader, which is defined with one input image (<codeph class="+ topic/ph pr-d/codeph ">src</codeph>), 
	 * two parameters (<codeph class="+ topic/ph pr-d/codeph ">size</codeph> and <codeph class="+ topic/ph pr-d/codeph ">radius</codeph>), and three metadata values 
	 * (<codeph class="+ topic/ph pr-d/codeph ">nameSpace</codeph>, <codeph class="+ topic/ph pr-d/codeph ">version</codeph>, and <codeph class="+ topic/ph pr-d/codeph ">description</codeph>):</p><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * &lt;languageVersion : 1.0;&gt;
	 * 
	 *   kernel DoNothing
	 * &lt;
	 * namespace: "Adobe::Example";
	 * vendor: "Adobe examples";
	 * version: 1;
	 * description: "A shader that does nothing, but does it well.";
	 * &gt;
	 * {
	 * input image4 src;
	 * 
	 *   output pixel4 dst;
	 * 
	 *   parameter float2 size
	 * &lt;
	 * description: "The size of the image to which the kernel is applied";
	 * minValue: float2(0.0, 0.0);
	 * maxValue: float2(100.0, 100.0);
	 * defaultValue: float2(50.0, 50.0);
	 * &gt;;
	 * 
	 *   parameter float radius
	 * &lt;
	 * description: "The radius of the effect";
	 * minValue: 0.0;
	 * maxValue: 50.0;
	 * defaultValue: 25.0;
	 * &gt;;
	 * 
	 *   void evaluatePixel()
	 * {
	 * float2 one = (radius / radius) ∗ (size / size);
	 * dst = sampleNearest(src, outCoord());
	 * }
	 * }
	 * </codeblock><p class="- topic/p ">If you create a Shader instance by loading the byte code for this shader, the ShaderData 
	 * instance in its <codeph class="+ topic/ph pr-d/codeph ">data</codeph> property contains these properties:</p><adobetable class="innertable"><tgroup cols="3" class="- topic/tgroup "><thead class="- topic/thead "><row class="- topic/row "><entry class="- topic/entry ">Property</entry><entry class="- topic/entry ">Data type</entry><entry class="- topic/entry ">Value</entry></row></thead><tbody class="- topic/tbody "><row class="- topic/row "><entry class="- topic/entry ">name</entry><entry class="- topic/entry ">String</entry><entry class="- topic/entry ">"DoNothing"</entry></row><row class="- topic/row "><entry class="- topic/entry ">nameSpace</entry><entry class="- topic/entry ">String</entry><entry class="- topic/entry ">"Adobe::Example"</entry></row><row class="- topic/row "><entry class="- topic/entry ">version</entry><entry class="- topic/entry ">String</entry><entry class="- topic/entry ">"1"</entry></row><row class="- topic/row "><entry class="- topic/entry ">description</entry><entry class="- topic/entry ">String</entry><entry class="- topic/entry ">"A shader that does nothing, but does it well."</entry></row><row class="- topic/row "><entry class="- topic/entry ">src</entry><entry class="- topic/entry ">ShaderInput</entry><entry class="- topic/entry "><i class="+ topic/ph hi-d/i ">[A ShaderInput instance]</i></entry></row><row class="- topic/row "><entry class="- topic/entry ">size</entry><entry class="- topic/entry ">ShaderParameter</entry><entry class="- topic/entry "><i class="+ topic/ph hi-d/i ">[A ShaderParameter instance, with properties for the parameter metadata]</i></entry></row><row class="- topic/row "><entry class="- topic/entry ">radius</entry><entry class="- topic/entry ">ShaderParameter</entry><entry class="- topic/entry "><i class="+ topic/ph hi-d/i ">[A ShaderParameter instance, with properties for the parameter metadata]</i></entry></row></tbody></tgroup></adobetable><p class="- topic/p ">Note that any input image or parameter that is defined in the shader source code 
	 * but not used in the shader's <codeph class="+ topic/ph pr-d/codeph ">evaluatePixel()</codeph> function is removed when the 
	 * shader is compiled to byte code. In that case, there is no corresponding ShaderInput 
	 * or ShaderParameter instance added as a property of the ShaderData instance.</p><p class="- topic/p ">Generally, developer code does not create a ShaderData instance. 
	 * A ShaderData instance containing data, parameters, and inputs 
	 * for a shader is available as the Shader instance's <codeph class="+ topic/ph pr-d/codeph ">data</codeph> 
	 * property.</p>
	 * 
	 *   EXAMPLE:
	 * 
	 *   The following example loads a shader and enumerates the ShaderData instance 
	 * in its <codeph class="+ topic/ph pr-d/codeph ">data</codeph> property to display the input, parameters, and metadata properties of 
	 * the shader.
	 * 
	 *   <p class="- topic/p ">Note that this example assumes there's a shader bytecode file named "donothing.pbj" in the same 
	 * directory as the output directory for the application.</p><codeblock xml:space="preserve" class="+ topic/pre pr-d/codeblock ">
	 * 
	 *   //
	 * // Source code for the shader:
	 * //
	 * &lt;languageVersion : 1.0;&gt;
	 * 
	 *   kernel DoNothing
	 * &lt;
	 * namespace: "Adobe::Example";
	 * vendor: "Adobe examples";
	 * version: 1;
	 * description: "A shader that does nothing, but does it well.";
	 * &gt;
	 * {
	 * input image4 src;
	 * 
	 *   output pixel4 dst;
	 * 
	 *   parameter float2 size
	 * &lt;
	 * description: "The size of the image to which the shader is applied";
	 * minValue: float2(0.0, 0.0);
	 * maxValue: float2(100.0, 100.0);
	 * defaultValue: float2(50.0, 50.0);
	 * &gt;;
	 * 
	 *   parameter float radius
	 * &lt;
	 * description: "The radius of the effect";
	 * minValue: float(0.0);
	 * maxValue: float(50.0);
	 * defaultValue: float(25.0);
	 * &gt;;
	 * 
	 *   void evaluatePixel()
	 * {
	 * float2 one = (radius / radius) * (size / size);
	 * dst = sampleNearest(src, outCoord());
	 * }
	 * }
	 * 
	 *   //
	 * // ActionScript source code:
	 * //
	 * package {
	 * import flash.display.Shader;
	 * import flash.display.Sprite;
	 * import flash.events.Event;
	 * import flash.net.URLLoader;
	 * import flash.net.URLLoaderDataFormat;
	 * import flash.net.URLRequest;
	 * 
	 *   public class ShaderDataExample extends Sprite {
	 * 
	 *   private var loader:URLLoader;
	 * 
	 *   public function ShaderDataExample() {
	 * loader = new URLLoader();
	 * loader.dataFormat = URLLoaderDataFormat.BINARY;
	 * loader.addEventListener(Event.COMPLETE, loadCompleteHandler);
	 * loader.load(new URLRequest("donothing.pbj"));
	 * }
	 * 
	 *   private function loadCompleteHandler(event:Event):void {
	 * var shader:Shader = new Shader();
	 * shader.byteCode = loader.data;
	 * 
	 *   for (var p:String in shader.data) {
	 * trace(p, ":", shader.data[p]);
	 * for (var d:String in shader.data[p]) {
	 * trace("\t", d, ":", shader.data[p][d]);
	 * }
	 * }
	 * }
	 * }
	 * }
	 * </codeblock>
	 * @langversion	3.0
	 * @playerversion	Flash 10
	 * @playerversion	AIR 1.5
	 */
	public final dynamic class ShaderData extends Object
	{
		/**
		 * Creates a ShaderData instance. Generally, developer code does not call 
		 * the ShaderData constructor directly. A ShaderData instance containing 
		 * data, parameters, and inputs for a Shader instance is accessed using 
		 * its data property.
		 * @param	byteCode	The shader's byte code.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 */
		public function ShaderData (byteCode:ByteArray);
	}
}
