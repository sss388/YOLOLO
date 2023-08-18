package com.semi.yolo.customerService.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.community.model.service.BoardService;
import com.semi.yolo.community.model.vo.Board;

@WebServlet(name = "FAQ", urlPatterns = { "/customerService/faq" })
public class FAQServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FAQServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
    	int page = 0;
		int listCount = 0;
		
		PageInfo pageInfo = null;
		List<Board> list = null;
		
		try {
			page = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			page = 1;
		}
		
		listCount = new BoardService().getBoardCount(4);
		pageInfo = new PageInfo(page, 10, listCount, 20);
		list = new BoardService().getBoardList(pageInfo, 4);
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("list", list);
		request.getRequestDispatcher("/views/customerservice/FAQ.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
