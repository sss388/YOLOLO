package com.semi.yolo.member.vo;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private int no;              // 회원번호	
	private String userId;       // 아이디 
	private String userPw;       // 비밀번호	
	private String name;         // 이름
	private String postcode;     // 우편번호
	private String address1;	 // 기본주소
	private String address2;     // 나머지주소	
	private String phone;        // 휴대전화 
	private String email;        // 이메일	
	private String status; 		 // 상태값
	private String createDate;   // 회원가입일
	private String updateDate;   // 최종수정일 
	private int role;            // 권한,역할
	private String profileImg;	 // 프사
	private String agree;        // 동의내역
}
