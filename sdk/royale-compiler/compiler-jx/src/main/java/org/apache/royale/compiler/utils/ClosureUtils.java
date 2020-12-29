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

package org.apache.royale.compiler.utils;

import java.util.LinkedHashSet;
import java.util.Set;

import org.apache.royale.compiler.asdoc.royale.ASDocComment;
import org.apache.royale.compiler.definitions.IAccessorDefinition;
import org.apache.royale.compiler.definitions.IDefinition;
import org.apache.royale.compiler.definitions.IFunctionDefinition;
import org.apache.royale.compiler.definitions.INamespaceDefinition;
import org.apache.royale.compiler.definitions.IPackageDefinition;
import org.apache.royale.compiler.definitions.ITypeDefinition;
import org.apache.royale.compiler.definitions.IVariableDefinition;
import org.apache.royale.compiler.definitions.IVariableDefinition.VariableClassification;
import org.apache.royale.compiler.definitions.references.INamespaceReference;
import org.apache.royale.compiler.internal.codegen.js.royale.JSRoyaleEmitter;
import org.apache.royale.compiler.internal.codegen.js.utils.DocEmitterUtils;
import org.apache.royale.compiler.internal.projects.RoyaleJSProject;
import org.apache.royale.compiler.scopes.IASScope;
import org.apache.royale.compiler.scopes.IFileScope;
import org.apache.royale.compiler.units.ICompilationUnit;

