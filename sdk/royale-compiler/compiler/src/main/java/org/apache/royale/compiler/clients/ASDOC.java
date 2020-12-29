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

package org.apache.royale.compiler.clients;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.apache.royale.compiler.Messages;
import org.apache.royale.compiler.common.VersionInfo;
import org.apache.royale.compiler.config.Configurator;
import org.apache.royale.compiler.config.ICompilerSettingsConstants;
import org.apache.royale.compiler.exceptions.ConfigurationException;
import org.apache.royale.compiler.internal.config.COMPCConfiguration;
import org.apache.royale.compiler.internal.parsing.as.SimpleASDocDelegate;
import org.apache.royale.compiler.internal.targets.SWFTarget;
import org.apache.royale.compiler.problems.ICompilerProblem;
import org.apache.royale.compiler.problems.MissingRequirementConfigurationProblem;
import org.apache.royale.compiler.targets.ISWCTarget;
import org.apache.royale.compiler.targets.ITargetSettings;
import org.apache.royale.compiler.targets.ITarget.TargetType;
import org.apache.royale.swc.ISWC;
import org.apache.royale.swc.io.ISWCWriter;
import org.apache.royale.swc.io.SWCDirectoryWriter;
import org.apache.royale.swc.io.SWCWriter;
import org.apache.royale.swf.io.SizeReportWritingSWFWriter;
import org.apache.flex.tools.FlexTool;
import org.apache.royale.utils.FilenameNormalization;

/**
 * Documentation compiler entry point.
 * <p>
 * This class is a quick start of component compiler. It depends on most of the
 * functionalities developed for mxmlc.
 */
public class ASDOC extends MXMLC implements FlexTool
{
    /**
     * Entry point for <code>compc</code> tool.
     * 
     * @param args command line arguments
     */
    public static void main(final String[] args)
    {
        int exitCode = staticMainNoExit(args);
        System.exit(exitCode);
    }

    /**
     * Entry point for the {@code <compc>} Ant task.
     * 
     * @param args Command line arguments.
     * @return An exit code.
     */
    public static int staticMainNoExit(final String[] args)
    {
        final ASDOC asdoc = new ASDOC();
        return asdoc.mainNoExit(args);
    }

    public ASDOC()
    {
        super();
        workspace.setASDocDelegate(new SimpleASDocDelegate());
    }
    
    @Override
    public String getName() {
        return FLEX_TOOL_ASDOC;
    }

    @Override
    public int execute(String[] args) {
        return mainNoExit(args);
    }

    /**
     * Console message describing the results of the ASDoc compilation 
     */
    private String asdocOutputMessage;
    
    @Override
    public boolean configure(String[] args)
    {
        return super.configure(args);
    }

    @Override
    protected String getConfigurationDefaultVariable()
    {
        return ICompilerSettingsConstants.INCLUDE_CLASSES_VAR;
    }
  
    @Override
    protected Configurator createConfigurator()
    {
        return new Configurator(COMPCConfiguration.class);
    }

    @Override
    protected String getProgramName()
    {
        return "asdoc";
    }

    @Override
    protected String getStartMessage()
    {
        // This message should not be localized.
        String message = "Apache Royale ASDoc Compiler" + NEWLINE +
            VersionInfo.buildMessage() + NEWLINE;
        return message;
    }

    /**
     * Build SWC library artifact. The compilation units are already built at
     * this point.
     */
    @Override
    protected void buildArtifact() throws InterruptedException, IOException
    {
        // Write the SWC model to disk.
        final String outputOptionValue = config.getOutput();
        if (outputOptionValue == null || outputOptionValue.length() == 0)
        {
            ICompilerProblem problem = new MissingRequirementConfigurationProblem(ICompilerSettingsConstants.OUTPUT_VAR);
            problems.add(problem);
            return;
        }

        // SWC target will create a SWC model.
        ISWCTarget swcTarget;
        ITargetSettings targetSettings = projectConfigurator.getTargetSettings(TargetType.SWC);
        if (targetSettings == null)
            return;
        
        swcTarget = project.createSWCTarget(targetSettings, null);
        target = (SWFTarget)swcTarget.getLibrarySWFTarget();

        Collection<ICompilerProblem> swcProblems = new ArrayList<ICompilerProblem>();
        final ISWC swc = swcTarget.build(swcProblems);

        problems.addAll(swcProblems);

        // Don't create a SWC if there are errors unless a 
        // developer requested otherwise.
        if (!config.getCreateTargetWithErrors() && problems.hasErrors())
            return;
        
        boolean useCompression = targetSettings.useCompression();
        if (config.getOutputSwcAsDirectory())
        {
            final String path = FilenameNormalization.normalize(outputOptionValue);
            final ISWCWriter swcWriter = new SWCDirectoryWriter(path, useCompression,
                    targetSettings.isDebugEnabled(), targetSettings.isTelemetryEnabled(),
                    SizeReportWritingSWFWriter.getSWFWriterFactory(targetSettings.getSizeReport()));
            swcWriter.write(swc);
            long endTime = System.nanoTime();
            String seconds = String.format("%5.3f", (endTime - startTime) / 1e9);
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("path", path);
            params.put("seconds", seconds);
            asdocOutputMessage = 
                    Messages.getString("COMPC.swc_written_open_directory_in_seconds_format",
                    params);
        }
        else
        {
            final ISWCWriter swcWriter = new SWCWriter(outputOptionValue, useCompression,
                    targetSettings.isDebugEnabled(), targetSettings.isTelemetryEnabled(),
                    targetSettings.getSWFMetadataDate(), targetSettings.getSWFMetadataDateFormat(),
                    SizeReportWritingSWFWriter.getSWFWriterFactory(targetSettings.getSizeReport()));
            swcWriter.write(swc);
            final File outputFile = new File(outputOptionValue);
            long endTime = System.nanoTime();
            String seconds = String.format("%5.3f", (endTime - startTime) / 1e9);
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("byteCount", outputFile.length());
            params.put("path", outputFile.getCanonicalPath());
            params.put("seconds", seconds);
            asdocOutputMessage = Messages.getString("MXMLC.bytes_written_to_file_in_seconds_format",
                    params);
        }
    }

    @Override
    protected void reportTargetCompletion()
    {
        if (asdocOutputMessage != null)
            println(asdocOutputMessage);
    }

    /**
     * Compc uses the target file as the output SWC file name. Nothing needs to
     * be done here.
     */
    @Override
    protected boolean setupTargetFile() throws InterruptedException
    {
        return true;
    }

    /**
     * Compc uses the target file as the output SWC file name if provided.
     * Nothing needs to be done here.
     */
    @Override
    protected void validateTargetFile() throws ConfigurationException
    {
    }

    @Override
    protected boolean isCompc()
    {
        return true;
    }
    
    @Override
    protected TargetType getTargetType()
    {
        return TargetType.SWC;
    }
}
