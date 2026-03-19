<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xurui.dormain.*" %>
<%@ page import="com.xurui.util.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String Uid = (String)session.getAttribute("Uid");
UserUtil userUtil = new UserUtil();
User user = userUtil.getUser(Uid);
String name = user != null ? user.getName() : "教师";
session.setAttribute("name", name);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>顶部导航</title>
<link rel="stylesheet" href="<%=path%>/css/modern.css">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    background: linear-gradient(135deg, #059669 0%, #10b981 100%);
    height: 60px;
    overflow: hidden;
}
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 60px;
    padding: 0 1.5rem;
    color: white;
}
.header-left {
    display: flex;
    align-items: center;
    gap: 1rem;
}
.logo {
    font-size: 1.25rem;
    font-weight: 700;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}
.logo-icon {
    width: 32px;
    height: 32px;
    background: rgba(255,255,255,0.2);
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.125rem;
}
.header-right {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    font-size: 0.875rem;
}
.time-display {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    background: rgba(255,255,255,0.15);
    padding: 0.375rem 0.875rem;
    border-radius: 20px;
}
.user-info {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}
.user-avatar {
    width: 32px;
    height: 32px;
    background: rgba(255,255,255,0.2);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
}
</style>
<script type="text/javascript">
function showTime() {
    var time = new Date();
    var timeString = time.toLocaleString('zh-CN', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
    });
    document.getElementById("timeSpan").innerHTML = timeString;
}
</script>
</head>
<body onload="setInterval(showTime, 1000)">
<div class="header">
    <div class="header-left">
        <div class="logo">
            <div class="logo-icon">📚</div>
            <span>在线考试系统</span>
        </div>
        <span style="opacity: 0.7; font-size: 0.875rem;">|</span>
        <span style="font-size: 0.9375rem; font-weight: 500;">教师平台</span>
    </div>
    <div class="header-right">
        <div class="time-display">
            <span>🕐</span>
            <span id="timeSpan">--</span>
        </div>
        <div class="user-info">
            <div class="user-avatar">👨‍🏫</div>
            <span>您好，<%=name%> 老师</span>
        </div>
    </div>
</div>
</body>
</html>