public class ClosureUtils
{
	public static void collectPropertyNamesToKeep(ICompilationUnit cu, RoyaleJSProject project, Set<String> result)
    {
        if (project.isExternalLinkage(cu))
        {
            return;
        }
        boolean preventRenamePublicSymbols = project.config != null && project.config.getPreventRenamePublicSymbols();
        boolean preventRenamePublicInstanceMethods = project.config != null && project.config.getPreventRenamePublicInstanceMethods();
        boolean preventRenamePublicStaticMethods = project.config != null && project.config.getPreventRenamePublicStaticMethods();
        boolean preventRenamePublicInstanceVariables = project.config != null && project.config.getPreventRenamePublicInstanceVariables();
        boolean preventRenamePublicStaticVariables = project.config != null && project.config.getPreventRenamePublicStaticVariables();
        boolean preventRenamePublicInstanceAccessors = project.config != null && project.config.getPreventRenamePublicInstanceAccessors();
        boolean preventRenamePublicStaticAccessors = project.config != null && project.config.getPreventRenamePublicStaticAccessors();
        
        boolean preventRenameProtectedSymbols = project.config != null && project.config.getPreventRenameProtectedSymbols();
        boolean preventRenameProtectedInstanceMethods = project.config != null && project.config.getPreventRenameProtectedInstanceMethods();
        boolean preventRenameProtectedStaticMethods = project.config != null && project.config.getPreventRenameProtectedStaticMethods();
        boolean preventRenameProtectedInstanceVariables = project.config != null && project.config.getPreventRenameProtectedInstanceVariables();
        boolean preventRenameProtectedStaticVariables = project.config != null && project.config.getPreventRenameProtectedStaticVariables();
        boolean preventRenameProtectedInstanceAccessors = project.config != null && project.config.getPreventRenameProtectedInstanceAccessors();
        boolean preventRenameProtectedStaticAccessors = project.config != null && project.config.getPreventRenameProtectedStaticAccessors();

        boolean preventRenameInternalSymbols = project.config != null && project.config.getPreventRenameInternalSymbols();
        boolean preventRenameInternalInstanceMethods = project.config != null && project.config.getPreventRenameInternalInstanceMethods();
        boolean preventRenameInternalStaticMethods =  project.config != null && project.config.getPreventRenameInternalStaticMethods();
        boolean preventRenameInternalInstanceVariables = project.config != null && project.config.getPreventRenameInternalInstanceVariables();
        boolean preventRenameInternalStaticVariables = project.config != null && project.config.getPreventRenameInternalStaticVariables();
        boolean preventRenameInternalInstanceAccessors = project.config != null && project.config.getPreventRenameInternalInstanceAccessors();
        boolean preventRenameInternalStaticAccessors = project.config != null && project.config.getPreventRenameInternalStaticAccessors();
        try
        {
            for(IASScope scope : cu.getFileScopeRequest().get().getScopes())
            {
                for(IDefinition def : scope.getAllLocalDefinitions())
                {
                    if(def instanceof IPackageDefinition)
                    {
                        //source files seem to return packages while SWC files
                        //return symbols inside the packages
                        //we want the symbols, so drill down into the package
                        IPackageDefinition packageDef = (IPackageDefinition) def;
                        def = packageDef.getContainedScope().getAllLocalDefinitions().iterator().next();
                    }
                    if(scope instanceof IFileScope && def.isPrivate())
                    {
                        //file-private symbols are emitted like static variables
                        result.add(def.getBaseName());
                    }
                    if (def instanceof IVariableDefinition
                            && !(def instanceof IAccessorDefinition))
                    {
                        IVariableDefinition varDef = (IVariableDefinition) def;
                        if (varDef.getVariableClassification().equals(VariableClassification.PACKAGE_MEMBER)) {
                            result.add(def.getBaseName());
                        }
                    }
                    if (def instanceof ITypeDefinition)
                    {
                        if (def.isImplicit() || def.isNative())
                        {
                            continue;
                        }
                        ITypeDefinition typeDef = (ITypeDefinition) def;
                        for (IDefinition localDef : typeDef.getContainedScope().getAllLocalDefinitions())
                        {
                            if (localDef.isImplicit() || localDef.isPrivate())
                            {
                                continue;
                            }
                            INamespaceReference nsRef = localDef.getNamespaceReference();
                            boolean isCustomNS = !nsRef.isLanguageNamespace();
                            boolean isMethod = localDef instanceof IFunctionDefinition
                                && !(localDef instanceof IAccessorDefinition);
                            boolean isVar = localDef instanceof IVariableDefinition
                                && !(localDef instanceof IAccessorDefinition)
                                && !localDef.isBindable();
                            boolean isAccessor = localDef instanceof IAccessorDefinition
                                || (localDef instanceof IVariableDefinition && localDef.isBindable());
                            if(localDef.isPublic() || isCustomNS)
                            {
                                if(!preventRenamePublicSymbols)
                                {
                                    continue;
                                }
                                if(localDef.isStatic())
                                {
                                    if(isMethod && !preventRenamePublicStaticMethods)
                                    {
                                        continue;
                                    }
                                    else if(isVar && !preventRenamePublicStaticVariables)
                                    {
                                        continue;
                                    }
                                    else if(isAccessor && !preventRenamePublicStaticAccessors)
                                    {
                                        continue;
                                    }
                                }
                                else // instance
                                {
                                    if(isMethod && !preventRenamePublicInstanceMethods)
                                    {
                                        continue;
                                    }
                                    else if(isVar && !preventRenamePublicInstanceVariables)
                                    {
                                        continue;
                                    }
                                    else if(isAccessor && !preventRenamePublicInstanceAccessors)
                                    {
                                        continue;
                                    }
                                }
                            }
                            else if(localDef.isProtected())
                            {
                                if(!preventRenameProtectedSymbols)
                                {
                                    continue;
                                }
                                if(localDef.isStatic())
                                {
                                    if(isMethod && !preventRenameProtectedStaticMethods)
                                    {
                                        continue;
                                    }
                                    else if(isVar && !preventRenameProtectedStaticVariables)
                                    {
                                        continue;
                                    }
                                    else if(isAccessor && !preventRenameProtectedStaticAccessors)
                                    {
                                        continue;
                                    }
                                }
                                else // instance
                                {
                                    if(isMethod && !preventRenameProtectedInstanceMethods)
                                    {
                                        continue;
                                    }
                                    else if(isVar && !preventRenameProtectedInstanceVariables)
                                    {
                                        continue;
                                    }
                                    else if(isAccessor && !preventRenameProtectedInstanceAccessors)
                                    {
                                        continue;
                                    }
                                }
                            }
                            else if(localDef.isInternal())
                            {
                                if(!preventRenameInternalSymbols)
                                {
                                    continue;
                                }
                                if(localDef.isStatic())
                                {
                                    if(isMethod && !preventRenameInternalStaticMethods)
                                    {
                                        continue;
                                    }
                                    else if(isVar && !preventRenameInternalStaticVariables)
                                    {
                                        continue;
                                    }
                                    else if(isAccessor && !preventRenameInternalStaticAccessors)
                                    {
                                        continue;
                                    }
                                }
                                else // instance
                                {
                                    if(isMethod && !preventRenameInternalInstanceMethods)
                                    {
                                        continue;
                                    }
                                    else if(isVar && !preventRenameInternalInstanceVariables)
                                    {
                                        continue;
                                    }
                                    else if(isAccessor && !preventRenameInternalInstanceAccessors)
                                    {
                                        continue;
                                    }
                                }
                            }
                            else
                            {
                                //skip anything else not covered by the above cases
                                continue;
                            }
                            String baseName = localDef.getBaseName();
                            if (isCustomNS)
                            {
                                String uri = nsRef.resolveNamespaceReference(project).getURI();
                                baseName = JSRoyaleEmitter.formatNamespacedProperty(uri, baseName, false);
                            }
                            result.add(baseName);
                        }
                    }
                }
            }
        }
        catch(InterruptedException e) {}
    }

