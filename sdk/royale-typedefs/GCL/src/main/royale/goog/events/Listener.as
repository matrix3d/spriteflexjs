// Copyright 2005 The Closure Library Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS-IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * @fileoverview Listener object.
 * @see ../demos/events.html
 */

package goog.events {


  /**
   * Simple class that stores information about a listener
   * @param {function(?):?} listener Callback function.
   * @param {Function} proxy Wrapper for the listener that patches the event.
   * @param {EventTarget|goog.events.Listenable} src Source object for
   *     the event.
   * @param {string} type Event type.
   * @param {boolean} capture Whether in capture or bubble phase.
   * @param {Object=} opt_handler Object in whose context to execute the callback.
   * @implements {goog.events.ListenableKey}
   * @constructor
   */
  public class Listener implements ListenableKey{
    public function Listener(listener:Function,proxy:Function,src:EventTarget,type:String,capture:Boolean,opt_handler:Object = null){
      super();
    }

    /**
     * Whether the listener works on capture phase.
     *
     * @see JSType - [boolean] 
     * @see [listenable]
     */
    public function get capture():Boolean{
      return false;
    }
    public function set capture(value:Boolean):void{

    }

    /**
     * The listener function.
     *
     * @see JSType - [(function (?): ?|null|{handleEvent: function (?): ?})] 
     * @see [listenable]
     */
    public function get listener():Object{
      return null;
    }
    public function set listener(value:Object):void{

    }

    /**
     * The source event target.
     *
     * @see JSType - [(Object|goog.events.EventTarget|goog.events.Listenable)] 
     * @see [listenable]
     */
    public function get src():Object{
      return null;
    }
    public function set src(value:Object):void{

    }

    /**
     * The event type the listener is listening to.
     *
     * @see JSType - [string] 
     * @see [listenable]
     */
    public function get type():String{
      return null;
    }
    public function set type(value:String):void{

    }

    /**
     * A globally unique number to identify the key.
     *
     * @see JSType - [number] 
     * @see [listenable]
     */
    public function get key():Number{
      return 0;
    }
    public function set key(value:Number):void{

    }

    /**
     * The 'this' object for the listener function's scope.
     *
     * @see JSType - [(Object|null)] 
     * @see [listenable]
     */
    public function get handler():Object{
      return null;
    }
    public function set handler(value:Object):void{

    }

    /**
     * Reserves a key to be used for ListenableKey#key field.
     *
     * @see [listenable]
     * @returns {number} A number to be used to fill ListenableKey#key field.
     */
    public function reserveKey():Number{
      return 0;
    }

      /**
       * A wrapper over the original listener. This is used solely to
       * handle native browser events (it is used to simulate the capture
       * phase and to patch the event object).
       * @type {Function}
       */
    public var proxy:Function;

      /**
       * Whether to remove the listener after it has been called.
       * @type {boolean}
       */
    public var callOnce:Boolean;

      /**
       * Whether the listener has been removed.
       * @type {boolean}
       */
    public var removed:Boolean;

    /**
     * If monitoring the goog.events.Listener instances is enabled, stores the
     * creation stack trace of the Disposable instance.
     * @type {string}
     */
    public var creationStack:String;

    /**
     * Marks this listener as removed. This also remove references held by
     * this listener object (such as listener and event source).
     */
    public function markAsRemoved():void {
    }

  }
}

