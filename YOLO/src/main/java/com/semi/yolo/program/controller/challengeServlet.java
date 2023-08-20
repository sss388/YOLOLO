package com.semi.yolo.program.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.program.model.service.ProgramService;
import com.semi.yolo.program.model.vo.Program;

@WebServlet(name = "challenge", urlPatterns = { "/program/challenge" })
public class challengeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public challengeServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int page = 1; // 기본 페이지 번호를 1로 설정
        int listCount = 0;
        PageInfo pageInfo = null;

        

        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            // 페이지 번호가 파라미터로 전달되지 않은 경우 처리
        }
        
        try {
        	int no = Integer.parseInt(request.getParameter("no"));
        	
        	Program program = new ProgramService().getProgramByNo(no);
        	request.setAttribute("program", program);
        } catch (NumberFormatException e) {
        	
        }

        // Service를 통해 데이터 가져오기
        ProgramService programService = new ProgramService();
        listCount = programService.getChallengeCount();
        pageInfo = new PageInfo(page, 10, listCount, 8);
        List<Program> list = new ProgramService().getBoardList(pageInfo, "challenge");
        
        

        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("list", list);
		
		
		request.getRequestDispatcher("/views/program/challenge.jsp").forward(request, response); //포워딩
	}

	
}
