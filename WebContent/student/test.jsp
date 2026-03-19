<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.xurui.dormain.*" %>
<%@ page import="com.xurui.util.*" %>
<%@ page import="java.util.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String course = (String)session.getAttribute("course");
String Uid = (String)session.getAttribute("Uid");
String name = (String)session.getAttribute("name");
String test_time = (String) session.getAttribute("test_time");
TestSetUtil testUtil = new TestSetUtil();
TestSet ts = null;
if(course != null && Uid != null && name != null) {
    ts = testUtil.getTestSet(course.trim(), test_time.trim());
    ArrayList al = null;
    QuestionUtil questionUtil = new QuestionUtil();
    Question qs = new Question();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%=course%> - 在线考试</title>
<link rel="stylesheet" href="<%=path%>/css/modern.css">
<style>
.exam-container {
    max-width: 1000px;
    margin: 0 auto;
    background-color: var(--white);
    min-height: 100vh;
    box-shadow: var(--shadow-xl);
}
.exam-header {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: var(--white);
    padding: 1.25rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: sticky;
    top: 0;
    z-index: 100;
}
.exam-title {
    font-size: 1.25rem;
    font-weight: 600;
}
.exam-info {
    display: flex;
    gap: 1.5rem;
    font-size: 0.875rem;
    align-items: center;
}
.exam-timer {
    background-color: rgba(255,255,255,0.2);
    padding: 0.5rem 1rem;
    border-radius: var(--radius);
    font-weight: 600;
    font-family: monospace;
    font-size: 1.125rem;
}
.exam-body {
    padding: 2rem;
}
.exam-section {
    margin-bottom: 3rem;
}
.exam-section-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: var(--gray-800);
    padding: 0.875rem 1.25rem;
    background: linear-gradient(90deg, var(--primary-color), transparent);
    color: white;
    border-radius: var(--radius);
    margin-bottom: 1.5rem;
}
.question-item {
    margin-bottom: 2.5rem;
    padding: 1.5rem;
    background-color: var(--gray-50);
    border-radius: var(--radius);
    border-left: 4px solid var(--primary-color);
}
.question-text {
    font-size: 1rem;
    color: var(--gray-800);
    margin-bottom: 1.25rem;
    line-height: 1.7;
    font-weight: 500;
}
.question-options {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}
.option-item {
    display: flex;
    align-items: flex-start;
    gap: 0.75rem;
    padding: 0.875rem 1rem;
    background-color: var(--white);
    border-radius: var(--radius-sm);
    cursor: pointer;
    transition: all 0.2s;
    border: 1px solid transparent;
}
.option-item:hover {
    border-color: var(--primary-color);
    background-color: #eef2ff;
}
.option-item input[type="radio"],
.option-item input[type="checkbox"] {
    width: 1.125rem;
    height: 1.125rem;
    margin-top: 0.125rem;
    cursor: pointer;
    accent-color: var(--primary-color);
}
.option-item label {
    cursor: pointer;
    flex: 1;
    color: var(--gray-700);
}
.textarea-answer {
    width: 100%;
    padding: 1rem;
    border: 1px solid var(--gray-300);
    border-radius: var(--radius);
    font-size: 0.875rem;
    resize: vertical;
    min-height: 150px;
    font-family: inherit;
}
.textarea-answer:focus {
    outline: none;
    border-color: var(--primary-color);
    box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
}
.exam-footer {
    padding: 1.5rem 2rem;
    background-color: var(--white);
    border-top: 2px solid var(--gray-200);
    display: flex;
    justify-content: center;
    position: sticky;
    bottom: 0;
}
.btn-submit {
    background: linear-gradient(135deg, var(--success-color), #059669);
    color: white;
    padding: 1rem 3rem;
    font-size: 1.125rem;
    font-weight: 600;
    border: none;
    border-radius: var(--radius);
    cursor: pointer;
    transition: all 0.3s;
    box-shadow: var(--shadow-md);
}
.btn-submit:hover {
    transform: translateY(-2px);
    box-shadow: var(--shadow-lg);
}
.progress-bar {
    position: fixed;
    top: 0;
    left: 0;
    height: 4px;
    background: linear-gradient(90deg, var(--success-color), var(--secondary-color));
    z-index: 101;
    transition: width 0.3s;
}
</style>
<script type="text/javascript">
var total = <%=ts.getTotaltime()%> * 60;
var show;
var timerInterval;

function setTime() {
    var h = parseInt(total / 3600);
    var hh = h < 10 ? "0" + h : h;
    var m = parseInt((total % 3600) / 60);
    var mm = m < 10 ? "0" + m : m;
    var s = (total % 3600) % 60;
    var ss = s < 10 ? "0" + s : s;
    
    if(total <= 0) {
        toSubmit();
    } else {
        total = total - 1;
        document.getElementById("timeSpan").innerHTML = hh + ":" + mm + ":" + ss;
        
        // 时间少于5分钟变红色警告
        if(total < 300) {
            document.getElementById("timeSpan").style.backgroundColor = "rgba(239, 68, 68, 0.3)";
        }
    }
}

function submitTest() {
    // 检查是否有未作答的题目
    var unanswered = 0;
    var radios = document.querySelectorAll('input[type="radio"]');
    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
    var textareas = document.querySelectorAll('textarea');
    
    if(confirm("确定要交卷吗？请确认所有题目已作答。")) {
        clearInterval(show);
        document.forms[0].submit();
    }
}

function toSubmit() {
    clearInterval(show);
    alert("考试时间到，系统将自动交卷！");
    document.forms[0].submit();
}

function setTimer() {
    show = setInterval(setTime, 1000);
}

function clearPlaceholder(obj) {
    if(obj.value == "==请在此答题==") {
        obj.value = "";
    }
    obj.style.color = "var(--gray-800)";
}

// 更新进度条
function updateProgress() {
    var totalQuestions = document.querySelectorAll('.question-item').length;
    var answered = 0;
    
    // 统计已作答
    var radioGroups = {};
    document.querySelectorAll('input[type="radio"]:checked').forEach(function(r) {
        radioGroups[r.name] = true;
    });
    answered += Object.keys(radioGroups).length;
    
    document.querySelectorAll('input[type="checkbox"]:checked').forEach(function() {
        answered++;
    });
    
    document.querySelectorAll('textarea').forEach(function(t) {
        if(t.value && t.value != "==请在此答题==") answered++;
    });
    
    var percent = (answered / totalQuestions) * 100;
    document.getElementById('progressBar').style.width = percent + '%';
}

window.onload = function() {
    setTimer();
    
    // 绑定进度更新事件
    document.querySelectorAll('input, textarea').forEach(function(el) {
        el.addEventListener('change', updateProgress);
        el.addEventListener('input', updateProgress);
    });
};
</script>
</head>
<body>
<div id="progressBar" class="progress-bar" style="width: 0%;"></div>

<div class="exam-container">
    <div class="exam-header">
        <div class="exam-title"><%=course%> 考试</div>
        <div class="exam-info">
            <span>学号: <%=Uid%></span>
            <span>姓名: <%=name%></span>
            <span>日期: <%=test_time%></span>
            <span class="exam-timer" id="timeSpan">--:--:--</span>
        </div>
    </div>

    <form action="<%=path%>/TestSubmitServlet" method="post">
    <div class="exam-body">
        <% int typeCount = 1; %>

        <% if(ts.getJudgeCount() != 0) { %>
        <div class="exam-section">
            <div class="exam-section-title">
                <%= Common.getTypeCount(typeCount) %>、判断题 (共<%=ts.getJudgeCount()%>题，每题<%=ts.getPerJudScore()%>分)
            </div>
            <%
            al = questionUtil.getQuestion2(course, ts.getJudgeCount(), 3);
            for(int i = 0; i < al.size(); i++) {
                qs = (Question)al.get(i);
            %>
            <div class="question-item">
                <div class="question-text"><%=i+1%>. <%=qs.getQues().trim()%></div>
                <div class="question-options">
                    <label class="option-item">
                        <input type="radio" name="judge<%=i%>Value" value="yes">
                        <span>正确</span>
                    </label>
                    <label class="option-item">
                        <input type="radio" name="judge<%=i%>Value" value="no">
                        <span>错误</span>
                    </label>
                </div>
                <input type="hidden" value="<%=qs.getId()%>" name="judgeId<%=i%>"/>
            </div>
            <% } %>
            <% typeCount++; %>
        </div>
        <% } %>

        <% if(ts.getSinChCount() != 0) { %>
        <div class="exam-section">
            <div class="exam-section-title">
                <%= Common.getTypeCount(typeCount) %>、单选题 (共<%=ts.getSinChCount()%>题，每题<%=ts.getPerSinScore()%>分)
            </div>
            <%
            al = questionUtil.getQuestion2(course, ts.getSinChCount(), 1);
            for(int i = 0; i < al.size(); i++) {
                qs = (Question)al.get(i);
            %>
            <div class="question-item">
                <div class="question-text"><%=i+1%>. <%=qs.getQues().trim()%></div>
                <div class="question-options">
                    <% if(qs.getKeyA() != null && !qs.getKeyA().trim().isEmpty()) { %>
                    <label class="option-item">
                        <input type="radio" name="choice<%=i%>Value" value="A">
                        <span>A. <%=qs.getKeyA().trim()%></span>
                    </label>
                    <% } %>
                    <% if(qs.getKeyB() != null && !qs.getKeyB().trim().isEmpty()) { %>
                    <label class="option-item">
                        <input type="radio" name="choice<%=i%>Value" value="B">
                        <span>B. <%=qs.getKeyB().trim()%></span>
                    </label>
                    <% } %>
                    <% if(qs.getKeyC() != null && !qs.getKeyC().trim().isEmpty()) { %>
                    <label class="option-item">
                        <input type="radio" name="choice<%=i%>Value" value="C">
                        <span>C. <%=qs.getKeyC().trim()%></span>
                    </label>
                    <% } %>
                    <% if(qs.getKeyD() != null && !qs.getKeyD().trim().isEmpty()) { %>
                    <label class="option-item">
                        <input type="radio" name="choice<%=i%>Value" value="D">
                        <span>D. <%=qs.getKeyD().trim()%></span>
                    </label>
                    <% } %>
                </div>
                <input type="hidden" value="<%=qs.getId()%>" name="choiceId<%=i%>"/>
            </div>
            <% } %>
            <% typeCount++; %>
        </div>
        <% } %>

        <% if(ts.getMulChCount() != 0) { %>
        <div class="exam-section">
            <div class="exam-section-title">
                <%= Common.getTypeCount(typeCount) %>、多选题 (共<%=ts.getMulChCount()%>题，每题<%=ts.getPerMulScore()%>分)
            </div>
            <%
            al = questionUtil.getQuestion2(course, ts.getMulChCount(), 2);
            for(int i = 0; i < al.size(); i++) {
                qs = (Question)al.get(i);
            %>
            <div class="question-item">
                <div class="question-text"><%=i+1%>. <%=qs.getQues().trim()%> <small style="color: var(--gray-500);">(多选)</small></div>
                <div class="question-options">
                    <% if(qs.getKeyA() != null && !qs.getKeyA().trim().isEmpty()) { %>
                    <label class="option-item">
                        <input type="checkbox" name="mulchoice<%=i%>Value" value="A">
                        <span>A. <%=qs.getKeyA().trim()%></span>
                    </label>
                    <% } %>
                    <% if(qs.getKeyB() != null && !qs.getKeyB().trim().isEmpty()) { %>
                    <label class="option-item">
                        <input type="checkbox" name="mulchoice<%=i%>Value" value="B">
                        <span>B. <%=qs.getKeyB().trim()%></span>
                    </label>
                    <% } %>
                    <% if(qs.getKeyC() != null && !qs.getKeyC().trim().isEmpty()) { %>
                    <label class="option-item">
                        <input type="checkbox" name="mulchoice<%=i%>Value" value="C">
                        <span>C. <%=qs.getKeyC().trim()%></span>
                    </label>
                    <% } %>
                    <% if(qs.getKeyD() != null && !qs.getKeyD().trim().isEmpty()) { %>
                    <label class="option-item">
                        <input type="checkbox" name="mulchoice<%=i%>Value" value="D">
                        <span>D. <%=qs.getKeyD().trim()%></span>
                    </label>
                    <% } %>
                </div>
                <input type="hidden" value="<%=qs.getId()%>" name="mulchoiceId<%=i%>"/>
            </div>
            <% } %>
            <% typeCount++; %>
        </div>
        <% } %>

        <% if(ts.getJdCount() != 0) { %>
        <div class="exam-section">
            <div class="exam-section-title">
                <%= Common.getTypeCount(typeCount) %>、简答题 (共<%=ts.getJdCount()%>题，每题<%=ts.getPerJdScore()%>分)
            </div>
            <%
            al = questionUtil.getQuestion2(course, ts.getJdCount(), 4);
            for(int i = 0; i < al.size(); i++) {
                qs = (Question)al.get(i);
            %>
            <div class="question-item">
                <div class="question-text"><%=i+1%>. <%=qs.getQues().trim()%></div>
                <textarea name="stuJdAnswer<%=i%>" class="textarea-answer" onfocus="clearPlaceholder(this)">==请在此答题==</textarea>
                <input type="hidden" value="<%=qs.getId()%>" name="jdId<%=i%>"/>
            </div>
            <% } %>
            <% typeCount++; %>
        </div>
        <% } %>

        <% if(ts.getProgramCount() != 0) { %>
        <div class="exam-section">
            <div class="exam-section-title">
                <%= Common.getTypeCount(typeCount) %>、编程题 (共<%=ts.getProgramCount()%>题，每题<%=ts.getPerProScore()%>分)
            </div>
            <%
            al = questionUtil.getQuestion2(course, ts.getProgramCount(), 5);
            for(int i = 0; i < al.size(); i++) {
                qs = (Question)al.get(i);
            %>
            <div class="question-item">
                <div class="question-text"><%=i+1%>. <%=qs.getQues().trim()%></div>
                <textarea name="stuProAnswer<%=i%>" class="textarea-answer" rows="10" onfocus="clearPlaceholder(this)">==请在此答题==</textarea>
                <input type="hidden" value="<%=qs.getId()%>" name="proId<%=i%>"/>
            </div>
            <% } %>
            <% typeCount++; %>
        </div>
        <% } %>
    </div>

    <div class="exam-footer">
        <button type="button" class="btn-submit" onclick="submitTest()">交 卷</button>
    </div>
    </form>
</div>
</body>
</html>
<%
} else {
    response.sendRedirect(path+"/student/login.jsp");
}
%>
