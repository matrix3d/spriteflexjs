/*
 *
 *  Licensed to the Apache Software Foundation (ASF) under one or more
 *  contributor license agreements.  See the NOTICE file distributed with
 *  this work for additional information regarding copyright ownership.
 *  The ASF licenses this file to You under the Apache License, Version 2.0
 *  (the "License"); you may not use this file except in compliance with
 *  the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

package org.apache.royale.compiler.ant.config;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.tools.ant.types.Commandline;

/**
 * Extends RepeatableConfigVariable by overriding addToCommandline().
 */
public class RepeatableConfigString extends RepeatableConfigVariable
{
    public RepeatableConfigString(OptionSpec spec)
    {
        super(spec);

        values = new ArrayList<String>();
    }

    private final List<String> values;
    
    public void add(String value)
    {
        values.add(value);
    }

    public void addToCommandline(Commandline cmdline)
    {
       if (values.size() != 0)
            cmdline.createArgument().setValue("-" + spec.getFullName() + "=" + makeArgString());
    }

    private String makeArgString()
    {
        String arg = "";
        Iterator<String> it = values.iterator();

        while (it.hasNext())
        {
            arg += (String) it.next();
            arg += it.hasNext() ? "," : "";
        }

        return arg;
    }
}
