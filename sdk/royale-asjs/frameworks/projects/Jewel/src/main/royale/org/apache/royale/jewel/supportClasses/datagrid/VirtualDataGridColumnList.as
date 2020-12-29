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
package org.apache.royale.jewel.supportClasses.datagrid
{
    import org.apache.royale.core.IBead;
    import org.apache.royale.core.IDataGrid;
    import org.apache.royale.jewel.VirtualList;
    import org.apache.royale.jewel.beads.models.DataGridColumnListPresentationModel;
    import org.apache.royale.jewel.supportClasses.datagrid.IDataGridColumnList;
    import org.apache.royale.jewel.supportClasses.list.IListPresentationModel;
    
    /**
     *  The VirtualDataGridColumnList class is the VirtualList class used internally
     *  by VirtualDataGrid for each column.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.8
     */
	public class VirtualDataGridColumnList extends VirtualList implements IDataGridColumnList
	{
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.8
         */
		public function VirtualDataGridColumnList()
		{
			super();
			typeNames = "jewel list column";
		}
		
        private var _columnInfo:IDataGridColumn;
        /**
         *  The IDataGridColumn for this list
         *  
         *
         *  @toplevel
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.8
         * 
         *  @royalesuppresspublicvarwarning
         */
		public function get columnInfo():IDataGridColumn
        {
            return _columnInfo;
        }
		public function set columnInfo(value:IDataGridColumn):void
        {
            if(_columnInfo != value)
                _columnInfo = value;
        }

        private var _datagrid:IDataGrid;
        /**
		 *  Pointer back to the IDataGrid that owns this column List
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.8
		 */
		public function get datagrid():IDataGrid {
            return _datagrid;
        }
		public function set datagrid(value:IDataGrid):void {
            _datagrid = value;
        }

        /**
		 *  The presentation model for the list.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9
		 *  @royaleignorecoercion org.apache.royale.jewel.supportClasses.list.IListPresentationModel
		 */
		override public function get presentationModel():IBead
		{
			var presModel:IListPresentationModel = getBeadByType(IListPresentationModel) as IListPresentationModel;
			if (presModel == null) {
				presModel = new DataGridColumnListPresentationModel();
				addBead(presModel);
			}
			return presModel;
		}
	}
}
