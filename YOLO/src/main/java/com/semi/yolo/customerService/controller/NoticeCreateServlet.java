package com.semi.yolo.customerService.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.yolo.community.model.service.BoardService;
import com.semi.yolo.community.model.vo.Board;
import com.semi.yolo.member.vo.Member;

/**
 * Servlet implementation class NoticeCreateServlet
 */
@WebServlet(name = "noticeCreate", urlPatterns = { "/customerService/noticeCreate" })
public class NoticeCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public NoticeCreateServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int no = Integer.parseInt(request.getParameter("no"));
			Board board = new BoardService().getBoardByNo(no);
			
			request.setAttribute("board", board);
		} catch (NumberFormatException e) {
			
		}
		
		request.getRequestDispatcher("/views/customerservice/noticeCreate.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	int result = 0;
		
    	if (loginMember != null && loginMember.getRole() == 1) {
    		
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			Board newNotice = new Board();
			
			newNotice.setTitle(title);
			newNotice.setContent(content);
			newNotice.setUserNo(loginMember.getNo());
			newNotice.setKind(5);
			
			try {
				int no = Integer.parseInt(request.getParameter("no"));
								
				newNotice.setNo(no);
			} catch (NumberFormatException e) {
			}
			
			result = new BoardService().save(newNotice);
			
			if (result > 0) {
				// 게시글 등록 성공
				request.setAttribute("msg", "게시글 등록 성공");
				request.setAttribute("location", "/customerService/notice?no=" + newNotice.getNo());
			} else {
				// 게시글 등록 실패
				request.setAttribute("msg", "게시글 등록 실패");
				request.setAttribute("location", "/customerService/notice");
			}
		} else {
			request.setAttribute("msg", "로그인 후 작성해 주세요 ");
			request.setAttribute("location", "/member/login");
		}	
		
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}
