<%@page contentType="text/html; charset=UTF-8"%>
<%@page isErrorPage="true"%>
<%
	response.setStatus(HttpServletResponse.SC_OK);	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>500 에러 발생</title>
</head>
<body>
	<h1>서비스 처리 과정에서 에러가 발생하였습니다.</h1>
  <h2>빠른 시간안에 문제를 해결하도록 노력하겠습니다.</h2>
  <h2>에러 타입: <%= exception.getClass().getName() %> </h2>
  <h2>에러 메시지: <%= exception.getMessage() %></h2>

</body>
</html>