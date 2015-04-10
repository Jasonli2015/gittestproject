<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>extjs layout test</title>
<script type="text/javascript" src="../../js/extjs/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-all.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-lang-zh_CN.js"></script>
<link type="text/css" rel="stylesheet" href="../../js/extjs/resources/css/ext-all.css" />
<script type="text/javascript">

	Ext.onReady(function(){
		
		//ContainerLayout：默认布局方式，其他布局继承该类进行扩展。布局方式：将内部组件以垂直方式叠加
		//创建BoxComponent组件
		var box1 = new Ext.BoxComponent({
			autoEl: {
				tag: 'div',
				style: 'background:red;width:300px;height:30px',
				html: 'duv标签'
			}
		});
		var box2 = new Ext.BoxComponent({
			autoEl: {
				tag: 'p',
				style: 'background:yellow;width:300px;height:30px',
				html: 'p标签'
			}
		});
		var box3 = new Ext.BoxComponent({
			xtype: 'box',			
			autoEl: {
				tag: 'a',
				style: 'background:blue;width:300px;height:30px;color:#fff',
				html: 'a标签',
				href: 'http://www.baidu.com/'
			}
		});
		//创建Container容器
		var containerlayout = new Ext.Container({
			layout: 'form',
			items: [box1,box2,box3],
			//renderTo：加到指定元素之内
			renderTo: 'ContainerLayout'
		});
		
		//FormLayout：产生类似表单的外观。布局方式：将内部组件以垂直方式叠加
		var formlayout = new Ext.Panel({
            title: 'FormLayout',
            layout: 'form',
            frame: true,//设置为true时可以为panel添加背景色、圆角边框等
            items: [
                new Ext.form.TextField({ 
                	fieldLabel: '用户名',
                	width: 120,
                	value: 'Jason'
                }),
                new Ext.form.TextField({ 
                	fieldLabel: '密码', 
                	width: 120
                }),
                new Ext.form.TextField({ 
                	fieldLabel: '重复密码',
                	width: 120
                })
            ],
            //renderTo：加到指定元素之内,等价于render()方法
            renderTo: 'FormLayout'
        });
		
		//formlayout.render('FormLayout'); 
		
		//ColumnLayout：将组件以水平方式放置
		var ColumnLayout = new Ext.Panel({
			width: 600,
			title: 'ColumnLayout',
			layout: 'column',
			items: [
				new Ext.form.FormPanel({
					title: '第一列',
					columnWidth: .33,
					labelWidth: 50,
					items: [
						new Ext.form.TextField({
							fieldLabel: '用户名'
						}) 
					]
				}),
				new Ext.form.FormPanel({
					title: '第二列',
					columnWidth: .33,
					labelWidth: 50,
					items: [
						new Ext.form.TextField({
							fieldLabel: '密码'
						})  
					]
				}),
				new Ext.form.FormPanel({
					title: '第三列',
					columWidth: .34,
					labelWidth: 80,
					items: [
						new Ext.form.TextField({
							fieldLabel: '重置密码'
						})        
					]
				})
			],
			renderTo: 'ColumnLayout'
		});
		
		//BorderLayout：以盒子方式进行布局：north、west、south、west 和 center(主体，必须包含)
		var BorderLayout = new Ext.Panel({
			title: 'BorderLayout',
			layout: 'border',
			width: 1100,
			height: 300,
			items: [
				new Ext.Panel({title: '上北', region: 'north', html:'上北'}),
				new Ext.Panel({title: '下南', region: 'south', html:'下南'}),
				new Ext.Panel({title: '中间', region: 'center', html:'中间'}),
				new Ext.Panel({title: '左东', region: 'west', html:'左东'}),
				new Ext.Panel({title: '右西', region: 'east', html:'右西'})
			],
			renderTo: 'BorderLayout'
		});
		
		//AccordionLayout：手风琴布局，即可用折叠的布局，一般应用于左侧菜单栏
		var AccordionLayout = new Ext.Panel({
			title: 'AccordionLayout',
			layout: 'accordion',
			height: 120,
			items: [
				new Ext.Panel({
					title: '用户管理',
					items: [
						new Ext.BoxComponent({
							autoEl:{
								tag: 'a',
								html: '用户管理',
								href: 'http://www.baidu.com/'
							}
						})        
					]
				}),
				new Ext.Panel({
					title: '角色管理',
					items: [
						new Ext.BoxComponent({
							autoEl:{
								tag: 'a',
								html: '角色管理',
								href: 'http://www.baidu.com/'
							}
						})        
					]
				}),
				new Ext.Panel({
					title: '系统管理',
					items: [
						new Ext.BoxComponent({
							autoEl:{
								tag: 'a',
								html: '系统管理',
								href: 'http://www.baidu.com/'
							}
						})        
					]
				}) 
			],
			renderTo: 'AccordionLayout'
		});
		
		//FitLayout：强迫知组件充满容器的布局,子容器能够自适应于父容器,所以用了fit布局子容器设置宽度无效,如果父容器有多个子容器，只会显示第一个
		var FitLayout = new Ext.Panel({
			title: 'FitLayout',
			height: 100,
			renderTo: 'FitLayout',
			layout: 'fit',
			items: [
				new Ext.Panel({bodyStyle: 'background:red', html: '使用了fit布局,填充满'}),
				new Ext.Panel({bodyStyle: 'background:yellow', html: '这个panel不会显示，因为是fit布局'})
			]
		});
		var NoFitLayout = new Ext.Panel({
			title: 'NoFitLayout',
			height: 100,
			renderTo: 'FitLayout',
			items: [
				new Ext.Panel({bodyStyle: 'background:yellow', html: '未使用了fit布局,没有填充满'})        
			]
		});
		
		//TableLayout：表格布局
		var TableLayout = new Ext.Panel({
			title: 'TableLayout',
			layout: 'table',
			layoutConfig: {
				columns: 3 //设置列数，不用设置行数
			},
			defaults: {
				width: 133,
				height: 100,
				autoEl: 'center'
			},
			defaultType: 'panel',
			items: [
				{ html: '行1列1' },
                { html: '行1列2' },
                { 
                	html: '行[1,2]列3',
                	rowspan: 2, //合并行
                	height: 200 
                },
                { 
                	html: '行2列[1,2]',
                	colspan: 2, //合并列
                	width: 266  
                }        
			],
			renderTo: 'TableLayout'
		});
		
	});

</script>
</head>
<body>
	<div id="ContainerLayout" style="float: left; width: 300px">
         ContainerLayout：垂直方式放置
	</div>
	<div id="FormLayout" style="float: left; width: 240px; padding-left: 10px;">
	</div>
	<div id="ColumnLayout" style="float: left; width: 500px; padding-left: 10px;">
	</div>
	<div id="BorderLayout" style="padding: 10px 0px; clear: both">
	</div>
	<div id="AccordionLayout" style="width: 300px; float: left; height: 200px">
	</div>
	<div id="FitLayout" style="width: 300px; float: left; height: 200px; padding-left: 10px;">
	</div>
	<div id="TableLayout" style="width: 400px; float: left; padding-left: 10px;">
	</div>
</body>
</html>