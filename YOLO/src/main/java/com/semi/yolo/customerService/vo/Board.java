package com.semi.yolo.customerService.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board {

	private int no;
	
	private int rowNum;
	
	private int writerNo;
	
	private String writerId;
	
	private String title;
	
	private String content;
	
	private String originalFilename;
	
	private String renamedFilename;
	
	private int readCount;
	
	private String status;
	
	private Date createDate;
	
	private Date modifyDate;
		
	private String reply;
}
