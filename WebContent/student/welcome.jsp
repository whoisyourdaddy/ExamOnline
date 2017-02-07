<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xurui.dormain.*" %>
<%@ page import="com.xurui.util.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>welcome to ExamOnline</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
    <!--
     .style1 {font-size: 14px}
     .style2 {font-size: 18px}
     .style3 {font-size: 18px; font-weight: bold; }
     .bold{font-weight:bold;}
     -->
    </style>
    <script type="text/javascript">
      function IsSubmit()
      {
       var okey = confirm("确定开始考试？");
       if(okey)
       {
         window.location.href="<%=request.getContextPath()%>/student/test.jsp"
       }
      }
    </script>

  </head>
  
  <body>
    <%
    	String course = (String)session.getAttribute("course");
          String Uid = (String)session.getAttribute("Uid");
          String test_time=(String)session.getAttribute("test_time");
          UserUtil userUtil = new UserUtil();
          User user = userUtil.getUser(Uid);
          TestSetUtil testUtil = new TestSetUtil();
          TestSet ts = testUtil.getTestSet(course,test_time);         
          if(ts!=null&&user!=null)
          {
            session.setAttribute("name",user.getName());
            int totalScore = testUtil.getTotalScore(ts); 
    %>
    <table width="650" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr style="background-color: rgb(255, 0, 0);">
        <td height="44" bgcolor="#0099FF"><div align="center" class="style3"><font color="#000000"><%=user.getName()%>你好!欢迎光临网上考试系统</font></div></td>
      </tr>
      <tr>
        <td height="28" bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
      </tr>
      <tr>
        <td height="12" bordercolor="#000000" bgcolor="#CCCCCC" ><span class="style1">&nbsp;&nbsp;&nbsp;&nbsp;<span class="style1 bold">&nbsp; 请验证一下你的信息是否正确!</span>
      </tr> 
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
      </tr>              
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
           <img src="<%=path%>/images/arrow.gif" width="12" height="12"> 
             学号:<%=user.getId()%></span>
        </td>
       </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
      </tr>
      <tr>
       <td bordercolor="#000000" bgcolor="#CCCCCC">
       <span class="style1 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="<%=path%>/images/arrow.gif" width="12" height="12">
         姓名:<%=user.getName()%></span>
        </td>
      </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
      </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
         <img src="<%=path%>/images/arrow.gif" width="12" height="12">
          性别:<%=user.getSex()%></span>
        </td>
       </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
      </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1 ">&nbsp; &nbsp; &nbsp;&nbsp; <a href="./student/login.jsp">返回</a></span></td>
      </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
      </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1 bold">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;若正确请点击开始进入在线考试!</span></td>
      </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1"></span></td>
      </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
      </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="style1 bold">考试科目：<%=course%> </span>
        </td>
      </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
      </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="style1 bold">考试时间：<%=ts.getTotaltime()%>分钟 </span>
      </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
      </tr>
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="style1 bold">考试日期：<%=test_time%> </span>
      </tr>   
      <tr>
        <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1"></span></td>
     </tr>
     <tr>
       <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
     </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1 bold">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 考题类型：（满分<%=totalScore%>分）</span></td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1"></span></td>
  </tr>
        <%
         int typeCount  =1;
        %>
  
  <% if(ts.getJudgeCount()!=0){%> 
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= Common.getTypeCount(typeCount) %>、判断：共<%=ts.getJudgeCount()%>题，每题<%=ts.getPerJudScore() %>分</span></td>
  </tr> 
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1"></span></td>
  </tr>
  <% typeCount++;%>
  <%}%>
 
  
   <% if(ts.getSinChCount()!=0){%>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= Common.getTypeCount(typeCount) %>、单选：共<%=ts.getSinChCount()%>题，每题<%=ts.getPerSinScore()%>分</span></td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1"></span></td>
  </tr>
  <% typeCount++;%>
 <%}%>
  
  
  <% if(ts.getMulChCount()!=0){%>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= Common.getTypeCount(typeCount) %>、多选：共<%=ts.getMulChCount() %>题，每题<%=ts.getPerMulScore() %>分</span></td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
  </tr>
  <% typeCount++;%>
 <%}%>
  
  
  <% if(ts.getJdCount()!=0){%>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= Common.getTypeCount(typeCount) %>、简答：共<%=ts.getJdCount() %>题, 每题<%=ts.getPerJdScore() %>分</span></td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
  </tr>
  <% typeCount++;%>
  <%}%>
 
 
 <% if(ts.getProgramCount()!=0){%>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= Common.getTypeCount(typeCount) %>、编程：共<%=ts.getProgramCount() %>题, 每题<%=ts.getPerProScore()%>分</span></td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
  </tr>
  <% typeCount++;%>
  <%}%>
  
  
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1 bold">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 请遵守本考场规则如下：</span></td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1"></span></td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.请不要点击刷新、后退等违纪按钮</span></td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 2.准时交卷，不拖交</span></td>
  </tr>
  <tr>
    <td bordercolor="#000000" bgcolor="#CCCCCC">&nbsp;</td>
  </tr>
  <tr>
    <td height="21" bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.不要违反考试各项规则</span></td>
  </tr>
   <tr>
    <td height="21" bordercolor="#000000" bgcolor="#CCCCCC"><span class="style1"></span></td>
  </tr>
  <tr>
    <td height="40" bgcolor="#0066FF" >&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" name="button" value="开始考试" onclick="IsSubmit()"/>
    </td>
  </tr>
</table>
<%
 }else
 {
   response.sendRedirect(path+"/student/login.jsp");
 } 
%>
  </body>
</html>
