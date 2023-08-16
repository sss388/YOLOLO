package com.semi.yolo.program.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.community.model.service.BoardService;
import com.semi.yolo.program.model.service.ProgramService;

/**
 * Servlet implementation class AdminDeleteProgramServlet
 */
@WebServlet(name = "adminDeleteProgram", urlPatterns = { "/program/adminDeleteProgram" })
public class AdminDeleteProgramServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminDeleteProgramServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("delete_program_no"));
		String category = request.getParameter("category");
		
		int result = 0;
		
		result = new ProgramService().delete(no); 
		
		if (result > 0) {
            request.setAttribute("msg", "게시글을 삭제했습니다.");
            request.setAttribute("location", "/program/" + category);
        } else {
        	request.setAttribute("msg", "게시글 삭제 실패");
        	request.setAttribute("location", "/");
        }
		
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}
