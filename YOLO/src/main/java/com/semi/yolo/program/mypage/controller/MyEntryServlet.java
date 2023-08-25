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
import com.semi.yolo.member.vo.Member;
import com.semi.yolo.program.model.service.EntryMemberService;
import com.semi.yolo.program.model.vo.Program;

@WebServlet(name = "myEntry", urlPatterns = { "/mypage/myentry" })
public class MyEntryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MyEntryServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int page = 0;
		int listCount = 0;
		
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		PageInfo pageInfo = null;
		List<Program> list = null;
		
		try {
    		page = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			page = 1;
		}
		
		listCount = new EntryMemberService().getListCountByUserNo(loginMember.getNo());
		pageInfo = new PageInfo(page, 10, listCount, 8);
		list = new EntryMemberService().getBoardListByEntry(pageInfo, listCount, loginMember.getNo());
		
		request.setAttribute("pageInfo", pageInfo);
    	request.setAttribute("list", list);
		request.getRequestDispatcher("/views/mypage/myentry_meeting.jsp").forward(request, response); //포워딩
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
