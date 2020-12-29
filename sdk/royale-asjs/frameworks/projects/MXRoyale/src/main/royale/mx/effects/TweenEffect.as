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

package mx.effects
{

import mx.effects.effectClasses.TweenEffectInstance;
//import mx.events.TweenEvent;
import org.apache.royale.events.EventDispatcher;

/**
 *  Dispatched when the tween effect starts, which corresponds to the 
 *  first call to the <code>onTweenUpdate()</code> method.
 *  Flex also dispatches the first <code>tweenUpdate</code> event 
 *  for the effect at the same time.
 *
 *  <p>The <code>Effect.effectStart</code> event is dispatched 
 *  before the <code>tweenStart</code> event.</p>
 *
 *  @eventType mx.events.TweenEvent.TWEEN_START
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Royale 0.9.3
 */
[Event(name="tweenStart", type="mx.events.TweenEvent")]

/**
 *  Dispatched every time the tween effect updates the target.
 *  This event corresponds to a call to 
 *  the <code>TweenEffectInstance.onTweenUpdate()</code> method.
 *
 *  @eventType mx.events.TweenEvent.TWEEN_UPDATE
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Royale 0.9.3
 */
[Event(name="tweenUpdate", type="mx.events.TweenEvent")]

/**
 *  Dispatched when the tween effect ends.
 *  This event corresponds to a call to 
 *  the <code>TweenEffectInstance.onTweenEnd()</code> method.
 *
 *  <p>When a tween effect plays a single time, this event occurs
 *  at the same time as an <code>effectEnd</code> event.
 *  If you configure the tween effect to repeat, 
 *  it occurs at the end of every repetition of the effect,
 *  and the <code>endEffect</code> event occurs
 *  after the effect plays for the final time.</p>
 *
 *  @eventType mx.events.TweenEvent.TWEEN_END
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Royale 0.9.3
 */
[Event(name="tweenEnd", type="mx.events.TweenEvent")]

/**
 *  TweenEffect is the superclass for the animated effects in Royale 0.9.3. As of Flex 4, the 
 *  Spark effects extend the spark.effects.Animate class instead of TweenEffect.
 */
[Alternative(replacement="spark.effects.Animate", since="4.0")]

/**
 *  The TweenEffect class is the superclass for all effects
 *  that are based on the Tween object.
 *  This class encapsulates methods and properties that are common
 *  among all Tween-based effects, to avoid duplication of code elsewhere.
 *
 *  <p>You create a subclass of the TweenEffect class to define
 *  an effect that plays an animation over a period of time. 
 *  For example, the Resize effect modifies the size of its target
 *  over a specified duration.</p>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:TweenEffect&gt;</code> tag
 *  inherits all of the tag attributes of its superclass,
 *  and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:TagName
 *    <b>Properties</b>
 *    easingFunction="<i>easing function name; no default</i>"
 *     
 *    <b>Events</b>
 *    tweenEnd="<i>No default</i>"
 *  /&gt;
 *  </pre>
 *
 *  @see mx.effects.Tween
 *  @see mx.effects.effectClasses.TweenEffectInstance 
 * 
 *  @includeExample examples/SimpleTweenEffectExample.mxml
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Royale 0.9.3
 *  @royalesuppresspublicvarwarning
 */
public class TweenEffect extends Effect
{
   /*  include "../core/Version.as";
	*/
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     *
     *  @param target The Object to animate with this effect.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */
    public function TweenEffect(target:Object = null)
    {
        super(target);

        instanceClass = TweenEffectInstance;    
    }
        
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
 
    //----------------------------------
    //  easingFunction
    //----------------------------------
    
    /**
     *  The easing function for the animation.
     *  The easing function is used to interpolate between the initial value
     *  and the final value.
     *  A trivial easing function would simply do linear interpolation,
     *  but more sophisticated easing functions create the illusion of
     *  acceleration and deceleration, which makes the animation seem
     *  more natural.
     *
     *  <p>If no easing function is specified, an easing function based
     *  on the <code>Math.sin()</code> method is used.</p>
     *
     *  <p>The easing function follows the function signature popularized
     *  by Robert Penner.
     *  The function accepts four arguments.
     *  The first argument is the "current time",
     *  where the animation start time is 0.
     *  The second argument is the initial value
     *  at the beginning of the animation (a Number).
     *  The third argument is the ending value minus the initial value.
     *  The fourth argument is the duration of the animation.
     *  The return value is the interpolated value for the current time.
     *  This is usually a value between the initial value
     *  and the ending value.</p>
     *
     *  <p>The value of this property must be a function object.</p>
     *
     *  <p>Flex includes a set of easing functions
     *  in the mx.effects.easing package.</p>
     *
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */ 
    public var easingFunction:Function = null;
    
    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------
    
    /**
     *  @private
     */
    override protected function initInstance(instance:IEffectInstance):void
    {
        //super.initInstance(instance);
        
        TweenEffectInstance(instance).easingFunction = easingFunction;

      //  EventDispatcher(instance).addEventListener(TweenEvent.TWEEN_START, tweenEventHandler);      
       // EventDispatcher(instance).addEventListener(TweenEvent.TWEEN_UPDATE, tweenEventHandler);         
       // EventDispatcher(instance).addEventListener(TweenEvent.TWEEN_END, tweenEventHandler);
    }
    
    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    /**
     *  Called when the TweenEffect dispatches a TweenEvent.
     *  If you override this method, ensure that you call the super method.
     *
     *  @param event An event object of type TweenEvent.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Royale 0.9.3
     */
   /*  protected function tweenEventHandler(event:TweenEvent):void
    {
        dispatchEvent(event);
    } */
}

}
