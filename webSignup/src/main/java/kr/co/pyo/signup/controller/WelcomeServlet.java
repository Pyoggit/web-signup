package kr.co.pyo.signup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/welcomeServlet.do")
public class WelcomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션 가져오기
        HttpSession session = request.getSession(false);
        if (session != null) {
            String id = (String) session.getAttribute("id");
            if (id != null) {
                // 로그인된 사용자가 있을 경우 welcome.jsp로 리다이렉트
                response.sendRedirect(request.getContextPath() + "/signup/success.jsp");
            } else {
                // 로그인 정보가 없는 경우 login.jsp로 리다이렉트
                response.sendRedirect(request.getContextPath() + "/signup/login.jsp");
            }
        } else {
            // 세션이 없는 경우 login.jsp로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/signup/login.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
