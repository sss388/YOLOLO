package com.semi.yolo.home.controller;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.community.model.service.BoardService;
import com.semi.yolo.community.model.vo.Board;
import com.semi.yolo.program.model.service.ProgramService;
import com.semi.yolo.program.model.vo.Program;

@WebServlet(name = "home", urlPatterns = { "/home" })
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public HomeServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Program> closeDeadLine = null; //마감 임박
		List<Program> recentProgram = null; // 최근 추가된 프로그램
		List<Board> recentReviewBoard = null; //최근 모임 후기 
		
		int remainDate[] = new int[4]; //마감 몇일 남았는지 담을 배열
		int index = 0; //remainDate에 순서대로 넣기 위한 인덱스 값
		
		closeDeadLine = new ProgramService().getCloseDeadLine(); // 프로그램 테이블에서 가져옴	
		
		for (Program program : closeDeadLine) { // 가져온 값을 토대로 마감 몇일 남았는지 계산 + 배열에 넣기
		    if (program.getExpireDate() != null) {
		    	Date now = new Date(); 
		    	
		    	Calendar now_cal = Calendar.getInstance(); // 현재 날짜
		    	now_cal.setTime(now);
		    	
		    	Calendar expire_cal = Calendar.getInstance(); // 마감일
		    	expire_cal.setTime(program.getExpireDate());
		        
		        remainDate[index++] = expire_cal.get(Calendar.DAY_OF_MONTH) - now_cal.get(Calendar.DAY_OF_MONTH);
		    }
		}
		
		recentProgram = new ProgramService().getRecentProgram(); // 최근 추가된 프로그램 테이블에서 가져오기
		
		recentReviewBoard = new BoardService().getBoardList(2);
		
		request.setAttribute("closeDeadLine", closeDeadLine);
		request.setAttribute("remainDate", remainDate);
		request.setAttribute("recentProgram", recentProgram);
		request.setAttribute("recentReviewBoard", recentReviewBoard);
		request.getRequestDispatcher("/views/home.jsp").forward(request, response);
	}

}
