<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>메인페이지</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/board/css/main.css" />
<script src="${pageContext.request.contextPath}/board/js/board.js"></script>
<script src="https://kit.fontawesome.com/01ba7af47f.js"
	crossorigin="anonymous"></script>
</head>
<body>
	<header>
		<div class="header-logo">
			<i class="fa-solid fa-users"></i> <a href="${pageContext.request.contextPath}/mainHome/mainPage.jsp">Main</a>
		</div>
		<ul class="header-menu">
			<li class="dropdown"><a href="#" class="dropbtn">페이지소개</a>
				<div class="dropdown-content">
					<a href="#">제작자</a> <a href="#">기여한사람들</a> <a href="#">참고문서</a>
				</div></li>
			<li class="dropdown"><a href="#" class="dropbtn">home2</a>
				<div class="dropdown-content">
					<a href="#">menu1</a> <a href="#">menu2</a>
				</div></li>
			<li class="dropdown"><a href="#" class="dropbtn">상품</a>
				<div class="dropdown-content">
					<a href="#">도서</a> <a href="#">의류</a> <a href="#">식품</a> <a
						href="#">전자제품</a> <a href="#">주류</a>
				</div></li>
			<li class="dropdown"><a href="#" class="dropbtn">커뮤니티</a>
				<div class="dropdown-content">
					<a href="${pageContext.request.contextPath}/notice/list.jsp">공지사항</a> <a href="#">자유게시판</a> <a href="#">상품후기</a>
				</div></li>
			<li class="dropdown"><a href="#" class="dropbtn">문의(Q&A)</a>
				<div class="dropdown-content">
					<a href="list.jsp">게시글목록</a> <a href="writeForm.jsp">게시글쓰기</a>
				</div>
			</li>
		</ul>
		<ul class="header-icons">
			<li><a
				href="${pageContext.request.contextPath}/signup/login.jsp">시작하기</a>
			</li>
		</ul>
	</header>