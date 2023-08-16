package com.semi.yolo.community.controller;

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

@WebServlet(name = "freeboard", urlPatterns = { "/community/freeBoard" })
public class FreeBoardSerlvet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FreeBoardSerlvet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int page = 0;
		int listCount = 0;
		PageInfo pageInfo = null;
		List<Board> list = null;
		
		try {
			page = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			page = 1;
		}
		
		listCount = new BoardService().getBoardCount(1);	
		pageInfo = new PageInfo(page, 10, listCount, 20);
		list = new BoardService().getBoardList(pageInfo, 1);
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("list", list);
		

		request.getRequestDispatcher("/views/community/freeBoard.jsp").forward(request, response); 
	}
}
