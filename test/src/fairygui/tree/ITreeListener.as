package fairygui.tree
{
	import fairygui.GComponent;
	import fairygui.event.ItemEvent;

	public interface ITreeListener
	{
		function treeNodeCreateCell(node:TreeNode):GComponent;
		function treeNodeRender(node:TreeNode, obj:GComponent):void;
		function treeNodeWillExpand(node:TreeNode, expand:Boolean):void;
		function treeNodeClick(node:TreeNode, evt:ItemEvent):void;
	}
}