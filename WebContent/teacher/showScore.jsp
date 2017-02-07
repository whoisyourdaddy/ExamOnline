<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xurui.util.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'showScore.jsp' starting page</title>
   <link rel="stylesheet" href="./css/public.css" type="text/css"/>
   <style type="text/css">
     body{
      padding-top:50px;
     }
     .TableRow2
     {
       font-weight: bold;
     }
   </style>
   <%
      String scoreString = request.getParameter("score").trim();
      String course = (String)session.getAttribute("course");
      RecordUtil ru = new RecordUtil();
      int count = ru.getCount(course);
      int pass = 0;
      String title="";
      if("pass".equals(scoreString))
      { 
       pass = ru.getPass(course);
       title="及格";
      }
      else
      {
       int score = Integer.parseInt(scoreString); 
       pass = ru.getCountByScore(course,score);
       title=scoreString+"分段";
      }
       String percent = count==0?"0.0%":((float)pass)/((float)count)*100+"%";
    %>
  </head>
  
  <body>
    <table class="table" cellspacing="1" cellpadding="2" width="80%" align="center" 
      border="0">
    <tr>
      <th class="bg_tr" align="center" colspan="2" height="50"><%=course%>考试<%=title%>情况统计表</th>
    </tr>
    <tr>
      <td class="td_bg" width="50%" height="50" align="center"><span class="TableRow2">考生人数:</span></td>
      <td width="50%" class="td_bg" align="center"><strong><%=count%><br /></strong></td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2"><%=title %>人数:</span></td>
      <td class="td_bg" align="center"><strong><%=pass%></strong></td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">占有比例:</span></td>
      <td class="td_bg" align="center"><strong><%=percent%></strong></td>
    </tr>
</table>
  </body>
</html>
