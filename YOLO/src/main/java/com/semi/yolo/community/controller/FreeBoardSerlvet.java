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
import com.semi.yolo.community.model.service.CommentService;
import com.semi.yolo.community.model.vo.Board;
import com.semi.yolo.community.model.vo.Comment;
import com.semi.yolo.member.service.MemberService;

@WebServlet(name = "freeboard", urlPatterns = { "/community/freeBoard" })
public class FreeBoardSerlvet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FreeBoardSerlvet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int page = 0;
		int listCount = 0;
		int no = 0;
		
		PageInfo pageInfo = null;
		List<Board> list = null;
		
		try {
			page = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			page = 1;
		}
		
		try {
			no = Integer.parseInt(request.getParameter("no"));
			
			Board board = new BoardService().getProgramByNo(no);
			String member_name = new MemberService().getMemberNameByNo(board.getUserNo());
			
			request.setAttribute("member_name", member_name);
	    	request.setAttribute("board", board); 
	    	
	    	List<Comment> comment_list = new CommentService().getCommentListByBoardNo(board.getNo());
	    	request.setAttribute("comment_list", comment_list);
			
		} catch (NumberFormatException e) {
		}
		
		BoardService boardservice = new BoardService();
		
		try {
        	// 검색했을 때
        	String keyword = request.getParameter("keyword");
        	
        	if( !keyword.isEmpty() ) {
        		listCount = boardservice.getBoardCountByKeyword(1, keyword);
        		pageInfo = new PageInfo(page, 10, listCount, 20);
        		list = new BoardService().getBoardListByKeyword(pageInfo, 1, keyword);
        	}
        	
		} catch (NullPointerException e) {
			listCount = boardservice.getBoardCount(1);	
			pageInfo = new PageInfo(page, 10, listCount, 20);
			list = boardservice.getBoardList(pageInfo, 1);
		}
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("list", list);
		

		request.getRequestDispatcher("/views/community/freeBoard.jsp").forward(request, response); 
	}
}
