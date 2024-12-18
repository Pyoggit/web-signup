package kr.co.pyo.freeBoard.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.pyo.freeBoard.model.FreeBoardCommentVO;
import kr.co.pyo.freeBoard.model.FreeBoardDAO;

@WebServlet("/commentWriteProc.do")
public class CommentWriteProcServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        // 로그인된 사용자 이름 가져오기
        String writer = (String) session.getAttribute("userName");
        if (writer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 댓글 정보 받아오기
        int boardNum = Integer.parseInt(request.getParameter("boardNum"));
        String content = request.getParameter("content");

        // 댓글 객체 생성
        FreeBoardCommentVO comment = new FreeBoardCommentVO();
        comment.setBoardNum(boardNum);
        comment.setWriter(writer); // 로그인 정보 사용
        comment.setContent(content);

        // DAO를 통해 댓글 저장
        boolean success = FreeBoardDAO.getInstance().insertComment(comment);

        if (success) {
            response.sendRedirect("boardDetail.jsp?num=" + boardNum);
        } else {
            response.sendRedirect("boardDetail.jsp?num=" + boardNum + "&error=댓글 작성 실패");
        }
    }
}
