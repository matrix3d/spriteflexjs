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

//import flash.utils.ByteArray;


[ExcludeClass]

/**
 *  Documentation is not currently available.
 *  Ported to ActionScript from flex/messaging/util/Hex.java
 *  @private
 */
public class HexDecoder
{
    /**
     *  @private
     *  Constructor.
     */
    public function HexDecoder()
    {
        super();
        _output = new ByteArray();
    }

    /**
     *  @private
     */
    public function decode(encoded:String):void
    {
        for (var i:int = 0; i < encoded.length; i++)
        {
            _work[0] = digit(encoded.charAt(i));
            
            i++;
            _work[1] = digit(encoded.charAt(i));

            _output.writeByte(((_work[0] << 4) | (_work[1])) & 0xff);
        }
    }

    /**
     * Returns the decimal representation of a hex digit.
     * @private 
     */
    public function digit(char:String):int
    {
        switch (char) 
        {
            case "A": 
            case "a":           
                return 10;
            case "B":
            case "b":
                return 11;
            case "C":
            case "c":
                return 12;
            case "D":
            case "d":
                return 13;
            case "E":
            case "e":
                return 14;                
            case "F":
            case "f":
                return 15;
            default:
                return new Number(char);
        }    
    }

    /**
     *  @private
     */
    public function drain():ByteArray
    {
        var result:ByteArray = _output;
        _output = new ByteArray();
        result.position = 0;
        return result;
    }

    /**
     *  @private
     */
    public function flush():ByteArray
    {
        return drain();
    }

    /**
     *  @private
     */
    private var _output:ByteArray;

    /**
     *  @private
     */
    private var _work:Array = [ 0, 0 ];

}

}
