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
<link type="text/css" href="../../js/extjs/resources/css/ext-all.css" />
<!--ExtJs框架结束-->
<script type="text/javascript">
	Ext.onReady(function(){
		Ext.MessageBox.alert('标题','Hello World!');
	});
</script>
<body>
<div>
说明：
(1)Ext.onReady():ExtJS Application的入口...就相当于Java或C#的main函数.<br>
(2)Ext.MessageBox.alert()：弹出对话框。
</div>
</body>
</html>