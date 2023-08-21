package com.semi.yolo.community.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.community.model.service.CommentService;

@WebServlet(name = "deleteComment", urlPatterns = { "/community/deleteComment" })
public class DeleteCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteCommentServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int comment_no = Integer.parseInt(request.getParameter("delete_comment_no"));
		
		new CommentService().delete(comment_no);
		
		response.sendRedirect(request.getHeader("Referer"));
	}

}
