package com.semi.yolo.customerService.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.yolo.customerService.service.commonService;
import com.semi.yolo.customerService.vo.Board;
import com.semi.yolo.member.vo.Member;


@WebServlet(name = "commonUpdate", urlPatterns = { "/customerservice/commonupdate" })
public class commonUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public commonUpdateServlet() {
       
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = 0;
		Board board = null;
		HttpSession session = request.getSession();
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	
    	//if (loginMember != null) {
    		no = Integer.parseInt(request.getParameter("no"));
    		board = new commonService().getBoardByNo(no); // 가져온 no로 게시글 조회
    		
    		if (board != null && loginMember.getUserId().equals(board.getWriterId())) {
    			request.setAttribute("board", board);
    			request.getRequestDispatcher("/views/customerservice/commonupdate.jsp").forward(request, response);
    		} else {
    			request.setAttribute("msg", "잘못된 접근입니다.");
    			request.setAttribute("location", "/board/list");
    			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    		}
    	//} else {
    	//	request.setAttribute("msg", "로그인 후 수정해 주세요 ");
    	//	request.setAttribute("location", "/");
    	//	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    	//}	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = 0;
		Board board = null;
		HttpSession session = request.getSession();
    	Member loginMember = (Member) session.getAttribute("loginMember");
    	
    	if (loginMember != null) {
    		String path = getServletContext().getRealPath("/resources/upload/board");
    		int maxSize = 10485760;
    		String encoding = "UTF-8";
    		//MultipartRequest mr = new MultipartRequest(request, path, maxSize, encoding, new FileRename());
    		
    		no = Integer.parseInt(request.getParameter("no"));
    		board = new commonService().getBoardByNo(no);  // no값으로 게시글 조회
    			
    		if (board != null && loginMember.getUserId().equals(board.getWriterId())) {
    			board.setTitle(request.getParameter("title"));
    			board.setContent(request.getParameter("content"));
    			
    			//String originalFileName = request.getOriginalFileName("upfile");
    			//String filesystemName = request.getFilesystemName("upfile");
    			
    			//if (originalFileName != null && originalFileName!= null) {
    			//	board.setOriginalFilename(originalFileName);
    			//	board.setRenamedFilename(filesystemName);
    			//}
    			
    			int result = new commonService().save(board);
    			
    			if (result > 0) {
    				// 게시글 수정 성공
    				request.setAttribute("msg", "게시글 수정 성공");
    				request.setAttribute("location", "/board/qnalist?no=" + board.getNo());
    			} else {
    				// 게시글 수정 실패
    				request.setAttribute("msg", "게시글 수정 실패");
    				request.setAttribute("location", "/board/qnalist?no=" + board.getNo());	
    			}
    		} else {
    			request.setAttribute("msg", "잘못된 접근입니다.");
    			request.setAttribute("location", "/board/list");
    		}
    	} else {
    		request.setAttribute("msg", "로그인 후 수정해 주세요 ");
    		request.setAttribute("location", "/");
    	}
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}


}