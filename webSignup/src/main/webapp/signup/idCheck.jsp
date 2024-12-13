<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="kr.co.pyo.signup.model.SignupVO"%>
<%@page import="kr.co.pyo.signup.model.SignupDAO"%>
	
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");

boolean flag = false;
if (id != null && !id.isEmpty()) {
    SignupVO svo = new SignupVO();
    svo.setId(id);
    SignupDAO sdao = new SignupDAO();
    flag = sdao.selectIdCheck(svo);
} else {
    flag = true;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>ID중복체크</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/idCheck.css">
<script src="/webSignup/js/check.js"></script>

</head>
<body bgcolor="#FFFFCC">
	<br>
	<main>
		<b><%=id%></b>
		<%
		if (flag == true) {
			out.println("이미 존재하는 ID입니다.<br></br>");
		} else {
			out.println("사용 가능 합니다.<br></br>");
		}
		%>
		<hr>
		<button onClick="javascript:self.close()">닫기</button>
	</main>
</body>
</html>