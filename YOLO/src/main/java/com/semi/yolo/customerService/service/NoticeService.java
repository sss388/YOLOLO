package com.semi.yolo.customerService.service;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;
import static com.semi.yolo.common.jdbc.JDBCTemplate.getConnection;
import static com.semi.yolo.common.jdbc.JDBCTemplate.rollback;
import static com.semi.yolo.common.jdbc.JDBCTemplate.commit;

import java.sql.Connection;
import java.util.List;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.customerService.vo.Notice;
import com.semi.yolo.customerService.dao.NoticeDao;

public class NoticeService {
	public int getNoticeCount() {
		int count = 0;
		Connection connection = getConnection();
		
		count = new NoticeDao().getCount(connection);
		
		return count;
	}

	public List<Notice> getNoticeList(PageInfo pageInfo) {
		List<Notice> list = null;
		Connection connection = getConnection();
		
		list = new NoticeDao().findAll(connection, pageInfo);
		
		close(connection);
		
		return list;
	}

	public Notice getCurrentNotice(int no) {
		Notice notice = null;
		Connection connection = getConnection();
		
		notice = new NoticeDao().findByNo(connection, no);
		
		close(connection);
		
		return notice;
	}

	public int updateNotice(Notice currentNotice) {
		int result = 0;
		Connection connection = getConnection();
		
		result = new NoticeDao().updateByNo(connection, currentNotice);
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	public int deleteNotice(int no) {
		int result = 0;
		Connection connection = getConnection();
		
		result = new NoticeDao().deleteByNo(connection, no);
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	public int createNotice(Notice newNotice, int userNo) {
		int result = 0;
		Connection connection = getConnection();
		
		result = new NoticeDao().create(connection, newNotice, userNo);
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}
}
