<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="kr.co.pyo.board.model.BoardVO" %>
<%@ page import="kr.co.pyo.board.model.BoardDAO" %>
<%@ page import="kr.co.pyo.freeBoard.model.FreeBoardVO" %>
<%@ page import="kr.co.pyo.freeBoard.model.FreeBoardDAO" %>
<%@ page import="kr.co.pyo.notice.model.NoticeVO" %>
<%@ page import="kr.co.pyo.notice.model.NoticeDAO" %>
<%@ page import="kr.co.pyo.user.model.UserVO" %>
<%@ page import="kr.co.pyo.user.model.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>메인페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/mainHome/css/main.css" />
    <script src="${pageContext.request.contextPath}/mainHome/js/main.js"></script>
    <script src="https://kit.fontawesome.com/01ba7af47f.js" crossorigin="anonymous"></script>
    
</head>
<body>
<%
    // 세션에서 로그인 확인
    String userId = (String) session.getAttribute("userId");
    UserVO user = null;
    if (userId != null) {
        UserDAO udao = UserDAO.getInstance();
        user = udao.getUserById(userId);
    }

    // 공지사항 가져오기
    NoticeDAO ndao = NoticeDAO.getInstance();
    ArrayList<NoticeVO> noticeList = ndao.selectNoticeList(5); // 공지사항 최근 5개 가져오기

    // 자유 게시판 최신 글 가져오기
    FreeBoardDAO fdao = FreeBoardDAO.getInstance();
    ArrayList<FreeBoardVO> boardList = fdao.selectFreeBoardList(5); // 게시판 최근 5개 가져오기
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<!-- Header 부분 -->
<header>
    <div class="header-logo">
        <a href="#"><img src="${pageContext.request.contextPath}/mainHome/img/user-menu-male.png" />Main</a>
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
            <li><a href="${pageContext.request.contextPath}/signup/signup.jsp" class="start-btn">시작하기</a></li>
        <% } %>
    </ul>
</header>

<!-- Section 부분 -->
	<section onload="carousel();">
		<div class="slideshow">
			<div class="slideshow_slides">
				<a href="#"><img
					src="${pageContext.request.contextPath}/mainHome/img/slide-1.jpg" /></a> <a
					href="#"><img
					src="${pageContext.request.contextPath}/mainHome/img/slide-2.jpg" /></a> <a
					href="#"><img
					src="${pageContext.request.contextPath}/mainHome/img/slide-3.jpg" /></a> <a
					href="#"><img
					src="${pageContext.request.contextPath}/mainHome/img/slide-4.jpg" /></a>
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

<!-- 메인 컨테이너 -->
<main class="main-container" style="display: flex; gap: 20px; padding: 20px;">
    <!-- 왼쪽: 공지사항 -->
    <section class="notice-section" style="flex: 1;">
        <h3>공지사항</h3>
        <ul>
            <% for (NoticeVO notice : noticeList) { %>
                <li>
                    <a href="${pageContext.request.contextPath}/notice/content.jsp?num=<%= notice.getNum() %>"><%= notice.getSubject() %></a>
                    <span><%= sdf.format(notice.getRegdate()) %></span>
                </li>
            <% } %>
        </ul>
    </section>

    <!-- 중앙: 게시판 -->
		<section class="board-section" style="flex: 2;">
		    <h3>최근 게시글</h3>
		    <ul>
		        <% if (boardList == null || boardList.isEmpty()) { %>
		            <li>등록된 게시글이 없습니다.</li>
		        <% } else { 
		            for (FreeBoardVO board : boardList) { %>
		            <li>
		                <a href="${pageContext.request.contextPath}/freeBoard/content.jsp?num=<%= board.getNum() %>">
		                    <%= board.getSubject() %>
		                </a>
		                <span><%= sdf.format(board.getRegdate()) %></span>
		            </li>
		        <%   }
		           } 
		        %>
		    </ul>
		</section>

		<!-- 오른쪽: 사용자 정보 또는 로그인 -->
		<section class="user-section">
		  
		    <% if (user != null) { %>
		        <!-- 로그인된 상태 -->
		        <div class="user-info">
						    <p><strong>이름:</strong> <%= user.getName() %></p>
		            <p><strong>이메일:</strong> <%= user.getEmail() %></p>
		            <p><strong>전화번호:</strong> <%= user.getPhone1() %>-<%= user.getPhone2() %>-<%= user.getPhone3() %></p>
						</div>
						<div class="user-buttons">
						    <a href="${pageContext.request.contextPath}/bookShop/cart.jsp" class="cart-btn">
						        장바구니
						    </a>
						    <div class="user-buttons-row">
						        <a href="${pageContext.request.contextPath}/signup/success.jsp" class="mypage-btn">
						            마이페이지
						        </a>
						        <a href="${pageContext.request.contextPath}/logoutServlet.do" class="logout-btn">
						            로그아웃
						        </a>
						    </div>
						</div>
		    <% } else { %>
		        <!-- 로그아웃된 상태 -->
		        <div class="user-login">
		            <a href="${pageContext.request.contextPath}/signup/login.jsp" class="login-btn">
		                로그인하기
		            </a>
		        </div>
		    <% } %>
		</section>
</main>

<!-- Footer -->
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