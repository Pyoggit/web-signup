package kr.co.pyo.signup.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.pyo.util.DBUtility;

public class SignupDAO {
    private final String SELECT_SQL = "SELECT * FROM SIGNUP";
    private final String SELECT_BY_ID_SQL = "SELECT * FROM SIGNUP WHERE ID = ?";
    private final String SELECT_ID_CHECK_SQL = "SELECT COUNT(*) AS COUNT FROM SIGNUP WHERE ID = ?";
    private final String SELECT_LOGIN_CHECK_SQL = "SELECT * FROM SIGNUP WHERE ID = ? AND PWD = ?";
    private final String INSERT_SQL = "INSERT INTO SIGNUP (ID, PWD, NAME, BIRTH, PHONE1, PHONE2, PHONE3, EMAIL, ZIPCODE, ADDRESS1, ADDRESS2) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private final String DELETE_SQL = "DELETE FROM SIGNUP WHERE ID = ?";
    private final String UPDATE_SQL = "UPDATE SIGNUP SET PWD = ?, NAME = ?, BIRTH = ?, PHONE1 = ?, PHONE2 = ?, PHONE3 = ?, EMAIL = ?, ZIPCODE = ?, ADDRESS1 = ?, ADDRESS2 = ? WHERE ID = ?";

    public ArrayList<SignupVO> selectDB() {
        Connection con = DBUtility.dbCon();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<SignupVO> mList = new ArrayList<>();
        try {
            pstmt = con.prepareStatement(SELECT_SQL);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                SignupVO svo = new SignupVO(
                    rs.getString("ID"),
                    rs.getString("PWD"),
                    rs.getString("NAME"),
                    rs.getString("BIRTH"),
                    rs.getString("PHONE1"),
                    rs.getString("PHONE2"),
                    rs.getString("PHONE3"),
                    rs.getString("EMAIL"),
                    rs.getString("ZIPCODE"),
                    rs.getString("ADDRESS1"),
                    rs.getString("ADDRESS2")
                );
                mList.add(svo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtility.dbClose(con, pstmt, rs);
        }
        return mList;
    }

    public SignupVO selectByIdDB(SignupVO svo) {
        Connection con = DBUtility.dbCon();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = con.prepareStatement(SELECT_BY_ID_SQL);
            pstmt.setString(1, svo.getId());
            rs = pstmt.executeQuery();
            if (rs.next()) {
                svo = new SignupVO(
                    rs.getString("ID"),
                    rs.getString("PWD"),
                    rs.getString("NAME"),
                    rs.getString("BIRTH"),
                    rs.getString("PHONE1"),
                    rs.getString("PHONE2"),
                    rs.getString("PHONE3"),
                    rs.getString("EMAIL"),
                    rs.getString("ZIPCODE"),
                    rs.getString("ADDRESS1"),
                    rs.getString("ADDRESS2")
                );
            } else {
                svo = null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtility.dbClose(con, pstmt, rs);
        }
        return svo;
    }

    public SignupVO selectLoginCheckDB(SignupVO svo) {
        Connection con = DBUtility.dbCon();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = con.prepareStatement(SELECT_LOGIN_CHECK_SQL);
            pstmt.setString(1, svo.getId());
            pstmt.setString(2, svo.getPwd());
            rs = pstmt.executeQuery();
            if (rs.next()) {
                svo = new SignupVO(
                    rs.getString("ID"),
                    rs.getString("PWD"),
                    rs.getString("NAME"),
                    rs.getString("BIRTH"),
                    rs.getString("PHONE1"),
                    rs.getString("PHONE2"),
                    rs.getString("PHONE3"),
                    rs.getString("EMAIL"),
                    rs.getString("ZIPCODE"),
                    rs.getString("ADDRESS1"),
                    rs.getString("ADDRESS2")
                );
            } else {
                svo = null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtility.dbClose(con, pstmt, rs);
        }
        return svo;
    }

    public Boolean insertDB(SignupVO svo) {
        Connection con = DBUtility.dbCon();
        PreparedStatement pstmt = null;
        int rs = 0;
        try {
            pstmt = con.prepareStatement(INSERT_SQL);
            pstmt.setString(1, svo.getId());
            pstmt.setString(2, svo.getPwd());
            pstmt.setString(3, svo.getName());
            pstmt.setString(4, svo.getBirth());
            pstmt.setString(5, svo.getPhone1());
            pstmt.setString(6, svo.getPhone2());
            pstmt.setString(7, svo.getPhone3());
            pstmt.setString(8, svo.getEmail());
            pstmt.setString(9, svo.getZipcode());
            pstmt.setString(10, svo.getAddress1());
            pstmt.setString(11, svo.getAddress2());
            rs = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtility.dbClose(con, pstmt);
        }
        return rs > 0;
    }

    public Boolean deleteDB(SignupVO svo) {
        Connection con = DBUtility.dbCon();
        PreparedStatement pstmt = null;
        int rs = 0;
        try {
            pstmt = con.prepareStatement(DELETE_SQL);
            pstmt.setString(1, svo.getId());
            rs = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtility.dbClose(con, pstmt);
        }
        return rs > 0;
    }

    public Boolean updateDB(SignupVO svo) {
        Connection con = DBUtility.dbCon();
        PreparedStatement pstmt = null;
        int rs = 0;
        try {
            pstmt = con.prepareStatement(UPDATE_SQL);
            pstmt.setString(1, svo.getPwd());
            pstmt.setString(2, svo.getName());
            pstmt.setString(3, svo.getBirth());
            pstmt.setString(4, svo.getPhone1());
            pstmt.setString(5, svo.getPhone2());
            pstmt.setString(6, svo.getPhone3());
            pstmt.setString(7, svo.getEmail());
            pstmt.setString(8, svo.getZipcode());
            pstmt.setString(9, svo.getAddress1());
            pstmt.setString(10, svo.getAddress2());
            pstmt.setString(11, svo.getId());
            rs = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtility.dbClose(con, pstmt);
        }
        return rs > 0;
    }

    public boolean selectIdCheck(SignupVO svo) {
        Connection con = DBUtility.dbCon();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        try {
            pstmt = con.prepareStatement(SELECT_ID_CHECK_SQL);
            pstmt.setString(1, svo.getId());
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("COUNT");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtility.dbClose(con, pstmt, rs);
        }
        return count > 0;
    }
}
