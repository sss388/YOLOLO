package com.semi.yolo.program.mypage.dao;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.program.model.vo.Program;

// 내가 만든 모임만 있는 Dao
public class ProgramDao {
	
	// 내가 만든 모임 
    public int madeMyCount(Connection connection,int user_no) {
        int count = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "SELECT count(*) FROM YOLO_PROGRAM WHERE USER_NO = ?";

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

    // 내가 만든 모임
	public List<Program> findAll(Connection connection, PageInfo pageInfo, int user_no) {
		    List<Program> list = new ArrayList<>();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String query = "SELECT * FROM YOLO_PROGRAM WHERE USER_NO = ? AND STATUS = 'Y'";

	        try {
	            pstmt = connection.prepareStatement(query);

	            pstmt.setInt(1, user_no);

	            rs = pstmt.executeQuery();

	            while (rs.next()) {
	                Program program = new Program();

	                program.setNo(rs.getInt("NO"));
	                program.setTitle(rs.getString("TITLE"));
	                program.setThumb(rs.getString("THUMB"));
	                program.setCreateDate(rs.getDate("CREATE_DATE"));
	                program.setCategory(rs.getString("CATEGORY"));

	                list.add(program);
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
