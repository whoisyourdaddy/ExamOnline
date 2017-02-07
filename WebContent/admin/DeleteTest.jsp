<%@ page language="java" import="java.util.*,com.xurui.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String course = new String(request.getParameter("course").getBytes("iso8859-1"),"utf-8" );
String test_time = new String(request.getParameter("test_time").getBytes("iso8859-1"),"utf-8");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>删除考试信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <%
      TestSetUtil tsu = new TestSetUtil();
      boolean success = tsu.deleteTest(course,test_time);
      if(success)
      {
     %>
    <script type="text/javascript">
      alert("删除成功！");
      window.location.href="<%=path%>/admin/ManageTest.jsp";
    </script>
    <%
      }else
      {
     %>
    <script type="text/javascript">
      alert("删除失败！");
      history.go(-1);
    </script>
    <%}%>
  </body>
</html>
