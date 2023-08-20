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
import com.semi.yolo.program.model.service.ProgramService;
import com.semi.yolo.program.model.vo.Program;

@WebServlet(name = "freeboarddetailedpage", urlPatterns = { "/community/freeBoarddetailpage" })
public class BoardDetailedpageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardDetailedpageServlet() {
    }
    
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int no = Integer.parseInt(request.getParameter("no"));
    	
    	Board board = new BoardService().getProgramByNo(no);
    	String member_name = new MemberService().getMemberNameByNo(board.getUserNo());
    	
    	request.setAttribute("member_name", member_name);
    	
    	request.setAttribute("board", board); 
    	request.getRequestDispatcher("/views/community/freeBoarddetailpage.jsp").forward(request, response);
    }
    
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
