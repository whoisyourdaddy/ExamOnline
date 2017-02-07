<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xurui.util.*"%>
<%@ page import="com.xurui.dormain.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>modifyInfo.jsp</title>
    
   <link rel="stylesheet" href="<%=path%>/css/public.css" type="text/css"/>
   <style type="text/css">
     body{
      padding-top:50px;
     }
     </style>
     <%
          String Uid = (String)session.getAttribute("Uid");
          UserUtil userUtil = new UserUtil();
          User user = userUtil.getUser(Uid);
          
     %>
     <script type="text/javascript">
       var type=<%=user.getType()%>;
       var sexString="<%=user.getSex()%>";
       function setType()
       {
         var typeString="";
         if(type==1)
         {
           typeString="学生";
         }else if(type==2)
         {
           typeString="教师";
         }else if(type==3)
         {
           typeString="管理员";
         }
         document.getElementById("type").value = typeString;
         var sex = document.getElementsByName("sex")[0];
         for(var i=0;i<sex.options.length;i++)
         {
           if(sex.options[i].value==sexString)
           {
            sex.options[i].selected=true;
            break;
           }
           
         }
       }
     </script>

  </head>
  
  <body onload="setType()">
    <form action="<%=path%>/ModifyUserServlet" method="post">
     <table class="table" cellspacing="1" cellpadding="2" width="80%" align="center" 
      border="0">
    <tr>
      <th class="bg_tr" align="center" colspan="2" height="50"><%=user.getName().trim()%>的个人信息</th>
    </tr>
    <tr>
      <td class="td_bg" width="50%" height="50" align="center"><span class="TableRow2">用户编号：</span></td>
      <td width="50%" class="td_bg" align="center"><%=user.getId()%></td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">用户姓名：</span></td>
      <td class="td_bg" align="center"><input type="text" value="<%=user.getName().trim()%>" class="readonly" name="name" readonly="readonly"/></td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">用户类型：</span></td>
      <td class="td_bg" align="center" class="type"><input type="text" id="type" class="readonly" readonly="readonly" name="type"/></td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">用户性别：</span></td>
      <td class="td_bg" align="center" class="type">
        <select name="sex" style="color:#1E5494;font-size:12px;">
          <option value="男">男</option>
          <option value="女">女</option>
        </select>
      </td>
    </tr>
    <tr>
     <td class="td_bg" height="50" align="center"><span class="TableRow2">操&nbsp;&nbsp;&nbsp;&nbsp;作：</span></td>
      <td class="td_bg" align="center"><input type="submit" onclick="return confirm('确定修改？')" value="修改" style="color:#1E5494;font-size:12px;"/></td>
    </tr>
</table>
</form>
</body>
</html>
