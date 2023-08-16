package com.semi.yolo.customerService.service;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;
import static com.semi.yolo.common.jdbc.JDBCTemplate.commit;
import static com.semi.yolo.common.jdbc.JDBCTemplate.getConnection;
import static com.semi.yolo.common.jdbc.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.customerService.dao.QnaBoardDao;
import com.semi.yolo.customerService.vo.Board;
import com.semi.yolo.customerService.vo.QnaReply;

public class QnaBoardService {
	
//	public int getBoardCount() {
//		int count = 0;
//		Connection connection = getConnection();
//		
//		count = new QnaBoardDao().getBoardCount(connection);
//		
//		close(connection);
//		
//		return count;
//	}
	
	// 내가 작성
	public int getBoardCount() {
	int count = 0;
	Connection connection = getConnection();
	
	count = new QnaBoardDao().getBoardCount(connection);
	
	close(connection);
	
	return count;
}
	
	

	public List<Board> getBoardList(PageInfo pageInfo) {
		List<Board> list = null;
		Connection connection = getConnection();
		
		list = new QnaBoardDao().findAll(connection, pageInfo);
		
		close(connection);
		
		return list;
	}

	// 글 번호를 가져오고 해당 번호의 글을 조회함
	public Board getBoardByNo(int no) {
		Board board = null; 
		Connection connection = getConnection();
		
		board = new QnaBoardDao().findBoardByNo(connection, no);
		
		close(connection);
	
		return board;
	}

	public int save(Board board) {
		int result = 0;
		Connection connection = getConnection();
		
		if (board.getNo() > 0) {
			// update
			result = new QnaBoardDao().updateBoard(connection, board);
		} else {
			// insert
			result = new QnaBoardDao().insertBoard(connection, board);
			
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
		
		result = new QnaBoardDao().updateStatus(connection, no, "N");
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	public int createReply(QnaReply reply) {
		int result = 0;
		Connection connection = getConnection();
		
		result = new QnaBoardDao().createReply(connection, reply);
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	public QnaReply getReplyByBoradNo(int selected) {
		QnaReply reply = null; 
		Connection connection = getConnection();
		
		reply = new QnaBoardDao().findReplyByBoardNo(connection, selected);
		
		close(connection);
	
		return reply;
	}

	public int updateReply(QnaReply updatedReply) {
		int result = 0;
		Connection connection = getConnection();
		
		result = new QnaBoardDao().updateReply(connection, updatedReply);
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

}
