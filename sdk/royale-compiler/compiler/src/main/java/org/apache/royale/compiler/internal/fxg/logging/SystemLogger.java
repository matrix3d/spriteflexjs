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

package org.apache.royale.compiler.internal.fxg.logging;

import java.io.PrintStream;

import org.apache.commons.io.IOUtils;


/**
 * A simple logger that traces messages out to System.out. 
 */
public class SystemLogger extends AbstractLogger
{
    public SystemLogger()
    {
        super(NONE);
    }

    @Override
    public void log(int level, Object message, Throwable t, String location, int line, int column)
    {
        if (level < getLevel())
            return;

        PrintStream ps = level > INFO ? System.err : System.out;

        try
        {
            StringBuilder sb = new StringBuilder();

            if (location != null)
            {
                sb.append(location).append(":");
            }

            if (line > 0)
            {
                sb.append(" Line ").append(line);

                if (column > 0)
                {
                    sb.append(", Column ").append(column);
                }
            }

            if (message != null)
            {
                sb.append(": ").append(message);
            }

            if (t != null)
            {
                sb.append(": ").append(t.getLocalizedMessage());
            }

            ps.println(sb.toString());
        }
        catch (Exception ex)
        {
        }
        finally
        {
            IOUtils.closeQuietly(ps);
        }
    }
}
