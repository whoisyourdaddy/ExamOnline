<%@ page language="java" import="java.util.*,com.xurui.dormain.*,com.xurui.util.*,java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String str_Qid = request.getParameter("Qid");
int Qid = 0;
if(str_Qid!=null)
{
  Qid = Integer.parseInt(str_Qid.trim());
}
QuestionUtil qu = new QuestionUtil();
Question question = qu.getQuestionById(Qid);
ArrayList al = qu.getCourse();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>AddQuestion.jsp</title>
    <link rel="stylesheet" href="<%=path%>/css/public.css" type="text/css"/>
    <link rel="stylesheet" href="<%=path%>/css/question_set.css" type="text/css"/>
    <script type="text/javascript" src="<%=path%>/js/question_set.js"></script>
    <script type="text/javascript">
      function inital()
      {
        setCourse();
        setType();
        setAnswer1();
        setAnswer();
        judgeCourse();
      }
      function setCourse()
      {
        var kemu = document.getElementsByName("kemu");
        var course1 = document.getElementsByName("course1")[0];
        var course = "<%=question.getCourse()%>";
        //alert(course1.options.length);
        //alert(kemu.value);
        for(var i=0;i<course1.options.length;i++)
        {
          if(course1.options[i].value==course)
          {
            course1.options[i].selected = true;
          }
        }
      }
      function setType()
      {
        var type="<%=question.getType()%>";
        //alert(type);
        var tag_type=document.getElementsByName("type")[0];
        for(var i=0;i<tag_type.options.length;i++)
        {
          if(tag_type.options[i].value==type)
          {
            tag_type.options[i].selected = true;
          }
        }
      }
      function setAnswer1()
      {
        var answer = "<%=question.getAnswer().trim()%>";
        var type=document.getElementsByName("type")[0];
        var answer_sin = document.getElementsByName("answer_sin");
        var answer_mul = document.getElementsByName("answer_mul");
        var answer_judge = document.getElementsByName("answer_jud");
        if(type.selectedIndex==0)
        {
          for(var i = 0;i < answer_sin.length;i++)
          {
            //alert(answer_sin[i].value);
            if(answer_sin[i].value==answer)
            {
              answer_sin[i].checked = true;
            }
          }
        }else if(type.selectedIndex==1)
        {
          var str_mul = answer.split("");
          for(var i = 0;i < answer_mul.length;i++)
          {
            for(var j = 0;j < str_mul.length;j++)
            {
              //alert(str_mul[j]);
             if(answer_mul[i].value==str_mul[j])
             {
              answer_mul[i].checked = true;
             }
            }
          }
        }else if(type.selectedIndex==2)
        {
          for(var i = 0;i < answer_judge.length;i++)
          {
            if(answer_judge[i].value==answer)
            {
              answer_judge[i].checked = true;
            }
          }
        }
      }
    </script>
  </head>
  <body style="padding-top:50px;" onload="inital()">
  <form action="<%=path%>/UpdateQuesServlet" method="post">
    <table class="table" cellspacing="1" cellpadding="2" width="100%" align="center" border="0">
    <tr>
      <th class="bg_tr" align="left" colspan="2" height="50">修改试题</th>
    </tr>
    <tr>
      <td class="td_bg" width="30%" align="center" height="50"><span class="TableRow2">科目:</span></td>
      <td width="70%" class="td_bg" align="center">
        <input type="radio" name="kemu" value="1" checked="checked" onchange="judgeCourse()"/>
        <select class="inputCSS" name="course1">
          <option value="0">请选择</option>
          <% 
           for(int i=0;i < al.size();i++)
           {
             String course = al.get(i).toString();
          %>
          <option value="<%=course%>"><%=course%></option>
          <%}%>
        </select>
        &nbsp;&nbsp;&nbsp;<input type="radio" name="kemu" value="2" onchange="judgeCourse()"/>新建<input type="text" class="inputCSS" name="course2"/>
       </td>
    </tr>
    <tr>
      <td class="td_bg" align="center" height="70"><span class="TableRow2">类型:</span></td>
      <td class="td_bg" align="center">
        <select name="type" class="inputCSS" onchange="setAnswer()">
          <option value="1" checked="checked">单选题</option>
          <option value="2">多选题</option>
          <option value="3">判断题</option>
          <option value="4">简答题</option>
          <option value="5">编程题</option>
        </select>
      </td>
    </tr>
    <tr>
      <td class="td_bg" width="30%" align="center"><span class="TableRow2">题目:</span></td>
      <td width="70%" class="td_bg" align="center">
        <textarea rows="5" cols="80" class="inputCSS" name="ques"><%=question.getQues().trim()%></textarea>
      </td>
    </tr>
    <tr id="choiceA" class="choice">
      <td class="td_bg" width="30%" align="center"><span class="TableRow2">A:</span></td>
      <td width="70%" class="td_bg" align="center">
        <textarea rows="3" cols="50" class="inputCSS" name="keyA"><%=question.getKeyA()==null?"":question.getKeyA().trim()%></textarea>
      </td>
    </tr>
    <tr id="choiceB" class="choice">
      <td class="td_bg" width="30%" align="center"><span class="TableRow2">B:</span></td>
      <td width="70%" class="td_bg" align="center">
        <textarea rows="3" cols="50" class="inputCSS" name="keyB"><%=question.getKeyB()==null?"":question.getKeyB().trim()%></textarea>
      </td>
    </tr>
    <tr id="choiceC" class="choice">
      <td class="td_bg" width="30%" align="center"><span class="TableRow2">C:</span></td>
      <td width="70%" class="td_bg" align="center">
        <textarea rows="3" cols="50" class="inputCSS" name="keyC"><%=question.getKeyC()==null?"":question.getKeyC().trim()%></textarea>
      </td>
    </tr>
    <tr id="choiceD" class="choice">
      <td class="td_bg" width="30%" align="center"><span class="TableRow2">D:</span></td>
      <td width="70%" class="td_bg" align="center">
        <textarea rows="3" cols="50" class="inputCSS"  name="keyD"><%=question.getKeyD()==null?"":question.getKeyD().trim()%></textarea>
      </td>
    </tr>
        <tr>
      <td class="td_bg" width="30%" align="center"><span class="TableRow2">参考答案</span></td>
      <td width="70%" class="td_bg" align="center">
        <div id="answer_sin" class="answer">
          <input type="radio" value="A" name="answer_sin"/>A&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="radio" value="B" name="answer_sin"/>B&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="radio" value="C" name="answer_sin"/>C&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="radio" value="D" name="answer_sin"/>D
        </div>
        <div id="answer_mul" class="answer">
          <input type="checkbox" value="A" name="answer_mul"/>A&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="checkbox" value="B" name="answer_mul"/>B&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="checkbox" value="C" name="answer_mul"/>C&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="checkbox" value="D" name="answer_mul"/>D
        </div>
        <div id="answer_judge" class="answer">
          <input type="radio" value="yes" name="answer_jud"/>是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="radio" value="no" name="answer_jud"/>不是
        </div>
        <div id="other" class="answer">
          <textarea rows="5" cols="80" class="inputCSS"  name="answer_other"><%=question.getAnswer()==null?"":question.getAnswer().trim()%></textarea>
        </div>
      </td>
    </tr>
    <tr>
      <td class="td_bg" colspan="2" align="center">
        <input type="button" value="修改" class="inputCSS" onclick="IsSubmit()"/>
        <input type="hidden" value="<%=question.getId()%>" name="hi_Qid"/>
      </td>
    </tr>
   </table>
   </form>
  </body>
</html>
