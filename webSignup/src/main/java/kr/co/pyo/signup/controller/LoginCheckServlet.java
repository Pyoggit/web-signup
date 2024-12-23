package kr.co.pyo.signup.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.pyo.util.DBUtility;

@WebServlet("/loginCheckServlet.do")
public class LoginCheckServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String pass = request.getParameter("pass");
        String message = "";

        if (id != null && pass != null) {
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                con = DBUtility.dbCon();
                if (con == null) {
                    throw new ServletException("데이터베이스 연결에 실패했습니다.");
                }

                // 로그인 정보 확인 쿼리
                String sql = "SELECT * FROM SIGNUP WHERE ID = ? AND PWD = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, id);
                pstmt.setString(2, pass);

                rs = pstmt.executeQuery();

                if (rs.next()) {
                    // 로그인 성공 시 세션 생성
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", id);
                    session.setAttribute("userName", rs.getString("NAME"));
                    session.setAttribute("userEmail", rs.getString("EMAIL"));
                    session.setAttribute("userPhone", rs.getString("PHONE1") + "-" + rs.getString("PHONE2") + "-" + rs.getString("PHONE3"));
                    
                    // 사용자 IP 저장
                    String userIp = request.getRemoteAddr();
                    session.setAttribute("userIp", userIp);

                    // 부모창 이동 및 팝업창 닫기
                    response.setContentType("text/html; charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.println("<script>");
                    out.println("window.opener.location.href = '" + request.getContextPath() + "/mainHome/mainPage.jsp';");
                    out.println("window.close();");
                    out.println("</script>");
                } else {
                    message = "아이디 또는 비밀번호가 잘못되었습니다.";
                    response.sendRedirect(request.getContextPath() + "/signup/login.jsp?error=" + 
                        java.net.URLEncoder.encode(message, "UTF-8"));
                }
            } catch (Exception e) {
                message = "로그인 처리 중 오류 발생: " + e.getMessage();
                System.out.println(message);
                response.sendRedirect(request.getContextPath() + "/signup/login.jsp?error=" +
                        java.net.URLEncoder.encode("로그인 처리 중 오류가 발생했습니다.", "UTF-8"));
            } finally {
                DBUtility.dbClose(con, pstmt, rs);
            }
        } else {
            message = "아이디와 비밀번호를 입력해 주세요.";
            response.sendRedirect(request.getContextPath() + "/signup/login.jsp?error=" +
                    java.net.URLEncoder.encode(message, "UTF-8"));
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/signup/login.jsp");
    }
}
