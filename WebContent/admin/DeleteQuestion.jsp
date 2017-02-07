<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.xurui.util.QuestionUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String str_qid = request.getParameter("Qid").trim();
int Qid = Integer.parseInt(str_qid);

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'DeleteQuestion.jsp' starting page</title>
    
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
      QuestionUtil qu = new QuestionUtil();
      boolean success = qu.deleteTest(Qid);
      if(success)
      {
     %>
    <script type="text/javascript">
      alert("删除成功！");
      window.location.href="<%=path%>/admin/ManageQuestion.jsp";
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
