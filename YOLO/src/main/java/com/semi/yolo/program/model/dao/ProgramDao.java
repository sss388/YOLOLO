package com.semi.yolo.program.model.dao;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.program.model.vo.Program;

public class ProgramDao {  
	  
	// 게시글 정보를 업데이트  
	public int updateprogram(Connection connection, Program program) {
	    int result = 0;
	    PreparedStatement pstmt = null;
	    String query = "UPDATE YOLO_PROGRAM SET TITLE=?, CONTENT=?, THUMB=?, CATEGORY=?, START_DATE=?, EXPIRE_DATE=?,ADDRESS=?, LATITUDE=?, LONGITUDE=?, INCLUSION=?, NONINCLUSION=?, SUPPLIES=?, MAXIMUM=? WHERE NO=?";

	    try {
	        pstmt = connection.prepareStatement(query);

	        pstmt.setString(1, program.getTitle());
	        pstmt.setString(2, program.getContent());
	        pstmt.setString(3, program.getThumb());
	        pstmt.setString(4, program.getCategory());
	        pstmt.setDate(5, new java.sql.Date(program.getStartDate().getTime()));
	        pstmt.setDate(6, new java.sql.Date(program.getExpireDate().getTime()));
	        pstmt.setString(7, program.getAddress());
	        pstmt.setDouble(8, program.getLatitude());
	        pstmt.setDouble(9, program.getLongitude());
	        pstmt.setString(10, program.getInclusion());
	        pstmt.setString(11, program.getNoninclusion());
	        pstmt.setString(12, program.getSupplies());
	        pstmt.setInt(13, program.getMaximum());
	        pstmt.setInt(14, program.getNo());

	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(pstmt);
	    }

	    return result;
	}
	
	// 새로운 게시글을 작성
	public int insertprogram(Connection connection, Program program) {
		int result = 0;
	    PreparedStatement pstmt = null;
	    String query = "INSERT INTO YOLO_PROGRAM (NO, USER_NO, TITLE, THUMB, CATEGORY, CONTENT, ADDRESS, LATITUDE, LONGITUDE, INCLUSION, NONINCLUSION, SUPPLIES, STATUS, CREATE_DATE, START_DATE, EXPIRE_DATE, WRITER_NAME, MAXIMUM) VALUES (YOLO_PROGRAM_SEQ.NEXTVAL,?,?,?,?,?,?,?,?,?,?,?,'Y',SYSDATE,?,?,?,?)";

	    try {
	        pstmt = connection.prepareStatement(query);

	        pstmt.setInt(1, program.getUserno());
	        pstmt.setString(2, program.getTitle());
	        pstmt.setString(3, program.getThumb());
	        pstmt.setString(4, program.getCategory());
	        pstmt.setString(5, program.getContent());
	        pstmt.setString(6, program.getAddress());
	        pstmt.setDouble(7, program.getLatitude());
	        pstmt.setDouble(8, program.getLongitude());
	        pstmt.setString(9, program.getInclusion());
	        pstmt.setString(10, program.getNoninclusion());
	        pstmt.setString(11, program.getSupplies());
	        pstmt.setDate(12, new java.sql.Date(program.getStartDate().getTime()));
	        pstmt.setDate(13, new java.sql.Date(program.getExpireDate().getTime()));
	        pstmt.setString(14, program.getWritename());
	        pstmt.setInt(15, program.getMaximum());

	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(pstmt);
	    }

	    return result;
	}
	
    //게시물 번호를 기반으로 특정 게시물을 가져오는 메서드
	public Program findProgramByNo(Connection connection, int no) {
		Program program = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT * FROM YOLO_PROGRAM WHERE STATUS = 'Y' AND NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				program = new Program();
				
				program.setNo(rs.getInt("NO"));
				program.setTitle(rs.getString("TITLE"));
				program.setUserno(rs.getInt("USER_NO"));
				program.setThumb(rs.getString("THUMB"));
				program.setCategory(rs.getString("CATEGORY"));
				program.setContent(rs.getString("CONTENT"));
				program.setInclusion(rs.getString("INCLUSION"));
				program.setNoninclusion(rs.getString("NONINCLUSION"));
				program.setSupplies(rs.getString("SUPPLIES"));
				program.setAddress(rs.getString("ADDRESS"));
				program.setStartDate(rs.getDate("START_DATE"));
				program.setExpireDate(rs.getDate("EXPIRE_DATE"));
				program.setWritename(rs.getString("WRITER_NAME"));
				program.setLatitude(rs.getDouble("LATITUDE"));
				program.setLongitude(rs.getDouble("LONGITUDE"));
				program.setMaximum(rs.getInt("MAXIMUM"));
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}		
		
