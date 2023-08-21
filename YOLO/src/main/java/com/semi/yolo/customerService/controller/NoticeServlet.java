package com.semi.yolo.customerService.controller;

import java.io.IOException;
import java.sql.Clob;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.community.model.service.BoardService;
import com.semi.yolo.community.model.vo.Board;
import com.semi.yolo.customerService.service.NoticeService;
import com.semi.yolo.customerService.vo.Notice;
import com.semi.yolo.member.service.MemberService;

// 자주묻는질문 서블릿

@WebServlet(name = "notice", urlPatterns = { "/customerService/notice" })
public class NoticeServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
  
   public NoticeServlet() {     
   }

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	
    	int no = 0;
    	int page = 0;
		int listCount = 0;
		
		PageInfo pageInfo = null;
		List<Board> list = null;
		Board currentNotice = null;
		
		try {
			page = Integer.parseInt(request.getParameter("page"));
			no = Integer.parseInt(request.getParameter("no"));
			
			currentNotice = new BoardService().getBoardByNo(no);
			
			String member_name = new MemberService().getMemberNameByNo(currentNotice.getUserNo());
			
			request.setAttribute("currentBoard", currentNotice);
			request.setAttribute("member_name", member_name);
		} catch (NumberFormatException e) {
			page = 1;
		}
		
		BoardService boardservice = new BoardService();
		
		try {
			String keyword = request.getParameter("keyword");
        	
        	if( !keyword.isEmpty() ) {
        		listCount = boardservice.getBoardCountByKeyword(5, keyword);
        		pageInfo = new PageInfo(page, 10, listCount, 20);
        		list = new BoardService().getBoardListByKeyword(pageInfo, 5, keyword);
        	}
		} catch (NullPointerException e) {
			listCount = boardservice.getBoardCount(5);
			pageInfo = new PageInfo(page, 10, listCount, 20);
			list = boardservice.getBoardList(pageInfo, 5);
		}
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("list", list);
    	request.getRequestDispatcher("/views/customerservice/notice.jsp").forward(request, response);       
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   request.setCharacterEncoding("UTF-8");
	   int no = Integer.parseInt(request.getParameter("no"));
	   
	   String title = request.getParameter("update_title");
	   String content = request.getParameter("content");
	   
	   Notice currentNotice = new Notice();
	   
	   currentNotice.setTitle(title);
	   currentNotice.setContent(content);
	   currentNotice.setNo(no);
	   
	   new NoticeService().updateNotice(currentNotice);
	   
	   String referer = request.getHeader("referer");
	   response.sendRedirect(referer);
   }

}
