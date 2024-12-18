<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.pyo.freeBoard.model.FreeBoardDAO" %>
<%@ page import="kr.co.pyo.freeBoard.model.FreeBoardCommentVO" %>

<%
    request.setCharacterEncoding("UTF-8");

    int boardNum = Integer.parseInt(request.getParameter("boardNum"));
    String writer = request.getParameter("writer");
    String content = request.getParameter("content");

    FreeBoardCommentVO comment = new FreeBoardCommentVO();
    comment.setBoardNum(boardNum);
    comment.setWriter(writer);
    comment.setContent(content);

    FreeBoardDAO dao = FreeBoardDAO.getInstance();
    boolean flag = dao.insertComment(comment);

    if (flag) {
        response.sendRedirect("content.jsp?num=" + boardNum);
    } else {
%>
        <script>
            alert("댓글 작성에 실패하였습니다.");
            history.back();
        </script>
<%
    }
%>
