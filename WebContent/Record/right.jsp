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
    
    <title>right.jsp</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/public.css" type="text/css"/>
   <%
    String Uid = (String)session.getAttribute("Uid");
          UserUtil userUtil = new UserUtil();
          User user = userUtil.getUser(Uid);
   
  %>
  </head>
  <body style="padding-top:50px;">
    <table class="table" cellspacing="1" cellpadding="2" width="80%" align="center" 
      border="0">
    <tr>
      <th class="bg_tr" align="left" colspan="2" height="50"><%=user.getName()%>个人信息</th>
    </tr>
    <tr>
      <td class="td_bg" width="50%" height="50" align="center"><span class="TableRow2">学号:</span></td>
      <td width="50%" class="td_bg" align="center"><strong><%=user.getId() %><br /></strong></td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">姓&nbsp;&nbsp;名:</span></td>
      <td class="td_bg" align="center"><%=user.getName()%><br /> </td>
    </tr>
    <tr>
      <td class="td_bg" align="center" height="50"><span class="TableRow2">性&nbsp;&nbsp;别:</span></td>
      <td class="td_bg" align="center"><%=user.getSex() %><br /></td>
    </tr>
</table>
  </body>
</html>
