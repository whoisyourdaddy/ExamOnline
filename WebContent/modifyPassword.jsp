<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'modifyPassword.jsp' starting page</title>
    <link rel="stylesheet" href="<%=path%>/css/public.css" type="text/css"/>
   <style type="text/css">
     body{
      padding-top:50px;
     }
     </style>
     <%
       String Uid = (String)session.getAttribute("Uid");
       String type = request.getParameter("type"); 
       String keyWord = request.getParameter("keyWord");
          
     %>
     <script type="text/javascript">
       function modify()
       {
         var oldPass=document.forms[0].oldPass;
         var newPass=document.forms[0].newPass;
         var rePass=document.forms[0].rePass;
         if(oldPass.value=="")
         {
           alert("请输入旧密码！");
           oldPass.focus();
           
         }else if(newPass.value=="")
         {
           alert("请输入新密码！");
           newPass.focus();
         }else if(rePass.value=="")
         {
           alert("请输入确认新密码！");
           rePass.focus();
         }else
         {
           if(newPass.value!=rePass.value)
           {
             alert("两次输入新密码不同，请确认！");
             newPass.focus();
           }else
           {
            var onsubmit = confirm("确认修改？");
            if(onsubmit==true)
            {
             document.forms[0].submit();
            }
           }
         }
       }
       function check()
       {
         var key="<%=keyWord%>";
         if(key=="error")
         {
           alert("您输入的旧密码不对");
         }
       }
     </script>

  </head>
  
  <body onload="check()">
   <form action="<%=path%>/ModifyPassServlet" method="post">
     <table class="table" cellspacing="1" cellpadding="2" width="80%" align="center"  border="0">
    <tr>
      <th class="bg_tr" align="center" colspan="2" height="50">修改密码</th>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">旧密码：</span></td>
      <td class="td_bg" align="center"><input type="password" name="oldPass" style="color:#1E5494;font-size:12px;"/></td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">新密码：</span></td>
      <td class="td_bg" align="center" class="type"><input type="password" name="newPass" style="color:#1E5494;font-size:12px;"/></td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">确认新密码：</span></td>
      <td class="td_bg" align="center" class="type">
        <input type="password" name="rePass" style="color:#1E5494;font-size:12px;"/>
      </td>
    </tr>
    <tr>
     <td class="td_bg" height="50" align="center"><span class="TableRow2">操&nbsp;&nbsp;&nbsp;&nbsp;作：</span></td>
      <td class="td_bg" align="center">
        <input type="button" onclick="modify()" value="修改" style="color:#1E5494;font-size:12px;"/>
        <input type="hidden" value="<%=type%>" name="type"/>
      </td>
    </tr>
</table>
</form>
  </body>
</html>
