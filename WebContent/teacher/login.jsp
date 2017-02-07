<%@page contentType="text/html; charset=utf-8"%>
<%@ page import="com.xurui.dormain.*,com.xurui.util.*,java.util.*"%>
<html>

<head>
  <title>在线考试系统-教师登陆</title>
  <link href="../images/css1.css" type="text/css" rel="stylesheet"/>
  <link href="../images/newhead.css" type="text/css" rel="stylesheet"/>
  <%
     String path = request.getContextPath();
     TestSetUtil tsu = new TestSetUtil();
     ArrayList al = tsu.getCourse();
   %>
  
  <script language="JavaScript">
      function submit() {
        var userName = document.forms[0].UserName.value;
        var password = document.forms[0].Password.value;
         var course = document.forms[0].course.value;
        if(userName=="")
        {
          alert("请输入教师号!");
        }
        else if(password=="")
        {
          alert("请输入密码!");
        }else if(course=="0")
        {
          alert("请选择科目!");
        }
        else
        document.forms[0].submit();
      }
  </script>
</head>
<body bgColor="#eef8e0" leftMargin="0" topMargin="0" MARGINWIDTH="0" MARGINHEIGHT="0">
  
  <TABLE cellSpacing=0 cellPadding=0 width=1004 border=0>
  <TBODY>
  <TR>
    <TD colSpan=6><IMG height=92 alt="" src="../images/crm_1.gif" 
    width=345></TD>
    <TD colSpan=4><IMG height=92 alt="" src="../images/crm_2.gif" 
    width=452></TD>
    <TD><IMG height=92 alt="" src="../images/crm_3.gif" width=207></TD></TR>
  <TR>
    <TD colSpan=6><IMG height=98 alt="" src="../images/crm_4.gif" 
    width=345></TD>
    <TD colSpan=4><IMG height=98 alt="" src="../images/crm_5.gif" 
    width=452></TD>
    <TD><IMG height=98 alt="" src="../images/crm_6.gif" width=207></TD></TR>
  <TR>
    <TD rowSpan=5><IMG height=370 alt="" src="../images/crm_7.gif" 
    width=59></TD>
    <TD colSpan=5><IMG height=80 alt="" src="../images/crm_8.gif" 
    width=286></TD>
    <TD colSpan=4><IMG height=80 alt="" src="../images/crm_9.gif" 
    width=452></TD>
    <TD><IMG height=80 alt="" src="../images/crm_10.gif" width=207></TD></TR>
  <TR>
    <TD><IMG height=110 alt="" src="../images/crm_11.gif" width=127></TD>
    <TD background=../images/crm_12.gif colSpan=6>
      <TABLE id=table1 cellSpacing=0 cellPadding=0 width="98%" border=0>
        <TBODY>
        <TR>
          <TD>
           <form name="adminlogin" action="<%=path%>/TeacherLoginServlet" method="post">
            <table id="table2" cellSpacing="1" cellPadding="0" width="100%"  border="0">
            <tbody>
              <tr>
                <td align="middle" width="81"><font color="#ffffff">教师号：</font></td>
                <td><input class="regtxt" type="text" name="UserName" id="UserName"/></td>
              </tr>
              <tr>
                <td align="middle" width="81"><font color="#ffffff">密&nbsp;&nbsp;&nbsp;&nbsp;码：</font></td>
                <td><input class="regtxt" type="password" name="Password" id="Password"/></td>
              </tr>
              <tr>
                <td align="middle" width="81"><font color="#ffffff">科&nbsp;&nbsp;&nbsp;&nbsp;目： </font></td>
                <td>
				  <select name="course">
				    <option value="0">请选择</option>
					<%
					  for(int i=0;i<al.size();i++)
					  {
					    String course = (String)al.get(i);
					 %>
					  <option value="<%=course%>"><%=course%></option>
					 <%}%>
				  </select>				
				 </td>
               </tr>
              </tbody>
              </table>
              </form>
              </TD></TR></TBODY></TABLE>
			  </TD>
    <TD colSpan=2 rowSpan=2><IMG height=158 alt="" 
      src="../images/crm_13.gif" width=295></TD>
    <TD rowSpan=2><IMG height=158 alt="" src="../images/crm_14.gif" 
      width=207></TD></TR>
  <TR>
    <TD rowSpan=3><IMG height=180 alt="" src="../images/crm_15.gif" 
      width=127></TD>
    <TD rowSpan=3><IMG height=180 alt="" src="../images/crm_16.gif" 
    width=24></TD>
    <TD>
      <INPUT title="登录" type="image" height="48" alt="" width="86" src="../images/crm_17.gif" name="imagesubmit" onclick="submit()"></TD>
    <TD><IMG height=48 alt="" src="../images/crm_18.gif" width=21></TD>
    <TD colSpan=2><a href="../index.jsp"><img title="返回首页" height="48" alt="" src="../images/crm_19.gif" width=84 border="0"></a></TD>
    <TD><IMG height=48 alt="" src="../images/crm_20.gif" width=101></TD></TR>
  <TR>
    <TD colSpan=5 rowSpan=2><IMG height=132 alt="" 
      src="../images/crm_21.gif" width=292></TD>
    <TD rowSpan=2><IMG height=132 alt="" src="../images/crm_22.gif" 
      width=170></TD>
    <TD colSpan=2><IMG height=75 alt="" src="../images/crm_23.gif" 
    width=332></TD></TR>
  <TR>
    <TD colSpan=2><IMG height=57 alt="" src="../images/crm_24.gif" 
    width=332></TD></TR>
  <TR>
    <TD><IMG height=1 alt="" src="../images/spacer.gif" width=59></TD>
    <TD><IMG height=1 alt="" src="../images/spacer.gif" width=127></TD>
    <TD><IMG height=1 alt="" src="../images/spacer.gif" width=24></TD>
    <TD><IMG height=1 alt="" src="../images/spacer.gif" width=86></TD>
    <TD><IMG height=1 alt="" src="../images/spacer.gif" width=21></TD>
    <TD><IMG height=1 alt="" src="../images/spacer.gif" width=28></TD>
    <TD><IMG height=1 alt="" src="../images/spacer.gif" width=56></TD>
    <TD><IMG height=1 alt="" src="../images/spacer.gif" width=101></TD>
    <TD><IMG height=1 alt="" src="../images/spacer.gif" width=170></TD>
    <TD><IMG height=1 alt="" src="../images/spacer.gif" width=125></TD>
    <TD><IMG height=1 alt="" src="../images/spacer.gif" 
  width=207></TD></TR></TBODY></TABLE>
  <%
     String flag = request.getParameter("flag");
     if(flag!=null&&flag.equals("error"))
     {
  %>
  <script type="text/javascript">
    alert("用户名或密码错误!");
  </script>
  <%}%>
</body>
</html>
