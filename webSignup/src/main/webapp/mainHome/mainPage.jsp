<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="kr.co.pyo.board.model.BoardVO" %>
<%@ page import="kr.co.pyo.board.model.BoardDAO" %>
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

    // 게시판 최신 글 가져오기
    BoardDAO bdao = BoardDAO.getInstance();
    ArrayList<BoardVO> boardList = bdao.selectRecentBoards(5); // 게시판 최근 5개 가져오기
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<!-- Header 부분 -->
<header>
    <div class="header-logo">
        <i class="fa-solid fa-users"></i> <a href="#">Main</a>
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
					<a href="#">공지사항</a> <a href="#">자유게시판</a> <a href="#">상품후기</a>
				</div></li>
			<li class="dropdown"><a href="#" class="dropbtn">문의(Q&A)</a>
				<div class="dropdown-content">
					<a href="${pageContext.request.contextPath}/board/list.jsp">게시글목록</a> <a href="${pageContext.request.contextPath}/board/writeForm.jsp">게시글쓰기</a>
				</div>
			</li>
		</ul>
    <ul class="header-icons">
        <% if (user != null) { %>
            <li><strong><%= user.getName() %></strong>님, 환영합니다!</li>
        <% } else { %>
            <li><a href="${pageContext.request.contextPath}/signup/login.jsp">시작하기</a></li>
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
                    <a href="noticeDetail.jsp?num=<%= notice.getNum() %>"><%= notice.getSubject() %></a>
                    <span><%= sdf.format(notice.getRegdate()) %></span>
                </li>
            <% } %>
        </ul>
    </section>

    <!-- 중앙: 게시판 -->
    <section class="board-section" style="flex: 2;">
        <h3>최근 게시글</h3>
        <table border="1" cellspacing="0" cellpadding="5" style="width: 100%; text-align: center;">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
            <% for (BoardVO board : boardList) { %>
                <tr>
                    <td><%= board.getNum() %></td>
                    <td><a href="content.jsp?num=<%= board.getNum() %>"><%= board.getSubject() %></a></td>
                    <td><%= board.getWriter() %></td>
                    <td><%= sdf.format(board.getRegdate()) %></td>
                </tr>
            <% } %>
        </table>
    </section>

		<!-- 오른쪽: 사용자 정보 또는 로그인 -->
		<section class="user-section" style="flex: 1;">
    <h3>사용자 정보</h3>
    <% if (user != null) { %>
        <p><strong>이름:</strong> <%= user.getName() %></p>
        <p><strong>이메일:</strong> <%= user.getEmail() %></p>
        <p><strong>전화번호:</strong> <%= user.getPhone1() %>-<%= user.getPhone2() %>-<%= user.getPhone3() %></p>
        
        <!-- 마이페이지와 로그아웃 버튼 -->
        <div class="user-buttons" style="display: flex; gap: 10px; margin-top: 10px;">
            <a href="${pageContext.request.contextPath}/signup/success.jsp" class="mypage-btn" 
               style="padding: 10px 15px; background-color: #166cea; color: #fff; border-radius: 5px;">
                마이페이지
            </a>
            <a href="${pageContext.request.contextPath}/logoutServlet.do" class="logout-btn" 
               style="padding: 10px 15px; background-color: #d9534f; color: #fff; border-radius: 5px;">
                로그아웃
            </a>
        </div>
    <% } else { %>
        <!-- 로그인 버튼 -->
        <a href="${pageContext.request.contextPath}/signup/login.jsp" class="login-btn"
           style="padding: 10px 15px; background-color: #28a745; color: #fff; border-radius: 5px;">
            로그인하기
        </a>
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
