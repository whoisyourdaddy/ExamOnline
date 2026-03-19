<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xurui.dormain.*" %>
<%@ page import="com.xurui.util.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String course = (String)session.getAttribute("course");
String Uid = (String)session.getAttribute("Uid");
String test_time=(String)session.getAttribute("test_time");
UserUtil userUtil = new UserUtil();
User user = userUtil.getUser(Uid);
TestSetUtil testUtil = new TestSetUtil();
TestSet ts = testUtil.getTestSet(course,test_time);

if(ts == null || user == null) {
    response.sendRedirect(path+"/student/login.jsp");
    return;
}

session.setAttribute("name", user.getName());
int totalScore = testUtil.getTotalScore(ts);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>考试信息确认 - 在线考试系统</title>
<link rel="stylesheet" href="<%=path%>/css/modern.css">
<script type="text/javascript">
function IsSubmit() {
    var okey = confirm("确定开始考试？考试计时将在点击确定后立即开始！");
    if(okey) {
        window.location.href = "<%=request.getContextPath()%>/student/test.jsp";
    }
}
</script>
</head>
<body style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 2rem;">
    <div class="welcome-container">
        <div class="welcome-header">
            <h1>欢迎参加考试</h1>
            <p>请仔细核对以下信息，确认无误后开始考试</p>
        </div>

        <div class="welcome-body">
            <div class="info-section">
                <h3>考生信息</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">学号：</span>
                        <span class="info-value"><%=user.getId()%></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">姓名：</span>
                        <span class="info-value"><%=user.getName()%></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">性别：</span>
                        <span class="info-value"><%=user.getSex()%></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">科目：</span>
                        <span class="info-value"><%=course%></span>
                    </div>
                </div>
            </div>

            <div class="info-section">
                <h3>考试信息</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">考试日期：</span>
                        <span class="info-value"><%=test_time%></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">考试时长：</span>
                        <span class="info-value"><%=ts.getTotaltime()%> 分钟</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">总分值：</span>
                        <span class="info-value"><%=totalScore%> 分</span>
                    </div>
                </div>
            </div>

            <div class="info-section">
                <h3>题型分布</h3>
                <% int typeCount = 1; %>
                <% if(ts.getJudgeCount() != 0) { %>
                <div class="info-item" style="margin-bottom: 0.5rem;">
                    <span class="info-label"><%=Common.getTypeCount(typeCount)%>、判断题：</span>
                    <span class="info-value">共 <%=ts.getJudgeCount()%> 题，每题 <%=ts.getPerJudScore()%> 分</span>
                </div>
                <% typeCount++; } %>

                <% if(ts.getSinChCount() != 0) { %>
                <div class="info-item" style="margin-bottom: 0.5rem;">
                    <span class="info-label"><%=Common.getTypeCount(typeCount)%>、单选题：</span>
                    <span class="info-value">共 <%=ts.getSinChCount()%> 题，每题 <%=ts.getPerSinScore()%> 分</span>
                </div>
                <% typeCount++; } %>

                <% if(ts.getMulChCount() != 0) { %>
                <div class="info-item" style="margin-bottom: 0.5rem;">
                    <span class="info-label"><%=Common.getTypeCount(typeCount)%>、多选题：</span>
                    <span class="info-value">共 <%=ts.getMulChCount()%> 题，每题 <%=ts.getPerMulScore()%> 分</span>
                </div>
                <% typeCount++; } %>

                <% if(ts.getJdCount() != 0) { %>
                <div class="info-item" style="margin-bottom: 0.5rem;">
                    <span class="info-label"><%=Common.getTypeCount(typeCount)%>、简答题：</span>
                    <span class="info-value">共 <%=ts.getJdCount()%> 题，每题 <%=ts.getPerJdScore()%> 分</span>
                </div>
                <% typeCount++; } %>

                <% if(ts.getProgramCount() != 0) { %>
                <div class="info-item" style="margin-bottom: 0.5rem;">
                    <span class="info-label"><%=Common.getTypeCount(typeCount)%>、编程题：</span>
                    <span class="info-value">共 <%=ts.getProgramCount()%> 题，每题 <%=ts.getPerProScore()%> 分</span>
                </div>
                <% typeCount++; } %>
            </div>

            <div class="exam-rules">
                <h4>考场规则</h4>
                <ul>
                    <li>请不要点击刷新、后退等按钮，否则可能导致考试异常</li>
                    <li>请在规定时间内完成考试，到时间系统将自动交卷</li>
                    <li>交卷前请仔细检查答案，确认无误后再提交</li>
                    <li>考试过程中请勿离开考试页面</li>
                </ul>
            </div>
        </div>

        <div class="welcome-footer">
            <a href="<%=path%>/student/login.jsp" class="btn btn-secondary" style="border-color: var(--gray-400); color: var(--gray-600);">返回</a>
            <button onclick="IsSubmit()" class="btn btn-success">开始考试</button>
        </div>
    </div>
</body>
</html>
