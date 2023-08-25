package com.semi.yolo.program.mypage.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.customerService.service.QnaBoardService;
import com.semi.yolo.member.vo.Member;
import com.semi.yolo.program.model.service.ProgramService;
import com.semi.yolo.program.model.vo.Program;
import com.semi.yolo.program.mypage.service.MyProgramService;

// 마이페이지에서 내가 만든 모임 연결
@WebServlet(name = "mademeeting", urlPatterns = { "/made/meeting" })
public class MadeMeetingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MadeMeetingServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     	    int page = 0;
    		int listCount = 0;
    	
    		HttpSession session = request.getSession();
    		Member loginMember = (Member) session.getAttribute("loginMember");
    		
    		int user_no = loginMember.getNo();  
    		
        	PageInfo pageInfo = null;
        	List<Program> list = null;
        	
        	try {
        		page = Integer.parseInt(request.getParameter("page"));
    		} catch (NumberFormatException e) {
    			page = 1;
    		}
    		
        	listCount = new MyProgramService().madeMyCount(user_no);
    		pageInfo = new PageInfo(page, 10, listCount, 8);
    		list = new MyProgramService().getBoardList(pageInfo, user_no);
    		
//    		System.out.println(list); 
//    		System.out.println(list.size());
    		
        	request.setAttribute("pageInfo", pageInfo);
        	request.setAttribute("list", list);
        	request.getRequestDispatcher("/views/mypage/made_meeting.jsp").forward(request, response);
    	}
	
 

}
