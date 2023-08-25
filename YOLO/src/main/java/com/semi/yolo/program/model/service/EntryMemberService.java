package com.semi.yolo.program.model.service;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;
import static com.semi.yolo.common.jdbc.JDBCTemplate.commit;
import static com.semi.yolo.common.jdbc.JDBCTemplate.getConnection;
import static com.semi.yolo.common.jdbc.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.program.model.dao.EntryMemberDao;
import com.semi.yolo.program.model.dao.ProgramDao;
import com.semi.yolo.program.model.vo.EntryMember;
import com.semi.yolo.program.model.vo.Program;

public class EntryMemberService {

	public List<EntryMember> getMembersByProgramNo(int no) {
		List<EntryMember> list = null;
		Connection connection = getConnection();
		
		try {
			EntryMemberDao entryMemberDao = new EntryMemberDao();
			list = entryMemberDao.findByProgramNo(connection, no);
		} finally {
			close(connection);
		}
		
		return list;
	}

	public int save(int user_no, int program_no) {
		int result = 0;
		Connection connection = getConnection();
		
		result = new EntryMemberDao().insert(connection, user_no, program_no);
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);			
		}
		
		close(connection);
		
		return result;
	}

	public int cancelEntry(int user_no, int program_no) {
		int result = 0;
		Connection connection = getConnection();
		
		result = new EntryMemberDao().delete(connection, user_no, program_no);
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);			
		}
		
		close(connection);
		
		return result;
	}

	public int getListCountByUserNo(int no) {
		int count = 0;
		Connection connection = getConnection();
		
		count = new EntryMemberDao().getCountByUserNo(connection, no);
		
		return count;
	}

	public List<Program> getBoardListByEntry(PageInfo pageInfo, int listCount, int no) {
		List<Program> list = null;
		Connection connection = getConnection();
		
		try {
			list = new EntryMemberDao().findEntryProgramByUserNo(connection, pageInfo, no);  
		} finally {
            close(connection);
        }
		
		return list;
	}

}
