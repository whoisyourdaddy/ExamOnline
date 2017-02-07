<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xurui.dormain.*" %>
<%@ page import="com.xurui.util.*" %>
<%@ page import="java.util.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>showTest</title>
    <link rel="stylesheet" href="<%=path%>/css/public.css" type="text/css"/> 
    <style type="text/css">
      body{
           SCROLLBAR-FACE-COLOR: #59D6FF; 
	       SCROLLBAR-HIGHLIGHT-COLOR: #ffffff; 
	       SCROLLBAR-SHADOW-COLOR: #ffffff; 
	       SCROLLBAR-3DLIGHT-COLOR: #007BC6; 
	       SCROLLBAR-DARKSHADOW-COLOR: #007BC6; 
	      SCROLLBAR-ARROW-COLOR: #007BC6;
	      SCROLLBAR-TRACK-COLOR: #009ED2;
      }
      .bg_td{
       color:#1E5494;
	   font-size:12px;
	   font-weight:bold;
	   background:#E4F1FA;
       line-height: 22px;
       text-align: left;
      }
    </style>
    <%
      String Uid = request.getParameter("Uid");
      String name = new String(request.getParameter("name").getBytes("iso8859-1"),"utf-8").trim();
      String course = (String)session.getAttribute("course");
      String test_time= new String(request.getParameter("test_time").getBytes("iso8859-1"),"utf-8").trim();

      TestQuestionUtil tqu = new TestQuestionUtil();
      TestSetUtil tsu = new TestSetUtil();
      TestSet ts = tsu.getTestSet(course,test_time);
      ArrayList al = null;
     %>
     <script type="text/javascript">
       function judgeJd(obj)
       {
         var perJd = <%=ts.getPerJdScore()%>
         if(isNaN(obj.value))
         {
           alert("输入值不是合法数字！");
           obj.focus();
         }else if(parseFloat(obj.value)>perJd)
         {
           alert("得分不能超过此题的分值！");
           obj.focus();
         }
       }
       function judgePro(obj)
       {
         var perPro = <%=ts.getPerProScore()%>
         if(parseFloat(obj.value)>perPro)
         {
           alert("得分不能超过此题的分值！");
           obj.focus();
         }
       }
     </script>

  </head>
  
  <body>
    <div class="title" style="text-align:center;color:#1E5494;font-weight:bold;font-size:16px;">学号：<%=Uid %>&nbsp;&nbsp;姓名：<%=name%>&nbsp;&nbsp;科目：<%=course%>&nbsp;&nbsp;考试时间：<%=test_time%></div>
    <form action="<%=path%>/ScoreSubmitServlet" method="post">
      <input type="hidden" name="test_time" value="<%=test_time%>"> 
      
    
        <%
         int typeCount  =1;
        %>
        
     <% if(ts.getJudgeCount()!=0){%> 
     <div class="dati">
     <div style="color:#1E5494;font-weight:bold;font-size:14px;margin-top:15px;margin-bottom:5px;"><%= Common.getTypeCount(typeCount) %>、判断题(每题<%=ts.getPerJudScore()%>分)</div>
    <%
      al = tqu.getTest(Uid,course,3,test_time);
      if(al!=null)
      {
       for(int i = 0;i<al.size();i++)
       {
        TestQuestion tq = (TestQuestion)al.get(i);
     %>
   <table class="table" cellspacing="1" cellpadding="2" width="99%" align="center" 
      border="0">
    <tr>
      <td class="bg_td" align="left" colspan="2"><%=tq.getTnumber()+1%>.<%=tq.getQues().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg">正确答案：<%=tq.getAnswer().trim()%></td>
      <td class="td_bg">考生答案：<%=tq.getStuAnswer()==null?"":tq.getStuAnswer().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg" colspan="2">得分：<input type="text" value="<%=tq.getScore()%>" readonly="readonly" name="judge<%=i%>" class="readOnly"/></td>
    </tr>
  </table>
       <%
          } 
        }
        %>
        <% typeCount++;%>
     </div>
     <%}%>
     
     
    <% if(ts.getSinChCount()!=0){%>
    <div class="dati">
     <div style="color:#1E5494;font-weight:bold;font-size:14px;margin-top:15px;margin-bottom:5px;"><%= Common.getTypeCount(typeCount) %>、选择题(每题<%=ts.getPerSinScore()%>分)</div>
    <%
      al = tqu.getTest(Uid,course,1,test_time);
      if(al!=null)
      {
       for(int i = 0;i<al.size();i++)
       {
         TestQuestion tq = (TestQuestion)al.get(i);
     %>
   <table class="table" cellspacing="1" cellpadding="2" width="99%" align="center" 
      border="0">
    <tr>
      <td class="bg_td" align="left" colspan="2"><%=tq.getTnumber()+1%>.<%=tq.getQues().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg" width="50%">A.<%=tq.getKeyA()==null?"":tq.getKeyA().trim()%></td>
      <td width="50%" class="td_bg">B.<%=tq.getKeyB()==null?"":tq.getKeyB().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg">C.<%=tq.getKeyC()==null?"":tq.getKeyC().trim()%></td>
      <td class="td_bg">D.<%=tq.getKeyD()==null?"":tq.getKeyD().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg">正确答案：<%=tq.getAnswer().trim()%></td>
      <td class="td_bg">考生答案：<%=tq.getStuAnswer()==null?"":tq.getStuAnswer().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg" colspan="2">得分：<input type="text" value="<%=tq.getScore()%>" readonly="readonly" name="choice<%=i%>" class="readOnly"/></td>
    </tr>
  </table>
       <%
          } 
        }
        %>
        <% typeCount++;%>
     </div>
      <%}%>
     
     
     <% if(ts.getMulChCount()!=0){%>
     <div class="dati">
     <div style="color:#1E5494;font-weight:bold;font-size:14px;margin-top:15px;margin-bottom:5px;"><%= Common.getTypeCount(typeCount) %>、多选题(每题<%=ts.getPerMulScore()%>分)</div>
    <%
      al = tqu.getTest(Uid,course,2,test_time);
      if(al!=null)
      {
       for(int i = 0;i<al.size();i++)
       {
        TestQuestion tq = (TestQuestion)al.get(i);
     %>
   <table class="table" cellspacing="1" cellpadding="2" width="99%" align="center" 
      border="0">
    <tr>
      <td class="bg_td" align="left" colspan="2"><%=tq.getTnumber()+1%>.<%=tq.getQues().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg" width="50%">A.<%=tq.getKeyA()==null?"":tq.getKeyA().trim()%></td>
      <td width="50%" class="td_bg">B.<%=tq.getKeyB()==null?"":tq.getKeyB().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg">C.<%=tq.getKeyC()==null?"":tq.getKeyC().trim()%></td>
      <td class="td_bg">D.<%=tq.getKeyD()==null?"":tq.getKeyD().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg">正确答案：<%=tq.getAnswer().trim()%></td>
      <td class="td_bg">考生答案：<%=tq.getStuAnswer()==null?"":tq.getStuAnswer().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg" colspan="2">得分：<input type="text" value="<%=tq.getScore()%>" readonly="readonly" name="mulChoice<%=i%>" class="readOnly"/></td>
    </tr>
  </table>
       <%
          } 
        }
        %>
       <% typeCount++;%>
     </div>
     <%}%>
     
   
     <% if(ts.getJdCount()!=0){%>
     <div class="dati">
     <div style="color:#1E5494;font-weight:bold;font-size:14px;margin-top:15px;margin-bottom:5px;"><%= Common.getTypeCount(typeCount) %>、简答题(每题<%=ts.getPerJdScore()%>分)</div>
    <%
      al = tqu.getTest(Uid,course,4,test_time);
      if(al!=null)
      {
       for(int i = 0;i<al.size();i++)
       {
        TestQuestion tq = (TestQuestion)al.get(i);
     %>
   <table class="table" cellspacing="1" cellpadding="2" width="99%" align="center" 
      border="0">
    <tr>
      <td class="bg_td" align="left" colspan="2"><%=tq.getTnumber()+1%>.<%=tq.getQues().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg" clospan="2"><strong>参考答案：</strong><%=tq.getAnswer().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg" clospan="2"><strong>考生答案：</strong><%=tq.getStuAnswer()==null?"":tq.getStuAnswer().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg" colspan="2">
         得分：<input type="text" value="<%=tq.getScore()%>" name="jd<%=i%>" style="font-size:12px;color:#1E5494;" onblur="judgeJd(this)"/>(需要老师修改)
        <input type="hidden" value="<%=tq.getQid()%>" name="jdId<%=i%>"/>
      </td>
    </tr>
  </table>
       <%
          } 
        }
        %>
        <% typeCount++;%>
     </div>
     <%}%>
     
     <% if(ts.getProgramCount()!=0){%>
    <div class="dati">
     <div style="color:#1E5494;font-weight:bold;font-size:14px;margin-top:15px;margin-bottom:5px;"><%= Common.getTypeCount(typeCount) %>、编程题(每题<%=ts.getPerProScore()%>分)</div>
    <%
      al = tqu.getTest(Uid,course,5,test_time);
      if(al!=null)
      {
       for(int i = 0;i<al.size();i++)
       {
        TestQuestion tq = (TestQuestion)al.get(i);
     %>
   <table class="table" cellspacing="1" cellpadding="2" width="99%" align="center" 
      border="0">
    <tr>
      <td class="bg_td" align="left" colspan="2"><%=tq.getTnumber()+1%>.<%=tq.getQues().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg" clospan="2"><strong>参考答案:</strong><%=tq.getAnswer().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg" clospan="2"><strong>考生答案:</strong><%=tq.getStuAnswer()==null?"":tq.getStuAnswer().trim()%></td>
    </tr>
    <tr>
      <td class="td_bg" colspan="2">
         得分：<input type="text" value="<%=tq.getScore()%>" name="pro<%=i%>" style="font-size:12px;color:#1E5494;" onblur="judgePro(this)"/>(需要老师修改)
        <input type="hidden" value="<%=tq.getQid()%>" name="proId<%=i%>"/>
      </td>
    </tr>
  </table>
       <%
          } 
        }
        %>
        <% typeCount++;%>
     </div>
         <%}%>
         
      <input type="hidden" value="<%=Uid%>" name="Uid"/>
      <input type="submit" value="提交" style="width:60px;height:30px;color:#2f4867;font-weight:bold;font-size:14px;background-color:#CAF2FF"/>
    </form>
  </body>
</html>
