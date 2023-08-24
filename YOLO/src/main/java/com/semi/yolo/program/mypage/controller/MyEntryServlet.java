package com.semi.yolo.program.mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "myEntry", urlPatterns = { "/mypage/myentry" })
public class MyEntryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MyEntryServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/views/mypage/myentry_meeting.jsp").forward(request, response); //포워딩
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
