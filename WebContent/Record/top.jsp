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
    <base href="<%=basePath%>">
    
 <title>top.html</title>
 <%
    String Uid = (String)session.getAttribute("Uid");
          UserUtil userUtil = new UserUtil();
          User user = userUtil.getUser(Uid);
          String name = user.getName();
          session.setAttribute("name",name);
   
  %>
 <style type="text/css">
   body{
	background-color:#06a9f6;
    margin-left: 0px;
	margin-right: 0px;
	margin-top:0px;
	overflow:hidden;
   }
   .one{
   background-image: url("<%=path%>/images/top_logo.jpg");
   background-repeat:no-repeat;
   margin:0px;
   padding:0px;
   }
   .two
   {
     background-image: url("<%=path%>/images/top_bg.jpg");
     background-repeat:no-repeat;
     margin:0px;
     padding:0px;
   }
   table
   {
     margin:0px;
     padding:0px;
   }
 </style>
 <script type="text/javascript">
   function showTime()
   {
     var time = new Date();
     var timeString = time.toLocaleString();
	 document.getElementById("timeSpan").innerHTML=timeString;
	 
   }
 </script>
</head>

<body onload="setInterval(showTime,1000)">
<table width="100%" height="60px" boder="0px" cellpadding="0px;" cellspacing="0px;">
  <tr>
    <td class="one" width="15%" height="60px">&nbsp;</td>
    <td class="two" width="55%" height="60px" align="center">
      <span style="font-size:25px;color:#032155;font-weight:bold;font-family:MS Gothic;overflow:hidden;">在线考试系统学生平台</span>
    </td>
    <td width="30%" height="60px" align="right" valign="bottom" style="overflow:hidden;">
      <span style="font-size:12px;">你好,<%=name%>||现在时刻是:</span><span style="color:red;font-size:12px;" id="timeSpan"></span>
    </td>
  </tr>
</table>
</body>
</html>
