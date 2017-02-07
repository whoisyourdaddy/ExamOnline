<%@ page language="java"
	import="java.util.*,com.xurui.dormain.*,com.xurui.util.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String Uid = request.getParameter("Uid");
	UserUtil userUtil = new UserUtil();
	User user = null;
	String name = "";
	int type = 1;
	String sex = "男";
	int flag = 0;//0为添加信息,1为修改信息
	if (Uid != null) {
		flag = 1;
		user = userUtil.getUser(Uid);
		name = user.getName();
		type = user.getType();
		sex = user.getSex();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>添加修改用户信息</title>
<link rel="stylesheet" href="./css/public.css" type="text/css" />
<script type="text/javascript">
      function setInfo()
      {
        var flag = <%=flag%>
        var Uid="<%=Uid%>";
        var name="<%=name%>";
        var type="<%=type%>";
        var sex="<%=sex%>";
		if (flag == 1) {
			var Uid_tag = document.getElementsByName("Uid")[0];
			Uid_tag.value = Uid;
			Uid_tag.readOnly = "readOnly";
			document.getElementsByName("name")[0].value = name;
			setType(type);
			setSex(sex);
			document.getElementById("title").innerHTML = "修改用户信息";
			document.getElementsByName("option")[0].value = "修改";
			document.getElementsByName("flag")[0].value = "1";
		}
	}
	function setType(type)//设置类型
	{
		var utype = document.getElementsByName("type")[0];
		for (var i = 0; i < utype.options.length; i++) {
			if (utype.options[i].value == type) {
				utype.options[i].selected = true;
				break;
			}
		}
	}
	function setSex(sex)//设置性别
	{
		var usex = document.getElementsByName("sex");
		for (var i = 0; i < usex.length; i++) {
			if (usex[i].value == sex) {
				usex[i].checked = true;
				break;
			}
		}
	}
	function checkForm(mobile) {
		var re = /^1[3|4|5|8|9]\d{9}$/;
		//var re = /^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
		//var re = /^(13[0-9]{9})|(15[89][0-9]{8})$/;
		//alert(re.test(mobile));
	   return re.test(mobile);
		
	}
	
	function checkMobile(mobile){
		var  result;
		var xmlhttp;
		if (window.XMLHttpRequest)
		{
			//  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
			xmlhttp=new XMLHttpRequest();
		}
		else
		{
			// IE6, IE5 浏览器执行代码
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function()
		{
			if (xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				 result=xmlhttp.responseText;
				
			}
		}
		xmlhttp.open("GET"," checkUser?Uid="+mobile,false);
		xmlhttp.send();
		return result;
	}
	
	function IsSubmit(obj) {
		var Uid = document.forms[0].Uid;
		var name = document.forms[0].name;
		if ( !checkForm(Uid.value) && obj.value != "修改") {
			alert("请输入11位手机号");
			Uid.value="";
			Uid.focus();
			return;
		}else{
			if(obj.value != "修改"){
				//验证手机号码是否可用
				var result =checkMobile(Uid.value);
				if(result =="1"){
					alert("手机号码"+Uid.value+"已经注册");
				    return;
				}
			}
		}
		if (name.value == "") {
			alert("请输入姓名！");
			name.focus();
			return;
		}

		if (obj.value == "修改") {
			var okey = confirm("确定修改？");
			if (okey == true) {
				document.forms[0].submit();
			}
		} else {
			document.forms[0].submit();
		}

	}
</script>
</head>

<body onload="setInfo()">
	<form action="<%=path%>/UpdateUserServlet" method="post">
		<table class="table" cellspacing="1" cellpadding="2" width="80%"
			align="center" border="0" style="margin-top: 50px;">
			<tr>
				<th class="bg_tr" align="left" colspan="2" height="50"><span
					id="title">添加用户</span></th>
			</tr>
			<tr>
				<td class="td_bg" width="50%" height="50" align="center"><span
					class="TableRow2">用户编号：</span></td>
				<td width="50%" class="td_bg" align="center"><input type="text"
					name="Uid" style="color: #1E5494; font-size: 12px;" /></td>
			</tr>
			<tr>
				<td class="td_bg" height="50" align="center"><span
					class="TableRow2">姓名：</span></td>
				<td class="td_bg" align="center"><input type="text" name="name"
					style="color: #1E5494; font-size: 12px;" /></td>
			</tr>
			<tr>
				<td class="td_bg" height="50" align="center"><span
					class="TableRow2">用户类型：</span></td>
				<td class="td_bg" align="center" class="type"><select
					name="type" style="color: #1E5494; font-size: 12px;">
						<option value="1" selected="selected">学生</option>
						<option value="2">教师</option>
						<option value="3">管理员</option>
				</select></td>
			</tr>
			<tr>
				<td class="td_bg" height="50" align="center"><span
					class="TableRow2">用户性别：</span></td>
				<td class="td_bg" align="center" class="type">男<input
					type="radio" value="男" name="sex" checked="checked" />&nbsp;&nbsp;
					女<input type="radio" value="女" name="sex" />
				</td>
			</tr>
			<tr>
				<td class="td_bg" height="50" align="center"><span
					class="TableRow2">操&nbsp;&nbsp;&nbsp;&nbsp;作：</span></td>
				<td class="td_bg" align="center"><input name="option"
					type="button" value="添加" style="color: #1E5494; font-size: 12px;"
					onclick="IsSubmit(this)" /> <input type="hidden" name="flag"
					value="0" /></td>
			</tr>
		</table>
	</form>
</body>
</html>
