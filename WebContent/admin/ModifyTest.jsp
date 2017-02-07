<%@ page language="java" import="java.util.*,com.xurui.dormain.*,com.xurui.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String course = request.getParameter("course");
String test_time=request.getParameter("test_time");
TestSetUtil tsu = new TestSetUtil();
QuestionUtil qu = new QuestionUtil();
ArrayList ali = qu.getCourse();
TestSet ts = null;
if(course!=null && test_time!=null)
{
  course = new String(course.getBytes("iso8859-1"),"utf-8").trim();
  ts = tsu.getTestSet(course,test_time);
}else{
	//不选默认选中java课程
	course="java";
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>添加修改用户信息</title>
    <link type="text/css" rel="stylesheet" href="<%=path%>/css/public.css"/>
    <style>
      input{
       color:#1E5494;
       font-size:12px;
      }
      .course{
       color:#1E5494;
       font-size:12px;
      }
    </style>
    <script type="text/javascript" src="<%=path%>/js/judgeTestInput.js"></script>
    <script type="text/javascript">
      function setCourse()
      {
        var course = "<%=course%>";
        //alert(course);
        //不选默认选中java课程
        //if(course == "" ||course == "null" || course == undefined || course == null){
        //	course ="java";
        //}
        var tag_course = document.getElementsByName("course")[0];
        for(var i = 0;i < tag_course.options.length;i++)
        {
          //alert(tag_course.options[i].value==course);
          if(tag_course.options[i].value==course)
          {
            //alert("1111");
            tag_course.options[i].selected = true;
          }
        }
        calEachQuesTypeCount(course);
      }
      
      //获得对应课程每种类型题目的个数
      function  calEachQuesTypeCount(course){
    	//alert(course);
    	var  data;
  		var xmlhttp;
  		if (window.XMLHttpRequest)
  		{
  			//  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
  			xmlhttp=new XMLHttpRequest();
  		}
  		else
  		{
  			// IE6, IE5 浏览器执行代码
  			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
  		xmlhttp.onreadystatechange=function()
  		{
  			if (xmlhttp.readyState==4 && xmlhttp.status==200)
  			{
  				 data=xmlhttp.responseText;
  				 var msg=eval("("+data+")");//转换为json对象 
  				 
  				 //单选题
  				 var danxCount  =  msg.result.danx;
  				 if(danxCount == 0){
  					document.getElementById("danx").innerHTML ="<font color='red'>"+danxCount+"</font>";
  				 }else{
  					document.getElementById("danx").innerText =danxCount;
  				 }
  				 
  				 //多选题
  				 var duoxCount  =  msg.result.duox;
 				 if(duoxCount == 0){
 					document.getElementById("duox").innerHTML ="<font color='red'>"+duoxCount+"</font>";
 				 }else{
 					document.getElementById("duox").innerText =duoxCount;
 				 }
 				 
 				 //判断题
 				 var pandCount  =  msg.result.pand;
 				 if(pandCount == 0){
 					document.getElementById("pand").innerHTML ="<font color='red'>"+pandCount+"</font>";
 				 }else{
 					document.getElementById("pand").innerText =pandCount;
 				 }
 				 
 				 //简单题
 				var jiandCount  =  msg.result.jiand;
 				 if(jiandCount == 0){
 					document.getElementById("jiand").innerHTML ="<font color='red'>"+jiandCount+"</font>";
 				 }else{
 					document.getElementById("jiand").innerText =jiandCount;
 				 }
 				 
 				 //编程题
 				var biancCount  =  msg.result.bianc;
 				 if(biancCount == 0){
 					document.getElementById("bianc").innerHTML ="<font color='red'>"+biancCount+"</font>";
 				 }else{
 					document.getElementById("bianc").innerText =biancCount;
 				 }
  				 
  				 
  			}
  		}
  		xmlhttp.open("GET","calEachQuesTypeCount?course="+course,true);
  		xmlhttp.send();
       }
      
    </script>
  </head>
  
   <body onload="setCourse()">
    <form  action="<%=path%>/UpdateTestServlet" method="post">
     <table class="table" cellspacing="1" cellpadding="2" width="80%" align="center" border="0" style="margin-top:50px;">
    <tr>
      <th class="bg_tr" align="left" colspan="3" height="50"><span id="title"><%=ts==null?"添加考试设置信息":"修改考试设置信息"%></span></th>
    </tr>
    <tr>
      <td class="td_bg" width="30%" height="50" align="center"><span class="TableRow2">课程名</span></td>
      <td width="70%" class="td_bg" align="right" colspan="2" style="padding-right:125px;">
        <select name="course" class="course" onchange="calEachQuesTypeCount(this.value)">
          <%
            for(int i = 0;i<ali.size();i++)
            {
             String temp = (String)ali.get(i);
           %>
            <option value="<%=temp.trim()%>"><%=temp.trim()%></option>
           <%}%>
        </select>
      </td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center" rowspan="2"><span class="TableRow2">单选题(<span id="danx">0</span>)</span></td>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">数量(/题)</span></td>
      <td class="td_bg" align="center">
       <input type="text" name="singleCount" value="<%=ts==null?"10":ts.getSinChCount()%>"/>
      </td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">单个分值(/分)</span></td>
      <td class="td_bg" align="center" class="type">
        <input type="text" name="perSingle" value="<%=ts==null?"2":ts.getPerSinScore()%>"/>
      </td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center" rowspan="2"><span class="TableRow2">多选题(<span id="duox">0</span>)</span></td>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">数量(/题)</span></td>
      <td class="td_bg" align="center">
       <input type="text" name="multiplyCount" value="<%=ts==null?"10":ts.getMulChCount()%>"/>
      </td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">单个分值(/分)</span></td>
      <td class="td_bg" align="center" class="type">
         <input type="text" name="perMultiply" value="<%=ts==null?"3":ts.getPerMulScore()%>"/>
      </td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center" rowspan="2"><span class="TableRow2">判断题(<span id="pand">0</span>)</span></td>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">数量(/题)</span></td>
      <td class="td_bg" align="center">
       <input type="text" name="judgeCount" value="<%=ts==null?"5":ts.getJudgeCount()%>"/>
      </td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">单个分值(/分)</span></td>
      <td class="td_bg" align="center" class="type">
         <input type="text" name="perJudge" value="<%=ts==null?"2":ts.getPerJudScore()%>"/>
      </td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center" rowspan="2"><span class="TableRow2">简答题(<span id="jiand">0</span>)</span></td>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">数量(/题)</span></td>
      <td class="td_bg" align="center">
       <input type="text" name="jdCount" value="<%=ts==null?"5":ts.getJdCount()%>"/>
      </td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">单个分值(/分)</span></td>
      <td class="td_bg" align="center" class="type">
         <input type="text" name="perJd" value="<%=ts==null?"8":ts.getPerJdScore()%>"/>
      </td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center" rowspan="2"><span class="TableRow2">编程题(<span id="bianc">0</span>)</span></td>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">数量(/题)</span></td>
      <td class="td_bg" align="center">
       <input type="text" name="programCount" value="<%=ts==null?"0":ts.getProgramCount()%>"/>
      </td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">单个分值(/分)</span></td>
      <td class="td_bg" align="center" class="type">
         <input type="text" name="perProgram" value="<%=ts==null?"15":ts.getPerProScore()%>"/>
      </td>
    </tr>
    <tr>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">考试时间（/分钟）</span></td>
      <td class="td_bg" align="right" class="type" colspan="2" style="padding-right: 125px;">
         <input type="text" name="totalTime" value="<%=ts==null?"45":ts.getTotaltime()%>"/>
         <input type="hidden" name="test_time" value="<%=ts==null?"":ts.getTest_time()%>"/>
         
      </td>
    </tr>
    <tr>
     <td class="td_bg" height="50" align="center"><span class="TableRow2">操&nbsp;&nbsp;&nbsp;&nbsp;作：</span></td>
      <td class="td_bg" align="center" colspan="2">
        <input name="option" type="button" value="<%=ts==null?"添加":"修改" %>" style="color:#1E5494;font-size:12px;width:80px;" onclick="IsSubmit(this)"/>
        <input type="hidden" name="flag" value="<%=ts==null?"0":"1"%>"/>
      </td>
    </tr>
</table>
</form>
</body>
</html>
