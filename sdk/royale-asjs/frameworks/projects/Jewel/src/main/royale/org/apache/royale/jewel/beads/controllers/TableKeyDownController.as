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
package org.apache.royale.jewel.beads.controllers
{
	import org.apache.royale.core.Bead;
	import org.apache.royale.core.IBeadKeyController;
	import org.apache.royale.core.IBeadView;
	import org.apache.royale.core.IRemovableBead;
	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.ITableModel;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.KeyboardEvent;
	import org.apache.royale.events.utils.WhitespaceKeys;
	import org.apache.royale.html.beads.ITableView;

    /**
     *  The Jewel TableKeyDownController class is a key controller for
     *  org.apache.royale.jewel.Table.
	 * 
	 *  This is just a dummy implementation for now, will be fully implemented soon
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.8
     */
	public class TableKeyDownController extends Bead implements IBeadKeyController, IRemovableBead
	{
        /**
         *  Constructor.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.8
         */
		public function TableKeyDownController()
		{
		}

		/**
		 *  The model.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.8
		 */
		protected var tableModel:ITableModel;

		/**
		 *  The view.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.8
		 */
		protected var tableView:ITableView;

        /**
         *  @copy org.apache.royale.core.IBead#strand
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.8
         *  @royaleignorecoercion org.apache.royale.core.ISelectionModel
		 *  @royaleignorecoercion org.apache.royale.jewel.beads.models.IJewelSelectionModel
         *  @royaleignorecoercion org.apache.royale.events.IEventDispatcher
         *  @royaleignorecoercion org.apache.royale.core.IListView
         */
		override public function set strand(value:IStrand):void
		{
			_strand = value;
			tableModel = value.getBeadByType(ISelectionModel) as ITableModel;
			tableView = value.getBeadByType(IBeadView) as ITableView;

            listenOnStrand(KeyboardEvent.KEY_DOWN, keyDownEventHandler);
		}

		/**
		 *  The actions needed before the removal
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.8
		 */
		public function tearDown():void
		{
			IEventDispatcher(_strand).removeEventListener(KeyboardEvent.KEY_DOWN, keyDownEventHandler);
		}

        /**
		 * @private
		 */
		protected function keyDownEventHandler(event:KeyboardEvent):void
		{
			// trace("TableKeyDownController", event)
			// avoid Tab loose the normal behaviour, for navigation we don't want build int scrolling support in browsers
			if(event.key === WhitespaceKeys.TAB)
				return;
			
			event.preventDefault();

			// var index:int = listModel.selectedIndex;

			// if(event.key === NavigationKeys.UP || event.key === NavigationKeys.LEFT)
			// {
			// 	if(index > 0)
			// 		listModel.selectedIndex--;
			// } 
			// else if(event.key === NavigationKeys.DOWN || event.key === NavigationKeys.RIGHT)
			// {
			// 	listModel.selectedIndex++;
			// }

			// if(index != listModel.selectedIndex)
			// {
			// 	listModel.selectedItem = listModel.dataProvider.getItemAt(listModel.selectedIndex);

			// 	var ir:IFocusable = listView.dataGroup.getItemRendererForIndex(listModel.selectedIndex) as IFocusable;
			// 	ir.setFocus();
				
            // 	sendEvent(listView.host, 'change');
			// }
		}
	}
}
