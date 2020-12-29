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
package org.apache.royale.compiler.internal.parsing.as;




import antlr.Token;

import org.apache.royale.compiler.asdoc.IASDocComment;
import org.apache.royale.compiler.asdoc.IASDocDelegate;
import org.apache.royale.compiler.asdoc.IASParserASDocDelegate;
import org.apache.royale.compiler.asdoc.IMetadataParserASDocDelegate;
import org.apache.royale.compiler.asdoc.IPackageDITAParser;
import org.apache.royale.compiler.asdoc.royale.ASDocComment;
import org.apache.royale.compiler.common.ISourceLocation;
import org.apache.royale.compiler.definitions.IDocumentableDefinition;
import org.apache.royale.compiler.tree.as.IDocumentableDefinitionNode;

/**
 * Default implementation of {@link IASDocDelegate} that does not have any code
 * model or eclipse dependencies.
 */
public final class RoyaleASDocDelegate implements IASDocDelegate
{
    private static final RoyaleASDocDelegate INSTANCE = new RoyaleASDocDelegate();

    /**
     * Gets the single instance of this delegate.
     * 
     * @return The single instance of this delegate.
     */
    public static IASDocDelegate get()
    {
        return INSTANCE;
    }

    public RoyaleASDocDelegate()
    {
    }

    @Override
    public IASParserASDocDelegate getASParserASDocDelegate()
    {
        return new ASDelegate();
    }

    @Override
    public IASDocComment createASDocComment(ISourceLocation location, IDocumentableDefinition definition)
    {
        return null;
    }

    @Override
    public IPackageDITAParser getPackageDitaParser()
    {
        return IPackageDITAParser.NIL_PARSER;
    }

    private static final class ASDelegate implements IASParserASDocDelegate, IMetadataParserASDocDelegate
    {
        @SuppressWarnings("unused")
		static final ASDelegate INSTANCE = new ASDelegate();

        @Override
        public void beforeVariable()
        {
        }

        @Override
        public void afterVariable()
        {
        }

        Token currentToken;
        
        @Override
        public void setCurrentASDocToken(Token asDocToken)
        {
            currentToken = asDocToken;
        }

        @Override
        public IASDocComment afterDefinition(IDocumentableDefinitionNode definitionNode)
        {
            if (currentToken == null)
                return null;
            
            ASDocComment comment = new ASDocComment(currentToken);
            currentToken = null;
            return comment;
        }

        @Override
        public IMetadataParserASDocDelegate getMetadataParserASDocDelegate()
        {
        	// ASDelegate is also MetadataDelegate because when metadata like
        	// event metadata has asdoc, the parser sees the asdoc token before
        	// seeing the metadata tokens so it tells the ASDelegate about
        	// the token but then asks the metadata delegate after the
        	// definition.  Sharing the token between the two types of
        	// delegates seems to fix the problem.
            return this;
        }

        @Override
        public void clearMetadataComment(String metaDataTagName)
        {
        }

        @Override
        public void afterMetadata(int metaDataEndOffset)
        {
        }
    }
}
