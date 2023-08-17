package com.semi.yolo.community.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board {
	private int no;
	private String title;                        // 제목
	private String category;                 // 카테고리
	private int kind;                 // 카테고리
	private String content;                  // 내용
	private String Attachment;            // 첨부파일
	private Date createDate;                 // 작성일
	private char state;
	private int rowNum;
	private int userNo;
	private String userName;
	private String thumb;
}

