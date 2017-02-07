<%@ page language="java" import="java.util.*,com.xurui.dormain.*,com.xurui.util.*" pageEncoding="utf-8"%>
<%

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String Uid = (String)session.getAttribute("Uid");
UserUtil userUtil = new UserUtil();
User user = userUtil.getUser(Uid);
RecordUtil ru = new RecordUtil();

int pageSize = 5;
int current = 1;


int pageCount = 0;
String str_current = request.getParameter("page");
if(str_current!=null)
{
  current = Integer.parseInt(str_current);
}
int totalCount =ru.getTestcount(Uid);
pageCount = (totalCount%pageSize==0)?(totalCount/pageSize):(totalCount/pageSize+1);
ArrayList al = ru.getZhiDingYe(Uid,pageSize,current);
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
          window.location.href="<%=path%>/Record/showRecord1.jsp?page="+page.value;
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
     <table class="table" cellspacing="1" cellpadding="2" width="80%" align="center" 
      border="0">
    <tr>
      <th class="bg_tr" align="center" colspan="7" height="50"><%=user.getName()%>的个人成绩</th>
      <th class="bg_tr" align="center" height="50">查看详情</th>
    </tr>
    <tr>
      <td width="10%" class="td_bg" width="" height="50" align="center"><span class="TableRow2">科目</span></td>
      <td width="10%" class="td_bg" width="" height="50" align="center"><span class="TableRow2">考试时间</span></td>
      <td width="10%" class="td_bg" align="center">单选题（分）</td>
      <td width="10%" class="td_bg" align="center">多选题(分)</td>
      <td width="10%" class="td_bg" align="center">判断题(分)</td>
      <td width="15%" class="td_bg" align="center">简答题(分)</td>
      <td width="15%" class="td_bg" align="center">编程题(分)</td>
      <td width="15%" class="td_bg" align="center">总分</td>
    </tr>
    <%
      for(int i=0;i<al.size();i++)
      {
        Record record = (Record)al.get(i);
     %>
    <tr>
      <td class="td_bg" width="80" height="50" align="center"><span class="TableRow2"><%=record.getCourse()%></span></td>
      <td class="td_bg" align="center"><span class="TableRow2"><%=record.getTest_time()%></span></td> 
      <td class="td_bg" align="center"><%=record.getSingle()%></td>
      <td class="td_bg" align="center"><%=record.getMultiply()%></td>
      <td class="td_bg" align="center"><%=record.getJudge()%></td>
      <td class="td_bg" align="center"><%=record.getJd()%></td>
      <td class="td_bg" align="center"><%=record.getProgram()%></td>
      <td class="td_bg" align="center"><a href="/ExamOnline/Record/showTest.jsp?Uid=<%=Uid %>&name=<%=user.getName()  %>&course=<%=record.getCourse() %>&test_time=<%=record.getTest_time()%>"><%=record.getScore()%></a></td>
    </tr>
     <%
      }
      %></table>
 <div class="pages">
   <span style="margin-right:20px;">共<%=totalCount%>条记录,当前第<%=current%>页,共<%=totalCount!=0?pageCount:1%>页  </span>  
   <span id="first">
     <a href="<%=path%>/Record/showRecord1.jsp?page=1"><img src="<%=path%>/images/fist.gif" alt="首页"/></a>
     <a href="<%=path%>/Record/showRecord1.jsp?page=<%=current-1%>"><img src="<%=path%>/images/back.gif" alt="上一页"/></a>
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
        <a id="pageA<%=i%>" href="<%=path%>/Record/showRecord1.jsp?page=<%=i%>"><%=i%></a>
        <% 
        }if(endPage!=pageCount)
        {
          out.print("...");
        } 
        %>
    </span>
   <%if(totalCount!=0){ %> 
   <span id="end">
     <a href="<%=path%>/Record/showRecord1.jsp?page=<%=current+1%>"><img src="<%=path%>/images/last.gif" alt="下一页"/></a>
     <a href="<%=path%>/Record/showRecord1.jsp?page=<%=pageCount%>"><img src="<%=path%>/images/end.gif" alt="尾页"/></a>
   </span>
   <span style="margin-left:20px;"> 
     转到<input type="text" style="width:25px" id="page"/>页
    <input type="image" src="<%=path%>/images/go.gif" onclick="submit();"/>
   </span>
    <%} %>
 </div>
  </body>
</html>
