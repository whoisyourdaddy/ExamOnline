<%@ page language="java" import="java.util.*,com.xurui.dormain.*,com.xurui.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
TestSetUtil tsu = new TestSetUtil();
int pageSize = 5;
int totalCount = tsu.getCount();
int current = 1;
int pageCount = 0;
String str_current = request.getParameter("page");
if(str_current!=null)
{
  current = Integer.parseInt(str_current);
}
pageCount = (totalCount%pageSize==0)?(totalCount/pageSize):(totalCount/pageSize+1);

ArrayList al = tsu.getAllTestSet(pageSize,current);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>考试设置管理</title>
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
           alert(" 你输入的不是合法数字!");
         }else if(parseInt(page.value)>pageCount)
         {
           alert("输入页数大于总页数，请重新输入！");
         }else if(parseInt(page.value)<1)
         {
           alert("输入页数不能小于1！");
         }
         else
         {
           window.location.href="<%=path%>/admin/ManageTest.jsp?page="+page.value;
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
       function IsDelete(course,test_time)
       {
         var okey = confirm("确认删除？");
         if(okey==true)
         { 
           window.location.href="<%=path%>/admin/DeleteTest.jsp?course="+course+"&test_time="+test_time;
         }
       }
     </script>
  </head>
  
  <body onload="judge()">
   <body>
     <table class="table" cellspacing="1" cellpadding="2" align="center" border="0">
    <tr>
      <td class="bg_tr" rowspan="2">课程名</td>
      <td class="bg_tr" colspan="2">单选题</td>
      <td class="bg_tr" colspan="2">多选题</td>
      <td class="bg_tr" colspan="2">判断题</td>
      <td class="bg_tr" colspan="2">简答题</td>
      <td class="bg_tr" colspan="2">编程题</td>
      <td class="bg_tr" rowspan="2">总分(/分)</td>
      <td class="bg_tr" rowspan="2">考试时间(/分钟)</td>
      <td class="bg_tr" rowspan="2">考试日期</td>
      <td class="bg_tr" rowspan="2">操作</td>
    </tr>
    <tr>
      <td class="td_bg">数量(/题)</td>
      <td class="td_bg">单个分值(/分)</td>
      <td class="td_bg">数量(/题)</td>
      <td class="td_bg">单个分值(/分)</td>
      <td class="td_bg">数量(/题)</td>
      <td class="td_bg">单个分值(/分)</td>
      <td class="td_bg">数量(/题)</td>
      <td class="td_bg">单个分值(/分)</td>
      <td class="td_bg">数量(/题)</td>
      <td class="td_bg">单个分值(/分)</td>
    </tr>
    <% 
      for(int i=0;i < al.size();i++)
      {
        TestSet ts = (TestSet)al.get(i);
        int totalScore = tsu.getTotalScore(ts);
 
    %>
    <tr>
      <td class="td_bg"><%=ts.getCourse()%></td>
      <td class="td_bg"><%=ts.getSinChCount()%></td>
      <td class="td_bg"><%=ts.getPerSinScore()%></td>
      <td class="td_bg"><%=ts.getMulChCount()%></td>
      <td class="td_bg"><%=ts.getPerMulScore()%></td>
      <td class="td_bg"><%=ts.getJudgeCount()%></td>
      <td class="td_bg"><%=ts.getPerJudScore()%></td>
      <td class="td_bg"><%=ts.getJdCount()%></td>
      <td class="td_bg"><%=ts.getPerJdScore()%></td>
      <td class="td_bg"><%=ts.getProgramCount()%></td>
      <td class="td_bg"><%=ts.getPerProScore()%></td>
      <td class="td_bg"><%=totalScore%></td>
       <td class="td_bg"><%=ts.getTotaltime()%></td>
       <td class="td_bg"><%=ts.getTest_time()%></td>
      <td class="td_bg">
        <a href="<%=path%>/admin/ModifyTest.jsp?course=<%=ts.getCourse()%>&test_time=<%=ts.getTest_time()%>"><img src="<%=path%>/images/edit.gif" alt="编辑"/></a>
        <input type="image" src="<%=path%>/images/delete.gif" onclick="IsDelete('<%=ts.getCourse()%>','<%=ts.getTest_time()%>')" />
      </td>
    </tr>
 <%}%>
</table>
 <div class="pages">
   <span style="margin-right:20px;"><a href="<%=path%>/admin/ModifyTest.jsp">添加信息<img src="<%=path%>/images/add.png" alt="添加信息"/></a></span>
   <span style="margin-right:20px;">共<%=totalCount%>条记录,当前第<%=current%>页,共<%=totalCount!=0?pageCount:1%>页  </span>  
   <span id="first">
     <a href="<%=path%>/admin/ManageTest.jsp?page=1"><img src="<%=path%>/images/fist.gif" alt="首页"/></a>
     <a href="<%=path%>/admin/ManageTest.jsp?page=<%=current-1%>"><img src="<%=path%>/images/back.gif" alt="上一页"/></a>
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
        <a id="pageA<%=i%>" href="<%=path%>/admin/ManageTest.jsp?page=<%=i%>"><%=i%></a>
        <% 
        }if(endPage!=pageCount)
        {
          out.print("...");
        } 
        %>
    </span>
      <%if(totalCount!=0){ %>
   <span id="end">
     <a href="<%=path%>/admin/ManageTest.jsp?page=<%=current+1%>"><img src="<%=path%>/images/last.gif" alt="下一页"/></a>
     <a href="<%=path%>/admin/ManageTest.jsp?page=<%=pageCount%>"><img src="<%=path%>/images/end.gif" alt="尾页"/></a>
   </span>
   <span style="margin-left:20px;"> 
     转到<input type="text" style="width:25px" id="page"/>页
    <input type="image" src="<%=path%>/images/go.gif" onclick="submit();"/>
   </span>
 </div>
 <%} %>
  </body>
</html>
