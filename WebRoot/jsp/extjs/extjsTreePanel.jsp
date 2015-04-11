<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>extjs tree panel test</title>
<script type="text/javascript" src="../../js/extjs/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-all.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-lang-zh_CN.js"></script>
<link type="text/css" rel="stylesheet" href="../../js/extjs/resources/css/ext-all.css" />
<style type="text/css">
	.nodeicon{
	 	background-image: url(../../js/extjs/resources/images/user.gif) !important;
	}
</style>
<script type="text/javascript">
	Ext.onReady(function(){
		//树的节点数据源
		var node = {
			text: '根',
			expanded: true,//是否展开子节点，默认为false
			leaf: false,//是否为叶子节点，如果设置为false但没有 children 那么会产生一直读取子节点的展示
			children: [
				{
					text: '根下节点一[user图标]', 
					leaf: true, 
					//ExtJs自带的图标显示为“文件夹”或是“列表”，通过 iconCls 可以列换树型菜单的图标
					iconCls: 'nodeicon' 
				},
				{
					text: '根下节点二', 
					leaf: true 
				},
				{
					text: '根下节点三', 
					leaf: false, 
					children: [
				    	{text: '节点三子节点一', leaf: true},
				    	{
				    		text: '节点三子节点二', 
				    		leaf: false,
				    		expanded: true,
				    		children: [
				    			{text: '节点三子节点二子节点一', leaf: true}, 
				    			{text: '节点三子节点二子节点二', leaf: true},
				    		]
				    	}
				    ] 
				},
			]
		};
		//树面板（本地数据源）
		var treelocal = new Ext.tree.TreePanel({
			title: 'TreePanelLocal',
			root: node
		});
		//树面板（服务器数据源）
		var treeservice = new Ext.tree.TreePanel({
			title: 'TreePanelService',
			root: {text: '根', expanded: true},
			//树的数据载入组件，通过url寻找service端返回的json,并且自动转换成 TreeNode
			loader: new Ext.tree.TreeLoader({
				url: '../../TreeServlet'
			})
		});
		//表单
		var form = new Ext.form.FormPanel({
			frame: true,
			title: '表单标题',
			style: 'margin: 10px',
			items: [treelocal,treeservice],
			buttons: [{
				text: '获取选中项',
				handler: function(){
					selectNode = treelocal.getSelectionModel().getSelectedNode();//获取选中项
					alert('TreePanelLocal：' + (selectNode == null ? treelocal.root.text : selectNode.text));
				}
			}]
		});
		var borderLayout = new Ext.Panel({
			layout: 'border',
			width: 500,
			height: 500,
			items: [
				new Ext.Panel({
					region: 'center',
					items: [form]
				})        
			]
		});
		borderLayout.render("BorderLayout");
	});
</script>
</head>
<body>
	<div id="BorderLayout" style="padding: 10px 0px; clear: both"></div>
</body>
</html>