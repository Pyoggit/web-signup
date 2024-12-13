<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="mainHeader.jsp" %> <!-- 메인 헤더 포함 -->

<%
    int num = 0, ref = 1, step = 0, depth = 0;
    try {
        if (request.getParameter("num") != null) {
            num = Integer.parseInt(request.getParameter("num"));
            ref = Integer.parseInt(request.getParameter("ref"));
            step = Integer.parseInt(request.getParameter("step"));
            depth = Integer.parseInt(request.getParameter("depth"));
        }
%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css">

<main class="write-container">
    <div class="write-title">글쓰기</div>
    <form method="post" name="writeForm" action="writeProc.jsp" onsubmit="return writeSave()">
        <input type="hidden" name="num" value="<%= num %>">
        <input type="hidden" name="ref" value="<%= ref %>">
        <input type="hidden" name="step" value="<%= step %>">
        <input type="hidden" name="depth" value="<%= depth %>">

        <table class="write-table">
            <tr>
                <th>이름</th>
                <td><input type="text" size="12" maxlength="12" name="writer" /></td>
            </tr>
            <tr>
                <th>이메일</th>
                <td><input type="text" size="30" maxlength="30" name="email" /></td>
            </tr>
            <tr>
                <th>제목</th>
                <td>
                    <%
                        if (request.getParameter("num") == null) {
                    %>
                        <input type="text" size="50" maxlength="50" name="subject" />
                    <%
                        } else {
                    %>
                        <input type="text" size="50" maxlength="50" name="subject" value="[답변]" />
                    <%
                        }
                    %>
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="content" rows="10" cols="50"></textarea></td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td><input type="password" size="10" maxlength="10" name="pass" /></td>
            </tr>
        </table>

        <div class="write-buttons">
            <input type="submit" value="글쓰기" />
            <input type="reset" value="다시작성" />
            <input type="button" value="목록" onClick="window.location='list.jsp'" />
        </div>
    </form>
</main>

<%
    } catch (Exception e) {
        out.println("오류가 발생했습니다.");
    }
%>
<%@ include file="mainFooter.jsp" %>
