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
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/update.css">
</head>
<body>
    <div class="container">
        <h1>회원정보 수정</h1>
        <form action="${pageContext.request.contextPath}/updateServlet.do" method="post">
            <input type="hidden" name="id" value="<%= user.getId() %>">
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" value="<%= user.getName() %>" required>
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
            </div>
            <div class="form-group">
                <label for="pwd">비밀번호</label>
                <input type="password" id="pwd" name="pwd" value="<%= user.getPwd() %>" required>
            </div>
            <div class="form-group">
                <label for="birth">생년월일</label>
                <input type="text" id="birth" name="birth" value="<%= user.getBirth() %>" required>
            </div>
            <div class="btn-group">
                <button type="submit" class="btn update">정보 수정</button>
                <button type="button" class="btn cancel" onclick="history.back();">취소</button>
            </div>
        </form>
    </div>
</body>

</html>
