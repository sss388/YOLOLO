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
import com.semi.yolo.member.vo.Member;

public class QnaBoardDao {
	
	// 문의글 등록하기
	public int insertBoard(Connection connection, Qna_Board board) {
	    int result = 0;
	    PreparedStatement pstmt = null;
	    String query = "INSERT INTO YOLO_QNABOARD (NO, TYPE, TITLE, WRITER_NO, NAME, EMAIL, PHONE, CONTENT, STATUS, AGREE, CREATE_DATE, MODIFY_DATE, REPLY)"
	                 + " VALUES (YOLO_QNABOARD_SEQ.NEXTVAL,?,?,?,?,?,?,?,'Y','Y',SYSDATE,SYSDATE,'N')";

	    try {
	        pstmt = connection.prepareStatement(query);

	        pstmt.setString(1, board.getType());
	        pstmt.setString(2, board.getTitle());
	        pstmt.setInt(3, board.getWriterNo());
	        pstmt.setString(4, board.getName());
	        pstmt.setString(5, board.getEmail());
	        pstmt.setString(6, board.getPhone());  
	        pstmt.setString(7, board.getContent());


	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(pstmt);
	    }

	    return result;
	}
	
	// 문의글 수정하기
	public int updateBoard(Connection connection, Qna_Board board) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE YOLO_QNABOARD SET TYPE=?, TITLE=?, NAME=?, EMAIL=?, PHONE=?, CONTENT=?, MODIFY_DATE=SYSDATE WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
	        pstmt.setString(1, board.getType());
	        pstmt.setString(2, board.getTitle());
	        pstmt.setString(3, board.getName());
	        pstmt.setString(4, board.getEmail());
	        pstmt.setString(5, board.getPhone());  
	        pstmt.setString(6, board.getContent());
	        
