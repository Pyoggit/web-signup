package kr.co.pyo.freeBoard.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.pyo.freeBoard.model.FreeBoardDAO;
import kr.co.pyo.freeBoard.model.FreeBoardVO;

@WebServlet("/freeBoard/writeProc.do")
public class WriteProcServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        // 로그인 상태 확인
        String writer = (String) session.getAttribute("userName");
        String email = (String) session.getAttribute("userEmail");
        if (writer == null || email == null) {
            response.sendRedirect(request.getContextPath() + "/signup/login.jsp?error=로그인이 필요합니다.");
            return;
        }

        // 입력값 유효성 검사
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");
        String pass = request.getParameter("pass");

        if (subject == null || subject.trim().isEmpty() ||
            content == null || content.trim().isEmpty() ||
            pass == null || pass.trim().isEmpty()) {
            response.sendRedirect("writeForm.jsp?error=모든 항목을 입력해주세요.");
            return;
        }

        // 클라이언트 IP 주소 가져오기
        String userIp = request.getRemoteAddr();
        if (userIp == null) {
            userIp = "0.0.0.0"; // IP가 비어있을 경우 기본값 설정
        }

        // FreeBoardVO 객체 생성
        FreeBoardVO vo = new FreeBoardVO();
        vo.setWriter(writer);
        vo.setEmail(email);
        vo.setSubject(subject);
        vo.setPass(pass);
        vo.setContent(content);

        // DAO를 통해 데이터베이스에 저장
        FreeBoardDAO dao = FreeBoardDAO.getInstance();
        boolean success = dao.insertDB(vo, userIp);

        // 결과에 따른 페이지 이동
        if (success) {
            response.sendRedirect("list.jsp?success=글이 성공적으로 등록되었습니다.");
        } else {
            response.sendRedirect("writeForm.jsp?error=등록 실패. 다시 시도해주세요.");
        }
    }
}
