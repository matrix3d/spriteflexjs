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
package
{

/**
 *  @private
 *  This class is used to link additional classes into SparkRoyale.swc
 *  beyond those that are found by dependecy analysis starting
 *  from the classes specified in manifest.xml.
 */
internal class SparkRoyaleClasses
{
	//import spark.components.HScrollBar; HScrollBar;
	//import spark.components.VScrollBar; VScrollBar;
	//import spark.core.SpriteVisualElement; SpriteVisualElement;
	//import spark.events.RendererExistenceEvent; RendererExistenceEvent;
	//import spark.events.TrackBaseEvent; TrackBaseEvent;
	//import spark.primitives.Graphic; Graphic;
	//import spark.skins.spark.ScrollBarDownButtonSkin; ScrollBarDownButtonSkin;
	//import spark.skins.spark.ScrollBarUpButtonSkin; ScrollBarUpButtonSkin;
    import spark.events.IndexChangeEvent; IndexChangeEvent;
    import spark.events.TextOperationEvent; TextOperationEvent;
    import spark.components.supportClasses.DropDownListBase; DropDownListBase;
    import spark.skins.spark.BorderContainerSkin;BorderContainerSkin; 
    import spark.skins.spark.DefaultItemRenderer;DefaultItemRenderer;
    import spark.skins.spark.DropDownListButtonSkin; DropDownListButtonSkin;
    import spark.skins.spark.TitleWindowCloseButtonSkin; TitleWindowCloseButtonSkin; 
	import spark.skins.spark.ComboBoxButtonSkin; ComboBoxButtonSkin; 
	import spark.skins.spark.ComboBoxTextInputSkin; ComboBoxTextInputSkin; 
    import spark.skins.spark.FormSkin; FormSkin; 
    import spark.skins.spark.FormItemSkin; FormItemSkin; 
    import spark.skins.spark.PanelSkin; PanelSkin; 
    import spark.skins.spark.TitleWindowSkin; TitleWindowSkin; 
	
	import spark.layouts.supportClasses.SparkLayoutBead; SparkLayoutBead;
    import spark.layouts.FormLayout; FormLayout;
    import spark.layouts.FormItemLayout; FormItemLayout;
	
	import spark.components.supportClasses.RegExPatterns; RegExPatterns;
	
	import spark.components.gridClasses.CellRegion; CellRegion;
	import spark.components.gridClasses.CellPosition; CellPosition;
	import spark.components.gridClasses.GridSelectionMode; GridSelectionMode;
	import spark.components.gridClasses.GridDoubleClickMode; GridDoubleClickMode;
	import spark.components.gridClasses.GridSortFieldComplex; GridSortFieldComplex;
	import spark.components.gridClasses.GridSortFieldSimple; GridSortFieldSimple;
	
	import spark.components.gridClasses.IDataGridElement; IDataGridElement;
	import spark.components.gridClasses.GridView; GridView;
	import spark.components.gridClasses.GridRowNode; GridRowNode;
	import spark.components.gridClasses.IGridItemRenderer; IGridItemRenderer;
	import spark.components.gridClasses.GridRowList; GridRowList;
	import spark.components.gridClasses.GridDimensions; GridDimensions;
	import spark.components.gridClasses.GridLayout; GridLayout;
	import spark.components.gridClasses.GridColumn; GridColumn;
	import spark.components.gridClasses.GridSelection; GridSelection;
	import spark.events.GridEvent; GridEvent;
	import spark.events.RendererExistenceEvent; RendererExistenceEvent;
	import spark.events.GridCaretEvent; GridCaretEvent;
	import spark.events.GridSelectionEvent; GridSelectionEvent;
	import spark.collections.SubListView; SubListView;
	import spark.collections.SortField; SortField;
	import spark.collections.ComplexSortField; ComplexSortField;
	import spark.components.supportClasses.GroupBase; GroupBase;
	import spark.components.supportClasses.IDataProviderEnhance; IDataProviderEnhance;
	import spark.components.Grid; Grid;
	import spark.components.DataGrid; DataGrid;
	import spark.components.Form; Form;
	import spark.components.FormItem; FormItem;
	import spark.core.IDisplayText; IDisplayText;
	import spark.events.PopUpEvent; PopUpEvent;
	import spark.modules.Module; Module;
	import spark.components.SkinnablePopUpContainer; SkinnablePopUpContainer;
    
    import spark.components.beads.PanelView; PanelView;
    import spark.components.beads.DataContainerView; DataContainerView;
    import spark.components.beads.GroupView; GroupView;
    import spark.components.beads.SkinnableContainerView; SkinnableContainerView;
    import spark.components.beads.SkinnableDataContainerView; SkinnableDataContainerView;
    import spark.components.beads.SparkSkinScrollingViewport; SparkSkinScrollingViewport;
	import spark.components.beads.SparkSkinWithClipAndEnableScrollingViewport; SparkSkinWithClipAndEnableScrollingViewport;
    import spark.components.beads.CollectionChangeUpdateForArrayListData; CollectionChangeUpdateForArrayListData;
    import spark.components.beads.DropDownListView; DropDownListView;
    import spark.components.beads.TitleWindowView; TitleWindowView;
    import spark.components.beads.controllers.DropDownListController; DropDownListController;
    import spark.components.beads.controllers.TabBarController; TabBarController;
    import spark.controls.advancedDataGridClasses.MXAdvancedDataGridItemRenderer; MXAdvancedDataGridItemRenderer;
    import spark.events.DropDownEvent; DropDownEvent;

	
import spark.components.IItemRenderer; IItemRenderer;
//import spark.components.VideoDisplay; VideoDisplay;
//import spark.components.mediaClasses.ScrubBar; ScrubBar;
//import spark.components.mediaClasses.VolumeBar; VolumeBar;
import spark.effects.easing.IEaser; IEaser;
import spark.events.TitleWindowBoundsEvent; TitleWindowBoundsEvent; // needed
import spark.components.IItemRendererOwner; IItemRendererOwner;
//import spark.skins.spark.mediaClasses.fullScreen.PlayPauseButtonSkin; PlayPauseButtonSkin;
//import spark.skins.spark.mediaClasses.fullScreen.ScrubBarSkin; ScrubBarSkin;
//import spark.skins.spark.mediaClasses.fullScreen.VolumeBarSkin; VolumeBarSkin;
//import spark.skins.spark.mediaClasses.normal.PlayPauseButtonSkin; PlayPauseButtonSkin;
//import spark.skins.spark.mediaClasses.normal.ScrubBarSkin; ScrubBarSkin;
//import spark.skins.spark.mediaClasses.normal.VolumeBarSkin; VolumeBarSkin;
import spark.utils.LabelUtil; LabelUtil; // needed
import spark.components.ResizeMode; ResizeMode;
import spark.filters.BevelFilter; BevelFilter; 

	
}

}

