package kr.co.pyo.signup.util;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

public final class ConnectionPool {
	// 1.
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	private ArrayList<Connection> free;
	private ArrayList<Connection> used; // 사용중인 커넥션을 저장하는 변수
	private int initialCons = 10; // 최초로 초기 커넥션수
	private int maxCons = 20; // 최대 커넥션수
	private int numCons = 0; // 총 Connection 수
	private String user = null;
	private String pw = null;
	private String url = null;;

	// 싱글톤(자기참조멤버변수, 생성자함수, 자기참조멤버변수)
	private static ConnectionPool cp;

	public static ConnectionPool getInstance() {
		if (cp == null) {
			synchronized (ConnectionPool.class) {
				cp = new ConnectionPool();
			}

		}
		return cp;
	}

	private ConnectionPool() {
		free = new ArrayList<Connection>(initialCons);
		used = new ArrayList<Connection>(initialCons);

		String filePath = "C:\\dev\\web-signup\\webSignup\\src\\main\\webapp\\resources\\db.properties";
		Properties pt = new Properties();
		try {
			pt.load(new FileReader(filePath));
		} catch (Exception e) {
			e.printStackTrace();
		}
		user = pt.getProperty("user");
		pw = pt.getProperty("pw");
		url = pt.getProperty("url");

		while (numCons < initialCons) {
			addConnection();
		}
	}

	// Connection free ArrayList
	private void addConnection() {
		free.add(getNewConnection());
	}

	// Connection 를 만들어서 리턴
	private Connection getNewConnection() {
		Connection con = null;

		try {
			con = DriverManager.getConnection(url, user, pw);
			numCons++;
			System.out.println("current to Connection: " + numCons);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return con;

	}

	public synchronized Connection dbCon() {

		// 1. free ArrayList Connection 들어있는지 확인
		Connection con = null;
		if (free.isEmpty()) {
			while (numCons < maxCons) {
				addConnection();

			}
		}
		con = free.get(free.size() - 1);
		free.remove(con);
		used.add(con);

		return con;

	}

	public void dbClose(Connection con, ResultSet rs, Statement... stmts) {
		if (con != null) {
			releaseConnection(con);
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

	public void dbClose(Connection con, Statement... stmts) {
		if (con != null) {
			releaseConnection(con);
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

	public void dbClose(Connection con, PreparedStatement pstmt, ResultSet rs) {
		if (con != null) {
			releaseConnection(con);
		}
		if (pstmt != null) {
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

	public void dbClose(Connection con, Statement stmt, ResultSet rs) {
		if (con != null) {
			releaseConnection(con);
		}
		if (stmt != null) {
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

	// ConnectionPool 만들어서 Connection free ArrayList에 반납하고 아니면 close
	public synchronized void releaseConnection(Connection con) {
		boolean flag = false;

		if (used.contains(con) == true) {
			used.remove(con);
			numCons--;
			free.add(con);
			flag = true;
		}

		try {
			if (flag == true) {
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//현재 커넥션풀에 있는커넥션을 모두 제거
	public void closeAll() {
		// used에 있는 커넥션을 모두 삭제해 버림.
		for (int i = 0; i < used.size(); i++) {
			Connection _con = (Connection) used.get(i);
			used.remove(i--);
			try {
				_con.close();
			} catch (SQLException sqle) {
				sqle.printStackTrace();
			}
		}
		// free에 있는 커넥션을 모두 삭제해 버림.
		for (int i = 0; i < free.size(); i++) {
			Connection _con = (Connection) free.get(i);
			free.remove(i--);
			try {
				_con.close();
			} catch (SQLException sqle) {
				sqle.printStackTrace();
			}
		}

	}
}