package com.semi.yolo.customerService.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QnaReply {
	private int no;
	
	private String content;
	
	private Date createDate;
}
