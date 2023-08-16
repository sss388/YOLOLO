package com.semi.yolo.customerService.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.customerService.service.commonService;
import com.semi.yolo.customerService.vo.Board;


@WebServlet(name = "commonlist", urlPatterns = { "/customerService/commonlist" })
public class commonListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public commonListServlet() {
        
    }

    @Override
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
		
    	listCount = new commonService().getBoardCount();
		pageInfo = new PageInfo(page, 10, listCount, 10);
		list= new commonService().getBoardList(pageInfo);
		
		System.out.println(list);
		System.out.println(list.size());
		
    	request.setAttribute("pageInfo", pageInfo);
    	request.setAttribute("list", list);
    	request.getRequestDispatcher("/views/customerservice/commonlist.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}