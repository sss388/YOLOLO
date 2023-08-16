package com.semi.yolo.community.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.yolo.community.model.service.BoardService;
import com.semi.yolo.community.model.vo.Board;
import com.semi.yolo.member.service.MemberService;
import com.semi.yolo.member.vo.Member;

@WebServlet(name = "reviewDetail", urlPatterns = { "/community/reviewDetail" })
public class ReviewDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ReviewDetailServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		
		Board board = new Board();
		
		board = new BoardService().getBoardByNo(no);
		String member_name = new MemberService().getMemberNameByNo(board.getUserNo());		
		
		request.setAttribute("board", board);
		request.setAttribute("member_name", member_name);
		
		request.getRequestDispatcher("/views/community/reviewDetail.jsp").forward(request, response); 
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int no = Integer.parseInt(request.getParameter("no"));
		String content = request.getParameter("content");
		
		new BoardService().updateReview(no, content);
		
		String referer = request.getHeader("referer");
		  response.sendRedirect(referer);
	}

}
