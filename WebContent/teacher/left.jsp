<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xurui.dormain.*" %>
<%@ page import="com.xurui.util.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String course = (String)session.getAttribute("course");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>左侧菜单</title>
<link rel="stylesheet" href="<%=path%>/css/modern.css">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    background-color: #f0fdf4;
    min-height: 100vh;
}
.sidebar {
    width: 220px;
    background-color: white;
    min-height: 100vh;
    border-right: 1px solid #bbf7d0;
}
.menu-item {
    border-bottom: 1px solid #dcfce7;
}
.menu-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0.875rem 1.25rem;
    cursor: pointer;
    transition: all 0.2s;
    font-size: 0.9375rem;
    font-weight: 500;
    color: #166534;
}
.menu-header:hover {
    background-color: #f0fdf4;
    color: #059669;
}
.menu-header.active {
    background-color: #dcfce7;
    color: #059669;
    border-left: 3px solid #059669;
}
.menu-icon {
    font-size: 1.125rem;
    margin-right: 0.75rem;
}
.menu-arrow {
    font-size: 0.75rem;
    transition: transform 0.2s;
}
.menu-header.active .menu-arrow {
    transform: rotate(90deg);
}
.submenu {
    display: none;
    background-color: #f0fdf4;
    padding: 0.5rem 0;
}
.submenu.active {
    display: block;
}
.submenu a {
    display: block;
    padding: 0.625rem 1.25rem 0.625rem 3rem;
    color: #15803d;
    text-decoration: none;
    font-size: 0.875rem;
    transition: all 0.2s;
    border-left: 3px solid transparent;
}
.submenu a:hover {
    color: #059669;
    background-color: #dcfce7;
    border-left-color: #059669;
}
.course-info {
    padding: 1rem;
    background: linear-gradient(135deg, #059669, #10b981);
    color: white;
    text-align: center;
}
.course-info .label {
    font-size: 0.75rem;
    opacity: 0.9;
    margin-bottom: 0.25rem;
}
.course-info .value {
    font-size: 1rem;
    font-weight: 600;
}
.sidebar-footer {
    position: absolute;
    bottom: 0;
    width: 220px;
    padding: 1rem;
    background-color: white;
    border-top: 1px solid #bbf7d0;
}
.logout-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    padding: 0.625rem;
    color: #ef4444;
    text-decoration: none;
    font-size: 0.875rem;
    font-weight: 500;
    border-radius: 0.375rem;
    transition: all 0.2s;
}
.logout-btn:hover {
    background-color: #fef2f2;
}
</style>
<script type="text/javascript">
function toggleMenu(menuId) {
    var submenu = document.getElementById(menuId);
    var header = submenu.previousElementSibling;
    
    document.querySelectorAll('.submenu').forEach(function(el) {
        if(el.id !== menuId) {
            el.classList.remove('active');
            el.previousElementSibling.classList.remove('active');
        }
    });
    
    submenu.classList.toggle('active');
    header.classList.toggle('active');
}
</script>
</head>
<body>
<div class="sidebar">
    <div class="course-info">
        <div class="label">当前科目</div>
        <div class="value"><%=course != null ? course : "未选择"%></div>
    </div>

    <div class="menu-item">
        <div class="menu-header active" onclick="toggleMenu('submenu1')">
            <span><span class="menu-icon">📋</span>试卷管理</span>
            <span class="menu-arrow">▶</span>
        </div>
        <div class="submenu active" id="submenu1">
            <a href="showName.jsp" target="right">查看/批改试卷</a>
        </div>
    </div>
    
    <div class="menu-item">
        <div class="menu-header" onclick="toggleMenu('submenu2')">
            <span><span class="menu-icon">📊</span>成绩统计</span>
            <span class="menu-arrow">▶</span>
        </div>
        <div class="submenu" id="submenu2">
            <a href="showScore.jsp?score=pass" target="right">及格率统计</a>
            <a href="showScore.jsp?score=60" target="right">60-69分</a>
            <a href="showScore.jsp?score=70" target="right">70-79分</a>
            <a href="showScore.jsp?score=80" target="right">80-89分</a>
            <a href="showScore.jsp?score=90" target="right">90-100分</a>
            <a href="tongji.jsp" target="right">分数统计</a>
        </div>
    </div>
    
    <div class="menu-item">
        <div class="menu-header" onclick="toggleMenu('submenu3')">
            <span><span class="menu-icon">🔧</span>个人设置</span>
            <span class="menu-arrow">▶</span>
        </div>
        <div class="submenu" id="submenu3">
            <a href="<%=path%>/modifyInfo.jsp" target="right">修改信息</a>
            <a href="<%=path%>/modifyPassword.jsp?type=2" target="right">修改密码</a>
        </div>
    </div>
    
    <div class="sidebar-footer">
        <a href="javascript:window.parent.location.href='login.jsp';" class="logout-btn">
            <span>🚪</span>
            <span>退出登录</span>
        </a>
    </div>
</div>
</body>
</html>
