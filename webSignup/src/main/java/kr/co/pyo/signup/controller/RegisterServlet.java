package kr.co.pyo.signup.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.pyo.signup.util.DBUtility;

@WebServlet("/registerServlet.do")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // GET 요청 처리: 회원가입 폼 페이지 반환
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/signup/signup.jsp");
    }

    // POST 요청 처리: 회원가입 데이터 처리
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        String pwd = request.getParameter("pwd");
        String pwdTest = request.getParameter("pwdtest");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String birth = request.getParameter("birth");
        String message = "";

        if (id != null && pwd != null && email != null && name != null) {
            if (pwdTest != null && !pwd.equals(pwdTest)) {
                message = "비밀번호와 비밀번호 확인이 일치하지 않습니다.";
                response.sendRedirect(request.getContextPath() + "/signup/signup.jsp?error=" + 
                    java.net.URLEncoder.encode(message, "UTF-8"));
            } else {
                Connection con = null;
                PreparedStatement pstmt = null;

                try {
                    // DB 연결
                    con = DBUtility.dbCon();
                    if (con == null) {
                        throw new ServletException("데이터베이스 연결에 실패했습니다.");
                    }

                    // INSERT SQL 실행
                    String sql = "INSERT INTO SIGNUP (ID, PWD, EMAIL, NAME, BIRTH) VALUES (?, ?, ?, ?, ?)";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, id);
                    pstmt.setString(2, pwd);
                    pstmt.setString(3, email);
                    pstmt.setString(4, name);
                    if (birth != null && !birth.isEmpty() && birth.matches("\\d{8}")) {
                        pstmt.setInt(5, Integer.parseInt(birth));
                    } else {
                        pstmt.setNull(5, java.sql.Types.INTEGER);
                    }

                    int result = pstmt.executeUpdate();
                    if (result > 0) {
                        message = "회원가입이 성공적으로 완료되었습니다.";
                        response.sendRedirect(request.getContextPath() + "/signup/success.jsp?message=" + 
                            java.net.URLEncoder.encode(message, "UTF-8"));
                    } else {
                        message = "회원가입에 실패했습니다.";
                        response.sendRedirect(request.getContextPath() + "/signup/signup.jsp?error=" + 
                            java.net.URLEncoder.encode(message, "UTF-8"));
                    }
                } catch (Exception e) {
                    message = "회원가입 처리 중 문제가 발생했습니다.";
                    System.out.println("회원가입 오류: " + e.getMessage());
                    response.sendRedirect(request.getContextPath() + "/signup/signup.jsp?error=" + 
                        java.net.URLEncoder.encode(message, "UTF-8"));
                } finally {
                    DBUtility.dbClose(con, pstmt);
                }
            }
        } else {
            message = "입력 정보가 올바르지 않습니다.";
            response.sendRedirect(request.getContextPath() + "/signup/signup.jsp?error=" + 
                java.net.URLEncoder.encode(message, "UTF-8"));
        }
    }
}
