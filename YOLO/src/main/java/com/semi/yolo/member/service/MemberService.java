package com.semi.yolo.member.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;

import static com.semi.yolo.common.jdbc.JDBCTemplate.*;
import com.semi.yolo.member.dao.MemberDao;
import com.semi.yolo.member.vo.Member;

// 회원 관련 비즈니스 로직을 처리하는 클래스
// 회원 로그인, 회원 가입 및 수정, 아이디 중복 체크, 회원 정보 조회, 회원 삭제 기능을 담당
public class MemberService {
	
	// 로그인 처리
	public Member login(String userId, String userPw) {
		
		Member member = this.findMemberById(userId);
		
		if (member == null || !member.getUserPw().equals(userPw)) {
			return null;  // 로그인 실패 시 null 반환
		}
		
		return member;  // 로그인 성공 시 Member 객체 반환
	
	}

	// 회원 정보 저장 (회원 가입 및 수정)
	public int save(Member member) {
		int result = 0;
		
		Connection connection = getConnection();
		
		if(member.getNo() > 0) {
			// update 작업
			// 기존에 등록된 회원의 경우 업데이트 작업
			result = new MemberDao().updateMember(connection, member);
		} else {
			// insert 작업
			// 신규 회원의 경우 삽입 작업
			result = new MemberDao().insertMember(connection, member);		
		}
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	// 아이디 중복 체크
	public boolean isUserIdExists(String userId) {
		return this.findMemberById(userId) != null;

	}

	// 아이디로 회원 정보 조회
	public Member findMemberById(String userId) {
		Member member = null;
		Connection connection = getConnection();
		
		member = new MemberDao().findMemberById(connection, userId);
		
		close(connection);
		
		return member;
	}
	
	// 이메일 중복체크
	public Boolean isUserEmailExists(String email) {
		return this.findMemberbyemail(email) != null;
	}
	
	// 이메일 번호 정보 조회
	private Object findMemberbyemail(String email) {
		Member member = null;
		Connection connection = getConnection();
		
		member = new MemberDao().findMemberByEmail(connection, email);
		
		close(connection);
		
		return member;
	}
	
	 // SHA-256 암호화 메서드
    public String encryptSHA256(String input) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(input.getBytes());
            
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    // 회원 탈퇴하기  => DB에서 삭제하는게 아니라 상태값 Y -> N 으로 변경
	public int delete(int no) {
		int result = 0; 
		Connection connection = getConnection();
		
		result = new MemberDao().updateMemberStatus(connection, no, "N");
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
			
		return result;
	}

	public String getMemberNameByNo(int userNo) {
		String user_name = null;
		Connection connection = getConnection();
		
		user_name = new MemberDao().findMemberNameByNo(connection, userNo);
		
		close(connection);
		
		return user_name;
	}

	public Member getMemberProfileByNo(int userNo) {
		Member member = null;
		Connection connection = getConnection();
		
		member = new MemberDao().findMemberByNo(connection, userNo);
		
		close(connection);
		
		return member;
	}
	
	
}
