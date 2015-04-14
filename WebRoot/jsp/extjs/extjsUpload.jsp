<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="../../js/extjs/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-all.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-basex.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-lang-zh_CN.js"></script>
<link type="text/css" rel="stylesheet" href="../../js/extjs/resources/css/ext-all.css" />
<script type="text/javascript">
	//var _interval;
	Ext.onReady(function() {
		var formPanel = new Ext.form.FormPanel({
			labelWidth : 80,
			id : 'formPanel',
			bodyStyle : 'padding:5 0 0 0 ',
			height : 515,
			width : 200,
			frame : true,
			fileUpload : true,
			items : [ new Ext.form.TextField({
				id : 'fileUpload',
				anchor : '90%',
				height : 30,
				width : 350,
				name : 'file',
				inputType : 'file',
				fieldLabel : '文件选择'
			}) ]
		});

		var upLoadFile = new Ext.Toolbar.Button({
			text : '上传',
			listeners : {
				'click' : uploadFiles
			}
		});

		new Ext.Window({
			title : '上传文件',
			width : 400,
			height : 140,
			minWidth : 400,
			id : 'uploadWin',
			minHeight : 140,
			layout : 'fit',
			plain : true,
			bodyStyle : 'padding:5px;',
			buttonAlign : 'center',
			items : formPanel,
			buttons : [ upLoadFile ]
		}).show();
	});
	
	function uploadFiles(t) {
		// 上传文件名称的路径 
		var name = Ext.getCmp('fileUpload').getRawValue(); 
		if (name == "") {
			Ext.Msg.alert("提示", "请选择需要上传的文件！");
			return;
		} else {
			var array = new Array();
			array = name.split("\\");
			var length = array.length;
			var fileName = "";
			var index = 0;
			for (index = 0; index < length; index++) {
				if (fileName == "") {
					fileName = array[index];
				} else {
					fileName = fileName + "/" + array[index];
				}
			}
			//_interval = setInterval("showRequest()", 100);
			Ext.getCmp("formPanel").getForm().submit({
				url : '../../FileOperationServlet',
				method : 'POST',
				waitTitle: "请稍候",
				waitMsg: '正在上传...',
				success : function(form, action, o) {
					Ext.MessageBox.alert("提示信息", action.result.message);
					Ext.getCmp("uploadWin").setTitle("上传文件");
				},
				failure : function(form, action) {
					Ext.MessageBox.alert("提示信息", "请求失败,文件上传失败");
				}
			});
		}
	}
	/* function showRequest() {
		Ext.Ajax.request({
			url : 'loginAction/getUploadPrcent.action',
			method : 'post',
			success : function(data, options) {
				Ext.getCmp("uploadWin").setTitle(
						"上传文件:已经写入(" + data.responseText + ")");
				if (data.responseText == '100%') {
					clearInterval(_interval);
					Ext.getCmp("uploadWin").setTitle("上传文件:写入完成,请稍等...");
					return;
				}
				m++;
			}
		});

	} */
</script>
<title>extjs upload test</title>
</head>
<body>
	<!-- <div id="form"></div> -->
</body>
</html>