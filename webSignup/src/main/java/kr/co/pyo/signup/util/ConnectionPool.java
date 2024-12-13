package kr.co.pyo.signup.util;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

public final class ConnectionPool {
    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private ArrayList<Connection> free;
    private ArrayList<Connection> used;
    private int initialCons = 10;
    private int maxCons = 20;
    private int numCons = 0;
    private String user;
    private String pw;
    private String url;

    private static ConnectionPool cp;

    public static synchronized ConnectionPool getInstance() {
        if (cp == null) {
            cp = new ConnectionPool();
        }
        return cp;
    }

    private ConnectionPool() {
        free = new ArrayList<>(initialCons);
        used = new ArrayList<>(initialCons);

        String filePath = "C:\\dev\\web-signup\\webSignup\\src\\main\\webapp\\resources\\db.properties";
        try (FileInputStream input = new FileInputStream(filePath)) {
            Properties pt = new Properties();
            pt.load(input);
            user = pt.getProperty("user");
            pw = pt.getProperty("pw");
            url = pt.getProperty("url");

            for (int i = 0; i < initialCons; i++) {
                free.add(getNewConnection());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private synchronized Connection getNewConnection() {
        try {
            numCons++;
            return DriverManager.getConnection(url, user, pw);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public synchronized Connection dbCon() {
        if (free.isEmpty() && numCons < maxCons) {
            free.add(getNewConnection());
        }

        if (!free.isEmpty()) {
            Connection con = free.remove(free.size() - 1);
            used.add(con);
            return con;
        } else {
            throw new RuntimeException("모든 커넥션이 사용 중입니다.");
        }
    }

    public synchronized void releaseConnection(Connection con) {
        if (used.remove(con)) {
            free.add(con);
        }
    }

    public void dbClose(Connection con, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) releaseConnection(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void dbClose(Connection con, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) releaseConnection(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void dbClose(Connection con, Statement stmt) {
        try {
            if (stmt != null) stmt.close();
            if (con != null) releaseConnection(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public synchronized void closeAll() {
        for (Connection con : free) {
            try {
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        free.clear();

        for (Connection con : used) {
            try {
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        used.clear();
        numCons = 0;
    }
}
