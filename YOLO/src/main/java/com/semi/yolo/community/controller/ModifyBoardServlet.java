package com.semi.yolo.community.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.yolo.community.model.service.BoardService;
import com.semi.yolo.community.model.vo.Board;
import com.semi.yolo.member.service.MemberService;
import com.semi.yolo.member.vo.Member;

@WebServlet(name = "modifyBoard", urlPatterns = { "/community/modifyBoard" })
public class ModifyBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ModifyBoardServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		
		Board board = new BoardService().getBoardByNo(board_no);
		
		board.setUserName(new MemberService().getMemberNameByNo(board.getUserNo()));
		
		request.setAttribute("board", board);
		if(board.getKind() == 2)
			request.setAttribute("kind", "meetingreview");		
		
		request.getRequestDispatcher("/views/community/review_write.jsp").forward(request, response);
	}

}
