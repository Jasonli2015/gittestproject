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
		
		//ContainerLayout
		var box1 = new Ext.BoxComponent({
			autoEl: {
				tag: 'div',
				style: 'background:red;width:300px;height:30px',
				html: 'box1'
			}
		});
		var box2 = new Ext.BoxComponent({
			autoEl: {
				tag: 'div',
				style: 'background:yellow;width:300px;height:30px',
				html: 'box2'
			}
		});
		var box3 = new Ext.BoxComponent({
			autoEl: {
				tag: 'div',
				style: 'background:blue;width:300px;height:30px;color:#fff',
				html: 'box3'
			}
		});
		var containerlayout = new Ext.Container({
			layout: 'form',
			items: [box1,box2,box3],
			renderTo: 'ContainerLayout'
		});
		
		//FormLayout
		var formlayout = new Ext.Panel({
            title: 'FormLayout',
            layout: 'form',
            items: [
                new Ext.form.TextField({ 
                	fieldLabel: '用户名' 
                }),
                new Ext.form.TextField({ 
                	fieldLabel: '密码' 
                }),
                new Ext.form.TextField({ 
                	fieldLabel: '重复密码' 
                })
            ],
            renderTo: 'FormLayout'
        });
		
		//ColumnLayout
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
						new Ext.Form.TextField({
							fieldLabel: '重置密码'
						})        
					]
				})
			],
			renderTo: 'ColumnLayout'
		});
		//BorderLayout
		
		
	});

</script>
</head>
<body>

</body>
</html>