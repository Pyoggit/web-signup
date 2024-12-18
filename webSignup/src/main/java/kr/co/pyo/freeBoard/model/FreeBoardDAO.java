package kr.co.pyo.freeBoard.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import kr.co.pyo.notice.model.NoticeVO;
import kr.co.pyo.signup.util.ConnectionPool;

public class FreeBoardDAO {
	private static FreeBoardDAO instance;

	private FreeBoardDAO() {
	}

	public static FreeBoardDAO getInstance() {
		if (instance == null) {
			synchronized (FreeBoardDAO.class) {
				instance = new FreeBoardDAO();
			}
		}
		return instance;
	}

	private final String SELECT_SQL = "SELECT * FROM FREEBOARD ORDER BY NUM DESC";
	private final String SELECT_START_END_SQL = "SELECT * FROM "
			+ "(SELECT ROWNUM AS RNUM, NUM, WRITER, EMAIL, SUBJECT, PASS, REGDATE, READCOUNT, REF, STEP, DEPTH, CONTENT, IP "
			+ "FROM (SELECT * FROM FREEBOARD ORDER BY REF DESC, STEP ASC)) " + "WHERE RNUM >= ? AND RNUM <= ?";
	private final String SELECT_PASS_SQL = "SELECT COUNT(*) AS COUNT FROM FREEBOARD WHERE NUM = ? AND PASS = ?";
	private final String SELECT_ONE_SQL = "SELECT * FROM FREEBOARD WHERE NUM = ?";
	private final String SELECT_COUNT_SQL = "SELECT COUNT(*) AS COUNT FROM FREEBOARD";
	private final String SELECT_MAX_NUM_SQL = "SELECT MAX(NUM) AS NUM FROM FREEBOARD";
	private final String INSERT_SQL = "INSERT INTO FREEBOARD (NUM, WRITER, EMAIL, SUBJECT, PASS, REGDATE, REF, STEP, DEPTH, CONTENT, IP) "
			+ "VALUES (FREEBOARD_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private final String DELETE_SQL = "DELETE FROM FREEBOARD WHERE NUM = ? AND PASS = ?";
	private final String UPDATE_SQL = "UPDATE FREEBOARD SET WRITER = ?, EMAIL = ?, SUBJECT = ?, CONTENT = ? WHERE NUM = ?";
	private final String UPDATE_STEP_SQL = "UPDATE FREEBOARD SET STEP = STEP + 1 WHERE REF = ? AND STEP > ?";
	private final String UPDATE_READCOUNT_SQL = "UPDATE FREEBOARD SET READCOUNT = READCOUNT + 1 WHERE NUM = ?";