	        pstmt.setInt(7, board.getNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	// 마이페이지 - 내문의글
	public int getmyQnaBoardCount(Connection connection, int user_no) {
		int count = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "SELECT count(*) FROM YOLO_QNABOARD WHERE WRITER_NO = ?";

        try {
            pstmt = connection.prepareStatement(query);
            
            pstmt.setInt(1, user_no);
            
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
        
        System.out.println(count);

        return count;
    }
	
	
	
	// 마이페이지 - 내문의글 - 상세페이지
	public Qna_Board findBoardAndReplyByNo(Connection connection, int no) {
		 Qna_Board board = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String query = "SELECT B.NO, " 
	                     + "B.NAME, "
	                     + "M.NO, "
	                     + "B.WRITER_NO, "
	                     + "B.EMAIL, "
	                     + "B.PHONE, "
	                     + "B.TITLE, "
	                     + "B.CONTENT, "
	                     + "B.TYPE, "
	                     + "B.CREATE_DATE, "
	                     + "B.MODIFY_DATE, "
	                     + "B.REPLY, "
	                     + "R.CONTENT AS REPLY_CONTENT, " 
	                     + "R.CREATE_DATE AS REPLY_CREATE_DATE " 
	                     + "FROM YOLO_QNABOARD B "
	                     + "INNER JOIN YOLO_MEMBER M ON(B.WRITER_NO = M.NO) "
	                     + "LEFT JOIN YOLO_QNA_REPLY R ON(B.NO = R.NO) "
	                     + "WHERE B.STATUS = 'Y' AND B.NO=?";
	        
	        try {
	            pstmt = connection.prepareStatement(query);
	            pstmt.setInt(1, no);
	            rs = pstmt.executeQuery();
	            
	            if (rs.next()) {
	                board = new Qna_Board();
	                board.setNo(rs.getInt("NO"));
	                board.setName(rs.getString("NAME"));
	                board.setWriterNo(rs.getInt("WRITER_NO"));
	                board.setEmail(rs.getString("EMAIL"));
	                board.setPhone(rs.getString("PHONE"));
	                board.setType(rs.getString("TYPE"));
	                board.setTitle(rs.getString("TITLE"));
	                board.setContent(rs.getString("CONTENT"));
	                board.setCreateDate(rs.getDate("CREATE_DATE"));
	                board.setModifyDate(rs.getDate("MODIFY_DATE"));
	                board.setReply(rs.getString("REPLY"));
	                
	                // 답변 정보 설정
	                QnaReply reply = new QnaReply();
	                reply.setContent(rs.getString("REPLY_CONTENT"));
	                reply.setCreateDate(rs.getDate("REPLY_CREATE_DATE"));
	                
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            close(rs);
	            close(pstmt);
	        }
	        
	        return board;
	}


	// 마이페이지 - 내문의글
	public List<Qna_Board> getBoardListByWriterNo(Connection connection, PageInfo pageInfo, int user_no) {
	    List<Qna_Board> list = new ArrayList<>(); 
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String query = "SELECT RNUM, NO, TYPE, TITLE, CONTENT, EMAIL, PHONE, NAME, CREATE_DATE, STATUS, REPLY "
	                 + "FROM ("
	                 +    "SELECT ROWNUM AS RNUM, "
	                 +           "NO, "
	                 +           "TYPE, "
	                 +           "NAME, "
	                 +           "TITLE, "
	                 +           "CONTENT, "
	                 +           "EMAIL, "
	                 +           "PHONE, "
	                 +           "CREATE_DATE, "
	                 +           "STATUS, "
	                 +           "REPLY "
	                 +     "FROM ("
	                 +         "SELECT B.NO, "
	                 +                "B.TYPE, "
	                 +                "B.NAME, "
	                 +                "B.TITLE, "
	                 +                "B.CONTENT, "
	                 +                "B.EMAIL, "
	                 +                "B.PHONE, "
	                 +                "B.CREATE_DATE, "
	                 +                "B.STATUS, "
	                 +                "B.REPLY "
	                 +         "FROM YOLO_QNABOARD B "
	                 +         "JOIN YOLO_MEMBER M ON(B.WRITER_NO = M.NO) "
	                 +         "WHERE M.NO = ? AND B.STATUS = 'Y' ORDER BY B.NO DESC"
	                 +     ")"
	                 + ") WHERE RNUM BETWEEN ? and ?";
	    try {
	        pstmt = connection.prepareStatement(query);
	        
	        pstmt.setInt(1, user_no); // 여기서 변경된 부분입니다.
	        pstmt.setInt(2, pageInfo.getStartList());
	        pstmt.setInt(3, pageInfo.getEndList());
	        
	        rs = pstmt.executeQuery();
	        
	        while (rs.next()) {

	            Qna_Board board = new Qna_Board();
	            
	            board.setNo(rs.getInt("NO"));
	            board.setRowNum(rs.getInt("RNUM"));
	            board.setType(rs.getString("TYPE"));
	            board.setTitle(rs.getString("TITLE"));
	            board.setName(rs.getString("NAME"));
	            board.setContent(rs.getString("CONTENT"));
	            board.setEmail(rs.getString("EMAIL"));
	            board.setPhone(rs.getString("PHONE"));
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

	
	// 문의글 삭제하기
	public int updateStatus(Connection connection, int no, String status) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE YOLO_QNABOARD SET STATUS=? WHERE NO=?";
		
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




	

//     ----------------------------------------  관리자 
	// 고객센터 - 문의사항 눌렀을때 관리자용 페이지
	//게시물 번호를 기반으로 특정 게시물을 가져오는 메서드
	public Qna_Board findBoardByNo(Connection connection, int no) {
		Qna_Board board = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT  B.NO, "        // 게시글번호 
							 + "B.NAME, "      // 작성자
							 + "M.NO, "            // member 회원번호
							 + "B.WRITER_NO, "     // 작성자 회원번호
							 + "B.EMAIL, "         // 이메일 
							 + "B.PHONE, "         // 휴대전화 
							 + "B.TITLE, "         // 제목
							 + "B.CONTENT, "       // 문의내용
							 + "B.TYPE, "          // 문의유형
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
				board.setName(rs.getString("NAME"));
				board.setEmail(rs.getString("EMAIL"));
				board.setPhone(rs.getString("PHONE"));
				board.setType(rs.getString("TYPE"));
				board.setTitle(rs.getString("TITLE"));
				board.setContent(rs.getString("CONTENT"));
				board.setCreateDate(rs.getDate("CREATE_DATE"));
				board.setModifyDate(rs.getDate("MODIFY_DATE"));
				board.setReply(rs.getString("REPLY"));
				board.setWriterNo(rs.getInt("WRITER_NO"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return board;
	}
	
	// 관리자
	// 게시글에 대한 답변 조회
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
	
	// 전체 게시글 개수 조회  
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
	
	// 작성자 번호로 문의사항 찾음  => 관리자용
	public List<Qna_Board> findBoardByWriterNo(Connection connection, PageInfo pageInfo, Member loginMember) {
		List<Qna_Board> list = new ArrayList<>();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String query = "SELECT RNUM, NAME, EMAIL,TITLE, PHONE, TYPE, CONTENT, CREATE_DATE, REPLY "
	            + "FROM ("
	            +    "SELECT ROWNUM AS RNUM, "
	            +           "NAME, "
	            +           "EMAIL, "
	            +           "TITLE, "
	            +           "PHONE, "
	            +           "TYPE, "
	            +           "CONTENT, "
	            +           "CREATE_DATE, "
	            +           "REPLY "
	            +    "FROM ("
	            +        "SELECT B.NO, "
	            +               "M.NO AS WRITER_NO, "
	            +               "M.NAME, "
	            +               "M.EMAIL, "
	            +               "M.TITLE, "
	            +               "M.PHONE, "
	            +               "B.TYPE, "
	            +               "B.CONTENT, "
	            +               "B.CREATE_DATE, "
	            +               "B.REPLY "
	            +        "FROM YOLO_QNABOARD B "
	            +        "JOIN YOLO_MEMBER M ON (B.WRITER_NO = M.NO) "
	            +        "WHERE B.STATUS = 'Y' AND B.WRITER_NO = ? ORDER BY B.NO DESC"
	            +    ")"
	            + ") WHERE RNUM BETWEEN ? AND ?";

	    try {
	        pstmt = connection.prepareStatement(query);

	        pstmt.setInt(1, loginMember.getNo()); // 로그인한 회원의 회원번호
	        pstmt.setInt(2, pageInfo.getStartList());
	        pstmt.setInt(3, pageInfo.getEndList());

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            Qna_Board board = new Qna_Board();

	            board.setNo(rs.getInt("NO"));
	            board.setRowNum(rs.getInt("RNUM"));
	            board.setName(rs.getString("NAME"));
	            board.setEmail(rs.getString("EMAIL"));
	            board.setTitle(rs.getString("TITLE"));
	            board.setPhone(rs.getString("PHONE"));
	            board.setType(rs.getString("TYPE"));
	            board.setContent(rs.getString("CONTENT"));
	            board.setCreateDate(rs.getDate("CREATE_DATE"));
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
	
	// 답변 생성
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
	
	// 답변 수정
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
	
	// 페이징 처리된 게시글 목록 조회 => 관리자용
	public List<Qna_Board> findAll(Connection connection, PageInfo pageInfo) {
		List<Qna_Board> list = new ArrayList<>(); 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query =  "SELECT RNUM, NO, TYPE, TITLE, CONTENT, NAME, CREATE_DATE, STATUS, REPLY "
			    + "FROM ("
			    +    "SELECT ROWNUM AS RNUM, "
			    +           "NO, "
			    + 			"TYPE, "
			    + 			"TITLE, "
			    + 			"NAME, "
			    + 			"CONTENT, "
			    + 			"CREATE_DATE, "
			    +     		"STATUS, "
			    +			"REPLY "
			    + 	 "FROM ("
			    + 	    "SELECT B.NO, "
			    + 			   "B.TYPE, "
			    + 			   "B.TITLE, "
			    +  			   "B.NAME, "
			    +  			   "B.CONTENT, "
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
				board.setType(rs.getString("TYPE"));
				board.setTitle(rs.getString("TITLE"));
				board.setName(rs.getString("NAME"));
				board.setContent(rs.getString("CONTENT"));
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


	

	
	
}
