package com.semi.yolo.community.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.yolo.community.model.service.CommentService;
import com.semi.yolo.community.model.vo.Comment;
import com.semi.yolo.member.vo.Member;

@WebServlet(name = "commentSave", urlPatterns = { "/community/commentSave" })
public class CommentSaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CommentSaveServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	int result = 0;
    	
    	if (loginMember != null ) {
    		
    		int board_no = Integer.parseInt(request.getParameter("board_no"));
    		String content = request.getParameter("content");
    		
    		Comment newComment = new Comment();
    		
    		newComment.setContent(content);
    		newComment.setBoardNo(board_no);
    		newComment.setUserNo(loginMember.getNo());
    		
    		result = new CommentService().save(newComment);
    		
    		if (result > 0) {
    		    response.sendRedirect(request.getHeader("Referer"));
    		} else {
    			System.out.println("save 실패");
    		}
    		
    	} else {
    		request.setAttribute("msg", "로그인 후 작성해 주세요 ");
			request.setAttribute("location", "/member/login");
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    	}
	}

}
