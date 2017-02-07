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
    
    <title>showRecord.jsp</title>
    
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
          RecordUtil ru = new RecordUtil();
          ArrayList al = ru.getAll(Uid);
          
     %>

  </head>
  
  <body>
     <table class="table" cellspacing="1" cellpadding="2" width="80%" align="center" 
      border="0">
    <tr>
      <th class="bg_tr" align="center" colspan="7" height="50"><%=user.getName()%>的个人成绩</th>
    </tr>
    <tr>
      <td width="10%" class="td_bg" width="" height="50" align="center"><span class="TableRow2">科目</span></td>
      <td width="10%" class="td_bg" align="center">单选题（分）</td>
      <td width="10%" class="td_bg" align="center">多选题(分)</td>
      <td width="10%" class="td_bg" align="center">判断题(分)</td>
      <td width="15%" class="td_bg" align="center">简答题(分)</td>
      <td width="15%" class="td_bg" align="center">编程题(分)</td>
      <td width="15%" class="td_bg" align="center">总分</td>
      <td width="15%" class="td_bg" align="center">查看详情</td>
    </tr>
    <%
      for(int i=0;i<al.size();i++)
      {
        Record record = (Record)al.get(i);
     %>
    <tr>
      <td class="td_bg" width="" height="50" align="center"><span class="TableRow2"><%=record.getCourse()%></span></td>
      <td class="td_bg" align="center"><%=record.getSingle()%></td>
      <td class="td_bg" align="center"><%=record.getMultiply()%></td>
      <td class="td_bg" align="center"><%=record.getJudge()%></td>
      <td class="td_bg" align="center"><%=record.getJd()%></td>
      <td class="td_bg" align="center"><%=record.getProgram()%></td>
      <td class="td_bg" align="center"><%=record.getScore()%></td>
      <td class="td_bg" align="center"><a href="/ExamOnline/Record/showTest.jsp?Uid=<%=Uid  %>&name=<%=user.getName()  %>&course=<%=record.getCourse() %>">查看详情</a></td>
    </tr>
     <%
      }
      %>
</table>
</body>
</html>