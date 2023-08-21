package com.semi.yolo.member.dao;

import java.io.IOException;
import java.io.Reader;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static com.semi.yolo.common.jdbc.JDBCTemplate.*;
import com.semi.yolo.member.vo.Member;

// 데이터베이스와 관련된 작업을 처리하는 DAO(Data Access Object) 클래스
public class MemberDao {

	// 주어진 데이터베이스 커넥션과 사용자 아이디로 멤버를 찾는 역할
	public Member findMemberById(Connection connection, String userId) {
		Member member = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String query = "SELECT * FROM YOLO_MEMBER WHERE ID=? AND STATUS='Y'";
		
		try {
			stmt = connection.prepareStatement(query);
			stmt.setString(1, userId);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				member = new Member();
				
				member.setNo(rs.getInt("NO"));
				member.setUserId(rs.getString("ID"));
				member.setUserPw(rs.getString("PASSWORD"));
				member.setName(rs.getString("NAME"));
				member.setPostcode(rs.getString("PCODE"));
				member.setAddress1(rs.getString("ADDRESS1"));
				member.setAddress2(rs.getString("ADDRESS2"));
				member.setPhone(rs.getString("PHONE"));
				member.setEmail(rs.getString("EMAIL"));
				member.setStatus(rs.getString("STATUS"));
				member.setCreateDate(rs.getString("CREATE_DATE"));
				member.setUpdateDate(rs.getString("UPDATE_DATE"));
				member.setRole(rs.getInt("ROLE"));
				
				// Clob 타입 데이터를 String 타입으로 변환하여 설정
				Clob profileImgClob = rs.getClob("PROFILE_IMG");
		        if (profileImgClob != null) {
		            StringBuilder sb = new StringBuilder();
		            try (Reader reader = profileImgClob.getCharacterStream()) {
		                int c = 0;
		                while ((c = reader.read()) != -1) {
		                    sb.append((char) c);
		                }
		                String profileImg = sb.toString();
		                member.setProfileImg(profileImg);
		            } catch (IOException e) {
		                throw new RuntimeException(e);
		            }
		        }
		        else {
		            member.setProfileImg("");
		        }
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return member;
	}
	

	public Member findMemberByEmail(Connection connection, String email) {
		Member member = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        String query = "SELECT * FROM YOLO_MEMBER WHERE EMAIL=? AND STATUS='Y'";
        
        try {
            stmt = connection.prepareStatement(query);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
				member = new Member();
				
				member.setNo(rs.getInt("NO"));
				member.setUserId(rs.getString("ID"));
				member.setUserPw(rs.getString("PASSWORD"));
				member.setName(rs.getString("NAME"));
				member.setPostcode(rs.getString("PCODE"));
				member.setAddress1(rs.getString("ADDRESS1"));
				member.setAddress2(rs.getString("ADDRESS2"));
				member.setPhone(rs.getString("PHONE"));
				member.setEmail(rs.getString("EMAIL"));
				member.setStatus(rs.getString("STATUS"));
				member.setCreateDate(rs.getString("CREATE_DATE"));
				member.setUpdateDate(rs.getString("UPDATE_DATE"));
				member.setRole(rs.getInt("ROLE"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(stmt);
        }
        
        return member;
	}


	// 신규 회원의 경우 삽입 작업
	public int insertMember(Connection connection, Member member) {
		PreparedStatement pstmt = null;
	    int result = 0;
	    String query = "INSERT INTO YOLO_MEMBER (NO, ID, PASSWORD, NAME, PCODE, ADDRESS1, ADDRESS2, PHONE, EMAIL, STATUS, CREATE_DATE) VALUES (YOLO_MEMBER_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, 'Y', SYSDATE)";

	    try {
	        pstmt = connection.prepareStatement(query);

	        pstmt.setString(1, member.getUserId());
	        pstmt.setString(2, member.getUserPw());
	        pstmt.setString(3, member.getName());
	        pstmt.setString(4, member.getPostcode());
	        pstmt.setString(5, member.getAddress1());
	        pstmt.setString(6, member.getAddress2());
	        pstmt.setString(7, member.getPhone());
	        pstmt.setString(8, member.getEmail());

	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(pstmt);
	    }

	    return result;
	}

	// 기존에 등록된 회원의 경우 업데이트 작업  => 아직 덜함 수정 필요
	public int updateMember(Connection connection, Member member) {
		PreparedStatement pstmt = null;
	    int result = 0;
	    String query = "UPDATE YOLO_MEMBER SET NAME=?, PCODE=?, ADDRESS1=?, ADDRESS2=?, PHONE=?, EMAIL=?, UPDATE_DATE=SYSDATE WHERE ID=?";

	    try {
	        pstmt = connection.prepareStatement(query);

			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getPostcode());
			pstmt.setString(3, member.getAddress1());
			pstmt.setString(4, member.getAddress2());
			pstmt.setString(5, member.getPhone());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getUserId());

	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(pstmt);
	    }

	    return result;
	}


	// 아이디찾기 정보 가져오기
	public Member findMemberByNameAndPhone(String name, String email) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    Member member = null;

	    try {
	        conn = getConnection();
	        String query = "SELECT ID FROM YOLO_MEMBER WHERE NAME = ? AND EMAIL = ? AND STATUS = 'Y'";
	        pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, name);
	        pstmt.setString(2, email);
	        System.out.println(name);
	        System.out.println(email);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            member = new Member();
	            member.setUserId(rs.getString("ID"));
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(rs);
	        close(pstmt);
	        close(conn);
	    }

	    return member;
	}

	// 비밀번호찾기
	public Member findMemberByIdAndNameAndPhone(String userId, String name, String email) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    Member member = null;

	    try {
	        conn = getConnection();
	        String query = "SELECT PASSWORD FROM YOLO_MEMBER WHERE ID = ? AND NAME = ? AND EMAIL = ? AND STATUS = 'Y'";
	        pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, userId);
	        pstmt.setString(2, name);
	        pstmt.setString(3, email);
	        System.out.println(userId);
	        System.out.println(name);
	        System.out.println(email);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            member = new Member();
	            member.setUserPw(rs.getString("PASSWORD"));
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(rs);
	        close(pstmt);
	        close(conn);
	    }

	    return member;
	}

	
	// 회원 상태변경 => 탈퇴
	public int updateMemberStatus(Connection connection, int no, String status) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query ="UPDATE YOLO_MEMBER SET STATUS=? WHERE NO=?";
		
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


	public String findMemberNameByNo(Connection connection, int userNo) {
		String result = null;
		PreparedStatement pstmt = null;
		String query = "SELECT NAME FROM YOLO_MEMBER WHERE NO=?";
		ResultSet rs = null;
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, userNo);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
	            result = (rs.getString("NAME"));
	        }
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}	

}
