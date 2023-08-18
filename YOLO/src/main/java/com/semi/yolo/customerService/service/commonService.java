package com.semi.yolo.customerService.service;

import java.sql.Connection;
import java.util.List;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.customerService.dao.commonDao;
import com.semi.yolo.customerService.vo.Qna_Board;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;
import static com.semi.yolo.common.jdbc.JDBCTemplate.commit;
import static com.semi.yolo.common.jdbc.JDBCTemplate.getConnection;
import static com.semi.yolo.common.jdbc.JDBCTemplate.rollback;

public class commonService {
	public int getBoardCount() {
		int count = 0;
		Connection connection = getConnection();
		
		count = new commonDao().getBoardCount(connection);
		
		close(connection);
		
		return count;
	}

	public List<Qna_Board> getBoardList(PageInfo pageInfo) {
		List<Qna_Board> list = null;
		Connection connection = getConnection();
		
		list = new commonDao().findAll(connection, pageInfo);
		
		close(connection);
		
		return list;
	}

	public Qna_Board getBoardByNo(int no) {
		Qna_Board board = null; 
		Connection connection = getConnection();
		
		board = new commonDao().findBoardByNo(connection, no);
		
		close(connection);
	
		return board;
	}

	public int save(Qna_Board board) {
		int result = 0;
		Connection connection = getConnection();
		
		if (board.getNo() > 0) {
			// update
			result = new commonDao().updateBoard(connection, board);
		} else {
			// insert
			result = new commonDao().insertBoard(connection, board);
			
		}
	
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	public int delete(int no) {
		int result = 0;
		Connection connection = getConnection();
		
		result = new commonDao().deleteBoard(connection, no);
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}


}
