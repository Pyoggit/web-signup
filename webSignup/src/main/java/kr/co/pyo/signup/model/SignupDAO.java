package kr.co.pyo.signup.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.pyo.signup.util.DBUtility;

public class SignupDAO {
	private final String SELECT_SQL = "SELECT * FROM SIGNUP";
	private final String SELECT_BY_ID_SQL = "SELECT * FROM SIGNUP WHERE ID = ?";
	private final String SELECT_ID_CHECK_SQL = "SELECT COUNT(*) AS COUNT FROM SIGNUP WHERE ID = ?";
	private final String SELECT_LOGIN_CHECK_SQL = "SELECT * FROM SIGNUP WHERE ID = ? AND PWD = ?";
	private final String INSERT_SQL = "INSERT INTO SIGNUP VALUES(?,?,?,?,?)";
	private final String DELETE_SQL = "DELETE FROM SIGNUP WHERE ID = ?";
	private final String UPDATE_SQL = "UPDATE SIGNUP SET PWD = ?, EMAIL = ?, NAME = ?, BIRTH = ? WHERE ID = ?";

	// 전체를 DB에서 출력
	public ArrayList<SignupVO> selectDB() {
		Connection con = DBUtility.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<SignupVO> mList = new ArrayList<SignupVO>();
		try {
			pstmt = con.prepareStatement(SELECT_SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String id = rs.getString("ID");
				String pwd = rs.getString("PWD");
				String email = rs.getString("EMAIL");
				String name = rs.getString("NAME");
				int birth = rs.getInt("BIRTH");
				SignupVO svo = new SignupVO(id, pwd, email, name, birth);
				mList.add(svo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return mList;
	}

	// 아이디를 받아서 아이디에 맞는 레코드 출력
	public SignupVO selectByIdDB(SignupVO svo) {
		Connection con = DBUtility.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(SELECT_BY_ID_SQL);
			pstmt.setString(1, svo.getId());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String id = rs.getString("ID");
				String pwd = rs.getString("PWD");
				String email = rs.getString("EMAIL");
				String name = rs.getString("NAME");
				int birth = rs.getInt("BIRTH");
				svo = new SignupVO(id, pwd, email, name, birth);
			} else {
				svo = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return svo;
	}

	// id, pwd를받아서 맞는 레코드를 출력
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
				String id = rs.getString("ID");
				String pwd = rs.getString("PWD");
				String email = rs.getString("EMAIL");
				String name = rs.getString("NAME");
				int birth = rs.getInt("BIRTH");
				svo = new SignupVO(id, pwd, email, name, birth);
			} else {
				svo = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
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
			pstmt.setString(3, svo.getEmail());
			pstmt.setString(4, svo.getName());
			pstmt.setInt(5, svo.getBirth());
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return (rs == 0) ? false : true;
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
		}
		return (rs == 0) ? false : true;
	}

	public Boolean updateDB(SignupVO svo) {
		Connection con = DBUtility.dbCon();
		PreparedStatement pstmt = null;
		int rs = 0;
		try {
			pstmt = con.prepareStatement(UPDATE_SQL);
	        pstmt.setString(1, svo.getPwd());
	        pstmt.setString(2, svo.getEmail());
	        pstmt.setString(3, svo.getName());
	        pstmt.setInt(4, svo.getBirth());
	        pstmt.setString(5, svo.getId()); // WHERE 조건 추가
	        rs = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DBUtility.dbClose(con, pstmt);
	    }
	    return rs > 0; // 성공 시 true 반환
	}
	
	public boolean selectIdCheck(SignupVO svo) {
		//ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = DBUtility.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			pstmt = con.prepareStatement(SELECT_ID_CHECK_SQL);
			pstmt.setString(1, svo.getId());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				count = rs.getInt("COUNT");

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtility.dbClose(con, pstmt, rs);
		}
		return (count != 0) ? (true) : (false);
	}
}