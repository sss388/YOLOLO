package com.semi.yolo.customerService.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.customerService.service.commonService;
import com.semi.yolo.customerService.vo.Board;



@WebServlet(name = "commonView", urlPatterns = { "/customService/view" })
public class commonViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public commonViewServlet() {
      
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
int no = Integer.parseInt(request.getParameter("no"));
		
		System.out.println("게시글 번호 : " + no);
		
		Board board = new commonService().getBoardByNo(no);
		
		System.out.println(board);
		
		request.setAttribute("board", board);
		request.getRequestDispatcher("/views/customerservice/commonview.jsp").forward(request, response);
	}

}