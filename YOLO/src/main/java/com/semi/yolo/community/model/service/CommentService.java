package com.semi.yolo.community.model.service;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;
import static com.semi.yolo.common.jdbc.JDBCTemplate.commit;
import static com.semi.yolo.common.jdbc.JDBCTemplate.getConnection;
import static com.semi.yolo.common.jdbc.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.semi.yolo.community.model.dao.BoardDao;
import com.semi.yolo.community.model.dao.CommentDao;
import com.semi.yolo.community.model.vo.Comment;

public class CommentService {
	public int save(Comment comment) {
		int result = 0;
		Connection connection = getConnection();
		
		if (comment.getNo() == 0) {
			result = new CommentDao().insertComment(connection, comment);
		} else {
			result = new CommentDao().updateComment(connection, comment);
		}
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);			
		}
		
		close(connection);
		
		return result;
	}

	public List<Comment> getCommentListByBoardNo(int no) {
		List<Comment> list = null;
		Connection connection = getConnection();
		
		try {
			list = new CommentDao().findAllByBoardNo(connection, no);
		} finally {
			close(connection);
		}
		
		return list;
	}

	public int delete(int comment_no) {
		Connection connection = getConnection();
		
		int result = new CommentDao().deleteComment(connection, comment_no);
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}
}
