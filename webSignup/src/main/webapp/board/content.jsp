<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.pyo.board.model.BoardDAO"%>
<%@ page import="kr.co.pyo.board.model.BoardVO"%>
<%@ include file="mainHeader.jsp"%>

<%
request.setCharacterEncoding("UTF-8");
int num = 0;
String pageNum = request.getParameter("pageNum");
try {
	num = Integer.parseInt(request.getParameter("num"));
} catch (NumberFormatException e) {
	num = -1;
}

BoardVO vo = new BoardVO();
vo.setNum(num);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

BoardDAO bdao = BoardDAO.getInstance();
BoardVO bvo = bdao.selectBoardDB(vo);
if (bvo == null) {
	out.println("<script>alert('해당 게시글을 찾을 수 없습니다.'); history.back();</script>");
	return;
}
%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/board/css/boardContent.css">

<main class="content-container">
	<div class="content-title">글내용 보기</div>
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
			<input type="button" value="글수정"
				onclick="document.location.href='updateForm.jsp?num=<%=bvo.getNum()%>&pageNum=<%=pageNum%>'">
			<input type="button" value="글삭제" class="delete-btn"
				onclick="document.location.href='deleteForm.jsp?num=<%=bvo.getNum()%>&pageNum=<%=pageNum%>'">
			<input type="button" value="답글쓰기" class="reply-btn"
				onclick="document.location.href='writeForm.jsp?num=<%=bvo.getNum()%>&ref=<%=bvo.getRef()%>&step=<%=bvo.getStep()%>&depth=<%=bvo.getDepth()%>&pageNum=<%=pageNum%>'">
			<input type="button" value="글목록"
				onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
		</div>
	</form>
</main>

<%@ include file="mainFooter.jsp"%>
