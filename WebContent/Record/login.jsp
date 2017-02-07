<%@page contentType="text/html; charset=utf-8"%>
<html>

<head>
  <title>在线考试系统-用户登陆</title>
  <link href="../images/css1.css" type="text/css" rel="stylesheet"/>
  <link href="../images/newhead.css" type="text/css" rel="stylesheet"/>
  <style type="text/css">
    #validate{
      color:black;
      font-style:italic;
      font-weight:bold;
      font-size:16px;
      letter-spacing:3px;
      text-align:center;
      border:0px;
      background-image: url("../images/validate.jpg");
     }
  </style>
  <script language="JavaScript">
      function submit() {
        var userName = document.forms[0].UserName;
        var password = document.forms[0].Password;
        var validate1 = document.forms[0].validate1;
        var validate = document.forms[0].validate;
        if(userName.value=="")
        {
          alert("请输入学号!");
          userName.focus();
        }
        else if(password.value=="")
        {
          alert("请输入密码!");
          password.focus();
        }else if(validate1.value.toLowerCase()!=validate.value.toLowerCase())
        {
          alert("验证码输入不对!");
          validate1.focus();
        }
        else
        document.forms[0].submit();
      }
       function create()
       {
         var str=getRandom();
         //alert(str);
         document.getElementById("validate").value=str;
       }
       function getRandom()
       {
         var i=65+Math.round(Math.random()*25);
         var j=97+Math.round(Math.random()*25);
         var k=48+Math.round(Math.random()*9);
         var l=65+Math.round(Math.random()*25);
         var str = String.fromCharCode(i,j,k,l);
         return str;
       }
      
  </script>
</head>
<body bgColor="#eef8e0" leftMargin="0" topMargin="0" MARGINWIDTH="0" MARGINHEIGHT="0" onload="create()">
  
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
           <form name="adminlogin" action="<%=request.getContextPath()%>/RecordQueryServlet" method="post">
            <table id="table2" cellSpacing="1" cellPadding="0" width="100%"  border="0">
            <tbody>
              <tr>
                <td align="middle" width="81"><font color="#ffffff">学 号：</font></td>
                <td><input class="regtxt" type="text" name="UserName" id="UserName"/></td>
              </tr>
              <tr>
                <td align="middle" width="81"><font color="#ffffff">密 码：</font></td>
                <td><input class="regtxt" type="password" name="Password" id="Password"/></td>
              </tr>
              <tr>
                <td align="middle" width="81"><font color="#ffffff">验证码</font></td>
                <td>
				  <input type="text" id="validate1" style="width:80px;"/>&nbsp;&nbsp;
				  <input type="text" id="validate" style="width:80px;" readonly="readonly"/>	
				  <a href="javascript:create();" style="color:blue;">换一张</a>		
				 </td>
               </tr>
               <tr>
                <td align="middle" colspan="2">
                	<a href="ModifyUser.jsp">还没账号？立即注册</a>					
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
