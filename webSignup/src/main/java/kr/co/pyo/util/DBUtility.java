package kr.co.pyo.util;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class DBUtility {

	public static Connection dbCon() {
		// 1. db.properties 파일 에서 id, pw 가져오기
		String filePath = "C:\\dev\\web-signup\\webSignup\\src\\main\\webapp\\resources\\db.properties";
		Properties pt = new Properties();
		try {
			pt.load(new FileReader(filePath));
		} catch (Exception e) {
			e.printStackTrace();
		}
		String user = pt.getProperty("user");
		String pw = pt.getProperty("pw");
		String url = pt.getProperty("url");
		Connection con = null;
		// 2. jdbc driver load, connection 생성
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(url, user, pw);
		} catch (ClassNotFoundException e) {
			System.out.println(e.toString());
		} catch (SQLException e) {
			System.out.println(e.toString());
		}
		return con;
	}

	public static void dbClose(Connection con, ResultSet rs, Statement... stmts) {
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				System.out.println(e.toString());
			}
		}
		for (Statement data : stmts) {
			if (data != null) {
				try {
					data.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
			}
		}

		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				System.out.println(e.toString());
			}
		}
	}

	public static void dbClose(Connection con, Statement... stmts) {
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				System.out.println(e.toString());
			}
		}
		for (Statement data : stmts) {
			if (data != null) {
				try {
					data.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
			}
		}

	}

	public static void dbClose(Connection con, PreparedStatement pstmt, ResultSet rs) {
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				System.out.println(e.toString());
			}
		}
			if ( pstmt != null) {
				try {
					 pstmt.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
			}

		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				System.out.println(e.toString());
			}
		}
	}

	public static void dbClose(Connection con, Statement stmt, ResultSet rs) {
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				System.out.println(e.toString());
			}
		}
			if ( stmt != null) {
				try {
					 stmt.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
			}

		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				System.out.println(e.toString());
			}
		}
		
		
	}
}
