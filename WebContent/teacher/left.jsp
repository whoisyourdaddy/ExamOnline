<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xurui.dormain.*" %>
<%@ page import="com.xurui.util.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String course=(String)session.getAttribute("course");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
<style type="text/css">
  a{
    text-decoration:none;
    color:#2f4867;
	}
  li{
  list-style-image:url("<%=path%>/images/list.gif");
  margin-top:5px;
  font-size:12px;
  }
  ul{
    margin-top:0px;
	display:none;
   }
  .first
  {
    background-image:url("<%=path%>/images/bk2.gif");
    background-repeat:no-repeat;
	padding-left:22px;
	height:23px;
	width:142px;
	margin-left:2px;
	margin-top:5px;
	padding-right:0px;
	line-height:23px;
	font-size:12px;
	color:#155a84;
	cursor:pointer;
  }
  .outer
  {
    width:166px;
	background-color:#FFFFFF;
	margin-left:2px;
	margin-top:5px;
	padding-top:5px;
	padding-right:0px;
  }
  body
  {
    background-color:#06a9f4;
    overflow-x:hidden;
    SCROLLBAR-FACE-COLOR: #59D6FF; 
	SCROLLBAR-HIGHLIGHT-COLOR: #ffffff; 
	SCROLLBAR-SHADOW-COLOR: #ffffff; 
	SCROLLBAR-3DLIGHT-COLOR: #007BC6; 
	SCROLLBAR-DARKSHADOW-COLOR: #007BC6; 
	SCROLLBAR-ARROW-COLOR: #007BC6;
	SCROLLBAR-TRACK-COLOR: #009ED2;
    
  }
  #submenu2,#submenu3
  {
    display:block;
  }
</style>
<script type="text/javascript">
  function show(showId)
  {
    var des = document.getElementById(showId);
	if(des.style.display=="block")
	{
	  des.style.display = "none";
	}else
	{
	  des.style.display="block";
	}
    
  }
  
  
</script>
</head>

<body>
<%
  ArrayList al = new ArrayList();
  TestUtil testUtil = new TestUtil();
  al = testUtil.getStudent(course);
  
 %>
 <div class="outer">
   <div class="first" onclick="show('submenu1')">查看/修改试卷</div>
    <ul id="submenu1">
	  	  	<li><a href="showName.jsp" target="right">查看/修改最新试卷</a></li>
	  
	  	   <!--  <li><a href="showT.jsp" target="right">查看/修改最新试卷</a></li> -->
	  </ul>
	 <%--  <ul id="">
	   <% 
	   if(al!=null)
	   {
	    for(int i = 0;i<al.size();i++)
	    {
	     User user =(User)al.get(i);
	    %>
	    <li><a href="showTest.jsp?Uid=<%=user.getId().trim()%>&name=<%=user.getName().trim()%>" target="right"><%=user.getName().trim()%></a></li>
		<%}} %>
	  </ul> --%>
   </div>
   <div class="outer">
     <div class="first"  onclick="show('submenu2')">分数段统计</div>
	  <ul id="submenu2">
	    <li><a href="showScore.jsp?score=pass" target="right">及格率</a></li>
	    <li><a href="showScore.jsp?score=60" target="right">60-69</a></li>
		<li><a href="showScore.jsp?score=70" target="right">70-79</a></li>
		<li><a href="showScore.jsp?score=80" target="right">80-89</a></li>
		<li><a href="showScore.jsp?score=90" target="right">90-100</a></li>
		<li><a href="tongji.jsp" target="right">分数统计</a></li>
	  </ul>
	</div>
    <div class="outer">
	  <div class="first"  onclick="show('submenu3')">个人信息维护</div>
	  <ul id="submenu3">
	    <li><a href="<%=path%>/modifyInfo.jsp" target="right">修改个人信息</a></li>
		<li><a href="<%=path%>/modifyPassword.jsp?type=2" target="right">修改密码</a></li>
	  </ul>
	</div>
	<div class="outer">
      <div class="first" onclick="show('submenu4')">安全退出</div>
      <ul id="submenu4">
        <li>
          <a href="javascript:window.open('login.jsp');window.parent.opener=null;window.parent.close();">安全退出</a>
        </li>
      </ul>
    </div>
  
</body>
</html>

