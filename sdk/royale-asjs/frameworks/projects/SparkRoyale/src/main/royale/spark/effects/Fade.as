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

package spark.effects
{
import mx.effects.Fade;


// not implemented
[Event(name="effectUpdate", type="mx.events.EffectEvent")]
public class Fade extends mx.effects.Fade
{
	public function set targets(value:Array):void {} // not implemented
	public function get isPlaying():Boolean {return false} // not implemented
	public function get playheadTime():Number {return NaN} // not implemented
}
}
