<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, kr.co.pyo.signup.model.SignupDAO, kr.co.pyo.signup.model.SignupVO" %>
<%
    String id = (String) session.getAttribute("id");
    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    SignupDAO dao = new SignupDAO();
    SignupVO user = dao.selectByIdDB(new SignupVO(id, null, null, null, 0));
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <link rel="stylesheet" href="../css/update.css">
</head>
<body>
    <div class="container">
        <h1>회원정보 수정</h1>
        <form action="/webSignup/updateServlet.do" method="post">
            <input type="hidden" name="id" value="<%= user.getId() %>" readonly>
            <label>이름:</label>
            <input type="text" name="name" value="<%= user.getName() %>" required><br>
            <label>이메일:</label>
            <input type="email" name="email" value="<%= user.getEmail() %>" required><br>
            <label>비밀번호:</label>
            <input type="password" name="pwd" value="<%= user.getPwd() %>" required><br>
            <label>생년월일:</label>
            <input type="text" name="birth" value="<%= user.getBirth() %>" required>
            <button type="submit">정보 수정</button>
        </form>
    </div>
</body>
</html>
