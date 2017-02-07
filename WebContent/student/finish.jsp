<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>在线考试系统</title>
    <style type="text/css">
      body{background-image: url("<%=path%>/images/bk1.jpg"); background-repeat: repeat-y;}
      .main{text-align: center;margin-top:100px;font-size:30px;font-weight:bold;};
      
    </style>

  </head>
  
  <body onload="alert('试卷已提交!请离开考场!')">
    <div class="main">试卷已提交,请离开考场!</div>
    <hr/>
  </body>
</html>
