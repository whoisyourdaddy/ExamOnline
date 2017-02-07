<%@ page language="java" import="java.util.*,com.xurui.dormain.*,com.xurui.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String Uid = request.getParameter("Uid").trim();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>DeleteUser.jsp</title>

  </head>
  
  <body>
   <%
     UserUtil userUtil = new UserUtil();
     boolean success=userUtil.deleteUser(Uid);
     if(success)
     {
    %>
    <script type="text/javascript">
      alert("删除成功！");
      window.location.href="<%=path%>/admin/ManageUser.jsp";
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
