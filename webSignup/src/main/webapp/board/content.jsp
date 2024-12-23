<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.pyo.board.model.BoardDAO"%>
<%@ page import="kr.co.pyo.board.model.BoardVO"%>
<%@ include file="/includes/mainHeader.jsp" %>

<%
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
BoardVO vo = new BoardVO();
vo.setNum(num);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>

<%
try {
	BoardDAO bdao = BoardDAO.getInstance();
	BoardVO bvo = bdao.selectBoardDB(vo);
	int _num = vo.getNum();
	int ref = bvo.getRef();
	int step = bvo.getStep();
	int depth = bvo.getDepth();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>문의내용 보기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/board/css/boardContent.css?timestamp=<%= System.currentTimeMillis() %>">
</head>
<body>
    <main class="content-container">
        <h1 class="content-title">문의내용 보기</h1>
        <form>
            <table class="content-table">
                <tr>
                    <th>글번호</th>
                    <td><%=bvo.getNum()%></td>
                    <th>조회수</th>
                    <td><%=bvo.getReadcount()%></td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td><%=bvo.getWriter()%></td>
                    <th>작성일</th>
                    <td><%=sdf.format(bvo.getRegdate())%></td>
                </tr>
                <tr>
                    <th>글제목</th>
                    <td colspan="3"><%=bvo.getSubject()%></td>
                </tr>
                <tr>
                    <th>글내용</th>
                    <td colspan="3"><pre><%=bvo.getContent()%></pre></td>
                </tr>
            </table>
            <div class="content-buttons">
                <input type="button" value="글수정" onclick="document.location.href='updateForm.jsp?num=<%=_num%>&pageNum=<%=pageNum%>'">
                <input type="button" value="글삭제" class="delete-btn" onclick="document.location.href='deleteForm.jsp?num=<%=_num%>&pageNum=<%=pageNum%>'">
                <input type="button" value="답글쓰기" class="reply-btn" onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&step=<%=step%>&depth=<%=depth%>'">
                <input type="button" value="문의목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
            </div>
        </form>
    </main>
</body>
</html>
<%
} catch (Exception e) {
	e.printStackTrace();
}
%>
<%@ include file="/includes/mainFooter.jsp" %>
