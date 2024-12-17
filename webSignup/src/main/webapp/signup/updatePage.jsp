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
%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/signup/css/update.css">
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
            <div class="form-group">
                <label for="phone1">전화번호(앞자리)</label>
                <input type="text" id="phone1" name="phone1" value="<%= user.getPhone1() %>" required>
            </div>
            <div class="form-group">
                <label for="phone2">전화번호(중간자리)</label>
                <input type="text" id="phone2" name="phone2" value="<%= user.getPhone2() %>" required>
            </div>
            <div class="form-group">
                <label for="phone3">전화번호(뒷자리)</label>
                <input type="text" id="phone3" name="phone3" value="<%= user.getPhone3() %>" required>
            </div>
            <div class="form-group">
                <label for="zipcode">우편번호</label>
                <input type="text" id="zipcode" name="zipcode" value="<%= user.getZipcode() %>" required>
            </div>
            <div class="form-group">
                <label for="address1">주소</label>
                <input type="text" id="address1" name="address1" value="<%= user.getAddress1() %>" required>
            </div>
            <div class="form-group">
                <label for="address2">상세주소</label>
                <input type="text" id="address2" name="address2" value="<%= user.getAddress2() %>" required>
            </div>
            <div class="btn-group">
                <button type="submit" class="btn update">정보 수정</button>
                <button type="button" class="btn cancel" onclick="history.back();">취소</button>
            </div>
        </form>
    </div>
</body>

</html>
