<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>extjs grid panel test</title>
<script type="text/javascript" src="../../js/extjs/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-all.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-lang-zh_CN.js"></script>
<link type="text/css" rel="stylesheet" href="../../js/extjs/resources/css/ext-all.css" />
<script type="text/javascript">
	Ext.onReady(function(){
		//创建数据源
		var jsonstore = new Ext.data.JsonStore({
			data: [
				{id: 1, name: '张三', sex: '0', birthday: '2001-01-01'},   
				{id: 2, name: '李四', sex: '1', birthday: '2001-02-01'}, 
				{id: 3, name: '王五', sex: '0', birthday: '2001-03-01'},
				{id: 4, name: '张三', sex: '0', birthday: '2001-01-01'},   
				{id: 5, name: '李四', sex: '1', birthday: '2001-02-01'}, 
				{id: 6, name: '王五', sex: '0', birthday: '2001-03-01'},
				{id: 7, name: '张三', sex: '0', birthday: '2001-01-01'},   
				{id: 8, name: '李四', sex: '1', birthday: '2001-02-01'}, 
				{id: 9, name: '王五', sex: '0', birthday: '2001-03-01'}
			],
			fields: ['id', 'name', 'sex', {name: 'birthday', type: 'data', dataformat: 'Y/m/d'}]
		});
		//创建复选框列
		var sm = new Ext.grid.CheckboxSelectionModel();
		//渲染性别
		/* 
			参数说明：
			value: 当前单元格的值。
			meetaData: 设置元素<div>男</div>的样式表与属性值，这个参数包含两个属性：metaData.css与metaData.attr
			record: 当前Record对象引用。
			rowIndex: 当前单元格行的索引。
			colIndex: 当前单元格列的索引。
			store: store的引用。 
		*/
		var sexrender = function(value, metaData, record, rowIndex, cloIndex, store){
			if(value == '0'){
				metaData.attr = 'style="font-weigth:bold";';
				return '男';
			}else{
				return '女';
			}
		}
		//定义列
		var column = new Ext.grid.ColumnModel({
			columns: [
				sm,
				{header: '编号', dataIndex: 'id', sortable: true},
				{header: '姓名', dataIndex: 'name'},
				{header: '性别', dataIndex: 'sex', renderer: sexrender},
				{header: '出生日期', dataIndex: 'birthday', renderer: Ext.util.Format.dateRenderer('Y-m-d')}
			]
		});
		//添加按钮：创建一个工具栏按钮，tbar可以添加多个按钮，处理不同的方法，如"添加","删除","修改"等
		var tbtn = new Ext.Toolbar.Button({
			text: '查看选中项',
			listeners: {
				'click': function(){
					var row = grid.getSelectionModel().getSelecttions();//获取选中项的行，row[i].get('id')获取行中的某一列
					for (var i = 0; i < row.length; i++) {
						//alert(row[i].get('id'));
					}
				}
			}
		});
		//分页控件
		var pager = new Ext.PagingToolbar({
			pageSize: 5,
			store: jsonstore,
			listeners: {
				"beforechange": function(bbar,params){
					var grid = bbar.ownerCt;
					var store = grid.getStore();
					var start = params.start;//起始数据的索引号
					var limit = params.limit;//每页大小
					console.log("==下面是打印信息")
					console.log(store.getCount());
					console.log(start);
					console.log(limit);
					console.log("==打印结束。")
					return false;
				}
			}
		});
		//列表
		var grid = new Ext.grid.GridPanel({
			sm: sm,
			title: 'GridPanel',
			height: 200,
			store: jsonstore,
			tbar: [tbtn],
			bbar: pager,
			colModel: column
		});
		//表单
		var form = new Ext.form.FormPanel({
			fram: true,
			fileUpload: true,
			url: '',
			title:'表单标题',
			sytle: 'margin:10px',
			items: [grid]
		});
		//
		var borderLayout = new Ext.Panel({
			layout: 'border',
			width: 476,
			height: 374,
			items: [
				new Ext.Panel({
					region: 'center',
					items: [form]
				})        
			]
		});
		borderLayout.render('BorderLayout');
	});
</script>
</head>
<body>
	<div id="BorderLayout" style="padding: 10px 0px; clear: both"></div>
</body>
</html>