    //the result must be a LinkedHashSet so that it iterates over the keys in
    //the same order that they were added
    public static void collectSymbolNamesToExport(ICompilationUnit cu, RoyaleJSProject project, LinkedHashSet<String> symbolsResult)
    {
        if (project.isExternalLinkage(cu))
        {
            return;
        }
        boolean exportPublic = project.config != null && project.config.getExportPublicSymbols();
        boolean exportProtected = project.config != null && project.config.getExportProtectedSymbols();
        boolean exportInternal = project.config != null && project.config.getExportInternalSymbols();
        try
        {
            String parentQName = null;
            Set<String> filePrivateNames = new LinkedHashSet<String>();
            for(IASScope scope : cu.getFileScopeRequest().get().getScopes())
            {
                for(IDefinition def : scope.getAllLocalDefinitions())
                {
                    if(def instanceof IPackageDefinition)
                    {
                        //source files seem to return packages while SWC files
                        //return symbols inside the packages
                        //we want the symbols, so drill down into the package
                        IPackageDefinition packageDef = (IPackageDefinition) def;
                        def = packageDef.getContainedScope().getAllLocalDefinitions().iterator().next();
                    }
                    if (def.isImplicit() || def.isNative())
                    {
                        continue;
                    }

                    String qualifiedName = def.getQualifiedName();
                    boolean isFilePrivate = false;
                    if(scope instanceof IFileScope && def.isPrivate())
                    {
                        isFilePrivate = true;
                        filePrivateNames.add(qualifiedName);
                    }
                    else
                    {
                        if (project.isExterns(qualifiedName))
                        {
                            return;
                        }
                        symbolsResult.add(qualifiedName);
                        if(parentQName == null)
                        {
                            parentQName = qualifiedName;
                        }
                    }
                    if (def instanceof ITypeDefinition)
                    {
                        ITypeDefinition typeDef = (ITypeDefinition) def;
                        ASDocComment asDoc = (ASDocComment) typeDef.getExplicitSourceComment();
                        if (asDoc != null && DocEmitterUtils.hasSuppressExport(null, asDoc.commentNoEnd()))
                        {
                            continue;
                        }

                        for(IDefinition localDef : typeDef.getContainedScope().getAllLocalDefinitions())
                        {
                            if (localDef.isImplicit())
                            {
                                continue;
                            }
                            boolean isMethod = localDef instanceof IFunctionDefinition
                                && !(localDef instanceof IAccessorDefinition);
                            boolean isVar = localDef instanceof IVariableDefinition
                                && !(localDef instanceof IAccessorDefinition)
                                && !localDef.isBindable();
                            boolean isAccessor = localDef instanceof IAccessorDefinition
                                || (localDef instanceof IVariableDefinition && localDef.isBindable());
                            if (isMethod || isVar || isAccessor)
                            {
                                INamespaceReference nsRef = localDef.getNamespaceReference();
                                boolean isCustomNS = !nsRef.isLanguageNamespace();
                                if ((localDef.isPublic() && exportPublic)
                                        || (isCustomNS && exportPublic)
                                        || (localDef.isProtected() && exportProtected)
                                        || (localDef.isInternal() && exportInternal))
                                {
                                    String baseName = localDef.getBaseName();
                                    if (isCustomNS)
                                    {
                                        String uri = nsRef.resolveNamespaceReference(project).getURI();
                                        baseName = JSRoyaleEmitter.formatNamespacedProperty(uri, localDef.getBaseName(), false);
                                    }
                                    if (isFilePrivate)
                                    {
                                        filePrivateNames.add(qualifiedName + (localDef.isStatic() ? "." : ".prototype.") + baseName);
                                    }
                                    else
                                    {
                                        symbolsResult.add(qualifiedName + (localDef.isStatic() ? "." : ".prototype.") + baseName);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            for(String filePrivateName : filePrivateNames)
            {
                symbolsResult.add(parentQName + "." + filePrivateName);
            }
        }
        catch(InterruptedException e) {}
    }
}