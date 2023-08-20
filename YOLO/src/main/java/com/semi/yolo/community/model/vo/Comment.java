package com.semi.yolo.community.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
	private int no;
	private int userNo;
	private int boardNo;
	private String userName;
	private String content;
	private Date create_date;
	private Date update_date;
}
