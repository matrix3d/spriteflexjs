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
package mx.utils
{

    import mx.events.TimerEvent;

    import org.apache.royale.utils.Timer;

    //--------------------------------------
    //  Events
    //--------------------------------------

    /**
     *  Dispatched when timer stops
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.8
     */
    [Event(name="timerComplete", type="org.apache.royale.events.Event")]


    /**
     *  The Timer class dispatches events based on a delay
     *  and repeat count.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.8
     *
     *  @royalesuppresspublicvarwarning
     */
    public class Timer extends org.apache.royale.utils.Timer
    {
        public function Timer(delay:Number, repeatCount:int = 0)
        {
            super(delay, repeatCount);
        }

        override public function stop():void
        {
            super.stop();
            COMPILE::JS
            {
                if (!running) {
                    dispatchEvent(new TimerEvent('timerComplete'));
                }
            }
        }
    }
}
