<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>메인페이지</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/main.css" />
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script src="https://kit.fontawesome.com/01ba7af47f.js" crossorigin="anonymous"></script>
</head>

<body>
	<!-- Header 부분 -->
	<header>
		<div class="header-logo">
			<i class="fa-solid fa-users"></i> <a href="#">Main</a>
		</div>
		<ul class="header-menu">
			<li class="dropdown"><a href="#" class="dropbtn">home1</a>
				<div class="dropdown-content">
					<a href="#">menu1</a> <a href="#">menu2</a> <a href="#">menu3</a>
				</div></li>
			<li class="dropdown"><a href="#" class="dropbtn">home2</a>
				<div class="dropdown-content">
					<a href="#">menu1</a> <a href="#">menu2</a>
				</div></li>
			<li class="dropdown"><a href="#" class="dropbtn">home3</a>
				<div class="dropdown-content">
					<a href="#">menu1</a> <a href="#">menu2</a> <a href="#">menu3</a> <a
						href="#">menu4</a> <a href="#">menu5</a>
				</div></li>
			<li class="dropdown"><a href="#" class="dropbtn">home4</a>
				<div class="dropdown-content">
					<a href="#">menu1</a> <a href="#">menu2</a> <a href="#">menu3</a> <a
						href="#">menu4</a> <a href="#">menu5</a>
				</div></li>
			<li class="dropdown"><a href="#" class="dropbtn">home5</a>
				<div class="dropdown-content">
					<a href="#">menu1</a> <a href="#">menu2</a> <a href="#">menu3</a> <a
						href="#">menu4</a> <a href="#">menu5</a> <a href="#">menu6</a>
				</div></li>
		</ul>

		<ul class="header-icons">
			<li>
				<a href="${pageContext.request.contextPath}/signup/login.jsp">시작하기</a>
			</li>
		</ul>

	</header>

	<!-- Section 부분 -->
	<section onload="carousel();">
		<div class="slideshow">
			<div class="slideshow_slides">
				<a href="#"><img
					src="${pageContext.request.contextPath}/img/slide-1.jpg" /></a> <a
					href="#"><img
					src="${pageContext.request.contextPath}/img/slide-2.jpg" /></a> <a
					href="#"><img
					src="${pageContext.request.contextPath}/img/slide-3.jpg" /></a> <a
					href="#"><img
					src="${pageContext.request.contextPath}/img/slide-4.jpg" /></a>
			</div>
			<div class="slideshow_nav">
				<a href="#" class="prev"><i
					class="fa-solid fa-circle-chevron-left"></i></a> <a href="#"
					class="next"><i class="fa-solid fa-circle-chevron-right"></i></a>
			</div>
			<div class="slideshow_indicator">
				<a href="#"><i class="fa-regular fa-circle-dot"></i></a> <a href="#"><i
					class="fa-regular fa-circle-dot"></i></a> <a href="#"><i
					class="fa-regular fa-circle-dot"></i></a> <a href="#"><i
					class="fa-regular fa-circle-dot"></i></a>
			</div>
		</div>
	</section>
	
	
	<!-- Footer 부분 -->
	<footer>
		<div class="footer-links">
			<ul>
				<li><a href="#">이용약관</a></li>
				<li><a href="#">블로그 서비스 운영정책</a></li>
				<li><a href="#">개인정보처리방침</a></li>
				<li><a href="#">책임의 한계와 법적고지</a></li>
				<li><a href="#">글 권리 보호하기</a></li>
				<li><a href="#">게시중단요청서비스</a></li>
			</ul>
		</div>
		<div class="footer-copyright">
			<span>NAVER</span> Copyright © NAVER Corp. All Rights Reserved.
		</div>
	</footer>
</body>

</html>