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



@WebServlet(name = "qnaWrite", urlPatterns = { "/customerService/qnaWrite" })
public class QnaWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public QnaWriteServlet() {
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	if (loginMember != null) {
    		 if( loginMember.getRole() == 1 ) {
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
    		 
    	} else {
    		request.setAttribute("msg", "로그인 후 작성해 주세요 ");
    		request.setAttribute("location", "/views/member/login.jsp");
    		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    	}	
    }

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	if (loginMember != null) {

    		Qna_Board board = new Qna_Board();
    		
    		// 게시글을 작성한 작성자의 No 값 
    		board.setWriterNo(loginMember.getNo());
    		
    		// 문의유형
    		String type = request.getParameter("type");

    		if (type.equals("member_info")) {
    		    board.setType("회원정보");
    		} else if (type.equals("program_info")) {
    		    board.setType("프로그램관련");
    		} else if (type.equals("etc")) {
    		    board.setType("기타");
    		}
    		
    		// 이름
    		board.setName(request.getParameter("name"));
    		
    		// 이메일
    		board.setEmail(request.getParameter("email"));
    		
    		// 휴대폰번호
    		board.setPhone(request.getParameter("phone"));
    		
    		// 제목
    		board.setTitle(request.getParameter("title"));
    		
    		// 문의내용
    		board.setContent(request.getParameter("contect"));
    		
    		// 동의내용
    		board.setAgree(request.getParameter("agree"));
    		
    	    // 파일을 서비스객체에 전달하고, (나중에 dao 객체를 사용해서 db에 저장)
    		int result = new QnaBoardService().save(board);
    		
    		if (result > 0) {
    			// 게시글 등록 성공
    			request.setAttribute("msg", "게시글 등록 성공");
        		request.setAttribute("location", "/customerService/qnalist");
    		} else {
    			// 게시글 등록 실패
    			request.setAttribute("msg", "게시글 등록 실패");
        		request.setAttribute("location", "/customerService/qna");
    		}
    		
    	} else {
    		request.setAttribute("msg", "로그인 후 작성해 주세요 ");
    		request.setAttribute("location", "/");
    	}	
    	// 무조건 포워딩 되게 else 밖으로
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		
	}
}
