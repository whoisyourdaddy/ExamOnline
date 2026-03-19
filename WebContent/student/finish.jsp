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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>考试完成</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 2rem;
}
.finish-container {
    background: white;
    padding: 3rem;
    border-radius: 1rem;
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
    text-align: center;
    max-width: 500px;
    width: 100%;
}
.finish-icon {
    width: 100px;
    height: 100px;
    background: linear-gradient(135deg, #10b981, #059669);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 1.5rem;
    font-size: 3rem;
    animation: scaleIn 0.5s ease;
}
@keyframes scaleIn {
    0% { transform: scale(0); }
    50% { transform: scale(1.1); }
    100% { transform: scale(1); }
}
.finish-title {
    font-size: 1.75rem;
    color: #1f2937;
    margin-bottom: 1rem;
}
.finish-message {
    color: #6b7280;
    margin-bottom: 2rem;
    line-height: 1.6;
}
.finish-info {
    background: #f3f4f6;
    padding: 1.5rem;
    border-radius: 0.5rem;
    margin-bottom: 2rem;
    text-align: left;
}
.finish-info-item {
    display: flex;
    justify-content: space-between;
    margin-bottom: 0.75rem;
    font-size: 0.9375rem;
}
.finish-info-item:last-child {
    margin-bottom: 0;
}
.finish-info-label {
    color: #6b7280;
}
.finish-info-value {
    color: #1f2937;
    font-weight: 600;
}
.btn {
    display: inline-block;
    padding: 0.875rem 2.5rem;
    background: linear-gradient(135deg, #4f46e5, #06b6d4);
    color: white;
    text-decoration: none;
    border-radius: 0.5rem;
    font-weight: 500;
    transition: transform 0.2s, box-shadow 0.2s;
}
.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>
<div class="finish-container">
    <div class="finish-icon">🎉</div>
    <h1 class="finish-title">考试完成！</h1>
    <p class="finish-message">
        您的试卷已成功提交，感谢您的参与。<br>
        考试成绩将在批改后公布，请耐心等待。
    </p>
    <div class="finish-info">
        <div class="finish-info-item">
            <span class="finish-info-label">提交时间：</span>
            <span class="finish-info-value" id="submitTime">--</span>
        </div>
        <div class="finish-info-item">
            <span class="finish-info-label">考试状态：</span>
            <span class="finish-info-value" style="color: #10b981;">已交卷</span>
        </div>
    </div>
    <a href="<%=path%>/student/login.jsp" class="btn">返回登录页</a>
</div>

<script>
// 显示提交时间
var now = new Date();
document.getElementById('submitTime').textContent = now.toLocaleString('zh-CN');
</script>
</body>
</html>
