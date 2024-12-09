package kr.co.pyo.signup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.pyo.signup.model.SignupDAO;
import kr.co.pyo.signup.model.SignupVO;

@WebServlet("/updateServlet.do")
public class UpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pwd = request.getParameter("pwd");
        String birthStr = request.getParameter("birth");

        int birth = 0;
        if (birthStr != null && !birthStr.isEmpty()) {
            birth = Integer.parseInt(birthStr);
        }

        SignupVO user = new SignupVO(id, pwd, email, name, birth);
        SignupDAO dao = new SignupDAO();

        boolean result = dao.updateDB(user);

        if (result) {
            // 수정 성공 시 success.jsp로 메시지 전달
            response.sendRedirect("/webSignup/signup/success.jsp?message=" + java.net.URLEncoder.encode("회원정보가 수정되었습니다.", "UTF-8"));
        } else {
            // 수정 실패 시 updatePage.jsp로 에러 메시지 전달
            response.sendRedirect("/webSignup/signup/updatePage.jsp?error=" + java.net.URLEncoder.encode("회원정보 수정에 실패했습니다.", "UTF-8"));
        }
    }
}
	