<%@page contentType="text/html; charset=utf-8"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>在线考试系统 - 腾翔信息</title>
<link rel="stylesheet" href="<%=path%>/css/modern.css">
<style>
.features {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
    margin-top: 4rem;
    padding: 0 2rem;
}

.feature-card {
    background: rgba(255,255,255,0.1);
    backdrop-filter: blur(10px);
    padding: 2rem;
    border-radius: 1rem;
    text-align: center;
    transition: transform 0.3s;
}

.feature-card:hover {
    transform: translateY(-5px);
    background: rgba(255,255,255,0.15);
}

.feature-icon {
    font-size: 3rem;
    margin-bottom: 1rem;
}

.feature-card h3 {
    color: white;
    font-size: 1.25rem;
    margin-bottom: 0.75rem;
}

.feature-card p {
    color: rgba(255,255,255,0.8);
    font-size: 0.875rem;
}
</style>
</head>
<body class="landing-page">
    <header class="landing-header">
        <div class="landing-logo">腾翔信息在线考试系统</div>
        <nav class="landing-nav">
            <a href="<%=path%>/student/login.jsp">学生入口</a>
            <a href="<%=path%>/teacher/login.jsp">教师入口</a>
            <a href="<%=path%>/admin/login.jsp">管理后台</a>
        </nav>
    </header>

    <main class="landing-hero">
        <div>
            <div class="landing-content">
                <h1>在线考试系统</h1>
                <p>高效、便捷、安全的在线考试解决方案，支持多种题型，智能评分，实时监控</p>
                <div class="landing-buttons">
                    <a href="<%=path%>/student/login.jsp" class="btn btn-primary">学生登录</a>
                    <a href="<%=path%>/teacher/login.jsp" class="btn btn-secondary">教师登录</a>
                    <a href="<%=path%>/admin/login.jsp" class="btn btn-secondary">管理员登录</a>
                </div>
            </div>

            <div class="features">
                <div class="feature-card">
                    <div class="feature-icon">📝</div>
                    <h3>多样化题型</h3>
                    <p>支持单选、多选、判断、简答、编程等多种题型</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">⏱️</div>
                    <h3>智能计时</h3>
                    <p>自动倒计时，到时间自动交卷，保证考试公平</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3>成绩统计</h3>
                    <p>实时统计考试成绩，多维度分析考试数据</p>
                </div>
            </div>
        </div>
    </main>

    <footer class="landing-footer">
        <p>&copy; 2024 腾翔信息在线考试系统 版权所有</p>
    </footer>
</body>
</html>
