<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ext js test</title>
</head>
<!--ExtJs框架开始-->
<script type="text/javascript" src="../../js/extjs/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-all.js"></script>
<link rel="stylesheet" type="text/css" href="../../js/extjs/resources/css/ext-all.css" />
<!--ExtJs框架结束-->
<script type="text/javascript">
	Ext.onReady(function(){	
		//读取标签中的ext:qtip属性，并为它赋予显示提示的动作，初始化后就会激活提示功能
		Ext.QuickTips.init();
		/*  提示的方式，枚举值为：
			qtip-当鼠标移动到控件上面时显示提示
			title-在浏览器的标题显示，但是测试结果是和qtip一样的
			under-在控件的底下显示错误提示
			side-在控件右边显示一个错误图标，鼠标指向图标时显示错误提示. 默认值.
			id-[element id]错误提示显示在指定id的HTML元件中
		*/
		Ext.form.Field.prototype.msgTarget = 'side';
		//用户名input
		var username = new Ext.form.TextField({
			width: 140,
			allowBlank: false,
			maxLength: 20,
			name: 'username',
			fieldLabel: '用户名称',
			blankText: '请输入用户名',
			maxLengthText: '用户名不能超过20个字符'
		});
		//密码input
		var password = new Ext.form.TextField({
			width: 140,
			allowBlank: false,//是否允许为空			
			minLength: 3,//最小长度
			maxLength: 20,//最大长度
			inputType: 'password',//输入框类型
			name: 'password',
			fieldLabel: '密码',
			blankText: '请输入密码',//非空检验信息
			minLengthText: '密码不能少于3个字符',//最小长度检验信息
			maxLengthText: '密码不能超过20个字符'//最大长度检验信息
		});
		//邮箱input
		var email = new Ext.form.TextField({
			width: 140,
			allowBlank: false,
			vtype: 'email',//预定义的客户端数据校验，每一种vtype都对应某一种特定的数据校验，比如说Email，IP地址，手机号等等
			vtypeText:"不是有效的邮箱地址",//自定义vtype检验信息
			name: 'email',
			fieldLabel: '邮箱地址',
			blankText: '请输入邮箱地址'
		});
		//表单
		var form = new Ext.FormPanel({
			frame: true,
			title: '表单标题',
			style: 'margin:10px',
			html: '<div style="padding:10px">这是表单内容</div>',
			items: [username,password,email]
		});
		//窗体
		var win = new Ext.Window({
			title: '窗口',
			width: 476,
			height: 374,
			html: '<div>这里是窗口内容</div>',
			resizable: true,//是否可以调整窗体的大小
			modal: true,//是否为模态窗体[什么是模态窗体？当你打开这个窗体以后，如果不能对其他的窗体进行操作，那么这个窗体就是模态窗体，否则为非模态窗体]。
			closable: true,//是否可以关闭，也可以理解为是否显示关闭按钮。
			maximizable: true,//是否可以最大化，也可以理解为是否显示最大化按钮。
			minimizable: true,//是否可以最小化，也可以理解为是否显示最小化按钮。	
			items: form//引入表单
		});
		//打开窗体
		win.show();
		//关闭窗体后触发
		win.on('close',function(){
			//弹出框
			Ext.MessageBox.alert('标题','Hello World!');
		});
	});
</script>
<body>
<div>
<h4>弹出框:</h4>
<p>(1)Ext.onReady():ExtJS Application的入口...就相当于Java或C#的main函数.</p>
<p>(2)Ext.MessageBox.alert()：弹出对话框。</p>
</div>
</body>
</html>