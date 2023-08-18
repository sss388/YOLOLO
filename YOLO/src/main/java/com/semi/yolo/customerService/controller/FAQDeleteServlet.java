package com.semi.yolo.customerService.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.community.model.service.BoardService;
import com.semi.yolo.customerService.service.NoticeService;

@WebServlet(name = "faqDelete", urlPatterns = { "/customerService/faqDelete" })
public class FAQDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FAQDeleteServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("delete_notice_no"));
		
		new BoardService().delete(no);
		
		String referer = request.getHeader("referer");
		response.sendRedirect(referer);
	}

}
