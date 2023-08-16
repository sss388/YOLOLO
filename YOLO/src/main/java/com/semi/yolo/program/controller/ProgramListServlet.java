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


@WebServlet(name = "programList", urlPatterns = { "/program/list" })
public class ProgramListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProgramListServlet() {
    }
    
    
    
    
    
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int page = 0;
    	int listCount = 0;
    	PageInfo pageInfo = null;
    	
    	try {
    		page = Integer.parseInt(request.getParameter("page"));
    		
    	} catch (NumberFormatException e) {
    		page = 1;
    	}
    	  
    	listCount = new ProgramService().getOneDayCount(); 
    	pageInfo = new PageInfo(page, 10, listCount, 10);
    	List<Program> list = new ProgramService().getBoardList(pageInfo, "ALL");
    	
//    	pageInfo = new PageInfo(1, 10, 104, 10);
//    	System.out.println(pageInfo.getCurrentPage());  // 1 : 현재 페이지
//    	System.out.println(pageInfo.getPrevPage());     // 1 : 현재 페이지 이전
//    	System.out.println(pageInfo.getNextPage());     // 2 : 다음 페이지
//    	System.out.println(pageInfo.getMaxPage());      // 10 : 최대 페이지
//    	System.out.println(pageInfo.getStartPage());    // 1 : 시작 페이지
//    	System.out.println(pageInfo.getEndPage());      // 10 : 마지막 페이지
    	
//    	System.out.println(list);
//    	System.out.println(list.size());
    	
    	request.setAttribute("pageInfo", pageInfo);
    	request.setAttribute("list", list);
    	request.getRequestDispatcher("/views/program/oneDay.jsp").forward(request, response);
    
    
    }
    
  

}