	// 댓글 저장
	public boolean insertComment(FreeBoardCommentVO comment) {
		String sql = "INSERT INTO FREEBOARDCOMMENT (COMMENTID, BOARDNUM, WRITER, CONTENT, REGDATE) "
				+ "VALUES (FREEBOARDCOMMENT_SEQ.NEXTVAL, ?, ?, ?, DEFAULT)";
		try (Connection con = ConnectionPool.getInstance().dbCon();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, comment.getBoardNum());
			pstmt.setString(2, comment.getWriter());
			pstmt.setString(3, comment.getContent());
			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// 댓글 목록 조회
	public ArrayList<FreeBoardCommentVO> getCommentsByBoardNum(int boardNum) {
		ArrayList<FreeBoardCommentVO> commentList = new ArrayList<>();
		String sql = "SELECT * FROM FREEBOARDCOMMENT WHERE BOARDNUM = ? ORDER BY REGDATE ASC";
		try (Connection con = ConnectionPool.getInstance().dbCon();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, boardNum);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					FreeBoardCommentVO comment = new FreeBoardCommentVO();
					comment.setCommentId(rs.getInt("COMMENTID"));
					comment.setBoardNum(rs.getInt("BOARDNUM"));
					comment.setWriter(rs.getString("WRITER"));
					comment.setContent(rs.getString("CONTENT"));
					comment.setRegdate(rs.getTimestamp("REGDATE"));
					commentList.add(comment);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return commentList;
	}

	// 자유게시판 최근 N개 가져오기
	public ArrayList<FreeBoardVO> selectFreeBoardList(int limit) {
		ArrayList<FreeBoardVO> boardList = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM FREEBOARD ORDER BY REGDATE DESC FETCH FIRST ? ROWS ONLY";
		try {
			con = ConnectionPool.getInstance().dbCon();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, limit);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				boardList.add(mapResultSetToFreeBoardVO(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.getInstance().dbClose(con, pstmt, rs);
		}
		return boardList;
	}

	// ResultSet을 FreeBoardVO로 매핑
	private FreeBoardVO mapResultSetToFreeBoardVO(ResultSet rs) throws SQLException {
		FreeBoardVO vo = new FreeBoardVO();
		vo.setNum(rs.getInt("NUM"));
		vo.setWriter(rs.getString("WRITER"));
		vo.setSubject(rs.getString("SUBJECT"));
		vo.setRegdate(rs.getTimestamp("REGDATE"));
		vo.setReadcount(rs.getInt("READCOUNT"));
		vo.setIp(rs.getString("IP"));
		return vo;
	}

	// 게시글 번호를 통해 게시글 조회 및 조회수 증가
	public FreeBoardVO selectBoardDB(FreeBoardVO vo) {
		FreeBoardVO board = null;
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// 조회수 증가
			pstmt = con.prepareStatement(UPDATE_READCOUNT_SQL);
			pstmt.setInt(1, vo.getNum());
			pstmt.executeUpdate();
			pstmt.close();

			// 게시글 조회
			pstmt = con.prepareStatement(SELECT_ONE_SQL);
			pstmt.setInt(1, vo.getNum());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				board = new FreeBoardVO();
				board.setNum(rs.getInt("NUM"));
				board.setWriter(rs.getString("WRITER"));
				board.setEmail(rs.getString("EMAIL"));
				board.setSubject(rs.getString("SUBJECT"));
				board.setPass(rs.getString("PASS"));
				board.setRegdate(rs.getTimestamp("REGDATE"));
				board.setReadcount(rs.getInt("READCOUNT"));
				board.setRef(rs.getInt("REF"));
				board.setStep(rs.getInt("STEP"));
				board.setDepth(rs.getInt("DEPTH"));
				board.setContent(rs.getString("CONTENT"));
				board.setIp(rs.getString("IP"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return board;
	}

	// 게시글 삭제하기
	public boolean deleteDB(FreeBoardVO vo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count = 0;

		try {
			pstmt = con.prepareStatement(DELETE_SQL);
			pstmt.setInt(1, vo.getNum());
			pstmt.setString(2, vo.getPass());
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt);
		}
		return count != 0;
	}

	// FreeBoardVO만 받는 insertDB 오버로딩 메서드 추가
	public Boolean insertDB(FreeBoardVO vo) {
	    return insertDB(vo, vo.getIp());
	}
	
	// 게시글 입력하기
	public Boolean insertDB(FreeBoardVO vo, String userIp) {
	    ConnectionPool cp = ConnectionPool.getInstance();
	    Connection con = cp.dbCon();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int number = 0;
	    int step = 0;
	    int depth = 0;
	    int ref = 1;
	    int count = 0;

	    try {
	        pstmt = con.prepareStatement(SELECT_MAX_NUM_SQL);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            number = rs.getInt("NUM") + 1;
	        } else {
	            number = 1;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    try {
	        if (vo.getNum() != 0) {
	            pstmt = con.prepareStatement(UPDATE_STEP_SQL);
	            pstmt.setInt(1, vo.getRef());
	            pstmt.setInt(2, vo.getStep());
	            pstmt.executeUpdate();
	            ref = vo.getRef();
	            step = vo.getStep() + 1;
	            depth = vo.getDepth() + 1;
	        } else {
	            ref = number;
	            step = 0;
	            depth = 0;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    try {
	        pstmt = con.prepareStatement(INSERT_SQL);
	        pstmt.setString(1, vo.getWriter()); // 닉네임 자동 입력
	        pstmt.setString(2, vo.getEmail());  // 이메일 자동 입력
	        pstmt.setString(3, vo.getSubject());
	        pstmt.setString(4, vo.getPass());
	        pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
	        pstmt.setInt(6, ref);
	        pstmt.setInt(7, step);
	        pstmt.setInt(8, depth);
	        pstmt.setString(9, vo.getContent());
	        pstmt.setString(10, userIp); // IP 주소 추가
	        count = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        cp.dbClose(con, pstmt, rs);
	    }
	    return count > 0;
	}

	// 특정 게시글 번호로 게시글 정보를 가져오기
	public FreeBoardVO selectBoardOneDB(FreeBoardVO vo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FreeBoardVO fvo = null;

		try {
			pstmt = con.prepareStatement(SELECT_ONE_SQL);
			pstmt.setInt(1, vo.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int num = rs.getInt("num");
				String writer = rs.getString("writer");
				String email = rs.getString("email");
				String subject = rs.getString("subject");
				String pass = rs.getString("pass");
				Timestamp regdate = rs.getTimestamp("regdate");
				int readcount = rs.getInt("readcount");
				int ref = rs.getInt("ref");
				int step = rs.getInt("step");
				int depth = rs.getInt("depth");
				String content = rs.getString("content");
				String ip = rs.getString("ip");
				fvo = new FreeBoardVO(num, writer, email, subject, pass, readcount, ref, step, depth, regdate, content,
						ip);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return fvo;
	}

	// 게시글 숫자 검색하기
	public int selectCountDB() {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {
			pstmt = con.prepareStatement(SELECT_COUNT_SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("COUNT");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return count;
	}

	// 페이징 기법
	public ArrayList<FreeBoardVO> selectStartEndDB(int start, int end) {
		ArrayList<FreeBoardVO> boardList = new ArrayList<>();
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement(SELECT_START_END_SQL);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				boardList.add(mapResultSetToFreeBoardVO(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return boardList;
	}

	// 게시글 수정하기
	public int updateDB(FreeBoardVO vo) {
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {
			pstmt = con.prepareStatement(UPDATE_SQL);
			pstmt.setString(1, vo.getWriter());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getSubject());
			pstmt.setString(4, vo.getContent());
			pstmt.setInt(5, vo.getNum());
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			cp.dbClose(con, pstmt, rs);
		}
		return count;
	}
}
