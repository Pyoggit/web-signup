package kr.co.pyo.signup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.pyo.signup.model.SignupDAO;
import kr.co.pyo.signup.model.SignupVO;

@WebServlet("/deleteServlet.do")
public class DeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        SignupDAO dao = new SignupDAO();
        SignupVO user = new SignupVO(id, null, null, null, 0);
        boolean deleted = dao.deleteDB(user);

        if (deleted) {
            // 세션 무효화
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            // 로그인 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/signup/login.jsp?message=" + java.net.URLEncoder.encode("회원 탈퇴가 완료되었습니다.", "UTF-8"));
        } else {
            // 마이페이지로 에러 메시지 전달
            response.sendRedirect(request.getContextPath() + "/signup/success.jsp?error=" + java.net.URLEncoder.encode("회원 탈퇴에 실패했습니다.", "UTF-8"));
        }
    }
}
