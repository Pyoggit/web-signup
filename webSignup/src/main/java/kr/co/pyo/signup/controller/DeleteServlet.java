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
        SignupVO user = new SignupVO(id, null, null, null, null, null, null, null, null, null, null);
        boolean deleted = dao.deleteDB(user);

        if (deleted) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("/webSignup/signup/login.jsp?message=" + 
                java.net.URLEncoder.encode("회원 탈퇴가 완료되었습니다.", "UTF-8"));
        } else {
            response.sendRedirect("/webSignup/signup/success.jsp?error=" + 
                java.net.URLEncoder.encode("회원 탈퇴에 실패했습니다.", "UTF-8"));
        }
    }
}
