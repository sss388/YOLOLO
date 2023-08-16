package com.semi.yolo.community.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.community.model.service.BoardService;

@WebServlet(name = "reviewDelete", urlPatterns = { "/community/reviewDelete" })
public class ReviewDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ReviewDeleteServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		int result = 0;
		
		result = new BoardService().delete(no); 
		
		if (result > 0) {
            request.setAttribute("msg", "게시글을 삭제했습니다.");
            request.setAttribute("location", "/community/meetingReview");
        } else {
        	request.setAttribute("msg", "게시글 삭제 실패");
        	request.setAttribute("location", "/");
        }
		
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}
}
