package com.semi.yolo.customerService.dao;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.customerService.vo.Notice;

public class NoticeDao {
	
	public int getCount(Connection connection) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT COUNT(*) FROM YOLO_BOARD WHERE KIND=5 AND STATUS='Y'";
		
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

	public List<Notice> findAll(Connection connection, PageInfo pageInfo) {
		List<Notice> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT *"
						+ "FROM ("
						+ "    SELECT yb.*,"
						+ "           ROW_NUMBER() OVER (ORDER BY NO DESC) AS RN"
						+ "    FROM YOLO_BOARD yb"
						+ "	   WHERE yb.STATUS = 'Y' AND yb.KIND = 5"
						+ ")"
						+ "WHERE RN BETWEEN ? AND ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, pageInfo.getStartList());
			pstmt.setInt(2, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Notice notice = new Notice();
				
				notice.setNo(rs.getInt("NO"));
				notice.setTitle(rs.getString("TITLE"));
				notice.setCreateDate(rs.getDate("CREATE_DATE"));
				notice.setRowNum(rs.getInt("RN"));
				
				list.add(notice);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	public Notice findByNo(Connection connection, int no) {
		Notice notice = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT * FROM YOLO_BOARD WHERE NO=? AND STATUS='Y'";
		
		try {
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, no);;

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				notice = new Notice();
				
				notice.setNo(rs.getInt("NO"));
				notice.setTitle(rs.getString("TITLE"));
				notice.setContent(rs.getString("CONTENT"));
				notice.setCreateDate(rs.getDate("CREATE_DATE"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return notice;
	}

	public int updateByNo(Connection connection, Notice updateNotice) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE YOLO_BOARD SET TITLE = ?, CONTENT = ?, CREATE_DATE = SYSDATE WHERE NO = ? AND KIND = 5";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, updateNotice.getTitle());
			pstmt.setString(2, updateNotice.getContent());
			pstmt.setInt(3, updateNotice.getNo());
			
			result = pstmt.executeUpdate(); 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int deleteByNo(Connection connection, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE YOLO_BOARD SET STATUS='N' WHERE NO = ? AND KIND = 5";
		
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

	public int create(Connection connection, Notice newNotice, int userNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO YOLO_BOARD (NO, TITLE, CONTENT, KIND, USER_NO)"
				+ "VALUES (YOLO_BOARD_NO.NEXTVAL, ?, ?, 5, ?)";
	
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, newNotice.getTitle());
			pstmt.setString(2, newNotice.getContent());
			pstmt.setInt(3, userNo);
			
			result = pstmt.executeUpdate(); 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
}
