<%@ page import="kr.co.pyo.board.model.BoardDAO"%>
<%@ page import="kr.co.pyo.board.model.BoardVO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="mainHeader.jsp" %>

<%
    int pageSize = 5;
    request.setCharacterEncoding("UTF-8");
    String pageNum = request.getParameter("pageNum");
    int currentPage = 1; // 기본 페이지 설정
    try {
        if (pageNum == null || pageNum.trim().isEmpty()) {
            pageNum = "1";
        }
        currentPage = Integer.parseInt(pageNum);
    } catch (NumberFormatException e) {
        currentPage = 1; // 잘못된 값이 들어오면 기본 페이지를 1로 설정
    }
    int start = (currentPage - 1) * pageSize + 1;
    int end = currentPage * pageSize;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

    int number = 0;
    ArrayList<BoardVO> boardList = null;
    BoardDAO bdao = BoardDAO.getInstance();
    int count = bdao.selectCountDB();
    if (count > 0) {
        boardList = bdao.selectStartEndDB(start, end);
    }
    number = count - (currentPage - 1) * pageSize;
%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/board/css/list.css">

<main class="list-container">
    <%
        if (count == 0) {
    %>
    <div class="list-empty">
        게시판에 저장된 글이 없습니다.
        <div class="empty-write-btn">
            <button onclick="location.href='writeForm.jsp'" class="write-btn">글쓰기</button>
        </div>
    </div>
    <%
        } else {
    %>
    <table class="list-table">
        <tr>
            <td colspan="5" align="left" class="list-title">문의하기 (전체 글: <%= count %>)</td>
            <td align="right" class="list-write-btn">
                <button onclick="location.href='writeForm.jsp'" class="write-btn">글쓰기</button>
            </td>
        </tr>
        <!-- 테이블 헤더 -->
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회</th>
            <th>IP</th>
        </tr>
        <!-- 게시판 데이터 -->
        <%
            for (BoardVO article : boardList) {
                int wid = 0;
                if (article.getDepth() > 0) {
                    wid = 5 * article.getDepth();
                }
        %>
        <tr>
            <td><%= number-- %></td>
            <td>
                <a href="content.jsp?num=<%= article.getNum() %>&pageNum=1">
                    <%
                        if (article.getDepth() > 0) {
                    %>
                    <img src="images/level.gif" width="<%= wid %>" height="16">
                    <img src="images/re.gif">
                    <%
                        }
                    %>
                    <%= article.getSubject() %>
                </a>
                <%
                    if (article.getReadcount() >= 20) {
                %>
                <img src="images/hot.gif" class="hot-img">
                <%
                    }
                %>
            </td>
            <td><a href="mailto:<%= article.getEmail() %>"><%= article.getWriter() %></a></td>
            <td><%= sdf.format(article.getRegdate()) %></td>
            <td><%= article.getReadcount() %></td>
            <td><%= article.getIp() %></td>
        </tr>
        <%
            }
        %>
    <%
        }
    %>
    </table>
</main>
 <div class="paging">
    <%
        if (count > 0) {
            int pageBlock = 5;
            int imsi = count % pageSize == 0 ? 0 : 1;
            int pageCount = count / pageSize + imsi;
            int startPage = (int) ((currentPage - 1) / pageBlock) * pageBlock + 1;
            int endPage = startPage + pageBlock - 1;
            if (endPage > pageCount) endPage = pageCount;

            if (startPage > pageBlock) {
    %>
    <a href="list.jsp?pageNum=<%= startPage - pageBlock %>" class="disabled">이전</a>
    <%
            }

            for (int i = startPage; i <= endPage; i++) {
                if (currentPage == i) {
    %>
    <a href="list.jsp?pageNum=<%= i %>" class="current-page"><%= i %></a>
    <%
                } else {
    %>
    <a href="list.jsp?pageNum=<%= i %>"><%= i %></a>
    <%
                }
            }

            if (endPage < pageCount) {
    %>
    <a href="list.jsp?pageNum=<%= startPage + pageBlock %>">다음</a>
    <%
            }
        }
    %>
</div>


<%@ include file="mainFooter.jsp" %> 