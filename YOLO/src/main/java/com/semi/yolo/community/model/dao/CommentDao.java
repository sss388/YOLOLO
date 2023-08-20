package com.semi.yolo.community.model.dao;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.semi.yolo.community.model.vo.Comment;

public class CommentDao {

	public int insertComment(Connection connection, Comment comment) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO YOLO_COMMENT (NO, USER_NO, BOARD_NO, CONTENT)"
				+ "VALUES (YOLO_COMMENT_SEQ.NEXTVAL, ?, ?, ?)";

	    try {
	        pstmt = connection.prepareStatement(query);

	        pstmt.setInt(1, comment.getUserNo());
	        pstmt.setInt(2, comment.getBoardNo());
	        pstmt.setString(3, comment.getContent());
	        		
	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(pstmt);
	    }

		return result;
	}

	public int updateComment(Connection connection, Comment comment) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE YOLO_COMMENT SET CONTENT=? WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, comment.getContent());
			pstmt.setInt(2, comment.getNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public List<Comment> findAllByBoardNo(Connection connection, int board_no) {
		List<Comment> list = new ArrayList<Comment>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT C.*, M.NAME\r\n"
				+ "FROM YOLO_COMMENT C\r\n"
				+ "JOIN YOLO_MEMBER M ON C.USER_NO = M.NO\r\n"
				+ "WHERE C.STATUS = 'Y' AND C.BOARD_NO = ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, board_no);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Comment comment = new Comment();
				
				comment.setNo(rs.getInt("NO"));
				comment.setUserNo(rs.getInt("USER_NO"));
				comment.setBoardNo(rs.getInt("BOARD_NO"));
				comment.setContent(rs.getString("CONTENT"));
				comment.setCreate_date(rs.getDate("CREATE_DATE"));
				comment.setUpdate_date(rs.getDate("UPDATE_DATE"));
				comment.setUserName(rs.getString("NAME"));
				
				list.add(comment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	public int deleteComment(Connection connection, int comment_no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE YOLO_COMMENT SET STATUS='N' WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, comment_no);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}



}
