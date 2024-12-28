<%@page contentType="text/html; charset=UTF-8"%>
<%@page isErrorPage="true"%>
<%
	response.setStatus(HttpServletResponse.SC_OK);	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>404 에러 발생</title>
</head>
<body>
	<h1>서비스 처리 과정에서 에러가 발생하였습니다.</h1>
  <h2>요청한 페이지가 존재하지 않습니다.</h2>
</body>
</html>