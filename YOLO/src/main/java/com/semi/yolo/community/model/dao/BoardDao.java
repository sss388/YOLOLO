package com.semi.yolo.community.model.dao;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.community.model.vo.Board;

public class BoardDao {

	public int getFreeBoardCount(Connection connection) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT COUNT(*) FROM YOLO_BOARD WHERE STATUS='Y'";
		
		try {
			pstmt = connection.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return count;
	}
	
	public int getBoardCountByKeyword(Connection connection, int kind, String keyword) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT COUNT(*) FROM YOLO_BOARD WHERE STATUS='Y' AND KIND=? AND TITLE LIKE ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, kind);
			pstmt.setString(2, "%" + keyword + "%"); // 검색어 추가
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return count;
	}
	
	public int getBoardCount(Connection connection, int kind) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT COUNT(*) FROM YOLO_BOARD WHERE STATUS='Y' AND KIND=" + kind;
		
		try {
			pstmt = connection.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return count;
	}

	public List<Board> findAll(Connection connection, PageInfo pageInfo, int kind) {
		List<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT *"
	              + "FROM ("
	              + "    SELECT yb.NO AS NO,"
	              + "           yb.TITLE AS TITLE,"
	              + "           yb.CONTENT AS CONTENT,"
	              + "           yb.KIND AS KIND,"
	              + "           yb.USER_NO AS USER_NO,"
	              + "			yb.CREATE_DATE AS CREATE_DATE,"
	              + "           ym.NAME AS NAME,"
	              + "           ROW_NUMBER() OVER (ORDER BY yb.NO DESC) AS RN"
	              + "    FROM YOLO_BOARD yb"
	              + "         INNER JOIN YOLO_MEMBER ym ON yb.USER_NO = ym.NO"
	              + "	   WHERE yb.STATUS = 'Y' AND yb.KIND = ?"
	              + ")"
	              + "WHERE RN BETWEEN ? AND ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, kind);
			pstmt.setInt(2, pageInfo.getStartList());
			pstmt.setInt(3, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Board board = new Board();
				
				board.setNo(rs.getInt("NO"));
				board.setTitle(rs.getString("TITLE"));
				board.setContent(rs.getString("CONTENT"));
				board.setCreateDate(rs.getDate("CREATE_DATE"));
				board.setRowNum(rs.getInt("RN"));
				board.setUserName(rs.getString("NAME"));
				if(board.getContent().indexOf("<img src=\"") != -1) {
					board.setThumb(board.getContent().substring(board.getContent().indexOf("<img src=\"") + 10 , board.getContent().indexOf("\">", board.getContent().indexOf("<img src=\""))));					
				}
				
				list.add(board);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}
	
	public List<Board> findAllByKeyword(Connection connection, PageInfo pageInfo, int kind, String keyword) {
		List<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT *"
	              + "FROM ("
	              + "    SELECT yb.NO AS NO,"
	              + "           yb.TITLE AS TITLE,"
	              + "           yb.CONTENT AS CONTENT,"
	              + "           yb.KIND AS KIND,"
	              + "           yb.USER_NO AS USER_NO,"
	              + "			yb.CREATE_DATE AS CREATE_DATE,"
	              + "           ym.NAME AS NAME,"
	              + "           ROW_NUMBER() OVER (ORDER BY yb.NO DESC) AS RN"
	              + "    FROM YOLO_BOARD yb"
	              + "         INNER JOIN YOLO_MEMBER ym ON yb.USER_NO = ym.NO"
	              + "	   WHERE yb.STATUS = 'Y' AND yb.KIND = ? AND yb.TITLE LIKE ?"
	              + ")"
	              + "WHERE RN BETWEEN ? AND ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, kind);
			pstmt.setString(2, "%" + keyword + "%");
			pstmt.setInt(3, pageInfo.getStartList());
			pstmt.setInt(4, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Board board = new Board();
				
				board.setNo(rs.getInt("NO"));
				board.setTitle(rs.getString("TITLE"));
				board.setContent(rs.getString("CONTENT"));
				board.setCreateDate(rs.getDate("CREATE_DATE"));
				board.setRowNum(rs.getInt("RN"));
				board.setUserName(rs.getString("NAME"));
				if(board.getContent().indexOf("<img src=\"") != -1) {
					board.setThumb(board.getContent().substring(board.getContent().indexOf("<img src=\"") + 10 , board.getContent().indexOf("\">", board.getContent().indexOf("<img src=\""))));					
				}
				
				list.add(board);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}
	
	
	public int insertboard(Connection connection, Board board) {
	    int result = 0;
	    PreparedStatement pstmt = null;
	    
	    String seqQuery = "SELECT YOLO_BOARD_NO.NEXTVAL FROM DUAL";
	    String query = "INSERT INTO YOLO_BOARD (NO, TITLE, CONTENT, KIND, USER_NO)"
	    		+ "VALUES (?,?,?,?,?)";

	    try {
	    	pstmt = connection.prepareStatement(seqQuery);
	        ResultSet rs = pstmt.executeQuery();

	        // 시퀀스의 다음 값을 변수에 저장
	        if(rs.next()) {
	        	board.setNo(rs.getInt(1));	        	
	        }
	    	
	        pstmt = connection.prepareStatement(query);

	        pstmt.setInt(1, board.getNo());
	        pstmt.setString(2, board.getTitle());
	        pstmt.setString(3, board.getContent());
	        pstmt.setInt(4, board.getKind());
	        pstmt.setInt(5, board.getUserNo());

	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(pstmt);
	    }

	    return result;
	}

	public int updateBoard(Connection connection, Board board) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE YOLO_BOARD SET TITLE=?,CONTENT=?,CREATE_DATE=SYSDATE WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
	        pstmt.setString(1, board.getTitle());
	        pstmt.setString(2, board.getContent());
	        pstmt.setInt(3, board.getNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}		
		
		return result;
	}

	public int deleteBoard(Connection connection, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE YOLO_BOARD SET STATUS='N' WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, no);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public Board findBoardByNo(Connection connection, int no) {
		Board board = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT * FROM YOLO_BOARD WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				board = new Board();
				
				board.setNo(rs.getInt("NO"));
				board.setTitle(rs.getString("TITLE"));
				board.setContent(rs.getString("CONTENT"));
				board.setCreateDate(rs.getDate("CREATE_DATE"));
				board.setUserNo(rs.getInt("USER_NO"));
				board.setKind(rs.getInt("KIND"));
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}		
		
		return board;
	}
	
	public List<Board> findAll(Connection connection, int kind) {
		List<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT *"
						+ "FROM ("
						+ "    SELECT yb.*,"
						+ "           ROW_NUMBER() OVER (ORDER BY NO DESC) AS RN"
						+ "    FROM YOLO_BOARD yb"
						+ "	   WHERE yb.STATUS = 'Y' AND yb.KIND = ?"
						+ ")"
						+ "WHERE RN BETWEEN 1 AND 4";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, kind);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Board board = new Board();
				
				board.setNo(rs.getInt("NO"));
				board.setTitle(rs.getString("TITLE"));
				board.setContent(rs.getString("CONTENT"));
				board.setCreateDate(rs.getDate("CREATE_DATE"));
				board.setState(rs.getString("STATUS").charAt(0));
				board.setRowNum(rs.getInt("RN"));
				if(kind == 2 && board.getContent().indexOf("<img src=\"") != -1) {
					board.setThumb(board.getContent().substring(board.getContent().indexOf("<img src=\"") + 10 , board.getContent().indexOf("\">", board.getContent().indexOf("<img src=\""))));					
				}
				
				list.add(board);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	public int updateReviewContentByNo(Connection connection, int no, String content) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE YOLO_BOARD SET CONTENT=? WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, content);
			pstmt.setInt(2, no);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}


}
