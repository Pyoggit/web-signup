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
        String birth = request.getParameter("birth");
        String phone1 = request.getParameter("phone1");
        String phone2 = request.getParameter("phone2");
        String phone3 = request.getParameter("phone3");
        String zipcode = request.getParameter("zipcode");
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");

        SignupVO user = new SignupVO(id, pwd, name, birth, phone1, phone2, phone3, email, zipcode, address1, address2);
        SignupDAO dao = new SignupDAO();

        boolean result = dao.updateDB(user);

        if (result) {
            response.sendRedirect("/webSignup/signup/success.jsp?message=" + 
                java.net.URLEncoder.encode("회원정보가 수정되었습니다.", "UTF-8"));
        } else {
            response.sendRedirect("/webSignup/signup/updatePage.jsp?error=" + 
                java.net.URLEncoder.encode("회원정보 수정에 실패했습니다.", "UTF-8"));
        }
    }
}
