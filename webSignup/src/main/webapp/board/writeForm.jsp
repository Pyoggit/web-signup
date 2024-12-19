<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="mainHeader.jsp" %>

<%
    int num = 0, ref = 0, step = 0, depth = 0;
    try {
        if (request.getParameter("num") != null) {
            num = Integer.parseInt(request.getParameter("num"));
            ref = Integer.parseInt(request.getParameter("ref"));
            step = Integer.parseInt(request.getParameter("step"));
            depth = Integer.parseInt(request.getParameter("depth"));
        }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/board/css/boardWrite.css?timestamp=<%= System.currentTimeMillis() %>">
</head>
<body>
    <div class="write-container">
        <h1 class="write-title">문의하기</h1>
        <form method="post" name="writeForm" action="writeProc.jsp" onsubmit="return writeSave()">
            <input type="hidden" name="num" value="<%=num%>">
            <input type="hidden" name="ref" value="<%=ref%>">
            <input type="hidden" name="step" value="<%=step%>">
            <input type="hidden" name="depth" value="<%=depth%>">

            <table class="write-table">
                <tr>
                    <td align="center">이름</td>
                    <td><input type="text" name="writer" maxlength="12"></td>
                </tr>
                <tr>
                    <td align="center">이메일</td>
                    <td><input type="text" name="email" maxlength="30"></td>
                </tr>
                <tr>
                    <td align="center">제목</td>
                    <td>
                        <% if (request.getParameter("num") == null) { %>
                            <input type="text" name="subject" maxlength="50">
                        <% } else { %>
                            <input type="text" name="subject" maxlength="50" value="[답변]">
                        <% } %>
                    </td>
                </tr>
                <tr>
                    <td align="center">내용</td>
                    <td><textarea name="content" rows="10" cols="50"></textarea></td>
                </tr>
                <tr>
                    <td align="center">비밀번호</td>
                    <td><input type="password" name="pass" maxlength="10"></td>
                </tr>
            </table>
            <div class="write-buttons">
                <input type="submit" value="글쓰기">
                <input type="reset" value="다시작성">
                <input type="button" value="목록" onclick="window.location='list.jsp'">
            </div>
        </form>
    </div>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<%@ include file="mainFooter.jsp" %>
