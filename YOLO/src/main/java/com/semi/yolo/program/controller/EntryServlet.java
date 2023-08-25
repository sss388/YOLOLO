package com.semi.yolo.program.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.program.model.service.EntryMemberService;
import com.semi.yolo.program.model.vo.EntryMember;

@WebServlet(name = "entry", urlPatterns = { "/program/entry" })
public class EntryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EntryServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int user_no = Integer.parseInt(request.getParameter("user_no"));
		int program_no = Integer.parseInt(request.getParameter("program_no"));
		
		int kind = Integer.parseInt(request.getParameter("kind"));
		
		switch (kind) {
		case 1:
			new EntryMemberService().save(user_no, program_no);
			break;
		case 2:
			new EntryMemberService().cancelEntry(user_no, program_no);
			break;
		}
		
		response.sendRedirect(request.getHeader("referer"));
	}

}
