<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, kr.co.pyo.signup.model.SignupDAO, kr.co.pyo.signup.model.SignupVO" %>
<%
    String id = (String) session.getAttribute("userId");
    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    SignupDAO dao = new SignupDAO();
    SignupVO user = dao.selectByIdDB(new SignupVO(id, null, null, null, null, null, null, null, null, null, null));

    String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/signup/css/success.css">
</head>
<body class="mypage">
    <div class="container">
        <h1>마이페이지</h1>
        <% if (message != null) { %>
            <p class="success-message"><%= message %></p>
        <% } %>
        <div class="info">
            <p><strong>이름:</strong> <%= user.getName() %></p>
            <p><strong>이메일:</strong> <%= user.getEmail() %></p>
            <p><strong>전화번호:</strong> <%= user.getPhone1() %>-<%= user.getPhone2() %>-<%= user.getPhone3() %></p>
            <p><strong>생년월일:</strong> <%= user.getBirth() %></p>
            <p><strong>우편번호:</strong> <%= user.getZipcode() %></p>
            <p><strong>주소:</strong> <%= user.getAddress1() %> <%= user.getAddress2() %></p>
        </div>
        <form action="/webSignup/signup/updatePage.jsp" method="get" style="margin-top: 20px;">
            <button type="submit" class="update">회원정보 수정</button>
        </form>
        <form action="/webSignup/signup/deletePage.jsp" method="get" style="margin-top: 20px;">
            <button type="submit" class="delete">회원 탈퇴</button>
        </form>
    </div>
</body>
</html>
