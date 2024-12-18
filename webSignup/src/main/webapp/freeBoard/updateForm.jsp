<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.pyo.freeBoard.model.FreeBoardDAO"%>
<%@ page import="kr.co.pyo.freeBoard.model.FreeBoardVO"%>
<%@ include file="mainHeader.jsp" %>

<%
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");
    FreeBoardVO vo = new FreeBoardVO();
    vo.setNum(num);

    try {
        FreeBoardDAO dao = FreeBoardDAO.getInstance();
        FreeBoardVO article = dao.selectBoardOneDB(vo);
%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/freeBoard/css/freeBoard.css">

<main class="write-container">
    <div class="write-title">자유게시판 수정</div>
    <form method="post" name="writeform" 
          action="updateProc.jsp?pageNum=<%=pageNum%>"
          onsubmit="return writeSave()">
        <table class="write-table">
            <tr>
                <th>이름</th>
                <td>
                    <input type="text" size="10" maxlength="10" name="writer" 
                           value="<%=article.getWriter()%>">
                    <input type="hidden" name="num" value="<%=article.getNum()%>">
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td>
                    <input type="text" size="40" maxlength="50" name="subject" 
                           value="<%=article.getSubject()%>">
                </td>
            </tr>
            <tr>
                <th>Email</th>
                <td>
                    <input type="text" size="40" maxlength="30" name="email" 
                           value="<%=article.getEmail()%>">
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <textarea name="content" rows="13" cols="40"><%=article.getContent()%></textarea>
                </td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td>
                    <input type="password" size="8" maxlength="12" name="pass">
                </td>
            </tr>
        </table>
        <div class="write-buttons">
            <input type="submit" value="게시글 수정"> 
            <input type="reset" value="다시작성">
            <input type="button" value="목록보기" 
                   onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
        </div>
    </form>
</main> 

<%
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
<%@ include file="mainFooter.jsp" %>
