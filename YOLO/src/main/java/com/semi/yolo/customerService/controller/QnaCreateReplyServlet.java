package com.semi.yolo.customerService.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.customerService.service.QnaBoardService;
import com.semi.yolo.customerService.vo.QnaReply;

@WebServlet(name = "qnaReply", urlPatterns = { "/customerService/qnaReply" })
public class QnaCreateReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public QnaCreateReplyServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int board_no = Integer.parseInt(request.getParameter("no"));
		String content = request.getParameter("content");
		
		QnaReply reply = new QnaReply();
		
		reply.setContent(content);
		reply.setNo(board_no);
		
		new QnaBoardService().createReply(reply);
		
		String referer = request.getHeader("referer");
		response.sendRedirect(referer);
	}

}
