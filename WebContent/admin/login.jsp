<%@page contentType="text/html; charset=utf-8"%>
<%
  String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>管理员登录 - 在线考试系统</title>
<link rel="stylesheet" href="<%=path%>/css/modern.css">
<script language="JavaScript">
    function createCaptcha() {
        var str = getRandom();
        document.getElementById("validate").value = str;
    }

    function getRandom() {
        var i = 65 + Math.round(Math.random() * 25);
        var j = 97 + Math.round(Math.random() * 25);
        var k = 48 + Math.round(Math.random() * 9);
        var l = 65 + Math.round(Math.random() * 25);
        var str = String.fromCharCode(i, j, k, l);
        return str;
    }

    function submitForm() {
        var userName = document.forms[0].UserName.value;
        var password = document.forms[0].Password.value;
        var validate1 = document.forms[0].validate1.value;
        var validate = document.forms[0].validate.value;
        if(userName == "") {
            alert("请输入用户名!");
            document.forms[0].UserName.focus();
            return false;
        } else if(password == "") {
            alert("请输入密码!");
            document.forms[0].Password.focus();
            return false;
        } else if(validate1.toLowerCase() != validate.toLowerCase()) {
            alert("验证码输入错误!");
            document.forms[0].validate1.focus();
            return false;
        }
        return true;
    }
</script>
</head>
<body class="login-page" onload="createCaptcha()">
    <div class="login-container">
        <div class="login-header">
            <h2>管理员登录</h2>
            <p>在线考试系统 Admin Login</p>
        </div>
        <div class="login-body">
            <form name="loginForm" action="<%=path%>/AdminLoginServlet" method="post" onsubmit="return submitForm()">
                <div class="form-group">
                    <label class="form-label">用户名</label>
                    <input type="text" name="UserName" class="form-input" placeholder="请输入用户名" autofocus>
                </div>
                <div class="form-group">
                    <label class="form-label">密码</label>
                    <input type="password" name="Password" class="form-input" placeholder="请输入密码">
                </div>
                <div class="form-group">
                    <label class="form-label">验证码</label>
                    <div class="captcha-box">
                        <input type="text" name="validate1" class="form-input" placeholder="输入验证码" style="flex: 1;">
                        <input type="text" name="validate" id="validate" class="captcha-code" readonly onclick="createCaptcha()" title="点击刷新">
                    </div>
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
