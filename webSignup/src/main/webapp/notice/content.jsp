<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.pyo.notice.model.NoticeDAO"%>
<%@ page import="kr.co.pyo.notice.model.NoticeVO"%>
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

NoticeVO vo = new NoticeVO();
vo.setNum(num);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

NoticeDAO ndao = NoticeDAO.getInstance();
NoticeVO nvo = ndao.selectBoardDB(vo);
if (nvo == null) {
	out.println("<script>alert('해당 공지사항을 찾을 수 없습니다.'); history.back();</script>");
	return;
}
%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/notice/css/noticeContent.css">

<main class="content-container">
	<div class="content-title">공지사항 내용 보기</div>
	<form>
		<table class="content-table">
			<tr>
				<th>글번호</th>
				<td><%=nvo.getNum()%></td>
				<th>조회수</th>
				<td><%=nvo.getReadcount()%></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=nvo.getWriter()%></td>
				<th>작성일</th>
				<td><%=sdf.format(nvo.getRegdate())%></td>
			</tr>
			<tr>
				<th>글제목</th>
				<td colspan="3"><%=nvo.getSubject()%></td>
			</tr>
			<tr>
				<th>글내용</th>
				<td colspan="3"><pre><%=nvo.getContent()%></pre></td>
			</tr>
		</table>
		<div class="content-buttons">
			<input type="button" value="글수정"
				onclick="document.location.href='updateForm.jsp?num=<%=nvo.getNum()%>&pageNum=<%=pageNum%>'">
			<input type="button" value="글삭제" class="delete-btn"
				onclick="document.location.href='deleteForm.jsp?num=<%=nvo.getNum()%>&pageNum=<%=pageNum%>'">
			<input type="button" value="공지목록"
				onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
		</div>
	</form>
</main>

<%@ include file="mainFooter.jsp"%>
