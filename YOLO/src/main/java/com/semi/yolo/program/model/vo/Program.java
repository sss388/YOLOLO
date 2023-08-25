package com.semi.yolo.program.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class Program {
	private int no;                          // 프로그램 번호
	private int userno;                      // 회원 번호  => 외래키 member에서 가져옴
	private String writename;				 // 작성자
	private String title;                    // 제목(모임명)
	private String thumb;                    // 썸네일(대표이미지)
	private String category;                 // 카테고리
	private String content;                  // 내용
	
	private String address;                  // 주소
	private double latitude;                 // 위도
	private double longitude;                // 경도
	
	private String inclusion;                // 포함사항
	private String noninclusion;          	 // 불포함사항
	private String supplies;         		 // 준비물
	
	private char status;                     // 상태값 => Y/N
	private Date createDate;                 // 작성일
	private Date startDate;                	 // 모임시작일
	private Date expireDate;                 // 모임만료일
	private int rowNum;
	
	private int maximum;					 // 최대인원


}
