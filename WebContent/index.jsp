<%@page contentType="text/html; charset=utf-8"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>腾翔信息在线考试系统</title>
</head>
<body>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="771">
    <!-- fwtable fwsrc="index2.png" fwbase="index.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
    <tr>
      <td width="148"><img src="images/spacer.gif" width="148" height="1" border="0" alt=""></td>
      <td width="156"><img src="images/spacer.gif" width="156" height="1" border="0" alt=""></td>
      <td width="65"><img src="images/spacer.gif" width="65" height="1" border="0" alt=""></td>
      <td width="8"><img src="images/spacer.gif" width="8" height="1" border="0" alt=""></td>
      <td width="6"><img src="images/spacer.gif" width="6" height="1" border="0" alt=""></td>
      <td width="107"><img src="images/spacer.gif" width="107" height="1" border="0" alt=""></td>
      <td width="32"><img src="images/spacer.gif" width="32" height="1" border="0" alt=""></td>
      <td width="248"><img src="images/spacer.gif" width="248" height="1" border="0" alt=""></td>
      <td width="10"><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
    </tr>
    <tr>
      <td colspan="8" bgcolor="#FF9200">&nbsp;</td>
      <td><img src="images/spacer.gif" width="1" height="124" border="0" alt=""></td>
    </tr>
    <tr>
      <td bgcolor="#FF9200">&nbsp;</td>
      <td><img name="index_r2_c2" src="./images/index_r2_c2.gif" width="156" height="44" border="0" alt=""></td>
      <td colspan="6"><img name="index_r2_c3" src="./images/index_r2_c3.gif" width="466" height="44" border="0" alt=""></td>
      <td><img src="images/spacer.gif" width="1" height="44" border="0" alt=""></td>
    </tr>
    <tr>
      <td rowspan="2"><img name="index_r3_c1" src="./images/index_r3_c1.gif" width="148" height="88" border="0" alt=""></td>
      <td rowspan="2"><img name="index_r3_c2" src="./images/index_r3_c2.gif" width="156" height="88" border="0" alt=""></td>
      <td colspan="6"><img name="index_r3_c3" src="./images/index_r3_c3.gif" width="466" height="28" border="0" alt=""></td>
      <td><img src="./images/spacer.gif" width="1" height="28" border="0" alt=""></td>
    </tr>
    <tr>
      <td><img name="index_r4_c3" src="./images/index_r4_c3.gif" width="65" height="60" border="0" alt=""></td>
      <td colspan="5" background="./images/index_r4_c4.gif">&nbsp;</td>
      <td><img src="./images/spacer.gif" width="1" height="60" border="0" alt=""></td>
    </tr>
    <tr>
      <td bgcolor="#003366">&nbsp;</td>
      <td><img name="index_r5_c2" src="./images/index_r5_c2.gif" width="156" height="30" border="0" alt=""></td>
      <td rowspan="2" colspan="5"><a href="<%=path%>/student/login.jsp"><img name="index_r5_c3" src="./images/index_r5_c3.gif" width="218" height="57" border="0" alt=""></a></td>
      <td rowspan="2" bgcolor="#003366">&nbsp;</td>
      <td><img src="images/spacer.gif" width="1" height="30" border="0" alt=""></td>
    </tr>
    <tr>
      <td colspan="2" bgcolor="#003366">&nbsp;</td>
      <td><img src="images/spacer.gif" width="1" height="27" border="0" alt=""></td>
    </tr>
    <tr>
      <td colspan="2" rowspan="3" bgcolor="#003366">&nbsp;</td>
      <td colspan="4"><img name="index_r7_c3" src="./images/index_r7_c3.gif" width="186" height="56" border="0" alt=""></td>
      <td><img name="index_r7_c7" src="./images/index_r7_c7.gif" width="32" height="56" border="0" alt=""></td>
      <td><a href="<%=path%>/teacher/login.jsp"><img name="index_r7_c8" src="./images/index_r7_c8.gif" width="248" height="56" border="0" alt=""></a></td>
      <td><img src="images/spacer.gif" width="1" height="56" border="0" alt=""></td>
    </tr>
    <tr>
      <td colspan="5"><a href="<%=path%>/Record/login.jsp" ><img name="index_r8_c3" src="./images/index_r8_c3.gif" width="218" height="52" border="0" alt=""></a></td>
      <td><img name="index_r8_c8" src="./images/index_r8_c8.gif" width="248" height="52" border="0" alt=""></td>
      <td><img src="images/spacer.gif" width="1" height="52" border="0" alt=""></td>
    </tr>
    <tr>
      <td colspan="3" bgcolor="#003366"></td>
      <td colspan="3" bgcolor="#003366"></td>
      <td><img src="images/spacer.gif" width="1" height="45" border="0" alt=""></td>
    </tr>
    <!-- <tr>
      <td colspan="2"><img name="index_r10_c1" src="./images/index_r10_c1.gif" width="304" height="34" border="0" alt=""></td>
      <td colspan="3"><img name="index_r10_c3" src="./images/index_r10_c3.gif" width="79" height="34" border="0" alt=""></td>
      <td colspan="3" bgcolor="#003366" ><p align="right"><a href="qunti.htm"><img src="./images/qunti.gif" width="70" height="25" border="0" align="right"></a></p></td>
      <td><img src="images/spacer.gif" width="1" height="34" border="0" alt=""></td>
    </tr> -->
  </table>
</div>
  <%-- <jsp:include page="foot2.html"></jsp:include> --%>
  <%@ include file="foot2.html" %>
 
</body>
</html>
