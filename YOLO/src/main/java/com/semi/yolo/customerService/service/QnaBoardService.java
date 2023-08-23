package com.semi.yolo.customerService.service;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;
import static com.semi.yolo.common.jdbc.JDBCTemplate.commit;
import static com.semi.yolo.common.jdbc.JDBCTemplate.getConnection;
import static com.semi.yolo.common.jdbc.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.customerService.dao.QnaBoardDao;
import com.semi.yolo.customerService.vo.QnaReply;
import com.semi.yolo.customerService.vo.Qna_Board;
import com.semi.yolo.member.vo.Member;

public class QnaBoardService {
	
	// 문의글 저장하기 (작성하기, 수정하기)
	public int save(Qna_Board board) {
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
	
	// 마이페이지 - 내문의글
	public List<Qna_Board> getBoardListByWriterNo(PageInfo pageInfo, int user_no) {
		List<Qna_Board> list = null;
		Connection connection = getConnection();
		
		list = new QnaBoardDao().getBoardListByWriterNo(connection, pageInfo, user_no);
		
		close(connection);
		
		return list;
	}
	
	// 마이페이지 - 내문의글 
	public int getmyQnaBoardCount(int user_no) {
        int count = 0;
        Connection connection = getConnection();

        count = new QnaBoardDao().getmyQnaBoardCount(connection, user_no);

        close(connection);

        return count;
	}
	
	// 마이페이지 - 내문의글 - 상세페이지
	public Qna_Board getBoardAndReplyByNo(int no) {
        Qna_Board board = null;
        Connection connection = getConnection();

        board = new QnaBoardDao().findBoardAndReplyByNo(connection, no);

        close(connection);

        return board;
	}
	// 마이페이지 - 내문의글 - 상세페이지(답변)
	public QnaReply getReplyByBoardNo(int no) {
		QnaReply reply = null; 
		Connection connection = getConnection();
		
		reply = new QnaBoardDao().findReplyByBoardNo(connection, no);
		
		close(connection);
	
		return reply;
	}
	

	// 문의글 삭제하기
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
	

	
//	---------------------------- 관리자
	// 고객센터 - 문의사항 눌렀을때 관리자용 페이지
	// 글 번호를 가져오고 해당 번호의 글을 조회함  => 관리자용
	public Qna_Board getBoardByNo(int no) {
		Qna_Board board = null; 
		Connection connection = getConnection();
		
		board = new QnaBoardDao().findBoardByNo(connection, no);
		
		close(connection);
	
		return board;
	}
	
	// 게시글 수 조회 => 관리자용
	public int getBoardCount() {
	int count = 0;
	Connection connection = getConnection();
	
	count = new QnaBoardDao().getBoardCount(connection);
	
	close(connection);
	
	return count;
	}
	
	// 페이징 처리된 게시글 목록 조회 => 관리자용
	public List<Qna_Board> getBoardList(PageInfo pageInfo) {
		List<Qna_Board> list = null;
		Connection connection = getConnection();
		
		list = new QnaBoardDao().findAll(connection, pageInfo);
		
		close(connection);
		
		return list;
	}

	
	// 게시글에 대한 답변 조회  => 관리자용
	public QnaReply getReplyByBoradNo(int selected) {
		QnaReply reply = null; 
		Connection connection = getConnection();
		
		reply = new QnaBoardDao().findReplyByBoardNo(connection, selected);
		
		close(connection);
	
		return reply;
	}	
	
	// 답변 생성
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
	
	// 답변 수정
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
