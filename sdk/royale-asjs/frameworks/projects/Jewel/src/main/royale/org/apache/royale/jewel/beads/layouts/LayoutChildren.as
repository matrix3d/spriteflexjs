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
package org.apache.royale.jewel.beads.layouts
{
    import org.apache.royale.core.layout.ILayoutChildren;
    import org.apache.royale.core.IStrand;
    import org.apache.royale.core.ILayoutView;
    import org.apache.royale.core.UIBase;
    import org.apache.royale.events.Event;

    /**
     *  The LayoutChildren class is an ILayoutChildren implememntation that indicates layout
	 *  classes like StyledLayoutBase to layout childrens
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.8
     */
	public class LayoutChildren implements ILayoutChildren
	{
        /**
         *  Constructor.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.8
         */
        public function LayoutChildren()
        {
            super();
        }

        private var _strand:IStrand;

        /**
		 *  @copy org.apache.royale.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.8
		 */
		public function set strand(value:IStrand):void
		{
            _strand = value;
        }

		/**
		 *  trigger the corresponding layout algorithm in all child
         *  elements.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.10
		 *  @royaleignorecoercion org.apache.royale.core.ILayoutView
		 *  @royaleignorecoercion org.apache.royale.core.UIBase
		 */
		public function executeLayoutChildren():void
		{
			// We just need to make chids resize themselves (through `sizeChanged` event)
			var contentView:ILayoutView = _strand as ILayoutView;
			var n:int = contentView.numElements;
			var child:UIBase;

			if (n == 0) return;
			
			for(var i:int=0; i < n; i++) {
				child = contentView.getElementAt(i) as UIBase;
				if (!child)
					continue;
				child.dispatchEvent(new Event('sizeChanged'));
			}
		}
	}
}
