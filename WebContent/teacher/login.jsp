<%@page contentType="text/html; charset=utf-8"%>
<%@ page import="com.xurui.dormain.*,com.xurui.util.*,java.util.*"%>
<%
  String path = request.getContextPath();
  TestSetUtil tsu = new TestSetUtil();
  ArrayList al = tsu.getCourse();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>教师登录 - 在线考试系统</title>
<link rel="stylesheet" href="<%=path%>/css/modern.css">
<script language="JavaScript">
    function submitForm() {
        var userName = document.forms[0].UserName.value;
        var password = document.forms[0].Password.value;
        var course = document.forms[0].course.value;
        if(userName == "") {
            alert("请输入教师号!");
            return false;
        } else if(password == "") {
            alert("请输入密码!");
            return false;
        } else if(course == "0") {
            alert("请选择科目!");
            return false;
        }
        return true;
    }
</script>
</head>
<body class="login-page">
    <div class="login-container">
        <div class="login-header">
            <h2>教师登录</h2>
            <p>在线考试系统 Teacher Login</p>
        </div>
        <div class="login-body">
            <form name="loginForm" action="<%=path%>/TeacherLoginServlet" method="post" onsubmit="return submitForm()">
                <div class="form-group">
                    <label class="form-label">教师号</label>
                    <input type="text" name="UserName" class="form-input" placeholder="请输入教师号" autofocus>
                </div>
                <div class="form-group">
                    <label class="form-label">密码</label>
                    <input type="password" name="Password" class="form-input" placeholder="请输入密码">
                </div>
                <div class="form-group">
                    <label class="form-label">科目</label>
                    <select name="course" class="form-select">
                        <option value="0">请选择科目</option>
                        <% for(int i=0; i<al.size(); i++) {
                            String course = (String)al.get(i);
                        %>
                        <option value="<%=course%>"><%=course%></option>
                        <% } %>
                    </select>
                </div>
                <button type="submit" class="btn btn-success" style="width: 100%; padding: 0.875rem;">
                    登录
                </button>
            </form>
        </div>
        <div class="login-footer">
            <a href="<%=path%>/index.jsp">← 返回首页</a>
        </div>
    </div>

    <%
        String flag = request.getParameter("flag");
        if(flag != null && flag.equals("error")) {
    %>
    <script type="text/javascript">
        alert("用户名或密码错误!");
    </script>
    <% } %>
</body>
</html>
