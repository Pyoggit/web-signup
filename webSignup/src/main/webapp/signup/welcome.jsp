<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>환영합니다</title>
</head>
<body>
    <h2><%= request.getAttribute("username") %>님, 환영합니다!</h2>
    <a href="logoutServlet.do">로그아웃</a> <!-- 로그아웃 서블릿을 호출 -->
</body>
</html>
