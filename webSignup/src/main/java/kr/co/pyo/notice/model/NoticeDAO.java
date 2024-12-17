package kr.co.pyo.notice.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import kr.co.pyo.signup.util.ConnectionPool;

public class NoticeDAO {
		private static NoticeDAO instance;

		private NoticeDAO() {
		}

		public static NoticeDAO getInstance() {
			if (instance == null) {
				synchronized (NoticeDAO.class) {
					instance = new NoticeDAO();
				}
			}

			return instance;
		}

		private final String SELECT_SQL = "SELECT * FROM NOTICE ORDER BY NUM DESC";
		private final String SELECT_START_END_SQL = 
		    "SELECT * FROM "
		    + "(SELECT ROWNUM AS RNUM, NUM, WRITER, EMAIL, SUBJECT, PASS, REGDATE, READCOUNT, REF, STEP, DEPTH, CONTENT, IP "
		    + "FROM (SELECT * FROM NOTICE ORDER BY REF DESC, STEP ASC)) "
		    + "WHERE RNUM >= ? AND RNUM <= ?";
		private final String SELECT_PASS_SQL = "SELECT COUNT(*) AS COUNT FROM NOTICE WHERE NUM = ? AND PASS = ?";
		private final String SELECT_ONE_SQL = "SELECT * FROM NOTICE WHERE NUM = ?";
		private final String SELECT_COUNT_SQL = "SELECT COUNT(*) AS COUNT FROM NOTICE";
		private final String SELECT_MAX_NUM_SQL = "SELECT MAX(NUM) AS NUM FROM NOTICE";
		private final String INSERT_SQL = "INSERT INTO NOTICE (NUM, WRITER, EMAIL, SUBJECT, PASS, REGDATE, REF, STEP, DEPTH, CONTENT, IP) "
		                                + "VALUES (NOTICE_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		private final String DELETE_SQL = "DELETE FROM NOTICE WHERE NUM = ? AND PASS = ?";
		private final String UPDATE_SQL = "UPDATE NOTICE SET WRITER = ?, EMAIL = ?, SUBJECT = ?, CONTENT = ? WHERE NUM = ?";
		private final String UPDATE_STEP_SQL = "UPDATE NOTICE SET STEP = STEP + 1 WHERE REF = ? AND STEP > ?";
		private final String UPDATE_READCOUNT_SQL = "UPDATE NOTICE SET READCOUNT = READCOUNT + 1 WHERE NUM = ?";

		
		// 공지사항 최근 N개 가져오기
	    public ArrayList<NoticeVO> selectNoticeList(int limit) {
	    	ArrayList<NoticeVO> noticeList = new ArrayList<>();
	    	Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	    	
	        String sql = "SELECT * FROM NOTICE ORDER BY REGDATE DESC FETCH FIRST ? ROWS ONLY";
	        try {
	            con = ConnectionPool.getInstance().dbCon();
	            pstmt = con.prepareStatement(sql);
	            pstmt.setInt(1, limit);
	            rs = pstmt.executeQuery();

	            while (rs.next()) {
	                noticeList.add(mapResultSetToNoticeVO(rs));
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            // 자원 반환
	            ConnectionPool.getInstance().dbClose(con, pstmt, rs);
	        }
	        return noticeList;
	    }

	    // ResultSet을 NoticeVO로 매핑
	    private NoticeVO mapResultSetToNoticeVO(ResultSet rs) throws SQLException {
	        NoticeVO vo = new NoticeVO();
	        vo.setNum(rs.getInt("NUM"));
	        vo.setWriter(rs.getString("WRITER"));
	        vo.setSubject(rs.getString("SUBJECT"));
	        vo.setRegdate(rs.getTimestamp("REGDATE"));
	        vo.setReadcount(rs.getInt("READCOUNT"));
	        return vo;
	    }
	


		// 게시글 삭제하기
		public boolean deleteDB(NoticeVO vo) {
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

	        return (count != 0) ? (true):(false);
	    }
		
		// 게시글 입력하기
		public Boolean insertDB(NoticeVO vo) {
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
					// 가장최고값 + 1
					number = rs.getInt("NUM") + 1;
				} else {
					// 가장최고값이 없으면 1
					number = 1;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			try {
				if (vo.getNum() != 0) {// 답변글일경우
					pstmt = con.prepareStatement(UPDATE_STEP_SQL);
					pstmt.setInt(1, vo.getRef());
					pstmt.setInt(2, vo.getStep());
					pstmt.executeUpdate();
					ref = vo.getRef();
					step = vo.getStep() + 1;
					depth = vo.getDepth() + 1;
				} else {// 새 글일 경우
					ref = number; // 가장최고값 + 1
					step = 0;
					depth = 0;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 게시판 글 입력하기
			try {
				pstmt = con.prepareStatement(INSERT_SQL);

				pstmt.setString(1, vo.getWriter());
				pstmt.setString(2, vo.getEmail());
				pstmt.setString(3, vo.getSubject());
				pstmt.setString(4, vo.getPass());
				pstmt.setTimestamp(5, vo.getRegdate());
				pstmt.setInt(6, ref);
				pstmt.setInt(7, step);
				pstmt.setInt(8, depth);
				pstmt.setString(9, vo.getContent());
				pstmt.setString(10, vo.getIp());

				count = pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				cp.dbClose(con, pstmt);
			}
			return (count > 0) ? (true) : (false);
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
		public ArrayList<NoticeVO> selectStartEndDB(int start, int end) {
			ConnectionPool cp = ConnectionPool.getInstance();
			Connection con = cp.dbCon();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ArrayList<NoticeVO> boardList = new ArrayList<NoticeVO>(end-start+1);
			try {
				pstmt = con.prepareStatement(SELECT_START_END_SQL);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				while (rs.next()) {
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
					NoticeVO vo = new NoticeVO(num, writer, email, subject, pass, readcount, ref, step, depth, regdate,
							content, ip);
					boardList.add(vo);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				cp.dbClose(con, pstmt, rs);
			}
			return boardList;
		}

		//게시글 전체 검색하기
		public ArrayList<NoticeVO> selectDB() {
			ConnectionPool cp = ConnectionPool.getInstance();
			Connection con = cp.dbCon();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ArrayList<NoticeVO> boardList = new ArrayList<NoticeVO>();
			try {
				pstmt = con.prepareStatement(SELECT_SQL);
				rs = pstmt.executeQuery();
				while (rs.next()) {
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
					NoticeVO vo = new NoticeVO(num, writer, email, subject, pass, readcount, ref, step, depth, regdate,
							content, ip);
					boardList.add(vo);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				cp.dbClose(con, pstmt, rs);
			}
			return boardList;
		}
		
		// 게시글 번호검색해서 조회수 조회
		public NoticeVO selectBoardDB(NoticeVO vo) {
			ConnectionPool cp = ConnectionPool.getInstance();
			Connection con = cp.dbCon();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			NoticeVO bvo = null;

			try {
				pstmt = con.prepareStatement(UPDATE_READCOUNT_SQL);
				pstmt.setInt(1, vo.getNum());
				pstmt.executeUpdate();

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
					bvo = new NoticeVO(num, writer, email, subject, pass, readcount, ref, step, depth, regdate, content, ip);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				cp.dbClose(con, pstmt, rs);
			}
			return bvo;
		}

		// 게시글 번호 검색
		public NoticeVO selectBoardOneDB(NoticeVO vo) {
			ConnectionPool cp = ConnectionPool.getInstance();
			Connection con = cp.dbCon();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			NoticeVO bvo = null;

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
					bvo = new NoticeVO(num, writer, email, subject, pass, readcount, ref, step, depth, regdate, content, ip);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				cp.dbClose(con, pstmt, rs);
			}
			return bvo;
		}

		// 게시글 수정하기
		public int updateDB(NoticeVO vo) {
			ConnectionPool cp = ConnectionPool.getInstance();
			Connection con = cp.dbCon();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int passCheckCount = 0;
			int count = 0;
			int returnValue = 1;

			try {
				pstmt = con.prepareStatement(SELECT_PASS_SQL);
				pstmt.setInt(1, vo.getNum());
				pstmt.setString(2, vo.getPass());
				rs = pstmt.executeQuery();
				if (rs.next()) {
					passCheckCount = rs.getInt("COUNT");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			if (passCheckCount != 0) {
				try {
					pstmt = con.prepareStatement(UPDATE_SQL);
					pstmt.setString(1, vo.getWriter());
					pstmt.setString(2, vo.getEmail());
					pstmt.setString(3, vo.getSubject());
					pstmt.setString(4, vo.getContent());
					pstmt.setInt(5, vo.getNum());
					count = pstmt.executeUpdate();
					if (count == 0) {
						returnValue = 3;
					}else {
						returnValue = 1;
					}
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					cp.dbClose(con, pstmt);
				}

			}else {
				returnValue = 2;
			}
			return returnValue;
		}

	}
