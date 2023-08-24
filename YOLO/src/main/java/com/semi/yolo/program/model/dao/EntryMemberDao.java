package com.semi.yolo.program.model.dao;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.semi.yolo.member.dao.MemberDao;
import com.semi.yolo.program.model.vo.EntryMember;
import com.semi.yolo.program.model.vo.Program;

public class EntryMemberDao {

	public List<EntryMember> findByProgramNo(Connection connection, int no) {
		List<EntryMember> list = new ArrayList<EntryMember>();
		PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String query = "SELECT E.*, M.NAME, M.PROFILE_IMG "
        		+ "FROM YOLO_PROGRAM_ENTRY_MEMBER E "
        		+ "JOIN YOLO_MEMBER M ON E.USER_NO = M.NO "
        		+ "WHERE PROGRAM_NO = " + no;
        
        try {
        	 pstmt = connection.prepareStatement(query);
             rs = pstmt.executeQuery();
             
             while (rs.next()) {
            	 EntryMember entryMember = new EntryMember();
            	 
            	 entryMember.setName(rs.getString("NAME"));
            	 if(rs.getBlob("PROFILE_IMG") != null) {
            		 entryMember.setProfileImg(new MemberDao().blobToString(rs.getBlob("PROFILE_IMG")));
            	 }
            	 entryMember.setUserNo(rs.getInt("USER_NO"));

                 list.add(entryMember);
             }
        } catch (SQLException e) {
        	e.printStackTrace();
        } catch (Exception e) {
        	System.out.println("BLOB TO STRING ERROR - EntryMemberDao - findByProgramNo");
		} finally {
            close(rs);
            close(pstmt);
        }
        
		return list;
	}

	public int insert(Connection connection, int user_no, int program_no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "INSERT INTO YOLO_PROGRAM_ENTRY_MEMBER (USER_NO, PROGRAM_NO) VALUES (?, ?)";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, user_no);
			pstmt.setInt(2, program_no);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
	    } finally {
	        close(pstmt);
	    }
		
		return result;
	}

	public int delete(Connection connection, int user_no, int program_no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "DELETE FROM YOLO_PROGRAM_ENTRY_MEMBER WHERE USER_NO=? AND PROGRAM_NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, user_no);
			pstmt.setInt(2, program_no);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
	    } finally {
	        close(pstmt);
	    }
		
		return result;
	}

}