		return program;
	}
	
    // 게시글을 삭제하는 메서드
    public int deleteBoard(Connection connection, int no) {
        int result = 0;
        PreparedStatement pstmt = null;
        String query = "UPDATE YOLO_PROGRAM SET STATUS='N' WHERE NO=?";

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
    
    public int getProgramCountByKeyword(Connection connection, String kind, String keyword) {
    	int count = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "SELECT COUNT(*) FROM YOLO_PROGRAM WHERE STATUS='Y' AND CATEGORY=? AND TITLE LIKE ?";

        try {
            pstmt = connection.prepareStatement(query);
            pstmt.setString(1, kind);
            pstmt.setString(2, "%" + keyword + "%");
            
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
	
	// getOneDayCount(Connection connection), getClubCount(Connection connection), getChallengeCount(Connection connection): 
	// 각각 OneDay, Club, Challenge 카테고리의 프로그램 수를 조회하는 메서드
    public int getOneDayCount(Connection connection) {
        int count = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "SELECT COUNT(*) FROM YOLO_PROGRAM WHERE STATUS='Y'";

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
    
    public int getClubCount(Connection connection) {
        int count = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "SELECT COUNT(*) FROM YOLO_PROGRAM WHERE STATUS='Y'";

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
    
    public int getChallengeCount(Connection connection) {
        int count = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "SELECT COUNT(*) FROM YOLO_PROGRAM WHERE STATUS='Y'";

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
    
    // 페이징 처리된 프로그램 목록을 조회하는 메서드
    public List<Program> findAll(Connection connection, PageInfo pageInfo, String category) {
        List<Program> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = null;
        
        if(category.equals("ALL")) {
        	query = "SELECT *"
        			+ "FROM ("
        			+ "    SELECT NO, TITLE, THUMB, CREATE_DATE, ROW_NUMBER() OVER (ORDER BY NO DESC) AS RN "
        			+ "    FROM YOLO_PROGRAM yp "
        			+ "    WHERE yp.STATUS = 'Y'"
        			+ ")  "
        			+ "WHERE RN BETWEEN ? AND ?";
        } else {
        	query = "SELECT *"
        			+ "FROM ("
        			+ "    SELECT NO, TITLE, THUMB, CREATE_DATE, ROW_NUMBER() OVER (ORDER BY NO DESC) AS RN "
        			+ "    FROM YOLO_PROGRAM yp "
        			+ "    WHERE yp.STATUS = 'Y' AND CATEGORY=?"
        			+ ")  "
        			+ "WHERE RN BETWEEN ? AND ?";
        }

        try {
            pstmt = connection.prepareStatement(query);
            
            if(category.equals("ALL")) {
            	pstmt.setInt(1, pageInfo.getStartList());
            	pstmt.setInt(2, pageInfo.getEndList());
            } else {
            	pstmt.setString(1, category);
            	pstmt.setInt(2, pageInfo.getStartList());
            	pstmt.setInt(3, pageInfo.getEndList());
            }
            	

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Program program = new Program();

                program.setNo(rs.getInt("NO"));
                program.setTitle(rs.getString("TITLE"));
                program.setThumb(rs.getString("THUMB"));
                program.setRowNum(rs.getInt("RN"));
                program.setCreateDate(rs.getDate("CREATE_DATE"));

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
    

    // 마감이 얼마 남지 않은 프로그램 목록을 조회하는 메서드
    public List<Program> findCloseDeadLine(Connection connection, int date) {
        List<Program> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String query = "SELECT * FROM ("
                + "  SELECT * FROM YOLO_PROGRAM"
                + "  WHERE EXPIRE_DATE >= SYSDATE - 1"
                + "    AND EXPIRE_DATE <= SYSDATE + " + date
                + "    AND STATUS = 'Y'"
                + "  ORDER BY EXPIRE_DATE ASC"
                + ") WHERE ROWNUM <= 4";

        try {
            pstmt = connection.prepareStatement(query);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Program program = new Program();

                program.setThumb(rs.getString("THUMB"));
                program.setTitle(rs.getString("TITLE"));
                program.setExpireDate(rs.getDate("EXPIRE_DATE"));
                program.setNo(rs.getInt("NO"));
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
    
    // 최근 등록된 프로그램 목록을 조회하는 메서드
    public List<Program> findRecentProgram(Connection connection, int i) {
        List<Program> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String query = "SELECT * "
                + "FROM ("
                + "    SELECT * FROM YOLO_PROGRAM"
                + "    WHERE STATUS = 'Y'"
                + "    ORDER BY CREATE_DATE DESC, NO DESC"
                + ")"
                + "WHERE ROWNUM <= 4";

        try {
            pstmt = connection.prepareStatement(query);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Program program = new Program();

                program.setThumb(rs.getString("THUMB"));
                program.setTitle(rs.getString("TITLE"));
                program.setCreateDate(rs.getDate("CREATE_DATE"));
                program.setNo(rs.getInt("NO"));
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