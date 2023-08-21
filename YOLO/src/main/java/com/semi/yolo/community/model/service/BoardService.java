package com.semi.yolo.community.model.service;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;
import static com.semi.yolo.common.jdbc.JDBCTemplate.commit;
import static com.semi.yolo.common.jdbc.JDBCTemplate.getConnection;
import static com.semi.yolo.common.jdbc.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.community.model.dao.BoardDao;
import com.semi.yolo.community.model.vo.Board;

public class BoardService {
	
	// 모임만들기 글쓰기 저장하기
		public int save(Board board) {
			int result = 0;
			Connection connection = getConnection();
			
			if(board.getNo() == 0) {				
				result = new BoardDao().insertboard(connection, board);
			} else {
				result = new BoardDao().updateBoard(connection, board);
			}
			
			if (result > 0) {
				commit(connection);
			} else {
				rollback(connection);			
			}
			
			close(connection);
			
			return result;
		}
		
	    // //글 번호를 받아서 해당 번호의 게시판 글을 조회하는 기능을 구현한 것
		public Board getProgramByNo(int no) {
			Board board = null;
			Connection connection = getConnection();
			
			board = new BoardDao().findBoardByNo(connection, no);
			
			close(connection);
			
			return board;
		}
	
	

	public int getBoardCount(int kind) {
		int count = 0;
		Connection connection = getConnection();
		
		count = new BoardDao().getBoardCount(connection, kind);
		
		close(connection);
		
		return count;
	}
	
	public int getBoardCountByKeyword(int kind, String keyword) {
		int count = 0;
		Connection connection = getConnection();
		
		count = new BoardDao().getBoardCountByKeyword(connection, kind, keyword);
		
		close(connection);
		
		return count;
	}

	 public List<Board> getBoardList(PageInfo pageInfo, int kind) {
        List<Board> list = null;
        Connection connection = getConnection();
        
        try {
            BoardDao boardDao = new BoardDao();
            list = boardDao.findAll(connection, pageInfo, kind);
        } finally {
            close(connection);
        }

        return list;
    }
	 
	 public List<Board> getBoardListByKeyword(PageInfo pageInfo, int kind, String keyword) {
		 List<Board> list = null;
		 Connection connection = getConnection();
		 
		 try {
			 BoardDao boardDao = new BoardDao();
			 list = boardDao.findAllByKeyword(connection, pageInfo, kind, keyword);
		 } finally {
			 close(connection);
		 }
		 
		 return list;
	 }
	 
	 public Board getBoardByNo(int no) {
			Board board = null;
			Connection connection = getConnection();
			
			board = new BoardDao().findBoardByNo(connection, no);
			
			close(connection);
			
			return board;
		}
	 
	 
//	 public int save(Board board) {
//			int result = 0;
//			Connection connection = getConnection();
//			
//			if (board.getNo() > 0) {
//				// update
//				result = new BoardDao().updateBoard(connection, board);
//			} else {
//				// insert
//				result = new BoardDao().insertboard(connection, board);
//			}
//			
//			if (result > 0) {
//				commit(connection);
//			} else {
//				rollback(connection);			
//			}
//			
//			close(connection);
//			
//			return result;
//		}
//	
	

	public int delete(int no) {
		Connection connection = getConnection();
		
		int result = new BoardDao().deleteBoard(connection, no);
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	public List<Board> getBoardList(int kind) {
		List<Board> list = null;
        Connection connection = getConnection();
        
        try {
            BoardDao boardDao = new BoardDao();
            list = boardDao.findAll(connection, kind);
        } finally {
            close(connection);
        }

        return list;
	}
	

	public int updateReview(int no, String content) {
		Connection connection = getConnection();
		int result = new BoardDao().updateReviewContentByNo(connection, no, content);
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}



	
	

}
