<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
 <title>文件上传</title>
 <script type="text/javascript">
 
    function uploadeFile(){
    	var location =document.uploadForm.file.value;
    	if(location == ""){
    		alert("请先下载试题模板后上传提交");
    		return false;
    	}
    	return true;
    }
 </script>
</head>
 
<body>
 <form action="${pageContext.request.contextPath}/UploadHandleServlet" 
     enctype="multipart/form-data" name="uploadForm"  id="uploadForm"
        onsubmit="return uploadeFile();" method="post">
  上传文件：<input type="file" name="file" id="file" name="file" title="下载试题模板 "><a href ="${pageContext.request.contextPath}/DownloadServlet">下载试题模板</a><br/>
  <input type="submit" value="提交">
 </form>
</body>
</html>