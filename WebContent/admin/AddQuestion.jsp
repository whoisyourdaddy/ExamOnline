<%@ page language="java" import="java.util.*,com.xurui.dormain.*,com.xurui.util.*,java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
QuestionUtil qu = new QuestionUtil();
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
  </head>
  <body style="padding-top:50px;" onload="init()">
  <form action="<%=path%>/AddQuesServlet" method="post">
    <table class="table" cellspacing="1" cellpadding="2" width="100%" align="center" border="0">
    <tr>
      <th class="bg_tr" align="left" colspan="2" height="50">添加试题</th>
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
        <textarea rows="5" cols="80" class="inputCSS" onfocus="edit(this)" name="ques">==添加试题==</textarea>
      </td>
    </tr>
    <tr id="choiceA" class="choice">
      <td class="td_bg" width="30%" align="center"><span class="TableRow2">A:</span></td>
      <td width="70%" class="td_bg" align="center">
        <textarea rows="3" cols="50" class="inputCSS" onfocus="edit(this)" name="keyA">==选项A==</textarea>
      </td>
    </tr>
    <tr id="choiceB" class="choice">
      <td class="td_bg" width="30%" align="center"><span class="TableRow2">B:</span></td>
      <td width="70%" class="td_bg" align="center">
        <textarea rows="3" cols="50" class="inputCSS" onfocus="edit(this)" name="keyB">==选项B==</textarea>
      </td>
    </tr>
    <tr id="choiceC" class="choice">
      <td class="td_bg" width="30%" align="center"><span class="TableRow2">C:</span></td>
      <td width="70%" class="td_bg" align="center">
        <textarea rows="3" cols="50" class="inputCSS" onfocus="edit(this)" name="keyC">==选项C==</textarea>
      </td>
    </tr>
    <tr id="choiceD" class="choice">
      <td class="td_bg" width="30%" align="center"><span class="TableRow2">D:</span></td>
      <td width="70%" class="td_bg" align="center">
        <textarea rows="3" cols="50" class="inputCSS" onfocus="edit(this)" name="keyD">==选项D==</textarea>
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
          <textarea rows="5" cols="80" class="inputCSS" onfocus="edit(this)" name="answer_other">==添加参考答案==</textarea>
        </div>
      </td>
    </tr>
    <tr>
      <td class="td_bg" colspan="2" align="center"><input type="button" value="添加" class="inputCSS" onclick="IsSubmit()"/></td>
    </tr>
   </table>
   </form>
  </body>
</html>