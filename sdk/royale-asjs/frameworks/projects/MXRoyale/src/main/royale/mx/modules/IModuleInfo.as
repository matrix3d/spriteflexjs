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

package mx.modules
{
/* 
import flash.system.ApplicationDomain;
import flash.system.SecurityDomain;
import flash.utils.ByteArray;
import mx.core.IFlexModuleFactory; */
import org.apache.royale.events.IEventDispatcher;

//--------------------------------------
//  Events
//--------------------------------------

/**
 *  Dispatched by the backing ModuleInfo if there was an error during
 *  module loading.
 *
 *  @eventType mx.events.ModuleEvent.ERROR
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Royale 0.9.3
 */
//[Event(name="error", type="mx.events.ModuleEvent")]

/**
 *  Dispatched by the backing ModuleInfo at regular intervals 
 *  while the module is being loaded.
 *
 *  @eventType mx.events.ModuleEvent.PROGRESS
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Royale 0.9.3
 */
//[Event(name="progress", type="mx.events.ModuleEvent")]

/**
 *  Dispatched by the backing ModuleInfo once the module is sufficiently
 *  loaded to call the <code>IModuleInfo.factory()</code> method and the
 *  <code>IFlexModuleFactory.create()</code> method.
 *
 *  @eventType mx.events.ModuleEvent.READY
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Royale 0.9.3
 */
//[Event(name="ready", type="mx.events.ModuleEvent")]

/**
 *  Dispatched by the backing ModuleInfo once the module is sufficiently
 *  loaded to call the <code>IModuleInfo.factory()</code> method and 
 *  the <code>IFlexModuleFactory.info()</code> method.
 *
 *  @eventType mx.events.ModuleEvent.SETUP
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Royale 0.9.3
 */
//[Event(name="setup", type="mx.events.ModuleEvent")]

/**
 *  Dispatched by the backing ModuleInfo when the module data is unloaded.
 *
 *  @eventType mx.events.ModuleEvent.UNLOAD
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Royale 0.9.3
 */
//[Event(name="unload", type="mx.events.ModuleEvent")]

/**
 *  An interface that acts as a handle for a particular module.
 *  From this interface, the module status can be queried,
 *  its inner factory can be obtained, and it can be loaded or unloaded.
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Royale 0.9.3
 */
public interface IModuleInfo extends IEventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  data
    //----------------------------------

    /**
     *  User data that can be associated with the singleton IModuleInfo
     *  for a given URL.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */
   /*  function get data():Object;
     */
    /**
     *  @private
     */
    // function set data(value:Object):void;

    //----------------------------------
    //  error
    //----------------------------------

    /**
     *  A flag that is <code>true</code> if there was an error
     *  during module loading.
     *  
     *  <p>This flag is <code>true</code> when the ModuleManager dispatches the
     *  <code>ModuleEvent.ERROR</code> event.</p>
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */
    // function get error():Boolean;
    
    //----------------------------------
    //  factory
    //----------------------------------

    /**
     *  The IFlexModuleFactory implementation defined in the module.
     *  This will only be non-<code>null</code> after the
     *  <code>ModuleEvent.SETUP</code> event has been dispatched
     *  (or the <code>IModuleInfo.setup()</code> method returns <code>true</code>).
     *  At this point, the <code>IFlexModuleFactory.info()</code> method can be called.
     *  Once a <code>ModuleEvent.READY</code> event is dispatched
     *  (or the <code>IModuleInfo.ready()</code> method returns <code>true</code>),
     *  it is possible to call the <code>IFlexModuleFactory.create()</code> method.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */
    // function get factory():IFlexModuleFactory;
    
    //----------------------------------
    //  loaded
    //----------------------------------

    /**
     *  A flag that is <code>true</code> if the <code>load()</code>
     *  method has been called on this module.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */
    // function get loaded():Boolean;
    
    //----------------------------------
    //  ready
    //----------------------------------

    /**
     *  A flag that is <code>true</code> if the module is sufficiently loaded
     *  to get a handle to its associated IFlexModuleFactory implementation
     *  and call its <code>create()</code> method.
     *  
     *  <p>This flag is <code>true</code> when the ModuleManager dispatches the
     *  <code>ModuleEvent.READY</code> event.</p>
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */
    // function get ready():Boolean;
    
    //----------------------------------
    //  setup
    //----------------------------------

    /**
     *  A flag that is <code>true</code> if the module is sufficiently loaded
     *  to get a handle to its associated IFlexModuleFactory implementation
     *  and call its <code>info()</code> method.
     *  
     *  <p>This flag is <code>true</code> when the ModuleManager dispatches the
     *  <code>ModuleEvent.SETUP</code> event.</p>
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */
    // function get setup():Boolean;
    
    //----------------------------------
    //  url
    //----------------------------------

    /**
     *  The URL associated with this module (for example, "MyImageModule.swf" or 
     *  "http://somedomain.com/modules/MyImageModule.swf". The URL can be local or remote, but 
     *  if it is remote, you must establish a trust between the module's domain and the 
     *  application that loads it.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */
    // function get url():String;
    
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Requests that the module be loaded. If the module is already loaded,
     *  the call does nothing. Otherwise, the module begins loading and dispatches 
     *  <code>progress</code> events as loading proceeds.
     *  
     *  @param applicationDomain The current application domain in which your code is executing.
     *  
     *  @param securityDomain The current security "sandbox".
     * 
     *  @param bytes A ByteArray object. The ByteArray is expected to contain 
     *  the bytes of a SWF file that represents a compiled Module. The ByteArray
     *  object can be obtained by using the URLLoader class. If this parameter
     *  is specified the module will be loaded from the ByteArray. If this 
     *  parameter is null the module will be loaded from the url specified in
     *  the url property.
     * 
     *  @param moduleFactory The moduleFactory of the caller. One use of the 
     *  moduleFactory is to determine the parent style manager of the loaded 
     *  module.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */
  /*   function load(applicationDomain:ApplicationDomain = null,
                  securityDomain:SecurityDomain = null,
                  bytes:ByteArray = null,
                  moduleFactory:IFlexModuleFactory = null):void;
 */
    /**
     *  Releases the current reference to the module.
     *  This does not unload the module unless there are no other
     *  open references to it and the ModuleManager is set up
     *  to have only a limited number of loaded modules.
     *  
     *  @see mx.modules.ModuleManager
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */
    // function release():void;

    /**
     *  Unloads the module.
     *  Flash Player and AIR will not fully unload and garbage collect this module if
     *  there are any outstanding references to definitions inside the
     *  module.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */
    // function unload():void;

    /**
     *  Publishes an interface to the ModuleManager. This allows late (or decoupled)
     *  subscriptions to factories with a String handle. Use a URL that starts with
     *  <code>publish://</code> to reference factories that are published in this manner.
     *  
     *  @param factory The class that implements the module's IFlexModuleFactory interface.
     *  
     *  @see mx.modules.ModuleManager
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */
    // function publish(factory:IFlexModuleFactory):void;

}

}
