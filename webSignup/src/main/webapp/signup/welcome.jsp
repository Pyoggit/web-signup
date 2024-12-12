<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, kr.co.pyo.signup.model.SignupDAO, kr.co.pyo.signup.model.SignupVO" %>
<%
    String id = (String) session.getAttribute("id");
    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    SignupDAO dao = new SignupDAO();
    SignupVO user = dao.selectByIdDB(new SignupVO(id, null, null, null, null, null, null, null, null, null, null));
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>환영합니다!</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/welcome.css">
</head>
<body>
    <div class="welcome-container">
        <h1>회원가입을 환영합니다!</h1>
        <p>
            <strong><%= user.getName() %></strong>님,<br>
            저희 서비스를 이용해 주셔서 감사합니다.
        </p>
        <p>계정이 성공적으로 생성되었습니다. 이제 다양한 기능을 즐겨보세요!</p>
        <div class="btn-container">
            <a href="${pageContext.request.contextPath}/signup/login.jsp" class="btn">로그인하러 가기</a>
        </div>
    </div>
</body>
</html>
