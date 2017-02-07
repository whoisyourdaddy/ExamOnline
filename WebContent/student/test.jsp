<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xurui.dormain.*" %>
<%@ page import="com.xurui.util.*" %>
<%@ page import="java.util.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String course = (String)session.getAttribute("course");
String Uid = (String)session.getAttribute("Uid");
String name = (String)session.getAttribute("name");
String test_time  =(String) session.getAttribute("test_time");
TestSetUtil testUtil = new TestSetUtil();
TestSet ts = null;
if(course!=null&&Uid!=null&&name!=null)
{
 ts = testUtil.getTestSet(course.trim(),test_time.trim());
 ArrayList al=null;
 QuestionUtil questionUtil = new QuestionUtil();
 Question qs = new Question();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>在线考试系统-在线测试</title>
    <style type="text/css">
      body{background-image: url("<%=path%>/images/bk1.jpg"); background-repeat: repeat-y;}
      .title{text-align:center;height:50px;}
      .head{height:30px;width:1000px;margin:20px;padding-left:100px;padding-right:80px;}
      .main{width:1000px;margin:auto;padding-left:100px;padding-right:50px;}
      .datikuang{color:gray;}
    </style>
    <script type="text/javascript">
       var total = <%=ts.getTotaltime()%>*60;
       var show;
      function setTime()
      {
       var h = parseInt(total/3600);
       var hh;
       if(h<10)
       {
         hh ="0"+h;
       }else
       {
         hh=h+"";
       }
       var m = parseInt((total%3600)/60);
       var mm;
       if(m<10)
       {
         mm = "0"+m;
       }
       else
       {
         mm = ""+m;
       }
       var s = (total%3600)%60;
       var ss;
       if(s<10)
       {
         ss = "0"+s;
       }
       else
       { ss = ""+s;
       }
       if(total==0)
       {
        toSumbmit();
       }
       else
       {
        total = total - 1;
        document.getElementById("timeSpan").innerHTML = hh+":"+mm+":"+ss;
       }
     }
      
     function edit(obj)
     {
       obj.innerHTML = "";
       obj.style.color="black";
     }
     function submitTest()
     {
       if(confirm("检查好试卷,确认交卷?"))
       {
         document.forms[0].submit();
       }
     }
     function toSumbmit()
     {
       clearInterval(show);
       //alert("考试时间到,试卷已提交!请离开考场!");
       document.forms[0].submit();
       
     }
     function setIner()
     {
       show=setInterval(setTime,1000);
     }
    </script>
  </head>
  
  <body onload="setIner()">
   
     <div class="title">
      <h2><%=course%>程序设计考试卷</h2>
    </div>
    <hr>
    <div class="head">
      <span style="margin-right:100px;"><strong>学号:</strong><%=Uid%></span>
      <span><strong>考生姓名:</strong><%=name%></span>
      <span style="margin-left:60px;"><strong>考试日期:<%=test_time %></strong></span>
      <span style="margin-left:60px;"><strong>考试剩余时间:</strong></span>
      <span id="timeSpan" style="color:red"></span>
    </div>
    <form action="<%=path%>/TestSubmitServlet" method="post">
    <div class="main">
        <%
         int typeCount  =1;
        %>
    
     <% if(ts.getJudgeCount()!=0){%>
      <div class="judge" style="margin-top:20px;">
         <strong><%= Common.getTypeCount(typeCount) %>、判断题</strong> (共<%=ts.getJudgeCount()%>题，每题<%=ts.getPerJudScore()%>分)
         <%
           al = questionUtil.getQuestion2(course,ts.getJudgeCount(),3);
           for(int i=0;i<al.size();i++)
           {
            qs = (Question)al.get(i);
          %> 
          <div name="stuJudge<%=i%>" style="width:900px;word-break:break-all;margin-top:20px;"><%=i+1%>.<%=qs.getQues().trim()%></div>
          <input type="radio" name="judge<%=i%>Value" value="yes"/>是<%=qs.getQues().trim()%><br/>
          <input type="radio" name="judge<%=i%>Value" value="no"/>不是<br/>
          <input type="hidden" value="<%=qs.getId()%>" name="judgeId<%=i%>"/>
         <%--  <input type="hidden" value="<%=qs.getAnswer()==null?"":qs.getAnswer().trim()%>" name="judgeAnswer<%=i%>"/> --%>
         <%}%>
         <% typeCount++;%>
       </div>
       <%}%>
       
       <% if(ts.getSinChCount()!=0){%>
      <div class="singleChoice">
        <strong><%= Common.getTypeCount(typeCount) %>、单选题</strong> (共<%=ts.getSinChCount()%>题，每题<%=ts.getPerSinScore()%>分)
        <%
          al = questionUtil.getQuestion2(course,ts.getSinChCount(),1);
          for(int i=0;i<al.size();i++)
          {
            qs = (Question)al.get(i);
         %>
          <div name="stuChoice<%=i%>" style="width:900px;word-break:break-all;margin-top:20px;"><%=i+1%>.<%=qs.getQues().trim()%></div>
          <input type="radio" name="choice<%=i%>Value" value="A"/>A.<%=qs.getKeyA()==null?"":qs.getKeyA().trim()%><br/>
          <input type="radio" name="choice<%=i%>Value" value="B"/>B.<%=qs.getKeyB()==null?"":qs.getKeyB().trim()%><br/>
          <input type="radio" name="choice<%=i%>Value" value="C"/>C.<%=qs.getKeyC()==null?"":qs.getKeyC().trim()%><br/>
          <input type="radio" name="choice<%=i%>Value" value="D"/>D.<%=qs.getKeyD()==null?"":qs.getKeyD().trim()%><br/>
          <input type="hidden" value="<%=qs.getId()%>" name="choiceId<%=i%>"/>

         <%--  <input type="hidden" value="<%=qs.getAnswer()==null?"":qs.getAnswer().trim()%>" name="choiceAnswer<%=i%>"/> --%>

          <%-- <input type="hidden" value="<%=qs.getAnswer()==null?"":qs.getAnswer().trim()%>" name="choiceAnswer<%=i%>"/> --%>

         
         <%}%>
         <% typeCount++;%>
       </div>
        <%}%>
       
       
       <% if(ts.getMulChCount()!=0){%>
       <div class="multiplyChoice" style="margin-top:30px;">
         <strong><%= Common.getTypeCount(typeCount) %>、多选题</strong> (共<%=ts.getMulChCount()%>题，每题<%=ts.getPerMulScore()%>分) 
         <%
           al = questionUtil.getQuestion2(course,ts.getMulChCount(),2);
           for(int i=0;i<al.size();i++)
           {
            qs = (Question)al.get(i);
          %>
          <div name="stuMulChoice<%=i%>" style="width:900px;word-break:break-all;margin-top:20px;"><%=i+1%>.<%=qs.getQues().trim()%></div>
          <input type="checkbox" name="mulchoice<%=i%>Value" value="A"/>A.<%=qs.getKeyA()==null?"":qs.getKeyA().trim()%><br/>
          <input type="checkbox" name="mulchoice<%=i%>Value" value="B"/>B.<%=qs.getKeyB()==null?"":qs.getKeyB().trim()%><br/>
          <input type="checkbox" name="mulchoice<%=i%>Value" value="C"/>C.<%=qs.getKeyC()==null?"":qs.getKeyC().trim()%><br/>
          <input type="checkbox" name="mulchoice<%=i%>Value" value="D"/>D.<%=qs.getKeyD()==null?"":qs.getKeyD().trim()%><br/>
          <input type="hidden" value="<%=qs.getId()%>" name="mulchoiceId<%=i%>"/>
         <%--  <input type="hidden" value="<%=qs.getAnswer()==null?"":qs.getAnswer().trim()%>" name="mulchoiceAnswer<%=i%>"/> --%>
         <%}%>
         <% typeCount++;%>
       </div>
       <%} %>
       
       <% if(ts.getJdCount()!=0){%>
       <div class="jianda" style="margin-top:20px;">
         <strong><%= Common.getTypeCount(typeCount) %>、简答题</strong> (共<%=ts.getJdCount()%>题，每题<%=ts.getPerJdScore()%>分) 
         <%
           al = questionUtil.getQuestion2(course,ts.getJdCount(),4);
           for(int i=0;i<al.size();i++)
           {
            qs = (Question)al.get(i);
          %> 
          <div name="stuJd<%=i%>" style="width:900px;word-break:break-all;margin-top:20px;"><%=i+1%>.<%=qs.getQues().trim()%></div>
          <textarea name="stuJdAnswer<%=i%>" cols="120" rows="5" class="datikuang" onfocus="edit(this)">==请在此答题==</textarea>
          <input type="hidden" value="<%=qs.getId()%>" name="jdId<%=i%>"/>
         <%}%>
         <% typeCount++;%>
       </div>
       <%} %>
       
       <% if(ts.getProgramCount()!=0){%>
       <div class="multiplyChoice" style="margin-top:20px;">
         <strong><%= Common.getTypeCount(typeCount) %>、编程题(核心代码/思想)</strong> (共<%=ts.getProgramCount() %>题，每题<%=ts.getPerProScore()%>分) 
         <%
           al = questionUtil.getQuestion2(course,ts.getProgramCount(),5);
           for(int i=0;i<al.size();i++)
           {
            qs = (Question)al.get(i);
          %> 
          <div name="stuPro<%=i%>" style="width:900px;word-break:break-all;margin-top:20px;"><%=i+1%>.<%=qs.getQues().trim()%></div>
          <textarea name="stuProAnswer<%=i%>" cols="120" rows="10" class="datikuang" onfocus="edit(this)">==请在此答题==</textarea>
          <input type="hidden" value="<%=qs.getId()%>" name="proId<%=i%>"/><br><br>
         <%}%>
         <% typeCount++;%>
       </div>
       <%} %>
       
       
       <div style="text-align: right;"><input type="button" value="交卷" style="width:80px;height:50px;font-size: 20px;" onclick="submitTest()"/></div>
    </div>
    </form>
</body>
</html>
<%
 }else
 {
   response.sendRedirect(path+"/student/login.jsp");
 }
 %>

