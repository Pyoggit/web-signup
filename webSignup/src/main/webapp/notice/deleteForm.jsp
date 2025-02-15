<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/includes/mainHeader.jsp"%>

<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/notice/css/notice.css">

<main class="write-container">
	<div class="write-title">공지사항 삭제</div>
	<form method="POST" name="delForm"
		action="deleteProc.jsp?pageNum=<%=pageNum%>"
		onsubmit="return deleteSave()">
		<input type="hidden" name="num" value="<%=num%>">
		<table class="write-table">
			<tr>
				<td colspan="2" align="center"><b>비밀번호를 입력해 주세요.</b></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pass" size="8" maxlength="12">
				</td>
			</tr>
		</table>
		<div class="write-buttons">
			<input type="submit" value="공지삭제" class="delete-btn"> 
			<input type="button" value="공지목록"
				onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
		</div>
	</form>
</main>

<%@ include file="/includes/mainFooter.jsp"%>
