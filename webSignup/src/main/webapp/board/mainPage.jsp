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
<script src="https://kit.fontawesome.com/01ba7af47f.js"
	crossorigin="anonymous"></script>
</head>

<body>
	<!-- 헤더 부분 -->
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
			<li><a
				href="${pageContext.request.contextPath}/signup/login.jsp"
				target="_blank">시작하기</a></li>
		</ul>



	</header>

	<!-- 세션 부분 -->
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

	<!-- 메인부분 -->
	<main>
		<div class="menu-left">
			<h2>국민소통</h2>
			<div class="menu-list">
				<div class="first-menu">
					<div class="list-title">국민참여</div>
					<div class="first-list">
						<ul class="list">
							<li><a href="#">이벤트</a></li>
							<li><a href="#">칭찬합시다</a></li>
							<li><a href="#">궁금합니다</a></li>
							<li><a href="#">제안합니다</a></li>
							<li><a href="#">국민신고방(불법산행)</a></li>
						</ul>
					</div>
				</div>
				<div class="second-menu">
					<div class="list-title">혁신제안</div>
					<div class="second-list">
						<ul class="list">
							<li><a href="#">기업성장응답센터</a></li>
							<li><a href="#">사회적가치, 혁신 우수사례</a></li>
						</ul>
					</div>
				</div>
				<div class="third-menu">
					<div class="list-title">클린신고센터</div>
					<div class="third-list">
						<ul class="list">
							<li><a href="#">공익신고</a></li>
							<li><a href="#">소극행정신고</a></li>
							<li><a href="#">갑질신고</a></li>
							<li><a href="#">청탁금지법 위반신고</a></li>
							<li><a href="#">사이버감사실</a></li>
							<li><a href="#">예산낭비신고</a></li>
							<li><a href="#">갑질행위 공개</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="board-content">
			<div class="board-top">
				<div class="board-title">
					<h2>칭찬합시다</h2>
				</div>

				<div class="board-menu">
					<table class="menu-table">
						<tr>
							<td><i class="fa-solid fa-house"></i></td>
							<td><a href="#">국립공원공단</a></td>
							<td><a href="#">국민소통</a></td>
							<td><a href="#">국민참여</a></td>
							<td><a href="#">칭찬합시다</a></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="board-center">
				<div class="board-alert">- 본 게시판과 관련이 없거나 상업적인 내용, 특정인이나 특정사안을
					비방하는 내용 등은 예고없이 삭제될 수 있습니다.</div>
				<div class="board-filter">
					<div class="left-filter">
						<select name="count" id="count">
							<option value="10">10개</option>
							<option value="20">20개</option>
							<option value="30">30개</option>
						</select> <a href="#" class="btn">보기</a>
					</div>
					<div class="right-filter">
						<select name="filter" id="filter">
							<option value="제목" sel>제목</option>
							<option value="내용">내용</option>
							<option value="작성자">작성자</option>
						</select> <input type="text" maxlength="30" /> <a href="#" class="btn">검색</a>
					</div>
				</div>
				<div class="board-article">
					<table class="article-table">
						<tr>
							<th>번호</th>
							<th>공원명</th>
							<th>제목</th>
							<th>작성자</th>
							<th>조회수</th>
							<th>등록일</th>
						</tr>
						<tr>
							<td>5417</td>
							<td>북한산</td>
							<td class="content"><a href="#">북한산 국립공원 특수산악구조대 전세호
									주임님과 유동욱 주임님 정말 감사했습니다!!!</a></td>
							<td>안준모</td>
							<td>52</td>
							<td>2022.12.20</td>
						</tr>
						<tr>
							<td>5416</td>
							<td>태백산</td>
							<td class="content"><a href="#">아직 어린 태백산국립공원을 응원합니다.</a></td>
							<td>이금녀</td>
							<td>99</td>
							<td>2022.12.11</td>
						</tr>
						<tr>
							<td>5415</td>
							<td>월출산</td>
							<td class="content"><a href="#">월출산 등산로 안전은 내가 지킨다</a></td>
							<td>허정태</td>
							<td>115</td>
							<td>2022.12.08</td>
						</tr>
						<tr>
							<td>5414</td>
							<td>치악산</td>
							<td class="content"><a href="#">치악산곧은탐방센터</a></td>
							<td>박경숙</td>
							<td>71</td>
							<td>2022.12.06</td>
						</tr>
						<tr>
							<td>5413</td>
							<td>지리산</td>
							<td class="content"><a href="#">지리산국립공원 산악구조대분들께 진심으로
									감사드립니다.</a></td>
							<td>이화실</td>
							<td>137</td>
							<td>2022.12.05</td>
						</tr>
						<tr>
							<td>5412</td>
							<td>한려해상</td>
							<td class="content"><a href="#">감사합니다</a></td>
							<td>김윤정</td>
							<td>69</td>
							<td>2022.11.30</td>
						</tr>
						<tr>
							<td>5411</td>
							<td>경주</td>
							<td class="content"><a href="#">리마인드 수학여행 일정과 인솔하신 직원분들께
									감사드립니다.</a></td>
							<td>문호선</td>
							<td>124</td>
							<td>2022.11.30</td>
						</tr>
						<tr>
							<td>5410</td>
							<td>치악산</td>
							<td class="content"><a href="#">고든치탐방로</a></td>
							<td>허순옥</td>
							<td>77</td>
							<td>2022.11.29</td>
						</tr>
						<tr>
							<td>5409</td>
							<td>경주</td>
							<td class="content"><a href="#">[경주]2022. 리마인드 수학여행 라떼투어
									담당자님과 스텝분들 칭찬합니다</a></td>
							<td>박송애</td>
							<td>468</td>
							<td>2022.11.27</td>
						</tr>
						<tr>
							<td>5408</td>
							<td>다도해해상</td>
							<td class="content"><a href="#">다도해 서부 흑산분소 친절에 감사드립니다.</a>
							</td>
							<td>임금규</td>
							<td>106</td>
							<td>2022.11.22</td>
						</tr>
					</table>
					<div class="page-list">
						<a href="#" class="page-selected">1</a> <a href="#" class="page">2</a>
						<a href="#" class="page">3</a> <a href="#" class="page">4</a> <a
							href="#" class="page">5</a> <a href="#" class="page">6</a> <a
							href="#" class="page">7</a> <a href="#" class="page">8</a> <a
							href="#" class="page">9</a> <a href="#" class="page">10</a> <a
							href="#">></a> <a href="#">>></a>
						<div class="write">
							<a href="#" class="btn">글쓰기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- footer 부분 -->
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