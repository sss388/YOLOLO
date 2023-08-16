package com.semi.yolo.customerService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.semi.yolo.customerService.vo.Board;
import com.semi.yolo.common.util.PageInfo;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;

public class commonDao {

	public int getBoardCount(Connection connection) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null; // 쿼리를 select로 실행시키면 무조건 resultset을 써줘야 한다.
		String query = "SELECT COUNT(*) FROM YOLO_COMMON";
		
		try {
			pstmt = connection.prepareStatement(query);
			rs = pstmt.executeQuery();
		
			if (rs.next()) {
				count = rs.getInt(1); // 1는 컬럼 순번 (어차피 셀렉은 1행1열로 나오니깐)
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rs);
		}
		
		return count;
	}

	public List<Board> findAll(Connection connection, PageInfo pageInfo) {
		List<Board> list = new ArrayList<>(); // 조회되는게 있으면 리스트에 담아서 주고, 없으면 빈 리스트를 주게
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query =  "SELECT RNUM, b.* FROM (SELECT ROWNUM AS RNUM, a.* FROM (SELECT B.NO, B.TITLE,M.ID, B.CREATE_DATE, B.ORIGINAL_FILENAME, B.READCOUNT,B.CONTENT FROM YOLO_COMMON B JOIN YOLO_MEMBER M ON(B.WRITER_NO = M.NO) ORDER BY B.NO DESC) a) b WHERE RNUM BETWEEN ? and ?"
				+ "";
		try {
			pstmt = connection.prepareStatement(query);
			
			int startList = pageInfo.getStartList();
			int endList = pageInfo.getEndList();
			pstmt.setInt(1, 0);
			pstmt.setInt(2, 100);
			
			rs = pstmt.executeQuery();
			
			// 1. 조회된 행에 하나씩 접근한다 (false를 리턴할 때까지)
			while (rs.next()) {
				// 2. 조회가 되면 각각의 행을 하나씩 객체로 만든다
				Board board = new Board();
				
				board.setNo(rs.getInt("NO"));
				board.setRowNum(rs.getInt("RNUM"));
				board.setWriterId(rs.getString("ID"));
				board.setTitle(rs.getString("TITLE"));
				board.setCreateDate(rs.getDate("CREATE_DATE"));
				board.setOriginalFilename(rs.getString("ORIGINAL_FILENAME"));
				board.setReadCount(rs.getInt("READCOUNT"));
				board.setContent(rs.getString("content"));
				
				// 만들어진 객체들을 리스트에 포함시킨다
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

	public Board findBoardByNo(Connection connection, int no) {
		Board board = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT  B.NO, "
							+ "B.TITLE, M.ID, "
							+ "B.READCOUNT, "
							+ "B.ORIGINAL_FILENAME, "
							+ "B.RENAMED_FILENAME, "
							+ "B.CONTENT, "
							+ "B.CREATE_DATE "
				+ "FROM YOLO_COMMON B "
				+ "INNER JOIN YOLO_MEMBER M ON(B.WRITER_NO = M.NO) "
				+ "WHERE B.NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				board = new Board();
				
				board.setNo(rs.getInt("NO"));
				board.setTitle(rs.getString("TITLE"));
				board.setWriterId(rs.getString("ID"));
				board.setReadCount(rs.getInt("READCOUNT"));
				board.setOriginalFilename(rs.getString("ORIGINAL_FILENAME"));
				board.setRenamedFilename(rs.getString("RENAMED_FILENAME"));
				board.setContent(rs.getString("CONTENT"));
				board.setCreateDate(rs.getDate("CREATE_DATE"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return board;
	}

	public int insertBoard(Connection connection, Board board) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "INSERT INTO YOLO_COMMON VALUES(SEQ_YOLO_COMMON_NO.NEXTVAL,?,?,?,?,?,DEFAULT,DEFAULT)";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			// 위의 쿼리문의 ?(5개)값들을 정해줌
			pstmt.setInt(1, board.getWriterNo());
			pstmt.setString(2, board.getTitle());
			pstmt.setString(3, board.getContent());
			pstmt.setString(4, null);
			pstmt.setString(5, null);
			
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
		String query = "UPDATE YOLO_QNABOARD SET TITLE=?,CONTENT=?,ORIGINAL_FILENAME=?,RENAMED_FILENAME=?,MODIFY_DATE=SYSDATE WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setString(3, board.getOriginalFilename());
			pstmt.setString(4, board.getRenamedFilename());
			pstmt.setInt(5, board.getNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int updateStatus(Connection connection, int no, String status) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE YOLO_QNABOARD SET STATUS=? WHERE NO=?"; // status 상태 변경이 아니라 그냥 지우고 싶으면 delete 쿼리쓰면 된다
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, status);
			pstmt.setInt(2, no);
			
			result = pstmt.executeUpdate(); 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 삭제 위해서 추가
	public int deleteBoard(Connection connection, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE YOLO_QNABOARD SET STATE='N' WHERE NO=?";
		
		System.out.println(no);
		
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

	

}
