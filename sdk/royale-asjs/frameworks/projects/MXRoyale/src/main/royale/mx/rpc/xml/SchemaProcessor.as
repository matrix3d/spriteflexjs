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

package mx.rpc.xml
{

import mx.utils.object_proxy;
import mx.utils.URLUtil;

use namespace object_proxy;

[ExcludeClass]

/**
 * This abstract class traverses an XML Schema to assist with marshalling typed
 * data between XML and ActionScript.
 * 
 * @private
 */
public class SchemaProcessor
{
    public function SchemaProcessor()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    // Properties
    // 
    //--------------------------------------------------------------------------

    public function get schemaManager():SchemaManager
    {
        if (_schemaManager == null)
            _schemaManager = new SchemaManager();

        return _schemaManager;
    }

    public function set schemaManager(manager:SchemaManager):void
    {
        _schemaManager = manager;
    }
    
    protected function get constants():SchemaConstants
    {
        return schemaManager.schemaConstants;
    }

    //--------------------------------------------------------------------------
    //
    // Methods
    // 
    //--------------------------------------------------------------------------



    /**
     * Clears the state in preparation for a fresh schema processing operation.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */ 
    public function reset():void
    {
        schemaManager.reset();
    }

    /**
     * @private
     */
    public function isBuiltInType(type:QName):Boolean
    {
        var uri:String = (type != null) ? type.uri : null;
        
        if (uri != null)
        {
            if (URLUtil.urisEqual(uri, SchemaConstants.XSD_URI_1999) ||
                URLUtil.urisEqual(uri, SchemaConstants.XSD_URI_2000) ||
                URLUtil.urisEqual(uri, SchemaConstants.XSD_URI_2001))
            {
                return true;    
            }
        }

        return false;
    }


    /**
     * Determines the length of a given value to check minOccurs/maxOccurs
     * ranges. If value is an Array, the count of the elements is returned
     * as the length otherwise the length is considered to be 1.
     * 
     * @private
     */
    public function getValueOccurence(value:*):uint
    {
        var result:uint = 1;
        if (value != null && TypeIterator.isIterable(value))
        {
            result = TypeIterator.getLength(value);
        }
        else if (value === undefined)
        {
            result = 0;
        }
        return result;
    }



    //--------------------------------------------------------------------------
    //
    // Protected Methods
    // 
    //--------------------------------------------------------------------------

    /**
     * A utility method to determine whether an attribute actually exists
     * on a given node.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    protected function getAttributeFromNode(name:*, node:XML):String
    {
        var value:String;
        if (node != null)
        {
            var attribute:XMLList = node.attribute(name);
            if (attribute.length() > 0)
                value = attribute[0];
        }

        return value;
    }

    protected function getSingleElementFromNode(node:XML, ...types:Array):XML
    {
        var elements:XMLList = node.elements();
        for each (var element:XML in elements)
        {
            if (types != null && types.length > 0)
            {
                for each (var type:QName in types)
                {
                    if (element.name() == type)
                    {
                        return element;
                    }
                }
            }
            else
            {
                return element;
            }
        }
        return null;
    }

    /**
     * Looks for a maxOccurs constraint on the given definition. The default
     * is 1. The constraint value "unbounded" is interpreted as
     * <code>uint.MAX_VALUE</code>.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    protected function getMaxOccurs(definition:XML):uint
    {
        var maxOccurs:uint = 1;
        var attributeValue:String = getAttributeFromNode("maxOccurs", definition);
        if (attributeValue != null)
            maxOccurs = (attributeValue == "unbounded") ? uint.MAX_VALUE : parseInt(attributeValue);

        return maxOccurs;
    }

    /**
     * Looks for a minOccurs constraint on the given definition. The default
     * is 1.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    protected function getMinOccurs(definition:XML):uint
    {
        var minOccurs:uint = 1;
        var attributeValue:String = getAttributeFromNode("minOccurs", definition);
        if (attributeValue != null)
            minOccurs = parseInt(attributeValue);

        return minOccurs;
    }


    //--------------------------------------------------------------------------
    //
    // Variables
    // 
    //--------------------------------------------------------------------------

    //FIXME: expose this as a configuration option
    protected var strictOccurenceBounds:Boolean = false;

    private var _schemaManager:SchemaManager;
}

}