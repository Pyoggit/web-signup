package kr.co.pyo.signup.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import kr.co.pyo.signup.util.DBUtility;

@WebServlet("/loginCheckServlet.do")
public class LoginCheckServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 인코딩 설정
        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String pass = request.getParameter("pass");
        String message = "";

        if (id != null && pass != null) {
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // DB 연결
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
                    session.setAttribute("id", id);

                    // 로그인 성공 후 welcome 페이지로 리다이렉트
                    response.sendRedirect(request.getContextPath() + "/signup/welcomeServlet.do");
                } else {
                    // 로그인 실패 시 에러 메시지 설정 및 로그인 페이지로 이동
                    message = "아이디 또는 비밀번호가 잘못되었습니다.";
                    response.sendRedirect(request.getContextPath() + "/signup/login.jsp?error=" + java.net.URLEncoder.encode(message, "UTF-8"));
                }
            } catch (Exception e) {
                message = "로그인 처리 중 오류 발생: " + e.getMessage();
                System.out.println(message);
                response.sendRedirect(request.getContextPath() + "/signup/login.jsp?error=" + java.net.URLEncoder.encode("로그인 처리 중 오류가 발생했습니다.", "UTF-8"));
            } finally {
                // 자원 해제
                DBUtility.dbClose(con, pstmt, rs);
            }
        } else {
            message = "아이디와 비밀번호를 입력해 주세요.";
            response.sendRedirect(request.getContextPath() + "/signup/login.jsp?error=" + java.net.URLEncoder.encode(message, "UTF-8"));
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // POST 요청으로만 접근해야 하므로, GET 요청이 오면 로그인 페이지로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/signup/login.jsp");
    }
}
