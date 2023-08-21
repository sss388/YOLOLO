package com.semi.yolo.customerService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.semi.yolo.common.jdbc.JDBCTemplate;
import com.semi.yolo.common.util.PageInfo;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;
import com.semi.yolo.customerService.vo.QnaReply;
import com.semi.yolo.customerService.vo.Qna_Board;

public class QnaBoardDao {
	// 게시글 작성
	public int insertBoard(Connection connection, Qna_Board board) {
	    int result = 0;
	    PreparedStatement pstmt = null;
	    String query = "INSERT INTO YOLO_QNABOARD (NO, TYPE, WRITER_NO, NAME, EMAIL, PHONE, CONTENT, STATUS, AGREE, CREATE_DATE, MODIFY_DATE, REPLY)"
	                 + " VALUES (YOLO_QNABOARD_SEQ.NEXTVAL,?,?,?,?,?,?,'Y','Y',SYSDATE,SYSDATE,'N')";

	    try {
	        pstmt = connection.prepareStatement(query);

	        pstmt.setString(1, board.getType());
	        pstmt.setInt(2, board.getWriterNo());
	        pstmt.setString(3, board.getName());
	        pstmt.setString(4, board.getEmail());
	        pstmt.setString(5, board.getPhone());  
	        pstmt.setString(6, board.getContent());


	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(pstmt);
	    }

	    return result;
	}

	public int updateBoard(Connection connection, Qna_Board board) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE YOLO_QNABOARD SET CONTENT=?,MODIFY_DATE=SYSDATE WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			

			pstmt.setString(1, board.getContent());
			pstmt.setInt(2, board.getNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	

	// 전체 게시물 개수
	public int getBoardCount(Connection connection) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null; // 쿼리를 select로 실행시키면 무조건 resultset을 써줘야 한다.
		String query = "SELECT COUNT(*) FROM YOLO_QNABOARD WHERE STATUS='Y'";
		
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

	public List<Qna_Board> findAll(Connection connection, PageInfo pageInfo) {
		List<Qna_Board> list = new ArrayList<>(); // 조회되는게 있으면 리스트에 담아서 주고, 없으면 빈 리스트를 주게
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query =  "SELECT RNUM, NO, TITLE, ID, CREATE_DATE, STATUS, REPLY "
			    + "FROM ("
			    +    "SELECT ROWNUM AS RNUM, "
			    +           "NO, "
			    + 			"CREATE_DATE, "
			    +     		"STATUS, "
			    +			"REPLY "
			    + 	 "FROM ("
			    + 	    "SELECT B.NO, "
			    + 			   "B.TITLE, "
			    +  			   "M.ID, "
			    + 			   "B.CREATE_DATE, "
			    + 	   		   "B.STATUS, "
			    + 	   		   "B.REPLY "
			    + 		"FROM YOLO_QNABOARD B "
			    + 		"JOIN YOLO_MEMBER M ON(B.WRITER_NO = M.NO) "
			    + 		"WHERE B.STATUS = 'Y' ORDER BY B.NO DESC"
			    + 	 ")"
			    + ") WHERE RNUM BETWEEN ? and ?";
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, pageInfo.getStartList());
			pstmt.setInt(2, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
	
				Qna_Board board = new Qna_Board();
				
				board.setNo(rs.getInt("NO"));
				board.setRowNum(rs.getInt("RNUM"));
				board.setCreateDate(rs.getDate("CREATE_DATE"));
				board.setStatus(rs.getString("STATUS"));
				board.setReply(rs.getString("REPLY"));
				
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

	//게시물 번호를 기반으로 특정 게시물을 가져오는 메서드
	public Qna_Board findBoardByNo(Connection connection, int no) {
		Qna_Board board = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT  B.NO, "
				 + "B.TITLE, "
				 + "M.NO, "
				 + "B.WRITER_NO "
				 + "B.CONTENT, "
				 + "B.CREATE_DATE, "
				 + "B.MODIFY_DATE, "
				 + "B.REPLY "
		 + "FROM YOLO_QNABOARD B "
		 + "INNER JOIN YOLO_MEMBER M ON(B.WRITER_NO = M.NO) "
		 + "WHERE B.STATUS = 'Y' AND B.NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				board = new Qna_Board();
				
				board.setNo(rs.getInt("NO"));
				board.setContent(rs.getString("CONTENT"));
				board.setCreateDate(rs.getDate("CREATE_DATE"));
				board.setModifyDate(rs.getDate("MODIFY_DATE"));
				board.setReply(rs.getString("REPLY"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return board;
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


	// 삭제
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

	public int createReply(Connection connection, QnaReply reply) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "INSERT INTO YOLO_QNA_REPLY VALUES(?,?,DEFAULT)";
		String reply_state_query = "UPDATE YOLO_QNABOARD SET REPLY='Y' WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, reply.getNo());
			pstmt.setString(2, reply.getContent());
			
			result = pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(reply_state_query);
			
			pstmt.setInt(1, reply.getNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public QnaReply findReplyByBoardNo(Connection connection, int selected) {
		QnaReply reply = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT * FROM YOLO_QNA_REPLY WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, selected);

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				reply = new QnaReply();
				reply.setNo(rs.getInt("NO"));
				reply.setContent(rs.getString("CONTENT"));
				reply.setCreateDate(rs.getDate("CREATE_DATE"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return reply;
	}

	public int updateReply(Connection connection, QnaReply updateReply) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE YOLO_QNA_REPLY SET CONTENT = ?, CREATE_DATE = SYSDATE WHERE NO = ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, updateReply.getContent());
			pstmt.setInt(2, updateReply.getNo());
			
			result = pstmt.executeUpdate(); 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	
	
}
