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

@WebServlet(name = "faqCreate", urlPatterns = { "/customerService/faqCreate" })
public class FAQCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FAQCreateServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int no = Integer.parseInt(request.getParameter("no"));
			Board board = new BoardService().getBoardByNo(no);
			
			request.setAttribute("board", board);
		} catch (NumberFormatException e) {
			
		}
		
		request.getRequestDispatcher("/views/customerservice/FAQcreate.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	int result = 0;
		
    	if (loginMember != null && loginMember.getRole() == 1) {
    		
    		String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			Board newFAQ = new Board();
			
			newFAQ.setTitle(title);
			newFAQ.setContent(content);
			newFAQ.setUserNo(loginMember.getNo());
			newFAQ.setKind(4);
			
			try {
				int no = Integer.parseInt(request.getParameter("no"));
								
				newFAQ.setNo(no);
			} catch (NumberFormatException e) {
			}
			
			result = new BoardService().save(newFAQ);
			
			if (result > 0) {
				// 게시글 등록 성공
				request.setAttribute("msg", "게시글 등록 성공");
				request.setAttribute("location", "/customerService/faq");
			} else {
				// 게시글 등록 실패
				request.setAttribute("msg", "게시글 등록 실패");
				request.setAttribute("location", "/customerService/faq");
			}
    	} else {
			request.setAttribute("msg", "로그인 후 작성해 주세요 ");
			request.setAttribute("location", "/member/login");
		}	
    	
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}
