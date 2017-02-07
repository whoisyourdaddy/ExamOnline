<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xurui.dormain.*" %>
<%@ page import="com.xurui.util.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
  a{
    text-decoration:none;
    color:#2f4867;
	}
  li{
  list-style-image:url("<%=path%>/images/list.gif");
  margin-top:5px;
  font-size:12px;
  }
  ul{
    margin-top:0px;
	display:none;
   }
  .first
  {
    background-image:url("<%=path%>/images/bk2.gif");
    background-repeat:no-repeat;
	padding-left:22px;
	height:23px;
	width:142px;
	margin-left:2px;
	margin-top:5px;
	padding-right:0px;
	line-height:23px;
	font-size:12px;
	color:#155a84;
	cursor:pointer;
  }
  .outer
  {
    width:166px;
	background-color:#FFFFFF;
	margin-left:2px;
	margin-top:5px;
	padding-top:5px;
	padding-right:0px;
  }
  body
  {
    background-color:#06a9f4;
    overflow-x:hidden;
    SCROLLBAR-FACE-COLOR: #59D6FF; 
	SCROLLBAR-HIGHLIGHT-COLOR: #ffffff; 
	SCROLLBAR-SHADOW-COLOR: #ffffff; 
	SCROLLBAR-3DLIGHT-COLOR: #007BC6; 
	SCROLLBAR-DARKSHADOW-COLOR: #007BC6; 
	SCROLLBAR-ARROW-COLOR: #007BC6;
	SCROLLBAR-TRACK-COLOR: #009ED2;
    
  }
  #submenu1,#submenu2,#submenu3
  {
    display:block;
  }
</style>
<script type="text/javascript">
  function show(showId)
  {
    var des = document.getElementById(showId);
	if(des.style.display=="block")
	{
	  des.style.display = "none";
	}else
	{
	  des.style.display="block";
	}
    
  }
  
</script>
</head>

<body>
 <div class="outer">
   <div class="first" onclick="show('submenu1')">试题管理</div>
	  <ul id="submenu1">
	    <li><a href="ManageQuestion.jsp" target="right">试题管理</a></li>
	  </ul>
   </div>
   <div class="outer">
     <div class="first"  onclick="show('submenu2')">考试设置管理</div>
	  <ul id="submenu2">
	    <li><a href="ManageTest.jsp" target="right">考试设置管理</a></li>
	  </ul>
	</div>
	   <div class="outer">
     <div class="first"  onclick="show('submenu3')">用户管理</div>
	  <ul id="submenu3">
	    <li><a href="ManageUser.jsp" target="right">用户管理</a></li>
	  </ul>
	</div>
    <div class="outer">
	  <div class="first"  onclick="show('submenu4')">个人信息维护</div>
	  <ul id="submenu4">
	    <li><a href="<%=path%>/modifyInfo.jsp" target="right">修改个人信息</a></li>
		<li><a href="<%=path%>/modifyPassword.jsp?type=3" target="right">修改密码</a></li>
	  </ul>
	</div>
	<div class="outer">
      <div class="first" onclick="show('submenu5')">安全退出</div>
      <ul id="submenu5">
        <li><a href="javascript:window.open('login.jsp');window.parent.opener=null;window.parent.close();">安全退出</a></li>
      </ul>
    </div>
  
</body>
</html>

