<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="kr.co.pyo.board.model.BoardDAO"%>
<%@ page import="kr.co.pyo.board.model.BoardVO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="mainHeader.jsp" %>

<%
 // 페이징 설정
 int pageSize = 5;
 request.setCharacterEncoding("utf-8");
 String pageNum = request.getParameter("pageNum");
 if(pageNum == null){ pageNum = "1"; }
 int currentPage = Integer.parseInt(pageNum);
 int start = (currentPage - 1)*pageSize + 1;
 int end = (currentPage)*pageSize;

 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

 int number = 0;
 ArrayList<BoardVO> boardList = null;
 BoardDAO bdao = BoardDAO.getInstance();
 int count = bdao.selectCountDB(); 
 if (count > 0) {
	boardList = bdao.selectStartEndDB(start, end);
 }
 number = count - (currentPage - 1) * pageSize;
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/board/css/list.css?timestamp=<%= System.currentTimeMillis() %>">
</head>
<body>
    <main class="list-container">
        <div class="list-header">
            <div class="list-title">문의하기(Q&A) (전체 글: <%=count%>)</div>
            <a href="writeForm.jsp" class="write-btn">문의하기</a>
        </div>
        <% if (count == 0) { %>
            <div class="list-empty">
                <p>문의하기에 저장된 글이 없습니다.</p>
            </div>
        <% } else { %>
            <table class="list-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회</th>
                        <th>IP</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (BoardVO article : boardList) { %>
                        <tr>
                            <td><%= number-- %></td>
                            <td>
                                <a href="content.jsp?num=<%= article.getNum() %>&pageNum=<%=currentPage%>">
                                    <% if (article.getDepth() > 0) { %>
                                        <img src="images/level.gif" width="<%= 5 * article.getDepth() %>" height="16">
                                        <img src="images/re.gif">
                                    <% } %>
                                    <%= article.getSubject() %>
                                    <% if (article.getReadcount() >= 20) { %>
                                        <img src="images/hot.gif" border="0" height="16">
                                    <% } %>
                                </a>
                            </td>
                            <td><a href="mailto:<%= article.getEmail() %>"><%= article.getWriter()%></a></td>
                            <td><%= sdf.format(article.getRegdate()) %></td>
                            <td><%= article.getReadcount() %></td>
                            <td><%= article.getIp() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="paging">
                <% 
                int pageBlock = 3;
                int imsi = count % pageSize == 0 ? 0 : 1;
                int pageCount = count / pageSize + imsi;
                int startPage = (int) ((currentPage - 1) / pageBlock) * pageBlock + 1;
                int endPage = startPage + pageBlock - 1;
                if (endPage > pageCount) endPage = pageCount;

                if (startPage > pageBlock) { %>
                    <a href="list.jsp?pageNum=<%= startPage - pageBlock %>">[이전]</a>
                <% }
                for (int i = startPage; i <= endPage; i++) {
                    if (currentPage == i) { %>
                        <a class="current-page" href="#"><%= i %></a>
                    <% } else { %>
                        <a href="list.jsp?pageNum=<%= i %>"><%= i %></a>
                    <% }
                }
                if (endPage < pageCount) { %>
                    <a href="list.jsp?pageNum=<%= startPage + pageBlock %>">[다음]</a>
                <% } %>
            </div>
        <% } %>
    </main>
</body>
</html>
<%@ include file="mainFooter.jsp" %>
