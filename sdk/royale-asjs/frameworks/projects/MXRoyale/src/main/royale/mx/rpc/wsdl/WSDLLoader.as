////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

package mx.rpc.wsdl
{

import org.apache.royale.events.Event;
import org.apache.royale.events.EventDispatcher;

import mx.resources.IResourceManager;
import mx.resources.ResourceManager;
import mx.rpc.AsyncToken;
import mx.rpc.Fault;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.events.SchemaLoadEvent;
import mx.rpc.events.WSDLLoadEvent;
import mx.rpc.http.HTTPService;
import mx.rpc.xml.Schema;
import mx.rpc.xml.SchemaLoader;
import mx.rpc.xml.SchemaManager;
import mx.rpc.xml.XMLLoader;
import mx.utils.URLUtil;

[Event(name="fault", type="mx.rpc.events.FaultEvent")]
[Event(name="wsdlLoad", type="mx.rpc.events.WSDLLoadEvent")]

//[ResourceBundle("rpc")]

[ExcludeClass]

/**
 * Manages the loading of a WSDL at runtime, including all imports for
 * WSDL 
 * 
 * @private
 */
public class WSDLLoader extends XMLLoader
{
    //--------------------------------------------------------------------------
    //
    // Constructor
    // 
    //--------------------------------------------------------------------------

    public function WSDLLoader(httpService:HTTPService = null)
    {
        super(httpService);

        locationMap = {};
        schemaLoader = new SchemaLoader(httpService);
        schemaLoader.addEventListener(SchemaLoadEvent.LOAD, schemaLoadHandler);
    }

    //--------------------------------------------------------------------------
    //
    // Variables
    // 
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    private var resourceManager:IResourceManager =
									ResourceManager.getInstance();

    //--------------------------------------------------------------------------
    //
    // Method
    // 
    //--------------------------------------------------------------------------

    /**
     * Asynchronously loads a WSDL for a given URL, including resolving all
     * WSDL imports and includes and XML Schema imports and includes.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    override public function load(url:String):void
    {
        // Resolve any relative URLs to the loader root URL
        url = getQualifiedLocation(url);
        loadWSDL(url);
    }

    override protected function faultHandler(event:FaultEvent):void
    {
        loadsOutstanding--;
        var location:String = event.token == null ? null : event.token.location;
        var detail:String = resourceManager.getString(
			"rpc", "unableToLoadWSDL", [ location ]);
        var fault:Fault = new Fault(event.fault.faultCode, event.fault.faultString, detail);
        event = FaultEvent.createEvent(fault, event.token, event.message);
        dispatchEvent(event);
    }

    override protected function resultHandler(event:ResultEvent):void
    {
        super.resultHandler(event);
        var token:AsyncToken = event.token;
        var xml:XML = XML(event.result);
        var wsdl:WSDL;

        var location:String = token.location;
        if (token.parent != null)
        {
            var parent:WSDL = token.parent as WSDL;
            var ns:Namespace = token.importNamespace as Namespace;

            // We still need to handle endpoints that are not WS-I Basic
            // Profile compliant as older WSDLs may import schemas using
            // wsdl:import instead of xsd:import
            var name:QName = xml.name() as QName;
            if (name == parent.schemaConstants.schemaQName)
            {
                var schema:Schema = new Schema(xml);

                schemaLoader.schemaImports(schema, location, parent.schemaManager);
                parent.addSchema(schema);

                // Treat WSDLs using non-compliant wsdl:import for schemas as
                // a top level import, even though xsd:import are scoped to
                // the parent WSDL.
                if (topLevelWSDL != null)
                {
                    topLevelWSDL.addSchema(schema);
                    
                    // Also re-check for any schema imports as this wsdl
                    // import may have contained the definition for an 
                    // imported namespace that wasn't available earlier...
                    schemaImports(topLevelWSDL, location);
                }
            }
            else
            {
                wsdl = new WSDL(xml, topLevelWSDL ? topLevelWSDL.schemaManager : null);
                // FIXME: An import without a valid namespace is an error!
                parent.addImport(ns, wsdl);
            }
        }
        else
        {
            wsdl = new WSDL(xml);
            topLevelWSDL = wsdl;
            topLevelLocation = location;
        }

        if (wsdl != null)
        {
            locationMap[location] = wsdl;
    
            // Check for WSDL imports
            wsdlImports(wsdl, location);

            // Check for XML Schema imports
            schemaImports(wsdl, location);
        }

        // Finally, check if we've finished loading all imports and includes.
        checkLoadsOutstanding();
    }

    /**
     * This handler is triggered when all schema imports and
     * includes have loaded. This is necessary as the WSDL imports and
     * includes are likely to be finished before the schema sections.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    private function schemaLoadHandler(event:SchemaLoadEvent):void
    {
        checkLoadsOutstanding();
    }

    /**
     * Checks whether a WSDL and all of its Schemas have finished loading.
     * If there are no loads outstanding, a WSDL load event will be dispatched.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    private function checkLoadsOutstanding():void
    {
        if (loadsOutstanding == 0 && schemaLoader.loadsOutstanding == 0)
        {
            var loadEvent:WSDLLoadEvent = WSDLLoadEvent.createEvent(topLevelWSDL, topLevelLocation);
            dispatchEvent(loadEvent);
        }
    }

    private function loadWSDL(location:String, parent:WSDL = null, ns:Namespace = null):AsyncToken
    {
        var token:AsyncToken = internalLoad(location);

        if (token != null)
        {
            token.parent = parent;
            token.importNamespace = ns;
        }
        return token;
    }

    /**
     * WSDL definitions can contain imports to other WSDL definitions.
     * 
     * A WSDL import must define a valid namespace and location.
     * 
     * The WSDLLoader attempts to keep track of imports to avoid cyclic
     * dependencies.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */  
    private function wsdlImports(wsdl:WSDL, parentLocation:String):void
    {
        var importQName:QName = wsdl.wsdlConstants.importQName;
        var imports:XMLList = wsdl.xml.elements(importQName);

        for each (var importNode:XML in imports)
        {
            var location:String = importNode.attribute("location").toString();
            var importURI:String = importNode.attribute("namespace").toString();

            // FIXME: Check location and importNS are valid
            var importNS:Namespace = new Namespace(importURI);

            // Resolve any relative locations to a fully qualified path
            location = getQualifiedLocation(location, parentLocation);

            var existing:WSDL = locationMap[location];
            if (existing == null)
                loadWSDL(location, wsdl, importNS);
            else
                wsdl.addImport(importNS, existing);
        }
    }

    private function schemaImports(wsdl:WSDL, parentLocation:String):void
    {
        var schemaManager:SchemaManager = wsdl.schemaManager;
        var schemas:Array = schemaManager.currentScope();

        for (var s:int = 0; s < schemas.length; s++)
        {
            var schema:Schema = schemas[s];
            var schemaXML:XML = schema.xml;

            //check for includes in the current schema
            var includeSchema:XMLList = schemaXML.elements(schema.schemaConstants.includeQName);
            if (includeSchema != null && includeSchema.length() > 0)
            {
                schemaLoader.schemaIncludes(schema, parentLocation);
            }

            schemaLoader.schemaImports(schema, parentLocation, schemaManager);

            // Fix for SDK-18926. Commenting out the following two lines that would add
            // the imported schema to the parent wsdl's SchemaManager. topLevelWSDL already
            // has information about this schema, since the same SchemaManager instance is
            // used across nested wsdls (see SDK-18926 comment in WSDL.as). Adding this
            // schema again would now cause a loop.
//            if (wsdl != topLevelWSDL)
//                topLevelWSDL.addSchema(schema);
        }
    }


    //--------------------------------------------------------------------------
    //
    // Variables
    // 
    //--------------------------------------------------------------------------

    private var schemaLoader:SchemaLoader;
    private var topLevelWSDL:WSDL;
    private var topLevelLocation:String;
    private var locationMap:Object;
}

}