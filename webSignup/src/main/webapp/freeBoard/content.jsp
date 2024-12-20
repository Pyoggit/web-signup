<%@	page import="kr.co.pyo.freeBoard.model.FreeBoardCommentVO"%>
<%@	page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.pyo.freeBoard.model.FreeBoardDAO"%>
<%@ page import="kr.co.pyo.freeBoard.model.FreeBoardVO"%>
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

    FreeBoardVO vo = new FreeBoardVO();
    vo.setNum(num);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

    FreeBoardDAO dao = FreeBoardDAO.getInstance();
    FreeBoardVO fvo = dao.selectBoardDB(vo);

    if (fvo == null) {
        out.println("<script>alert('해당 게시글을 찾을 수 없습니다.'); history.back();</script>");
        return;
    }

    // 로그인한 사용자 정보 가져오기
    String userName = (String) session.getAttribute("userName");
%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/freeBoard/css/freeBoardContent.css">

<main class="content-container">
    <div class="content-title">자유게시판 내용 보기</div>
    <form>
        <table class="content-table">
            <tr>
                <th>글번호</th>
                <td><%=fvo.getNum()%></td>
                <th>조회수</th>
                <td><%=fvo.getReadcount()%></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td><%=fvo.getWriter()%></td>
                <th>작성일</th>
                <td><%=sdf.format(fvo.getRegdate())%></td>
            </tr>
            <tr>
                <th>글제목</th>
                <td colspan="3"><%=fvo.getSubject()%></td>
            </tr>
            <tr>
                <th>글내용</th>
                <td colspan="3"><pre><%=fvo.getContent()%></pre></td>
            </tr>
        </table>
        <div class="content-buttons">
            <input type="button" value="글수정"
                onclick="document.location.href='updateForm.jsp?num=<%=fvo.getNum()%>&pageNum=<%=pageNum%>'">
            <input type="button" value="글삭제" class="delete-btn"
                onclick="document.location.href='deleteForm.jsp?num=<%=fvo.getNum()%>&pageNum=<%=pageNum%>'">
            <input type="button" value="글목록"
                onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
        </div>
    </form>
    
    <!-- 댓글 작성 폼 -->
    <section class="comment-form">
        <form method="post" action="commentProc.jsp">
            <input type="hidden" name="boardNum" value="<%= fvo.getNum() %>">
            <table>
                <tr>
                    <td>
                        <!-- 작성자 필드: 로그인 정보가 있으면 자동 입력 -->
                        <input type="text" name="writer" value="<%= userName != null ? userName : "" %>" 
                               placeholder="작성자" required readonly>
                    </td>
                </tr>
                <tr>
                    <td>
                        <textarea name="content" rows="3" placeholder="댓글을 입력하세요" required></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="submit" value="댓글 작성">
                    </td>
                </tr>
            </table>
        </form>
    </section>

    <!-- 댓글 목록 -->
    <section class="comment-list">
        <h3>댓글</h3>
        <ul>
            <% 
                ArrayList<FreeBoardCommentVO> comments = dao.getCommentsByBoardNum(fvo.getNum());
                for (FreeBoardCommentVO comment : comments) { 
            %>
            <li>
                <p><strong><%= comment.getWriter() %>:</strong> <%= comment.getContent() %></p>
                <p><small><%= sdf.format(comment.getRegdate()) %></small></p>
            </li>
            <% } %>
        </ul>
    </section>
</main>

<%@ include file="mainFooter.jsp"%>
