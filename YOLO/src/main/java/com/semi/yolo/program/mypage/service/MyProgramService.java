package com.semi.yolo.program.mypage.service;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;
import static com.semi.yolo.common.jdbc.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import com.semi.yolo.common.util.PageInfo;

import com.semi.yolo.program.model.vo.Program;
import com.semi.yolo.program.mypage.dao.ProgramDao;

// 내가 만든 모임만 있는 Service
public class MyProgramService {
	 // 내가 만든 모임
    public int madeMyCount(int user_no) {
        int count = 0;
        Connection connection = getConnection();

        count = new ProgramDao().madeMyCount(connection, user_no);

        close(connection);

        return count;
    }


    // 내가 만든 모임
	public List<Program> getBoardList(PageInfo pageInfo, int user_no) {
		List<Program> list = null;
        Connection connection = getConnection();
        
        try {
            ProgramDao programDao = new ProgramDao();
            list = programDao.findAll(connection, pageInfo, user_no);
        } finally {
            close(connection);
        }

        return list;
	}
	

}
