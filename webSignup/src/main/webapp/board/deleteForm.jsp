<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/includes/mainHeader.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/board/css/boardDelete.css?timestamp=<%= System.currentTimeMillis() %>">
    <title>게시판</title>
</head>
<body>
    <main class="delete-container">
    	<h1 class="delete-title">글삭제</h1>
        <form method="POST" name="delForm" action="deleteProc.jsp?pageNum=<%=pageNum%>" onsubmit="return deleteSave()"> 
            <input type="hidden" name="num" value="<%=num%>">
            <table class="delete-table">
                <tr>
                    <td colspan="2" align="center">
                        <b>비밀번호를 입력해 주세요.</b>
                    </td>
                </tr>
                <tr>
                    <td align="center">비밀번호:</td>
                    <td><input type="password" name="pass" size="12" maxlength="12"></td>
                </tr>
                <tr>
                    <td colspan="2" class="delete-buttons">
                        <input type="submit" class="delete-confirm-btn" value="글삭제">
                        <input type="button" value="글목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
                    </td>
                </tr>  
            </table> 
        </form>
    </main>
</body>
</html>

<%@ include file="/includes/mainFooter.jsp" %>
