<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Extjs form test</title>
<!--ExtJs框架开始-->
<script type="text/javascript" src="../../js/extjs/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-all.js"></script>
<script type="text/javascript" src="../../js/extjs/ext-lang-zh_CN.js"></script>
<link type="text/css" rel="stylesheet" href="../../js/extjs/resources/css/ext-all.css" />
<style type="text/css">
	.loginicon{
		background-image: url("../../js/extjs/resources/images/login.gif") !important;
	}
	.x-form-unit{
		height: 22px;
		line-height: 22px;
		padding-left: 2px;
		display: inline-block;
		display: inline;
	}
</style>
<!--ExtJs框架结束-->
<script type="text/javascript">

	//重写文本框
	Ext.override(Ext.form.TextField,{
		unitText: '',
		onRender: function (ct,position){
			Ext.form.TextField.superclass.onRender.call(this,ct,position);
			//如果单位名字符串已定义，则在后方添加单位对象
			if (this.unitText!='') {
				this.unitEl = ct.createChild({
					tag: 'div',
					html: this.unitText
				});
				this.unitEl.addClass('x-form-unit');
				//增加单位名称的同时，按单位名称大小减少文本框的长度，初步考虑了中英文混排，文考虑为负的情况
				this.width = this.width - (this.unitText.replace(/[^\x00-\xff]/g, "xx").length*6+2);
				//同时修改错误提示图标的位置
				this.alignErrorIcon = function(){
					this.errorIcon.alignTo(this.unitEl,'tl-tr',[2,0]);
				}
			}
		}		
	});

	//Ext.onReady():ExtJS Application的入口
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
		
		/*表单内容*/
		//用户名input
		var username = new Ext.form.TextField({
			width: 140,
			allowBlank: false,
			maxLength: 20,
			name: 'username',
			fieldLabel: '用户名',
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
		//验证码input
		var checkcodeinput = new Ext.form.TextField({
			fieldLabel: '验证码',
			id: 'checkcode',
			allowBlank: false,
			width: 76,
			blankText: '请输入验证码',
			maxlength: 4,
			maxLength: '验证码不能超过4个字符'
		});		
		//数字field
		var numberfield = new Ext.form.NumberField({
			fieldLabel: '身高',
			width: 40,
			decimalPrecision: 1,//设置小数点后面的位数，当位数超过时系统会自动截断
			minValue: 0.01,
			maxValue: 200,
			unitText: 'cm',//并非 Extjs文本框自带的属性,在override重写该属性
			allowBlank: false,
			blankText: '输入身高'
		});		
		//隐藏域field
		var hiddenfield = new Ext.form.Hidden({
			name: 'userid',
			value: 1
		});
		//日期field
		var datefield = new Ext.form.DateField({
			fieldLabel: '出生日期',
			format: 'Y-m-d',
			editable: false,//不可编辑
			allowBlank: false,
			blankText: '请选择日期'
		});
		//单选框field
		var radiogroup = new Ext.form.RadioGroup({
			fieldLabel: '性别',
			width: 100,
			items: [
				{
					name: 'sex',
					inputValue: '0',
					boxLabel: '男',
					checked: true
				},
				{
					name: 'sex',
					inputValue: '1',
					boxLabel: '女'
				}
			]
		});
		//获取单选组的值
		radiogroup.on('change',function(rdgroup,checked){
			//alert(checked.getRawValue());
		});
		//复选框field
		var checkboxgroup = new Ext.form.CheckboxGroup({
			fieldLabel: '兴趣爱好',
			width: 170,
			items:[
				{
					boxLabel: '看书',
					inputValue: '0'
				},
				{
					boxLabel: '打篮球',
					inputValue: '1'
				},
				{
					boxLabel: '看电影',
					inputValue: '2'
				}
			]
		});
		//获得复选框的值
		checkboxgroup.on('change',function(cbgroup,checked){
			for (var i = 0; i < checked.length; i++) {
				//alert(checked[i].getRawValue());
			}
		});
		//下拉列表:创建一个新的数组数据源
		var combostore = new Ext.data.ArrayStore({
			fields: ['id','name'],
			data: [[1,'团员'],[2,'党员'],[3,'其他']]
		});
		//创建Combobox
		var combobox = new Ext.form.ComboBox({
			fieldLabel: '政治面貌',
			width: 140,
			store: combostore,//数据源为上面创建的数据源，这个属性是combobox的必需属性
			displayField: 'name',//对应数据源的显示列，必须项			
			valueField: 'id',//对应数据源的列值，必须项
			/*triggerAction：'all'：请设置为”all”,否则默认 为”query”的情况下，你选择某个值后，再此下拉时，只出现匹配选项，
			     如果设为all的话，每次下拉均显示全部选项*/
			triggerAction: 'all',
			emptyText: '请选择...',
			allowBlank: false,
			blankText: '请选择政治面貌',
			editable: false,
			mode: 'local'
		});
		//获取Combobox选中的值
		combobox.on('select',function(){
			//alert(combobox.getValue());
		});
		//级联下拉列表
		//创建区数据源
		var comboareastore = new Ext.data.Store({
			//设定读取地址
			proxy: new Ext.data.HttpProxy({url: '../../ComboBoxServlet',method: 'get'}),
			//读取json返回值根节点为data，对象列为id和name
			reader: new Ext.data.JsonReader(
				{root: 'data'}, 
				[{name: 'id'},{name: 'name'}]		
			)
		});		
		//创建区Combobox
		var comboareacity = new Ext.form.ComboBox({
			fieldLabel: '区',
			width: 120,
			store: comboareastore,
			displayField: 'name',
			valueField: 'id',
			triggerAction: 'all',
			emptyText: '请选择...',
			allowBlank: false,
			blankText: '请选择区',
			editable: false
		});
		//创建市数据源
		var combocitystore = new Ext.data.Store({
			//设定读取的地址
			proxy: new Ext.data.HttpProxy({url: '../../ComboBoxServlet',method: 'get'}),
			//读取json返回值根节点为data，对象列为id和name
			reader: new Ext.data.JsonReader(
				{root: 'data'}, 
				[{name: 'id'},{name: 'name'}]		
			)
		});
		//创建市Combobox
		var comboboxcity = new Ext.form.ComboBox({
			id: 'comboboxcity',
			fieldLabel: '市',
			width: 120,
			store: combocitystore,
			displayField: 'name',
			valueField: 'id',
			triggerAction: 'all',
			emptyText: '请选择...',
			allowBlank: false,
			blankText: '请选择市',
			editable: false,
			mode: 'local', //该属性和以下方法为了兼容ie8
			listeners: {
				'render': function () {
				 	combocitystore.load();
				}
			}
		});
		
		//实现联动
		//市选择变化时触发事件
		comboboxcity.on('select', function () {
			//comboareastore是区的数据源，当市变化时，给区的数据源加上个向service端发送的参数
	 		comboareastore.baseParams.id = comboboxcity.getValue();
	 		comboareacity.setValue('');//把区的下拉列表设置为空，由于非空验证，Ext会提示用户“请选择区”
	 		comboareastore.load();//区的数据源重新加载
 		});
		//创建html编辑器
		var exteditor = new Ext.form.HtmlEditor({
			fieldLabel: '员工描述'
		});
		
		/*Button*/
		//提交按钮处理方法
		var submitclick = function(){
			//校验表单的验证项是否全部通过
			if (form.getForm().isValid()) {
				Ext.Msg.alert('提示','登陆成功！');						
			} else {
				Ext.MessageBox.alert('提示','检验失败');
			}	
		}
		//重置按钮处理方法
		var resetclick = function(){
			//Ext.MessageBox.alert('提示','你点击了重置按钮');
			//重置表单
			form.getForm().reset();
		}
		//重置按钮“鼠标悬停”处理方法
		var resetmouseover = function(){
			//Ext.MessageBox.alert('提示','鼠标悬停在按钮上');
		}
		//提交按钮
		var submit = new Ext.Button({
			text: '提交',
			//首发方法处理事件,是特殊的listeners
			handler: submitclick
		});
		//重置按钮
		var reset = new Ext.Button({
			text: '重置',
			//listeners：事件名 + 处理函数的组合，事件监听器
			listeners: {
				'mouseover': resetmouseover,
				'click': resetclick
			}
		});
		
		/*FormPanel*/
		//表单
		var form = new Ext.FormPanel({
			url: '',
			labelAlign: 'right',
			labelWidth: 65,
			frame: true,
			cls: 'multipart/form',
			buttonAlign: 'center',
			bodyStyle: 'padding:6px 0px 0xp 15px',
			fileUpload: true,
			defaultType:'textfield', 
			items: [
		        username,
		        password,
		        checkcodeinput,
		        numberfield,
		        hiddenfield,
		        datefield,
		        radiogroup,
		        checkboxgroup,
		        combobox,
		        comboboxcity, 
		        comboareacity,
		        exteditor
			],
			buttons: [submit,reset]
		});
		
		/*Window*/
		//窗体
		var win = new Ext.Window({
			title: '用户登录',
			iconCls: 'loginicon',//给窗体加上小图标
			plain: true,
			width: 626,
			height: 654,
			//html: '<div>这里是窗口内容</div>',
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
		
		//创建验证码
		var checkcode = Ext.getDom('checkcode');//根据ID获取Dom
		var checkimage = Ext.get(checkcode.parentNode);//根据Dom获取父节点
		//创建子节点
		checkimage.createChild({
			tag: 'img',
			src: '../../js/extjs/resources/images/checkcode.gif',
			align: 'absbottom',
			style: 'padding-left:18px;cursor:pointer;'
		});
	});
</script>
</head>
<body>
<div>

</div>
</body>
</html>