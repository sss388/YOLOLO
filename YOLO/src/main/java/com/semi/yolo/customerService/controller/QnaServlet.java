package com.semi.yolo.customerService.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.yolo.common.util.PageInfo;
import com.semi.yolo.customerService.service.QnaBoardService;
import com.semi.yolo.customerService.vo.QnaReply;
import com.semi.yolo.customerService.vo.Qna_Board;
import com.semi.yolo.member.vo.Member;


// 고객센터 누르고 사으드바 문의하기 누르면 기본적으로 나오는 창
@WebServlet(name = "qna", urlPatterns = { "/customerService/qna" })
public class QnaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public QnaServlet() {
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	if(loginMember != null && loginMember.getRole() == 1) {
    		 // 관리자용 페이지
            int selected = 0;
            int page = 0;
            int listCount = 0;
            PageInfo pageInfo = null;
            List<Qna_Board> list = null;
            
            try {
               page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
               page = 1;
            }
            
            try {               
               selected = Integer.parseInt(request.getParameter("no"));
               
               Qna_Board currentBoard = null;
               
               currentBoard = new QnaBoardService().getBoardByNo(selected);
               request.setAttribute("currentBoard", currentBoard);
               
               QnaReply reply = null;
               
               reply = new QnaBoardService().getReplyByBoradNo(selected);
               
               request.setAttribute("reply", reply);
               
            } catch(NumberFormatException e) {
               selected = 0;
            }
            
            listCount = new QnaBoardService().getBoardCount();
            pageInfo = new PageInfo(page, 10, listCount, 20);
            list = new QnaBoardService().getBoardList(pageInfo);
            
            request.setAttribute("pageInfo", pageInfo);
            request.setAttribute("list", list);
    		request.getRequestDispatcher("/views/customerservice/qnaAdmin.jsp").forward(request, response);
    	}else {
    		request.getRequestDispatcher("/views/customerservice/qna.jsp").forward(request, response);           		
    	}

	}

	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	

}
