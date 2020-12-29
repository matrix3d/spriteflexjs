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

package mx.rpc.soap.mxml
{

import mx.core.mx_internal;
import mx.managers.CursorManager;
import mx.messaging.events.MessageEvent;
import mx.messaging.messages.AsyncMessage;
import mx.messaging.messages.IMessage;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;
import mx.rpc.AbstractService;
import mx.rpc.AsyncToken;
import mx.rpc.AsyncDispatcher;
import mx.rpc.Fault;
import mx.rpc.events.FaultEvent;
import mx.rpc.mxml.Concurrency;
import mx.rpc.mxml.IMXMLSupport;
import mx.rpc.soap.WebService;
import mx.rpc.soap.Operation;
import mx.rpc.soap.mxml.WebService;
import mx.validators.Validator;

use namespace mx_internal;

//[ResourceBundle("rpc")]

/**
* An Operation used specifically by WebServices. An Operation is an individual method on a service. An Operation can be called either by invoking the function of the same name on the service or by accessing the Operation
* as a property on the service and calling the <code>send()</code> method.
*  
*  @langversion 3.0
*  @playerversion Flash 9
*  @playerversion AIR 1.1
*  @productversion Flex 3
*/
public class Operation extends mx.rpc.soap.Operation implements IMXMLSupport
{
    //--------------------------------------------------------------------------
    //
    // Constructor
    // 
    //--------------------------------------------------------------------------

     /**
      * Creates a new Operation. 
      *
      * @param webService The web service upon which this Operation is invoked.
      *
      * @param name The name of this Operation.
      *  
      *  @langversion 3.0
      *  @playerversion Flash 9
      *  @playerversion AIR 1.1
      *  @productversion Flex 3
      */
   public function Operation(webService:mx.rpc.soap.WebService = null, name:String = null)
    {
        super(webService, name);

        this.webService = mx.rpc.soap.mxml.WebService(webService);
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
    // Properties
    // 
    //--------------------------------------------------------------------------

    [Inspectable(enumeration="multiple,single,last", defaultValue="multiple", category="General")]
    /**
     * The concurrency for this Operation.  If it has not been explicitly set the setting from the WebService
     * will be used.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function get concurrency():String
    {
        if (_concurrencySet)
        {
            return _concurrency;
        }
        //else
        return webService.concurrency;
    }

    /**
     *  @private
     */
    public function set concurrency(c:String):void
    {
        _concurrency = c;
        _concurrencySet = true;
    }

    override mx_internal function setService(ro:AbstractService):void
    {
        super.setService(ro);

        webService = mx.rpc.soap.mxml.WebService(ro);
    }


    /**
     * Whether this operation should show the busy cursor while it is executing.
     * If it has not been explicitly set the setting from the WebService
     * will be used.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function get showBusyCursor():Boolean
    {
        if (_showBusyCursorSet)
        {
            return _showBusyCursor;
        }
        //else
        return webService.showBusyCursor;
    }

    public function set showBusyCursor(sbc:Boolean):void
    {
        _showBusyCursor = sbc;
        _showBusyCursorSet = true;
    }


    //--------------------------------------------------------------------------
    //
    // Methods
    // 
    //--------------------------------------------------------------------------

    /**
     * @inheritDoc
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    override public function cancel(id:String = null) : AsyncToken
    {
        if (showBusyCursor)
        {
            CursorManager.removeBusyCursor();
        }
        return super.cancel(id);
    }

    /**
     * @private
     */
    override public function send(... args:Array):AsyncToken
    {
        if (Concurrency.SINGLE == concurrency && (hasPendingInvocations() || activeCalls.hasActiveCalls()))
        {
            var token:AsyncToken = new AsyncToken(null);
            var message:String = /*resourceManager.getString(
                "rpc", */"pendingCallExists"/*);*/
            var fault:Fault = new Fault("ConcurrencyError", message);
            var faultEvent:FaultEvent = FaultEvent.createEvent(fault, token);
            new AsyncDispatcher(dispatchRpcEvent, [faultEvent], 10);
            return token;
        }

        return super.send.apply(this, args);
    }


    //--------------------------------------------------------------------------
    //
    // Internal Methods
    // 
    //--------------------------------------------------------------------------

    /**
     * @private
     * Return the id for the NetworkMonitor
     */
    override mx_internal function getNetmonId():String
    {
        return webService.id;
    }
    

    override mx_internal function invoke(message:IMessage, token:AsyncToken = null):AsyncToken
    {
        if (showBusyCursor)
        {
            CursorManager.setBusyCursor();
        }

        return super.invoke(message, token);
    }

    /*
     * Kill the busy cursor, find the matching call object and pass it back
     */
    override mx_internal function preHandle(event:MessageEvent):AsyncToken
    {
        if (showBusyCursor)
        {
            CursorManager.removeBusyCursor();
        }

        var wasLastCall:Boolean = activeCalls.wasLastCall(AsyncMessage(event.message).correlationId);
        var token:AsyncToken = super.preHandle(event);

        if (Concurrency.LAST == concurrency && !wasLastCall)
        {
            return null;
        }
        //else
        return token;
    }


    //--------------------------------------------------------------------------
    //
    // Variables
    // 
    //--------------------------------------------------------------------------

    private var _concurrency:String;
    
    private var _concurrencySet:Boolean;
    
    private var webService:mx.rpc.soap.mxml.WebService;
    
    private var _showBusyCursor:Boolean;
    
    private var _showBusyCursorSet:Boolean;
}

}
