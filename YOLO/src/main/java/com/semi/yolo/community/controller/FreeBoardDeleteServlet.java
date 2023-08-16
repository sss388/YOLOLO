package com.semi.yolo.community.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.community.model.service.BoardService;

@WebServlet(name = "freeBoardDelete", urlPatterns = { "/community/freeBoardDelete" })
public class FreeBoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FreeBoardDeleteServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("delete_freeboard_no"));
		int result = 0;
		
		result = new BoardService().delete(no); 
		
		if (result > 0) {
            request.setAttribute("msg", "게시글을 삭제했습니다.");
            request.setAttribute("location", "/community/freeBoard");
        } else {
        	request.setAttribute("msg", "게시글 삭제 실패");
        	request.setAttribute("location", "/");
        }
		
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}