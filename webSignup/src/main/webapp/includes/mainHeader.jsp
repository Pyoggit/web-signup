<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="kr.co.pyo.user.model.UserVO" %>
<%@ page import="kr.co.pyo.user.model.UserDAO" %>

<%
    // 세션에서 로그인 확인
    String userId = (String) session.getAttribute("userId");
    UserVO user = null;
    if (userId != null) {
        UserDAO udao = UserDAO.getInstance();
        user = udao.getUserById(userId);
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>메인페이지</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/includes/css/main.css" />
<script src="${pageContext.request.contextPath}/includes/js/main.js"></script>
<script src="https://kit.fontawesome.com/01ba7af47f.js"
	crossorigin="anonymous"></script>
</head>
<body>
	<!-- Header 부분 -->
<header>
    <div class="header-logo">
        <i class="fa-solid fa-users"></i> <a href="${pageContext.request.contextPath}/mainHome/mainPage.jsp">Main</a>
    </div>
    <ul class="header-menu">
			<li class="dropdown"><a href="#" class="dropbtn">페이지소개</a>
				<div class="dropdown-content">
					<a href="https://github.com/Pyoggit" target="_blank">제작자</a> <a href="https://github.com/Pyoggit" target="_blank">기여한사람들</a> <a href="#">참고문서</a>
				</div></li>
			<li class="dropdown"><a href="#" class="dropbtn">구매/판매</a>
				<div class="dropdown-content">
					<a href="${pageContext.request.contextPath}/bookShop/addProduct.jsp">상품등록하기</a>
				</div></li>
			<li class="dropdown"><a href="#" class="dropbtn">상품</a>
				<div class="dropdown-content">
					<a href="${pageContext.request.contextPath}/bookShop/products.jsp">도서</a> <a href="#">의류</a> <a href="#">식품</a> <a href="#">전자제품</a> <a href="#">주류</a>
				</div></li>
			<li class="dropdown"><a href="#" class="dropbtn">커뮤니티</a>
				<div class="dropdown-content">
					<a href="${pageContext.request.contextPath}/notice/list.jsp">공지사항</a> <a href="${pageContext.request.contextPath}/freeBoard/list.jsp">자유게시판</a> <a href="#">상품후기</a>
				</div></li>
			<li class="dropdown"><a href="#" class="dropbtn">고객지원</a>
				<div class="dropdown-content">
					<a href="${pageContext.request.contextPath}/board/list.jsp">문의글목록</a> <a href="${pageContext.request.contextPath}/board/writeForm.jsp">문의하기(Q&A)</a>
				</div>
			</li>
		</ul>
    <ul class="header-icons">
        <% if (user != null) { %>
            <li><strong><%= user.getName() %></strong>님, 환영합니다!</li>
        <% } else { %>
            <li><a href="${pageContext.request.contextPath}/signup/login.jsp" class="start-btn">시작하기</a></li>
        <% } %>
    </ul>
</header>