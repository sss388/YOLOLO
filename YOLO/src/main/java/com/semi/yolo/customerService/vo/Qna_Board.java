package com.semi.yolo.customerService.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Qna_Board {

	private int no;          // 게시글번호
	private String type;     // 문의유형
	private String title;     // 제목
	private int writerNo;    // 작성자 회원번호
	private String name;     // 작성자
	private String email;    // 이메일
	private String phone;    // 휴대전화
	private String content;  // 문의내용 
	private String status;   // 상태값
	private String agree;    // 동의여부
	private Date createDate; // 게시글올린날짜
	private Date modifyDate; // 게시글수정날짜 
	private String reply;    // 답변여부
	
	private int readCount;
	private int rowNum;
	

}
