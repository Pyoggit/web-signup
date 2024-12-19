<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.pyo.board.model.BoardDAO"%>
<%@ page import="kr.co.pyo.board.model.BoardVO"%>
<%@ include file="mainHeader.jsp" %>

<%
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
BoardVO vo = new BoardVO(); 
vo.setNum(num); 
%>
<%
try {
	BoardDAO bdao = BoardDAO.getInstance();
	BoardVO article = bdao.selectBoardOneDB(vo); 
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/board/css/boardUpdate.css?timestamp=<%= System.currentTimeMillis() %>">
    <title>문의하기수정</title>
</head>
<body>
    <main class="write-container">
        <h1 class="write-title">문의글수정</h1>
        <form method="post" name="writeform" action="updateProc.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()">
            <input type="hidden" name="num" value="<%=article.getNum()%>">
            <table class="write-table">
                <tr>
                    <th>이 름</th>
                    <td><input type="text" name="writer" maxlength="10" value="<%=article.getWriter()%>"></td>
                </tr>
                <tr>
                    <th>제 목</th>
                    <td><input type="text" name="subject" maxlength="50" value="<%=article.getSubject()%>"></td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td><input type="text" name="email" maxlength="30" value="<%=article.getEmail()%>"></td>
                </tr>
                <tr>
                    <th>내 용</th>
                    <td><textarea name="content" rows="10" cols="50"><%=article.getContent()%></textarea></td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td><input type="password" name="pass" maxlength="12"></td>
                </tr>
                <tr>
                    <td colspan="2" class="write-buttons">
                        <input type="submit" value="글수정">
                        <input type="reset" value="다시작성">
                        <input type="button" value="목록보기" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
                    </td>
                </tr>
            </table>
        </form>
    </main>
</body>
</html>
<%
} catch (Exception e) {
    e.printStackTrace();
}
%>
<%@ include file="mainFooter.jsp" %>
