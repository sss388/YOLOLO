package com.semi.yolo.program.model.service;

import static com.semi.yolo.common.jdbc.JDBCTemplate.close;
import static com.semi.yolo.common.jdbc.JDBCTemplate.commit;
import static com.semi.yolo.common.jdbc.JDBCTemplate.getConnection;
import static com.semi.yolo.common.jdbc.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.program.model.dao.ProgramDao;
import com.semi.yolo.program.model.vo.Program;

public class ProgramService {
	  
	// 모임만들기 글쓰기 저장하기
	public int save(Program program) {
		int result = 0;
		Connection connection = getConnection();
		
		if (program.getNo() > 0) {
			// 업데이트
			result = new ProgramDao().updateprogram(connection, program);
		} else {
			// 저장하기
			result = new ProgramDao().insertprogram(connection, program);
		}
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);			
		}
		
		close(connection);
		
		return result;
	}
	
    // 글 번호를 받아서 해당 번호의 게시판 글을 조회하는 기능을 구현한 것
	public Program getProgramByNo(int no) {
		Program program = null;
		Connection connection = getConnection();
		
		program = new ProgramDao().findProgramByNo(connection, no);
		
		close(connection);
		
		return program;
	}
	
    // delete(int no): 게시글 번호를 입력받아 해당 번호의 프로그램을 삭제하는 메서드
    public int delete(int no) {
        Connection connection = getConnection();

        int result = new ProgramDao().deleteBoard(connection, no);

        if (result > 0) {
            commit(connection);
        } else {
            rollback(connection);
        }

        close(connection);

        return result;
    }
    
    public int getProgramCountByKeyword(String keyword, String kind) {
    	int count = 0;
        Connection connection = getConnection();

        count = new ProgramDao().getProgramCountByKeyword(connection, kind, keyword);

        close(connection);

        return count;
    }
	
	// getOneDayCount(), getClubCount(), getChallengeCount(): 각각 OneDay, Club, Challenge 카테고리의 프로그램 수를 조회하는 메서드
	public int getOneDayCount() {
        int count = 0;
        Connection connection = getConnection();

        count = new ProgramDao().getOneDayCount(connection);

        close(connection);

        return count;
    }
    
    public int getClubCount() {
        int count = 0;
        Connection connection = getConnection();

        count = new ProgramDao().getClubCount(connection);

        close(connection);

        return count;
    }
    public int getChallengeCount() {
        int count = 0;
        Connection connection = getConnection();

        count = new ProgramDao().getChallengeCount(connection);

        close(connection);

        return count;
    }

    // getBoardList(PageInfo pageInfo): 페이징 처리된 프로그램 목록을 조회하는 메서드
    public List<Program> getBoardList(PageInfo pageInfo, String category) {
        List<Program> list = null;
        Connection connection = getConnection();
        
        try {
            ProgramDao programDao = new ProgramDao();
            list = programDao.findAll(connection, pageInfo, category);
        } finally {
            close(connection);
        }

        return list;
    }
    
    // getCloseDeadLine(): 마감이 얼마 남지 않은 프로그램 목록을 조회하는 메서드
    public List<Program> getCloseDeadLine() {
        List<Program> list = null;
        Connection connection = getConnection();

        list = new ProgramDao().findCloseDeadLine(connection, 7);

        close(connection);

        return list;
    }
    
    // getRecentProgram(): 최근 등록된 프로그램 목록을 조회하는 메서드
    public List<Program> getRecentProgram() {
        List<Program> list = null;
        Connection connection = getConnection();

        list = new ProgramDao().findRecentProgram(connection, 1);

        close(connection);

        return list;
    }


}