<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 탈퇴 확인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/signup/css/delete.css">
</head>
<body>
    <div class="container">
        <h1>회원 탈퇴 확인</h1>
        <p><strong><%= user.getName() %></strong>님, 정말로 회원 탈퇴를 하시겠습니까?</p>
        <p>탈퇴 후에는 모든 정보가 삭제되며 복구가 불가능합니다.</p>
        <form action="${pageContext.request.contextPath}/deleteServlet.do" method="post">
            <input type="hidden" name="id" value="<%= user.getId() %>">
            <button type="submit" class="confirm-delete">예, 탈퇴합니다</button>
            <button type="button" class="cancel-delete" onclick="location.href='${pageContext.request.contextPath}/signup/success.jsp'">취소</button>
        </form>
    </div>
</body>
</html>
