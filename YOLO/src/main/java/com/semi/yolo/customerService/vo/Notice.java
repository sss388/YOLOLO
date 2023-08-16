package com.semi.yolo.customerService.vo;

import java.sql.Clob;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Notice {
	private int no;
	
	private int rowNum;
	
	private String title;
	
	private String content;
	
	private Date createDate;
	
	private String status;
}
