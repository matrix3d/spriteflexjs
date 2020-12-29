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

package mx.styles
{

import mx.styles.CSSStyleDeclaration;
import mx.styles.ISimpleStyleClient;

/**
 *  This interface describes the properties and methods that an object 
 *  must implement so that it can fully participate in the style subsystem. 
 *  This interface is implemented by UIComponent.
 *
 *  <p>If the object does not need to store style values locally, it can 
 *  implement the <code>ISimpleStyleClient</code> interface instead.</p>
 *
 *  @see mx.styles.ISimpleStyleClient
 *  @see mx.styles.CSSStyleDeclaration
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
public interface IStyleClient extends ISimpleStyleClient
{
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  className
    //----------------------------------

    /**
     *  The name of the component class.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    function get className():String;

    //----------------------------------
    //  inheritingStyles
    //----------------------------------

    /**
     *  An object containing the inheritable styles for this component.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    //function get inheritingStyles():Object;

    /**
     *  @private
     */
    //function set inheritingStyles(value:Object):void;

    //----------------------------------
    //  nonInheritingStyles
    //----------------------------------

    /**
     *  An object containing the noninheritable styles for this component.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    //function get nonInheritingStyles():Object;

    /**
     *  @private
     */
    //function set nonInheritingStyles(value:Object):void;

    //----------------------------------
    //  styleDeclaration
    //----------------------------------

    /**
     *  The style declaration that holds the inline styles declared by this
     *  object.
     *
     *  @see mx.styles.CSSStyleDeclaration
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    //function get styleDeclaration():CSSStyleDeclaration;

    /**
     *  @private
     */
    //function set styleDeclaration(value:CSSStyleDeclaration):void;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Gets a style property that has been set anywhere in this
     *  component's style lookup chain.
     *
     *  <p>This same method is used to get any kind of style property,
     *  so the value returned may be a Boolean, String, Number, int,
     *  uint (for an RGB color), Class (for a skin), or any kind of object.
     *  Therefore the return type is specified as ~~.</p>
     *
     *  <p>If you are getting a particular style property, you will
     *  know its type and will often want to store the result in a
     *  variable of that type. You can use either the <code>as</code>
     *  operator or coercion to do this. For example:</p>
     *
     *  <pre>
     *  var backgroundColor:uint = getStyle("backgroundColor") as int;
     *  
     *  or
     *  
     *  var backgroundColor:uint = int(getStyle("backgroundColor"));
     *  </pre>
     *
     *  <p>If the style property has not been set anywhere in the
     *  style lookup chain, the value returned by the <code>getStyle()</code> method
     *  is <code>undefined</code>.
     *  Note that <code>undefined</code> is a special value that is
     *  not the same as <code>false</code>, the empty String (<code>""</code>),
     *  <code>NaN</code>, 0, or <code>null</code>.
     *  No valid style value is ever <code>undefined</code>.
     *  You can use the static method
     *  <code>StyleManager.isValidStyleValue()</code>
     *  to test whether the value was set.</p>
     *
     *  @param styleProp Name of the style property.
     *
     *  @return Style value.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    function getStyle(styleProp:String):*;

    /**
     *  Sets a style property on this component instance.
     *
     *  <p>This may override a style that was set globally.</p>
     *
     *  <p>Calling the <code>setStyle()</code> method can result in decreased performance.
     *  Use it only when necessary.</p>
     *
     *  @param styleProp Name of the style property.
     *
     *  @param newValue New value for the style.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    //function setStyle(styleProp:String, newValue:*):void

    /**
     *  Deletes a style property from this component instance.
     *
     *  <p>This does not necessarily cause the <code>getStyle()</code> method to return
     *  <code>undefined</code>.</p>
     *
     *  @param styleProp Name of the style property.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    //function clearStyle(styleProp:String):void;

    /**
     *  Returns an Array of CSSStyleDeclaration objects for the type selector
     *  that applies to this component, or <code>null</code> if none exist.
     *
     *  <p>For example, suppose that component MyButton extends Button.
     *  This method first looks for a MyButton selector; then, it looks for a Button type selector;
     *  finally, it looks for a UIComponent type selector.</p>
     *
     *  @return Array of CSSStyleDeclaration objects.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    //function getClassStyleDeclarations():Array; // of CSSStyleDeclaration;

    /**
     *  Propagates style changes to the children of this component.
     *
     *  @param styleProp Name of the style property.
     *
     *  @param recursive Whether to propagate the style changes to the children's children. 
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    //function notifyStyleChangeInChildren(styleProp:String,
    //                                     recursive:Boolean):void;

    /**
     *  Sets up the internal style cache values so that the <code>getStyle()</code> 
     *  method functions.
     *  If this object already has children, then reinitialize the children's
     *  style caches.
     *
     *  @param recursive Regenerate the proto chains of the children. 
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    //function regenerateStyleCache(recursive:Boolean):void;

    /**
     *  Registers the EffectManager as one of the event listeners for each effect event.
     *
     *  @param effects An Array of Strings of effect names. 
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    //function registerEffects(effects:Array /* of String */):void
}

}
