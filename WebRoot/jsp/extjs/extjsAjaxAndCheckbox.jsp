<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>extjs ajax and checkbox text</title>
<script type="text/javascript" src="../../js/extjs/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-all.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-basex.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-lang-zh_CN.js"></script>
<link type="text/css" rel="stylesheet" href="../../js/extjs/resources/css/ext-all.css" />
<script type="text/javascript">
	
	Ext.onReady(function(){
		/*Ajax*/
		var panel = new Ext.Panel({
			 title: 'Ajax与数据显示',
			 width: 200,
			 height: 200,
			 frame: true
		});
		//创建模板对象，常用于数据显示，也就是我们在开发中提到的“内容页或详细页”
		var template = new Ext.XTemplate(
			//中间的{id}等占位符要和我们在后台输出 json对象对应
			'<table id="template">',
              '<tr><td>编号:</td><td>{id}</td></tr>',
                '<tr><td>姓名:</td><td>{name}</td></tr>',
                '<tr><td>生日:</td><td>{brithday}</td></tr>',
                '<tr><td>身高:</td><td>{height}</td></tr>',
                '<tr><td>性别:</td><td>{sex}</td></tr>',
                '<tr><td valign="top">描述:</td><td>{discribe}</td></tr>',
            '</table>'
		);
		//获取数据
		Ext.Ajax.request({
			url: '../../DataServlet',
			method: 'post',
			params: {id: 1},
			success: function(response, options){
				//向服务端发送的对象
				for ( i in options) {
					//alert('option参数名称：'+i);
					//alert('option参数['+i+']的值：'+options[i]);					
				}
				//通过response.responseText来获得XMLHttpRequest的数据，并通过Ext.util.JSON.decode方法把字符串转换成json对象
				var responseJson = Ext.util.JSON.decode(response.responseText);
				template.compile();//编译模板 
				template.overwrite(panel.body,responseJson);//把数据填充到模板中
			},
			failure: function(){
				alert('系统出错，请联系管理人员！');
			}
		});
	
		var borderLayout = new Ext.Panel({
			layout: 'border',
			width: 200,
			height: 174,
			items: [
				new Ext.Panel({
					region: 'center',
					items: [panel]
				})       
			]
		});
		borderLayout.render('BorderLayoutByAjax');
	
		/*RemoteCheckboxGroup*/
		
		Ext.namespace("Ext.ux");
	    //继承了CheckboxGroup使其能够取 remote 数据源
	    Ext.ux.RemoteCheckboxGroup = Ext.extend(Ext.form.CheckboxGroup, {
	        url: '',
	        method: 'post',
	        boxLabel: '',
	        inputValue: '',
	        setValue: function (val) {
	            if (val.split) {
	                val = val.split(',');
	            }
	            this.reset();
	            for (var i = 0; i < val.length; i++) {
	                this.items.each(function (c) {
	                    if (c.inputValue == val[i]) {
	                        c.setValue(true);
	                    }
	                });
	            }
	        },
	        reset: function () {
	            this.items.each(function (c) {
	                c.setValue(false);
	            });
	        },
	        getValue: function () {
	            var val = [];
	            this.items.each(function (c) {
	                if (c.getValue() == true)
	                    val.push(c.inputValue);
	            });
	            return val.join(',');
	        },
	        onRender: function (ct, position) {
	            var items = [];
	            if (!this.items) { //如果没有指定就从URL获取
	                Ext.Ajax.request({
	                    url: this.url,
	                    scope: this,
	                    async: false,
	                    success: function (response) {
	                        var data = Ext.util.JSON.decode(response.responseText);
	                        var Items2 = this.items;
	                        if (this.panel) {
	                            var columns = this.panel.items;
	                            if (columns) {
	                                for (var i = 0; i < columns.items.length; i++) {
	                                    column = columns.items[i];
	                                    column.removeAll();
	                                }
	                                Items2.clear();
	                            }
	                        }
	                        for (var i = 0; i < data.length; i++) {
	                            var d = data[i];
	                            var chk = { boxLabel: d[this.boxLabel], name: this.name, inputValue: d[this.inputValue] };
	                            items.push(chk);
	                        }
	                    }
	                });
	                this.items = items;
	            }
	            Ext.ux.RemoteCheckboxGroup.superclass.onRender.call(this, ct, position);
	        }
	    });
	    Ext.reg('remotecheckboxgroup', Ext.ux.RemoteCheckboxGroup);
	    
	    var checksource = new Ext.ux.RemoteCheckboxGroup({
	        name: 'checksource',//名称，当客户端提交的时候，服务端会根据该名称接收值，当值为多选时post 结果如下[1,2,3]，用'，'分隔
	        boxLabel: 'name',//显示的字段
	        inputValue: 'id',//checkBox存的值
	        url: '../../ComboBoxServlet',
	        method: 'post',
	        fieldLabel: '招聘来源',
	        style: 'padding-top:3px;height:17px;'
	    });
	
	    //创建panel
	    var panel2 = new Ext.Panel({
	        title: '动态复选框',
	        width: 200,
	        height: 100,
	        frame: true,
	        items: [checksource]
	    });
	
	    var borderLayout2 = new Ext.Panel({
			layout: 'border',
			width: 200,
			height: 100,
			items: [
				new Ext.Panel({
					region: 'center',
					items: [panel2]
				})        
			]
		});
		borderLayout2.render("BorderLayoutByRemoteCheckboxGroup");
	});
</script>
</head>
<body>
	<div id="BorderLayoutByAjax" style="padding: 10px 0px; clear: both"></div>
	<div id="BorderLayoutByRemoteCheckboxGroup" style="padding: 10px 0px; clear: both"></div>
</body>
</html>