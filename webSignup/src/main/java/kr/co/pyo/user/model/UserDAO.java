package kr.co.pyo.user.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.pyo.util.ConnectionPool;

public class UserDAO {
    // 싱글톤 패턴
    private static UserDAO instance;

    private UserDAO() {
    }

    public static UserDAO getInstance() {
        if (instance == null) {
            synchronized (UserDAO.class) {
                if (instance == null) {
                    instance = new UserDAO();
                }
            }
        }
        return instance;
    }

    // 사용자 정보 가져오기 (ID로 조회)
    private static final String SELECT_USER_BY_ID = 
        "SELECT ID, NAME, BIRTH, PHONE1, PHONE2, PHONE3, EMAIL, ZIPCODE, ADDRESS1, ADDRESS2 FROM SIGNUP WHERE ID = ?";
    
    public UserVO getUserById(String userId) {
        ConnectionPool cp = ConnectionPool.getInstance();
        Connection con = cp.dbCon();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        UserVO user = null;

        try {
            pstmt = con.prepareStatement(SELECT_USER_BY_ID);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new UserVO();
                user.setId(rs.getString("ID"));
                user.setName(rs.getString("NAME"));
                user.setBirth(rs.getString("BIRTH"));
                user.setPhone1(rs.getString("PHONE1"));
                user.setPhone2(rs.getString("PHONE2"));
                user.setPhone3(rs.getString("PHONE3"));
                user.setEmail(rs.getString("EMAIL"));
                user.setZipcode(rs.getString("ZIPCODE"));
                user.setAddress1(rs.getString("ADDRESS1"));
                user.setAddress2(rs.getString("ADDRESS2"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            cp.dbClose(con, pstmt, rs);
        }

        return user;
    }

    // 사용자 로그인 체크
    private static final String LOGIN_CHECK = "SELECT COUNT(*) FROM SIGNUP WHERE ID = ? AND PWD = ?";
    
    public boolean checkLogin(String userId, String password) {
        ConnectionPool cp = ConnectionPool.getInstance();
        Connection con = cp.dbCon();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean isValid = false;

        try {
            pstmt = con.prepareStatement(LOGIN_CHECK);
            pstmt.setString(1, userId);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                isValid = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            cp.dbClose(con, pstmt, rs);
        }

        return isValid;
    }
}
