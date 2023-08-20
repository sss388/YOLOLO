package com.semi.yolo.community.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.community.model.service.CommentService;
import com.semi.yolo.community.model.vo.Comment;

@WebServlet(name = "modifyComment", urlPatterns = { "/community/modifyComment" })
public class ModifyCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ModifyCommentServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int no = Integer.parseInt(request.getParameter("comment_no"));
		String content = request.getParameter("content"); 
		
		Comment comment = new Comment();
		comment.setNo(no);
		comment.setContent(content);
		
		new CommentService().save(comment);
		
		response.sendRedirect(request.getHeader("Referer"));
	}

}
