<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xurui.dormain.*" %>
<%@ page import="com.xurui.util.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
    background-color: #f8fafc;
    min-height: 100vh;
}
.sidebar {
    width: 220px;
    background-color: white;
    min-height: 100vh;
    border-right: 1px solid #e2e8f0;
}
.menu-item {
    border-bottom: 1px solid #f1f5f9;
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
    color: #475569;
}
.menu-header:hover {
    background-color: #f8fafc;
    color: #4f46e5;
}
.menu-header.active {
    background-color: #eef2ff;
    color: #4f46e5;
    border-left: 3px solid #4f46e5;
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
    background-color: #f8fafc;
    padding: 0.5rem 0;
}
.submenu.active {
    display: block;
}
.submenu a {
    display: block;
    padding: 0.625rem 1.25rem 0.625rem 3rem;
    color: #64748b;
    text-decoration: none;
    font-size: 0.875rem;
    transition: all 0.2s;
    border-left: 3px solid transparent;
}
.submenu a:hover {
    color: #4f46e5;
    background-color: #eef2ff;
    border-left-color: #4f46e5;
}
.sidebar-footer {
    position: absolute;
    bottom: 0;
    width: 220px;
    padding: 1rem;
    background-color: white;
    border-top: 1px solid #e2e8f0;
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
    
    // 关闭其他菜单
    document.querySelectorAll('.submenu').forEach(function(el) {
        if(el.id !== menuId) {
            el.classList.remove('active');
            el.previousElementSibling.classList.remove('active');
        }
    });
    
    // 切换当前菜单
    submenu.classList.toggle('active');
    header.classList.toggle('active');
}
</script>
</head>
<body>
<div class="sidebar">
    <div class="menu-item">
        <div class="menu-header active" onclick="toggleMenu('submenu1')">
            <span><span class="menu-icon">📝</span>试题管理</span>
            <span class="menu-arrow">▶</span>
        </div>
        <div class="submenu active" id="submenu1">
            <a href="ManageQuestion.jsp" target="right">试题列表</a>
            <a href="AddQuestion.jsp" target="right">添加试题</a>
            <a href="piLiangAddQuestion.jsp" target="right">批量导入</a>
        </div>
    </div>
    
    <div class="menu-item">
        <div class="menu-header" onclick="toggleMenu('submenu2')">
            <span><span class="menu-icon">⚙️</span>考试设置</span>
            <span class="menu-arrow">▶</span>
        </div>
        <div class="submenu" id="submenu2">
            <a href="ManageTest.jsp" target="right">考试安排</a>
        </div>
    </div>
    
    <div class="menu-item">
        <div class="menu-header" onclick="toggleMenu('submenu3')">
            <span><span class="menu-icon">👥</span>用户管理</span>
            <span class="menu-arrow">▶</span>
        </div>
        <div class="submenu" id="submenu3">
            <a href="ManageUser.jsp" target="right">用户列表</a>
        </div>
    </div>
    
    <div class="menu-item">
        <div class="menu-header" onclick="toggleMenu('submenu4')">
            <span><span class="menu-icon">🔧</span>个人设置</span>
            <span class="menu-arrow">▶</span>
        </div>
        <div class="submenu" id="submenu4">
            <a href="<%=path%>/modifyInfo.jsp" target="right">修改信息</a>
            <a href="<%=path%>/modifyPassword.jsp?type=3" target="right">修改密码</a>
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
