package com.semi.yolo.program.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EntryMember {
	private int userNo;
	private String name;
	private String profileImg;
}
