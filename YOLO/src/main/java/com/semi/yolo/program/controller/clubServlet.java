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

@WebServlet(name = "club", urlPatterns = { "/program/club" })
public class clubServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public clubServlet() {
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

        // Service를 통해 데이터 가져오기
        ProgramService programService = new ProgramService();
        listCount = programService.getClubCount();
        pageInfo = new PageInfo(page, 10, listCount, 8);
        List<Program> list = new ProgramService().getBoardList(pageInfo, "club");
        
        

        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("list", list);
		
		
		request.getRequestDispatcher("/views/program/club.jsp").forward(request, response); //포워딩
	}

	
}
