<%@ page language="java" import="java.util.*,com.xurui.dormain.*,com.xurui.util.*" pageEncoding="utf-8"%>
<%

TestUtil testUtil = new TestUtil();

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String course=(String)session.getAttribute("course");
RecordUtil ru = new RecordUtil();
int pageSize = 5;
int current = 1;


int pageCount = 0;
String str_current = request.getParameter("page");
if(str_current!=null)
{
  current = Integer.parseInt(str_current);
}
int totalCount =ru.getScoresC(course);
pageCount = (totalCount%pageSize==0)?(totalCount/pageSize):(totalCount/pageSize+1);
ArrayList al =ru.getScores(course,pageSize,current);
if(al!=null)
{
 
/* ArrayList al = userUtil.getAllUser(pageSize,current); */

   	  
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>用户管理</title>
     <link rel="stylesheet" href="./css/public.css" type="text/css"/>
     <style type="text/css">
       .bg_tr{
         height:22px;
         line-height:22px;
         text-align:center;
       }
       .td_bg{
          height:22px;
          line-height:22px;
          text-align: center;
       }
       .table
       {
         margin-top:50px;
       }
       .pages{
        color:#1E5494;
	    font-size:14px;
        line-height: 22px;
        text-align: center;
        margin-top:20px;
       }
       img{
         margin-left:5px;
         margin-top:0px;
         border:0px;
       }
        a{
         text-decoration: none;
          color:#1E5494;
       }
       a:HOVER {
	      color:green;
	      text-decoration: underline;
         }
     </style>
     <script type="text/javascript">
       function submit()
       {
         var pageCount = <%=pageCount%>;
         var page = document.getElementById("page");
         if(page.value=="")
         {
           alert("请输入要查询页数！");
         }else if(isNaN(page.value))
         {
           alert("你输入的不是合法数字!");
         }else if(parseInt(page.value)>pageCount)
         {
           alert("输入页数大于总页数，请重新输入！");
         }else if(parseInt(page.value)<1)
         {
           alert("输入页数不能小于1！");
         }
         else
         {
          window.location.href="<%=path%>/teacher/tongji.jsp?page="+page.value;
         }
       }
       function judge()
       {
         var current=<%=current%>;
         var pageCount=<%=pageCount%>;
         if(current==1)
         {
           document.getElementById("first").style.display="none";
         }
         if(current==pageCount)
         {
           document.getElementById("end").style.display="none";
         }
         var currentA = document.getElementById("pageA"+current);
         currentA.style.color="red";
       }
     
     </script>
  </head>
  
  <body onload="judge()">
   <body>
   <table class="table"  width="80%" align="center"   border="0">
    <tr>
      <th class="bg_tr" align="center" colspan="9" height="50"><%=course%>考试情况统计表</th>
    </tr>
    <tr>
     
      <td class="td_bg" height="50" align="center"><span class="TableRow2">考试时间</span></td>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">课程</span></td>
       <td class="td_bg" height="50" align="center"><span class="TableRow2">考生人数</span></td>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">及格人数</span></td>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">不及格人数</span></td>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">60-70</span></td>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">70-80</span></td>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">80-90</span></td>
      <td class="td_bg" height="50" align="center"><span class="TableRow2">90-100</span></td>
    
    </tr>
    <tr>  
      <%for(int i = 0;i<al.size();i++)
	    {
	    	Scores scores =(Scores)al.get(i); %>
     
      <td  class="td_bg" align="center"><strong><%=scores.getTest_time().trim()%><br /></strong></td>
      <td  class="td_bg" align="center"><strong><%=scores.getCourse().trim()%><br /></strong></td>
      <td  class="td_bg" align="center"><strong><%=scores.getCount()%></strong></td>
      <td  class="td_bg" align="center"><strong><%=scores.getYessix()%><br /></strong></td>
      <td  class="td_bg" align="center"><strong><%=scores.getNosix()%><br /></strong></td>
      <td  class="td_bg" align="center"><strong><%=scores.getSix()%><br /></strong></td>
      <td  class="td_bg" align="center"><strong><%=scores.getSeven()%><br /></strong></td>
      <td  class="td_bg" align="center"><strong><%=scores.getSeven()%><br /></strong></td>
      <td  class="td_bg" align="center"><strong><%=scores.getNine()%></strong></td>
    </tr>
   <% }
	   } %> 
</table>
 <div class="pages">
   <span style="margin-right:20px;">共<%=totalCount%>条记录,当前第<%=current%>页,共<%=totalCount!=0?pageCount:1%>页  </span>  
   <span id="first">
     <a href="<%=path%>/teacher/tongji.jsp?page=1"><img src="<%=path%>/images/fist.gif" alt="首页"/></a>
     <a href="<%=path%>/teacher/tongji.jsp?page=<%=current-1%>"><img src="<%=path%>/images/back.gif" alt="上一页"/></a>
    </span>
     <span>
    <%
      int startPage = 1;
      int endPage = 1;
      if(pageCount<=5)
      {
        startPage = 1;
        endPage = pageCount;
      }else if(current+4<=pageCount)
      {
        startPage = current;
        endPage = current+4;
      }else
      {
        startPage = pageCount-4;
        endPage = pageCount;
      }
      if(startPage!=1)
      {
        out.print("...");
       }for(int i = startPage;i<=endPage;i++)
       {
      %>
        <a id="pageA<%=i%>" href="<%=path%>/teacher/tongji.jsp?page=<%=i%>"><%=i%></a>
        <% 
        }if(endPage!=pageCount)
        {
          out.print("...");
        } 
        %>
    </span>
    <%if(totalCount!=0){ %>
    <span id="end">
     <a href="<%=path%>/teacher/tongji.jsp?page=<%=current+1%>"><img src="<%=path%>/images/last.gif" alt="下一页"/></a>
     <a href="<%=path%>/teacher/tongji.jsp?page=<%=pageCount%>"><img src="<%=path%>/images/end.gif" alt="尾页"/></a>
   </span>
   <span style="margin-left:20px;"> 
     转到<input type="text" style="width:25px" id="page"/>页
    <input type="image" src="<%=path%>/images/go.gif" onclick="submit();"/>
   </span>
   <%} %>
 </div>
  </body>
</html>
